Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54E978DD04
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243292AbjH3Sr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344010AbjH3R5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:57:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE50BE;
        Wed, 30 Aug 2023 10:57:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58FA4620A3;
        Wed, 30 Aug 2023 17:57:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A395C433C7;
        Wed, 30 Aug 2023 17:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693418264;
        bh=7W67d4uHZx8ajrE+AREOx4IigFIIZor8rqkBDeQvMJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OLHkY9OhI80JbtlD7N/Cxgq0zP3p6QW4HGRHg1+n9m0NGjIkyVEk+1mPYO+GNqX7i
         g/BeVBWxc1FLg/sYMIaRJEau45F73DyIVz0hkHp25+O/zWAJYkRJNXQKvU8wC/f+nZ
         MkuPE8G86R+nVwdE1Piox6loaLtKj+V83SwrsifQ=
Date:   Wed, 30 Aug 2023 19:57:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] vt: Fix potential read overflow of kernel memory
Message-ID: <2023083035-unpadded-amulet-8c7e@gregkh>
References: <20230830160410.3820390-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830160410.3820390-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 04:04:10PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit if
> a source string is not NUL-terminated [1].

But that's not the case here, right?  So your "potential read overflow"
isn't relevant here.

> The copy_to_user() call uses @len returned from strlcpy() directly
> without checking its value. This could potentially lead to read
> overflow.

But can it?  How?

Those are all hard-coded strings, in the kernel source, there is no
potential overflow here.

And you know the buffer size is correct as well.

So why even check?

> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>  drivers/tty/vt/keyboard.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index 358f216c6cd6..15359c328a23 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -2079,12 +2079,15 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
>  			return -ENOMEM;
> 
>  		spin_lock_irqsave(&func_buf_lock, flags);
> -		len = strlcpy(kbs, func_table[kb_func] ? : "", len);
> +		len = strscpy(kbs, func_table[kb_func] ? : "", len);
>  		spin_unlock_irqrestore(&func_buf_lock, flags);
> 
> +		if (len < 0) {
> +			ret = -EFAULT;
> +			break;
> +		}

Don't check for impossible things please.

thanks,

greg k-h
