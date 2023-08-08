Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216C7774B9C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbjHHUvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjHHUui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:50:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0F0110752;
        Tue,  8 Aug 2023 09:46:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A82062445;
        Tue,  8 Aug 2023 08:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184BEC433C9;
        Tue,  8 Aug 2023 08:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691483297;
        bh=Djk8mLxd+Qv4AQ1frLgSkodP5pGCBCHr0ci1b1vDP7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BNzHXKKuW9lHvuBNDCS1RHJmhFsVODNnXd16zMlsLGK76bwVpjSfmnoC5uE64kg/n
         5Dmiil6Tu+9hLUEyn92V6w7564PoTEGKe6NElZFgMI77TuLzy9ut5/pFiBmckKxYs2
         t59MEiB5pG5TIPbPvNzW6TW5TfrltVuSbqMSvYp8=
Date:   Tue, 8 Aug 2023 10:28:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     gustavoars@kernel.org, u.kleine-koenig@pengutronix.de,
        giometti@linux.it, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: host: oxu210hp-hcd: Fix potential deadlock on
 &oxu->mem_lock
Message-ID: <2023080817-antler-enchilada-cccf@gregkh>
References: <20230729092634.78336-1-dg573847474@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729092634.78336-1-dg573847474@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 09:26:34AM +0000, Chengfeng Ye wrote:
> &oxu->mem_lock is acquired by isr oxu_irq() along the below call
> chain under hardirq context.
> 
> <hard interrupt>
>         -> oxu_irq()
>         -> oxu210_hcd_irq()
>         -> ehci_work()
>         -> scan_async()
>         -> qh_completions()
>         -> oxu_murb_free()
>         -> spin_lock(&oxu->mem_lock)
> 
> Thus the acquisition of the lock under process context should disable
> irq, otherwise deadlock could happen if the irq happens to preempt the
> execution while the lock is held in process context on the same CPU.
> 
> This flaw was found by an experimental static analysis tool I am developing
> for irq-related deadlock. x86_64 allmodconfig using gcc shows no new
> warning.
> 
> The patch fixes the potential deadlocks by using spin_lock_irqsave() on
> &oxu->mem_lock
> 
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> 
> Changes in v2
> - use spin_lock_irqsave() on more potential deadlock sites of &oxu->mem_lock

This needs to be below the --- line, as documented, so it doesn't show
up in the changelog.

How did you test this change?  Do you have hardware to test it out?  If
not, I don't think we can accpet this, see the kernel documentation for
what we accept from tools and researchers.

thanks,

greg k-h
