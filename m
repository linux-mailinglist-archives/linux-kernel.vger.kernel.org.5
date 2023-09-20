Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71027A82F2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbjITNJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbjITNJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:09:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204D21B7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:08:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BDD6521C00;
        Wed, 20 Sep 2023 13:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695215330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZNNjjHKGzFsgYCWcXiYg2UfEdGAFaY3R4tUcgu0Pvqg=;
        b=rcPPjo1nGFadAtj91wS80q0UFFan7yt5cTgnwBUfH0zRJ+ootYduHvpC2hHedVk5m+D/qi
        MmYhkHZCVNIPpCy1bSqEZvE2Y1USyeOgWJbmDCd4jOuv0Mv9Hn++Vzg5GiNIg1p3h4MSST
        CaQB+ZxbESlHW+b+JO8G0RNOkQX7FMI=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 801462C143;
        Wed, 20 Sep 2023 13:08:50 +0000 (UTC)
Date:   Wed, 20 Sep 2023 15:08:50 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk/nbcon: Add assert that CPU migration is disabled
 when calling nbcon_context_try_acquire()
Message-ID: <ZQru4sOkaxR_aMC6@alley>
References: <20230920125136.15504-1-pmladek@suse.com>
 <874jjpt2xz.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jjpt2xz.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-09-20 15:06:08, John Ogness wrote:
> On 2023-09-20, Petr Mladek <pmladek@suse.com> wrote:
> > The nbcon console is locked when the 'prio' and 'cpu' fields in
> > console->nbcon_state stay the same. The locking algorithm would
> > break when the locked context got migrated to another CPU.
> >
> > Add assert into nbcon_context_try_acquire(). It would warn when
> > the function is called in a context where the CPU migration
> > is possible.
> 
> static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
> {
>         unsigned int cpu = smp_processor_id();
> 
> Doesn't smp_processor_id() already provide the necessary checking and
> warning?

Ah, I have missed it. Please, forgot this patch.

Best Regards,
Petr
