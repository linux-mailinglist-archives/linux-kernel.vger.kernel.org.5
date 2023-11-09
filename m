Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDC37E6915
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjKILD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjKILD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:03:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29386271C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 03:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699527763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jduw0JNu+/2Yz2uO1ZuHOSLI0zVMzITtnyRkYjjO+Mo=;
        b=gHGiMMmJxNpTjTmaMkmn9hQbEliRQLJhRFX9Zk/PkowXZxohuOTzLdW+oV5oZBb6xsKu5R
        WL8AiV3xOq332RgH10ci2DbA/U44MG+fsl2GMyqmtyAqDnLG6B5cBv6Wpbzsl5oW+hBxEb
        9EFjyd4JQzRLmFMpYxDf05bSvuxSLSg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-PbzaV8vZMtWEXN4jLCw-xw-1; Thu,
 09 Nov 2023 06:02:36 -0500
X-MC-Unique: PbzaV8vZMtWEXN4jLCw-xw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 537753C40B4C;
        Thu,  9 Nov 2023 11:02:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.27])
        by smtp.corp.redhat.com (Postfix) with SMTP id 11EFD40C6EB9;
        Thu,  9 Nov 2023 11:02:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  9 Nov 2023 12:01:33 +0100 (CET)
Date:   Thu, 9 Nov 2023 12:01:30 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     lijiazi <qiwuchen55@gmail.com>
Cc:     christian.brauner@ubuntu.com, axboe@kernel.dk,
        keescook@chromium.org, akpm@linux-foundation.org,
        mcgrof@kernel.org, ebiederm@xmission.com, jannh@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exit: dump thread info on global init exit
Message-ID: <20231109110129.GB12330@redhat.com>
References: <20231108081506.149016-1-qiwu.chen@transsion.com>
 <20231108095732.GA3678@redhat.com>
 <20231109071341.GA14505@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109071341.GA14505@rlk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've just noticed we discuss this offlist. Add lkml...

On 11/09, lijiazi wrote:
>
> On Wed, Nov 08, 2023 at 10:57:32AM +0100, Oleg Nesterov wrote:
>
> > > +	if (mmap_read_lock_killable(mm)) {
> >
> > why do you need _killable ?
> >
> I'm not sure which type lock (killable or unkillable) should be used here

killable should be used to allow to kill the task which waits for this lock.
Who can kill the global init? Yes it is possible (but very unlikely) that
fatal_signal_pending() is true, but I don't think this was your concern.

> if there is a lock contention, perhaps using down_read_trylock is better.

Perhaps. If we have another bug mmap_read_lock() can hang forever.

> > > +static void dump_thread_info(struct task_struct *tsk)
> > > +{
> > > +	struct pt_regs *regs = task_pt_regs(tsk);
> > > +
> > > +	if (user_mode(regs))
> > > +		dump_thread_maps_info(tsk);
> > > +	show_regs(regs);
> >
> > This looks confusing to me...
> >
> > How can user_mode() return false in this case? And even if this is
> > possible, then show_regs() should depend on user_mode() as well?
> > I must have missed something.
> >
> Sure, the last global init thread cannot be exited in non-user mode.

Forgot to mention... panic() should dump the regs, so I think show_regs()
is not needed?

Oleg.

