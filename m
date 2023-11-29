Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877A67FDC09
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343995AbjK2P0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbjK2PZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:25:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B321BD1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:25:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8283AC43391;
        Wed, 29 Nov 2023 15:25:23 +0000 (UTC)
Date:   Wed, 29 Nov 2023 10:25:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        dmaluka@google.com, Sean Paul <seanpaul@chromium.org>,
        Arun Easi <aeasi@marvell.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] tracing: Allow creating instances with specified system
 events
Message-ID: <20231129102545.56901df5@gandalf.local.home>
In-Reply-To: <20231129235821.d99da161644525a2fa988938@kernel.org>
References: <20231128122117.2276f4a7@gandalf.local.home>
        <20231129235821.d99da161644525a2fa988938@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 23:58:21 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > - Dynamic events had to be specified directly to still allow them to be
> >   created.  
> 
> I have a question about this point. Does this mean the dynamic event files
> will be created in the instance which limits the "system"?
> For this point, I would like to allow limiting dynamic events on instance too.
> If user needs to use specific one, e.g. synthetic, then it is possible to
> add it to the filter.

I'm going back and forth on this. Here's my thoughts about it.

Arguments for allowing all dynamic events:

1. There's not many. This code is basically a way to keep the overhead of
   an instance down. By removing all static events, it can substantially lower
   the memory footprint.

   As synthetic events are user created, there shouldn't be too many that
   would cause a memory foot print issue, and the user also has a bit of
   control of what events are created.

2. We have no idea what a user may want to do with those events. What if
   the user wants to see an event in that buffer and creates a synthetic
   event for it? Should the kernel create a policy for that?

Arguments against defaulting dynamic events in:

1. The list is created in the kernel. The instance is not created by the
   user and thus the kernel could have more control over it.

2. If the user really wants to have dynamic events, they can create another
   instance with the needed events or use the top level.

Hmm, writing this out, I am now leaning more toward not defaulting dynamic
events in. And if we can create a way to dynamically add and remove events
systems from an instance (via mkdir and rmdir), this should not be an issue.

Anyone else have any thoughts about this?

-- Steve
