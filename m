Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E1A7887C0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244332AbjHYMsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244910AbjHYMrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:47:43 -0400
X-Greylist: delayed 5222 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Aug 2023 05:47:41 PDT
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3006::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F18E1BE2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202212; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4fORvnyTFCcal4ymvAabYEtTRuLBNmZwVaPYVJ/waps=; b=YX19gxmUnhAih3uS8NAfVxGvqT
        0gHk7yZ2cTk0lgp0AGQ+dlUe0foHmlJqB2Jj9Q9GsuCls/3DbLlvCZjlyjeRPH3EytJ0ezzyhN5/y
        ePflMfmO3gSHoWOfuGevkkLqyplMw5K1c6sog4ziX6vUo95/tjGWe2mXrb/CecRfizi7OVp/49bFn
        /1QJFzxCs6lG4iais7dEl60vL5bJm5XYgDMv5Wgr/T2F9DOYxExhC2jK29nKeAtNAYt+FHE+ACcE2
        FJFRddZVd91B3/bVyP27SmZIHn77oQZKFlBb5zKM1uerNqm0TCU5EfAAt9oOCUTsIjQ+UR7p0WEwl
        TBRYaVjw==;
Received: from [2a01:799:95f:2800:2fb5:c6db:11b1:a10f] (port=48232)
        by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <noralf@tronnes.org>)
        id 1qZUrO-0023Ou-Lw;
        Fri, 25 Aug 2023 13:20:14 +0200
Message-ID: <0187d72b-e8d6-db6d-ef66-1dde1faf128f@tronnes.org>
Date:   Fri, 25 Aug 2023 13:20:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/repaper: fix -Wvoid-pointer-to-enum-cast warning
Content-Language: en-US
To:     Justin Stitt <justinstitt@google.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, noralf@tronnes.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20230816-void-drivers-gpu-drm-tiny-repaper-v1-1-9d8d10f0d52f@google.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20230816-void-drivers-gpu-drm-tiny-repaper-v1-1-9d8d10f0d52f@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/23 21:55, Justin Stitt wrote:
> When building with clang 18 I see the following warning:
> |       drivers/gpu/drm/tiny/repaper.c:952:11: warning: cast to smaller integer
> |       type 'enum repaper_model' from 'const void *' [-Wvoid-pointer-to-enum-cast]
> |         952 |                 model = (enum repaper_model)match;
> |
> 
> This is due to the fact that `match` is a void* while `enum repaper_model`
> has the size of an int.
> 
> Add uintptr_t cast to silence clang warning while also keeping enum cast
> for readability and consistency with other `model` assignment just a
> few lines below:
> |       model = (enum repaper_model)spi_id->driver_data;
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1910
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---

Thanks, applied to drm-misc-next.

Noralf.

>  drivers/gpu/drm/tiny/repaper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
> index c2677d081a7b..165f2099e7d8 100644
> --- a/drivers/gpu/drm/tiny/repaper.c
> +++ b/drivers/gpu/drm/tiny/repaper.c
> @@ -949,7 +949,7 @@ static int repaper_probe(struct spi_device *spi)
>  
>  	match = device_get_match_data(dev);
>  	if (match) {
> -		model = (enum repaper_model)match;
> +		model = (enum repaper_model)(uintptr_t)match;
>  	} else {
>  		spi_id = spi_get_device_id(spi);
>  		model = (enum repaper_model)spi_id->driver_data;
> 
> ---
> base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
> change-id: 20230816-void-drivers-gpu-drm-tiny-repaper-a08321cd99d7
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
