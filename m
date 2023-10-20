Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218C67D09B6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 09:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376430AbjJTHsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 03:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbjJTHsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 03:48:41 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0215EE8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 00:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IaUvHvf8Dgzxm7NYbMB7ToEmLLG4rPc01nfYboIRTVM=;
  b=hpx2qlYp2mxSWdOkDwoENgxhYKBtvWsc/CHLQzj3bi3a+lsqERaUr7QO
   9nu4FRCWcwcs8jvyPTdDFGCgkoh10r3M2xFlv/ZxT/SCcxNvB9MGBqYkK
   pirRrb8n4dzthvnF9N6xio06F2PQSUrD7SlXnJ0iuVZj2osq6A5K8jwMH
   Q=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,238,1694728800"; 
   d="scan'208";a="132264898"
Received: from dhcp-138-246-3-50.dynamic.eduroam.mwn.de (HELO hadrien) ([138.246.3.50])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 09:48:36 +0200
Date:   Fri, 20 Oct 2023 09:48:35 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     kenechukwu maduechesi <maduechesik@gmail.com>
cc:     shreeya.patel23498@gmail.com, outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Add parenthesis to macro arguments
In-Reply-To: <20231020065439.GA3579@ubuntu>
Message-ID: <d22ddf2b-39ab-c47-a0e1-d051ddc1aed5@inria.fr>
References: <20231020065439.GA3579@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Oct 2023, kenechukwu maduechesi wrote:

> Checkpatch suggests using (reg) and (host) instead of reg and host
>
> The use of parenthesis in the macro argument '(reg)' ensures proper
> precedence and resolves potential issues that may arise due to the
> surrounding code context. This modification adheres to the recommended
> coding style and improves the readability or maintainability of the
> code.
>
> Signed-off-by: kenechukwu maduechesi <maduechesik@gmail.com>
> ---
>  drivers/staging/rts5208/rtsx.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/staging/rts5208/rtsx.h b/drivers/staging/rts5208/rtsx.h
> index 2e101da83220..7d3373797eb4 100644
> --- a/drivers/staging/rts5208/rtsx.h
> +++ b/drivers/staging/rts5208/rtsx.h
> @@ -39,17 +39,17 @@
>  /*
>   * macros for easy use
>   */
> -#define rtsx_writel(chip, reg, value) \
> +#define rtsx_writel(chip, (reg), value) \
>  	iowrite32(value, (chip)->rtsx->remap_addr + reg)

I don't think this code has been subjected to the compiler.  Note that you
can't comiple a .h file directly; you have to find some other file that
includes it.  It may be useful to run make path/to/cfile.i (for some
cfile.c) to see if the specific code you changed it included in the
configuration or is discarded by the preprocessor.

In any case, you have put () in the argument list of a macro, for reg,
which is not correct.  The parentheses for chip are ok.

> -#define rtsx_readl(chip, reg) \
> +#define rtsx_readl(chip, (reg) \

Here you have broken the argument list of the macro completely, because
the parentheses are not balanced.

>  	ioread32((chip)->rtsx->remap_addr + reg)
> -#define rtsx_writew(chip, reg, value) \
> +#define rtsx_writew(chip, (reg), value) \
>  	iowrite16(value, (chip)->rtsx->remap_addr + reg)
> -#define rtsx_readw(chip, reg) \
> +#define rtsx_readw(chip, (reg)) \
>  	ioread16((chip)->rtsx->remap_addr + reg)
> -#define rtsx_writeb(chip, reg, value) \
> +#define rtsx_writeb(chip, (reg), value) \
>  	iowrite8(value, (chip)->rtsx->remap_addr + reg)
> -#define rtsx_readb(chip, reg) \
> +#define rtsx_readb(chip, (reg)) \
>  	ioread8((chip)->rtsx->remap_addr + reg)
>
>  #define rtsx_read_config_byte(chip, where, val) \
> @@ -131,8 +131,8 @@ static inline struct rtsx_dev *host_to_rtsx(struct Scsi_Host *host)
>   * The scsi_lock() and scsi_unlock() macros protect the sm_state and the
>   * single queue element srb for write access
>   */
> -#define scsi_unlock(host)	spin_unlock_irq(host->host_lock)
> -#define scsi_lock(host)		spin_lock_irq(host->host_lock)
> +#define scsi_unlock(host)	spin_unlock_irq((host)->host_lock)
> +#define scsi_lock(host)		spin_lock_irq((host)->host_lock)

I also wonder if someone has worked on this code already?  There was
a suggestion to just drop these macros and use the standard kernel
functions.  Maybe your kernel tree is not up to date.

julia

>  #define lock_state(chip)	spin_lock_irq(&((chip)->rtsx->reg_lock))
>  #define unlock_state(chip)	spin_unlock_irq(&((chip)->rtsx->reg_lock))
> --
> 2.25.1
>
>
>
