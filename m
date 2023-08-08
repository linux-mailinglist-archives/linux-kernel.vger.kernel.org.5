Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1B7773FDD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjHHQy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbjHHQxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:53:53 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF064FB17;
        Tue,  8 Aug 2023 08:58:51 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1691501337; bh=SC4V/QQjj+X/ZeY1IQLSw2kpaRNKgGjQtfK/LhrJ4fQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IlrW+S8F/ClLuxsmtFITKHC6AAKiWBKH5JPypWdJkxks7slcoZYVogkGBCXGk/MLR
         4zKFXQO2//XKvOmIOaTC+EwuoIm0R1s7FqPf+K/uXjtdGpFtRELBxJWw+BIiMu97Di
         10yHsFcZkfZqLkG6WMIwZWkwhqCkdNbjc5Wi63vQErIeT4/Nhldoj/qCiyJzQhVX0S
         JmcABNXUfqU35mE0hYgstmM+UUwUEKVMBH6uuSvB8SOpCEIGIJkvPScg/9gkMa+xvO
         GX3/2u+s6hh2CUjNCXk59TkBXOOy0hDvzqU+aSw59sB2U7NHrOE9mnNOvlBSWeBleV
         qX/Dp7HHLXM+A==
To:     Wang Ming <machel@vivo.com>, Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: Re: [PATCH net-next v3] wifi: ath9k: Remove error checking for
 debugfs_create_dir()
In-Reply-To: <20230726110750.3925-1-machel@vivo.com>
References: <20230726110750.3925-1-machel@vivo.com>
Date:   Tue, 08 Aug 2023 15:28:57 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87sf8tbr3a.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wang Ming <machel@vivo.com> writes:

> It is expected that most callers should _ignore_ the errors
> return by debugfs_create_dir() in ath9k_htc_init_debug().
>
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  drivers/net/wireless/ath/ath9k/htc_drv_debug.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
> index b3ed65e5c4da..85ad45771b44 100644
> --- a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
> +++ b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
> @@ -491,8 +491,6 @@ int ath9k_htc_init_debug(struct ath_hw *ah)
>  
>  	priv->debug.debugfs_phy = debugfs_create_dir(KBUILD_MODNAME,
>  					     priv->hw->wiphy->debugfsdir);
> -	if (!priv->debug.debugfs_phy)
> -		return -ENOMEM;

Hmm, so it's true that all the debugfs_create* functions deal correctly
with the dir pointer being an error pointer, which means that it's
possible to just ignore the return value of debugfs_create_dir() without
anything breaking. However, it also seems kinda pointless to have all
those calls if we know they're going to fail, so I prefer v1 of this
patch that just fixed the IS_ERR check. No need to resend, we can just
apply v1 instead...

-Toke
