Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D0C808F3C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbjLGR6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbjLGR6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:58:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CCA173C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 09:57:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500ABC433C8;
        Thu,  7 Dec 2023 17:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701971867;
        bh=he6LQ25WriwrUDDfYMH36GaKEnf82jbzGv13WZYSigA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l4TN7o1bbCnfchU9RLrHJPvjo+IZ4KULQNSU5zsj3q64CV1bTzf9IP4m/+rGhIOIn
         oODMJChWCx477zxVUlNsE6IiNamrGVAYLkSOsAW8UWbIDDKQEU0zCFkl5Mk4fYQIts
         HOo+02W54XWWpeoEuIF0nOJ7f0mHuv24kSBz+ftktQSyzd2VhtGnUmbfYn1oR9I4w+
         TEmD0BS8uKH8WiFT3owGtMdsYPLRGGonI2MbEl75vFuxW7WT48v05dZDyYWiqibHTF
         pdqXCqbnIvyVn+8rcYo+hwaS9FmzBMzKw7Ff6x4+jlp2JrR99IxRJkBwBIDAwizBwj
         cQ2PSv3eCw8wg==
Date:   Thu, 7 Dec 2023 18:57:42 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Tycho Andersen <tycho@tycho.pizza>, Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Tycho Andersen <tandersen@netflix.com>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
Message-ID: <20231207-weither-autopilot-8daee206e6c5@brauner>
References: <20231130163946.277502-1-tycho@tycho.pizza>
 <20231130173938.GA21808@redhat.com>
 <ZWjM6trZ6uw6yBza@tycho.pizza>
 <ZWoKbHJ0152tiGeD@tycho.pizza>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWoKbHJ0152tiGeD@tycho.pizza>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 09:31:40AM -0700, Tycho Andersen wrote:
> On Thu, Nov 30, 2023 at 10:57:01AM -0700, Tycho Andersen wrote:
> > On Thu, Nov 30, 2023 at 06:39:39PM +0100, Oleg Nesterov wrote:
> > > I think that wake_up_all(wait_pidfd) should have a single caller,
> > > do_notify_pidfd(). This probably means it should be shiftef from
> > > do_notify_parent() to exit_notify(), I am not sure...
> 
> Indeed, below passes the tests without issue and is much less ugly.

So I think I raised that question on another medium already but what
does the interaction with de_thread() look like?

Say some process creates pidfd for a thread in a non-empty thread-group
is created via CLONE_PIDFD. The pidfd_file->private_data is set to
struct pid of that task. The task the pidfd refers to later exec's.

Once it passed de_thread() the task the pidfd refers to assumes the
struct pid of the old thread-group leader and continues.

At the same time, the old thread-group leader now assumes the struct pid
of the task that just exec'd.

So after de_thread() the pidfd now referes to the old thread-group
leaders struct pid. Any subsequent operation will fail because the
process has already exited.

Basically, the pidfd now refers to the old thread-group leader and any
subsequent operation will fail even though the task still exists.

Conversely, if someone had created a pidfd that referred to the old
thread-group leader task then this pidfd will now suddenly refer to the
new thread-group leader task for the same reason: the struct pid's were
exchanged.

So this also means, iiuc, that the pidfd could now be passed to
waitid(P_PIFD) to retrieve the status of the old thread-group leader
that just got zapped.

And for the case where the pidfd referred to the old thread-group leader
task you would now suddenly _not_ be able to wait on that task anymore.

If these concerns are correct, then I think we need to decide what
semantics we want and how to handle this because that's not ok.
