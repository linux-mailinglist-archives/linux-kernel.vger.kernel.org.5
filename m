Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99957FC256
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345601AbjK1RkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345347AbjK1RkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:40:13 -0500
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E518D64
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:40:18 -0800 (PST)
Date:   Tue, 28 Nov 2023 12:40:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701193216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=INs2zZgjKSxCudQ4urP1DNFRoEn0+TxPVLEnF4N6OJI=;
        b=b302NC3gfpP27hEZZOIe+T5tsmwvJVErzX8kUCHeWMbrFdst8W4meCK43eU2fKX6vAsCw2
        yAJLib84C2pCW7vxReaCpzLzdEjmigAzL80YQak+PVNIqTxVNEohLWyCvpliBiiToKYVMB
        dFN7lH9hwG/YQT7CCKR2rn17QKmKzDM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Mike Christie <michael.christie@oracle.com>,
        Zqiang <qiang1.zhang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kthread: kthread_should_stop() checks if we're a kthread
Message-ID: <20231128174012.bfno4f3matn3d7cw@moria.home.lan>
References: <20231120221503.3378095-1-kent.overstreet@linux.dev>
 <ZWWzSZeyRuPDwBHZ@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWWzSZeyRuPDwBHZ@alley>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 10:30:49AM +0100, Petr Mladek wrote:
> Adding Andrew into Cc. He usually takes changes in kernel/kthread.c.
> 
> On Mon 2023-11-20 17:15:03, Kent Overstreet wrote:
> > bcachefs has a fair amount of code that may or may not be running from a
> > kthread (it may instead be called by a userspace ioctl); having
> > kthread_should_stop() check if we're a kthread enables a fair bit of
> > cleanup and makes it safer to use.
> > 
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > ---
> >  kernel/kthread.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/kthread.c b/kernel/kthread.c
> > index 1eea53050bab..fe6090ddf414 100644
> > --- a/kernel/kthread.c
> > +++ b/kernel/kthread.c
> > @@ -155,7 +155,8 @@ void free_kthread_struct(struct task_struct *k)
> >   */
> >  bool kthread_should_stop(void)
> >  {
> > -	return test_bit(KTHREAD_SHOULD_STOP, &to_kthread(current)->flags);
> > +	return (current->flags & PF_KTHREAD) &&
> > +		test_bit(KTHREAD_SHOULD_STOP, &to_kthread(current)->flags);
> >  }
> >  EXPORT_SYMBOL(kthread_should_stop);
> 
> I agree that it makes the API more safe because &to_kthread(current)
> is NULL when the process is not a kthread.
> 
> Well, I do not like the idea of quietly ignoring a misuse of
> the kthread_*() API. I would personally prefer to do:

It's only a misuse in the most pedantic sense, IMO.

Is it ever possible that with this change calling kthread_should_stop()
from a non-kthread could cause a problem?

> 
> // define this in include/linux/kthread.h
> static inline bool in_kthread(void)
> {
> 	return current->flags & PF_KTHREAD
> }
> 
> // add WARN() into kthread_should_stop()
> bool kthread_should_stop(void)
> {
> 	if (WARN_ON_ONCE(!in_kthread))
> 		return false;
> 
> 	return test_bit(KTHREAD_SHOULD_STOP, &to_kthread(current)->flags);
> }
> EXPORT_SYMBOL(kthread_should_stop);
> 
> 
> And use the following in bcachefs() code:
> 
> 	if (in_kthread() && kthread_should_stop())
> 		goto exit;

That's what bcachefs code does today, and forgetting to check
in_kthread() is a real footgun - particularly for other people starting
to work on the code.

So I could do a bch2_in_kthread() instead that does the in_kthread(
check, but then I have to make sure that people know to use
bch2_in_kthread() instead of in_kthread(). Not ideal.
