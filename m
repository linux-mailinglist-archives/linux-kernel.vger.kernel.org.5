Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAD47E809C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344415AbjKJSNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjKJSMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:12:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B2D76A8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 23:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699602153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r80TQKEZJvJoUBFoArIynTXpNbKCuJp883mFJbRS71Y=;
        b=U2Y+L+WWOujIxhX4Hk42yTZ0ItBKPISNXRRBr4BMfeT6vfYLSsYFs48ehTbNaDr1SkevNh
        qGMa+MfBxF4rhaO3On5cEemEQYVHf3DWrCBns5g+j7gwzxGG0oOO3YhlTZjxbWdQ9Cja+Z
        k6CHOjXy05Ofw6myruCZCemKkuyOVvI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-SWr2flEXMNqZRy_Z4EppCw-1; Fri, 10 Nov 2023 02:42:29 -0500
X-MC-Unique: SWr2flEXMNqZRy_Z4EppCw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C84088D584;
        Fri, 10 Nov 2023 07:42:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.27])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3ABFB502A;
        Fri, 10 Nov 2023 07:42:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 10 Nov 2023 08:41:26 +0100 (CET)
Date:   Fri, 10 Nov 2023 08:41:23 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     chenqiwu <qiwuchen55@gmail.com>
Cc:     axboe@kernel.dk, keescook@chromium.org, akpm@linux-foundation.org,
        mcgrof@kernel.org, ebiederm@xmission.com, jannh@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exit: dump thread info on global init exit
Message-ID: <20231110074123.GA7768@redhat.com>
References: <20231108081506.149016-1-qiwu.chen@transsion.com>
 <20231108095732.GA3678@redhat.com>
 <20231109071341.GA14505@rlk>
 <20231109110129.GB12330@redhat.com>
 <20231110022720.GA3087@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110022720.GA3087@rlk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10, chenqiwu wrote:
>
> On Thu, Nov 09, 2023 at 12:01:30PM +0100, Oleg Nesterov wrote:
> > I've just noticed we discuss this offlist. Add lkml...
> >
> > On 11/09, chenqiwu wrote:
> > >
> > > On Wed, Nov 08, 2023 at 10:57:32AM +0100, Oleg Nesterov wrote:
> > >
> > > > > +	if (mmap_read_lock_killable(mm)) {
> > > >
> > > > why do you need _killable ?
> > > >
> > > I'm not sure which type lock (killable or unkillable) should be used here
> >
> > killable should be used to allow to kill the task which waits for this lock.
> > Who can kill the global init? Yes it is possible (but very unlikely) that
> > fatal_signal_pending() is true, but I don't think this was your concern.
> >
> > > if there is a lock contention, perhaps using down_read_trylock is better.
> >
> > Perhaps. If we have another bug mmap_read_lock() can hang forever.
> >
> Yes, but we really don't want to hang here forever if we cannot get the mmap read
> lock.

Yes, this is what I tried to say.

> I think using down_read_trylock should be better, I wiil resend the patch as
> V2 cc LKML to discuss the thing.

OK.

> > > > > +static void dump_thread_info(struct task_struct *tsk)
> > > > > +{
> > > > > +	struct pt_regs *regs = task_pt_regs(tsk);
> > > > > +
> > > > > +	if (user_mode(regs))
> > > > > +		dump_thread_maps_info(tsk);
> > > > > +	show_regs(regs);
> > > >
> > > > This looks confusing to me...
> > > >
> > > > How can user_mode() return false in this case? And even if this is
> > > > possible, then show_regs() should depend on user_mode() as well?
> > > > I must have missed something.
> > > >
> > > Sure, the last global init thread cannot be exited in non-user mode.
> >
> > Forgot to mention... panic() should dump the regs, so I think show_regs()
> > is not needed?
> >
> In fact, panic don't dump the regs. For example, the current kill init panic log from Andriod system:

Hmm. OK, panic()->dump_stack() depends on CONFIG_DEBUG_BUGVERBOSE, so perhaps
Andriod runs without CONFIG_DEBUG_BUGVERBOSE... or perhaps show_stack() doesn't
do __show_regs() on arm64 ? I dunno.

OK, I see you have already sent V2.

Oleg.

