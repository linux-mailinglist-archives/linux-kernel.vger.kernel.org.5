Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1EB75E2A9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 16:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjGWOcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 10:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGWOcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 10:32:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A2710E3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 07:32:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B90A360DC0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 14:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934A5C433C8;
        Sun, 23 Jul 2023 14:32:11 +0000 (UTC)
Date:   Sun, 23 Jul 2023 10:32:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     <kkabe@vega.pgw.jp>
Cc:     regressions@lists.linux.dev, bagasdotme@gmail.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: Re: radeon.ko/i586: BUG: kernel NULL pointer
 dereference,address:00000004
Message-ID: <20230723103210.4b1b032e@rorschach.local.home>
In-Reply-To: <230723205506.M0106064@vega.pgw.jp>
References: <230722113014.M0204460@vega.pgw.jp>
        <230723205506.M0106064@vega.pgw.jp>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Sun, 23 Jul 2023 20:55:06 +0900
<kkabe@vega.pgw.jp> wrote:

> So I tried to trap NULL and return:
> 
> ================ patch-drm_vblank_cancel_pending_works-printk-NULL-ret.patch
> diff -up ./drivers/gpu/drm/drm_vblank_work.c.pk2 ./drivers/gpu/drm/drm_vblank_work.c
> --- ./drivers/gpu/drm/drm_vblank_work.c.pk2	2023-06-06 20:50:40.000000000 +0900
> +++ ./drivers/gpu/drm/drm_vblank_work.c	2023-07-23 14:29:56.383093673 +0900
> @@ -71,6 +71,10 @@ void drm_vblank_cancel_pending_works(str
>  {
>  	struct drm_vblank_work *work, *next;
>  
> +	if (!vblank->dev) {
> +		printk(KERN_WARNING "%s: vblank->dev == NULL? returning\n", __func__);
> +		return;
> +	}
>  	assert_spin_locked(&vblank->dev->event_lock);
>  
>  	list_for_each_entry_safe(work, next, &vblank->pending_work, node) {
> ================
> 
> This time, the printk trap does not happen!! and radeon.ko works.
> (NULL check for vblank->worker is still fireing though)
> 
> Now this is puzzling.
> Is this a timing issue?

It could very well be. And the ftrace patch could possibly not be the
cause at all. But the thread that is created to do the work is causing
the race window to be opened up, which is why you see it with the patch
and don't without it. It may not be the problem, it may just tickle the
timings enough to trigger the bug, and is causing you to go on a wild
goose chase in the wrong direction.

-- Steve


> Is systemd-udevd doing something not favaorble to kernel?
> Is drm vblank code running without enough initialization?
> 
> Puzzling is, that purely useland activity
> (logging in on tty1 before radeon.ko load)
> is affecting kernel panic/no-panic.

