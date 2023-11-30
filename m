Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8546B7FF314
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346089AbjK3O7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbjK3O6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:58:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E923172D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:58:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE65C433C8;
        Thu, 30 Nov 2023 14:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701356338;
        bh=Fi+PXbFeaElSMsJ85ZgC4fiBmvsEM9ElGQ2yDWOBSwg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j8Gc1JD6u2c5eeZjTJtjzejxJmsZctNa2jWwdImxvAN12/Rho7yWrgwCjDMhUveyS
         Fb9MpgGkdd2Dgmk1b1EG5qcDy+HXt+dFAWGui91lsvLoDmfUl7kg2ufIF0L6d3D7wX
         zaenxtk7LJU8Pvf4/eBaPu1vYn537Xw8KE+uJiIf/cVhMDLceCDN1IDz5nbXlZBFhe
         cC4Cq2jSoseytIw6D2xXwojtRKawIJDpHncBhhbdA/tVcn8QKBv486TUEyZyLY+Byq
         7rIA2JyqUJk90QyWN/i8Ie31x+y16U7GYx4KU+TM2Etl3/zqaOn5RBgpv6pzj813Xu
         O2rwI6tIYSOfg==
Date:   Thu, 30 Nov 2023 23:58:53 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        dmaluka@google.com, Sean Paul <seanpaul@chromium.org>,
        Arun Easi <aeasi@marvell.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] tracing: Allow creating instances with specified system
 events
Message-Id: <20231130235853.0d41c12583548472c9df8dcd@kernel.org>
In-Reply-To: <20231129102545.56901df5@gandalf.local.home>
References: <20231128122117.2276f4a7@gandalf.local.home>
        <20231129235821.d99da161644525a2fa988938@kernel.org>
        <20231129102545.56901df5@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 10:25:45 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 29 Nov 2023 23:58:21 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > - Dynamic events had to be specified directly to still allow them to be
> > >   created.  
> > 
> > I have a question about this point. Does this mean the dynamic event files
> > will be created in the instance which limits the "system"?
> > For this point, I would like to allow limiting dynamic events on instance too.
> > If user needs to use specific one, e.g. synthetic, then it is possible to
> > add it to the filter.
> 
> I'm going back and forth on this. Here's my thoughts about it.
> 
> Arguments for allowing all dynamic events:
> 
> 1. There's not many. This code is basically a way to keep the overhead of
>    an instance down. By removing all static events, it can substantially lower
>    the memory footprint.
> 
>    As synthetic events are user created, there shouldn't be too many that
>    would cause a memory foot print issue, and the user also has a bit of
>    control of what events are created.

Sometimes synthetic event user != instance user. (Only the privileged user
will do, but maybe done by different program.)

> 2. We have no idea what a user may want to do with those events. What if
>    the user wants to see an event in that buffer and creates a synthetic
>    event for it? Should the kernel create a policy for that?

I think it is enough to give a choice to user. User can enable events
under synthetic, probes, etc. by mkdir later. IIUC, current implementation
forcibly exposes all dynamic events.

> 
> Arguments against defaulting dynamic events in:
> 
> 1. The list is created in the kernel. The instance is not created by the
>    user and thus the kernel could have more control over it.
> 
> 2. If the user really wants to have dynamic events, they can create another
>    instance with the needed events or use the top level.
> 
> Hmm, writing this out, I am now leaning more toward not defaulting dynamic
> events in. And if we can create a way to dynamically add and remove events
> systems from an instance (via mkdir and rmdir), this should not be an issue.

Yeah, that's my point. If we allow all dynamic events, it needs to change the
default behavior later. That will not be consistent.

Thank you,

> 
> Anyone else have any thoughts about this?
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
