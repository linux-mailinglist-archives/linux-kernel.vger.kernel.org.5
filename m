Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7636799E78
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 15:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245516AbjIJNVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 09:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbjIJNVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 09:21:51 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC1BCD1;
        Sun, 10 Sep 2023 06:21:46 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31fa15f4cc6so267364f8f.2;
        Sun, 10 Sep 2023 06:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694352105; x=1694956905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3yiYILhEuCNUQeqPmsTOJF5pdnP1MyjjDZaseeFDik=;
        b=Qfsa0ZJkXvfx2fWGbnqj2cvUSoJE+9XvTFJVaX4o3MLsI7RoRclfuWx8bgaBWcM2nt
         JR/R6Np5tRfM52pCxuYbz/iBQbTF2syYME2My4SABEzgB/bB8hbi6GI702h2qComZZdh
         rNASCD5EyP5UmSze0t/yJ06lD4Z8fdqYf/yoOGj9ui+82Ipw3uAQTjij8qY+HQpVqWpA
         dAtr8jjV/N5F4Sd/KW4Dl9ZPWiiVGG8mdKXN9gw3+mNCxoPl1khTtgH4i2qq+qRTVwM3
         60cc+lcmz1JYs4fR8Q4w8Gp6R9jhL7vu+uHi4K/SIdvqQRjt5sT0CtEXKxTgzAdyicph
         ipfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694352105; x=1694956905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3yiYILhEuCNUQeqPmsTOJF5pdnP1MyjjDZaseeFDik=;
        b=FcQoc/2CuCo15IkXe8lkrjbVzLthOqyu4qDnyIc9osOdUDqjm7dR7nUB0k6DOavXsG
         +KHIDxDoFCl6VO5k8yKhC43ZTAL1CNvi70GmrF82DaAjMkavZImlQY+7Cwx7/qT0w8aq
         Tzaxnrc/E+6Elu9nJRZoN5hR8Bt1Ci7bXkIS/08cNTPWQYetoIhngFPSXRebZwfufJ3s
         lvfgGKkcuN2CIkWZ4S65cXs4JDP+/jyq3cyYTgkoN6L4bUXvGRHvHiqZH4OX0jYk01+0
         cjJY5/WNcaCnmyNQ0xShIcL5LM9JQIooNsIDhJQ6nsEwbFpd6RmguKrHfnyaiWntMZev
         X+Iw==
X-Gm-Message-State: AOJu0YxgbKU5LV1AKAedFyr/53CewILvfgkp3V1ujm4oJboRIQqivJok
        gP2keOb/xUfIPHQmUICe1Q+vGenThNMKOLiw
X-Google-Smtp-Source: AGHT+IHBW5u0oYJcRGEvrYuxS4KJf+ofoX9BINJgRqjlcAtgbTBDPybxSD7j2EjBbYgPCuTfVGTdFA==
X-Received: by 2002:a5d:4809:0:b0:317:73d3:441a with SMTP id l9-20020a5d4809000000b0031773d3441amr5628694wrq.46.1694352104814;
        Sun, 10 Sep 2023 06:21:44 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id d22-20020aa7ce16000000b005233609e39dsm3358895edv.30.2023.09.10.06.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 06:21:44 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [PATCH v6 14/18] media: verisilicon: vp9: Use destination buffer height
 to compute chroma offset
Date:   Sun, 10 Sep 2023 15:21:41 +0200
Message-ID: <4856958.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20230901124414.48497-15-benjamin.gaignard@collabora.com>
References: <20230901124414.48497-1-benjamin.gaignard@collabora.com>
 <20230901124414.48497-15-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin!

Dne petek, 01. september 2023 ob 14:44:10 CEST je Benjamin Gaignard 
napisal(a):
> Source and destination buffer height may not be the same because
> alignment constraint are different.
> Use destination height to compute chroma offset because we target
> this buffer as hardware output.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Fixes: e2da465455ce ("media: hantro: Support VP9 on the G2 core")
> ---
>  drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
> b/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c index
> 6db1c32fce4d..1f3f5e7ce978 100644
> --- a/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
> +++ b/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
> @@ -93,9 +93,7 @@ static int start_prepare_run(struct hantro_ctx *ctx, const
> struct v4l2_ctrl_vp9_ static size_t chroma_offset(const struct hantro_ctx
> *ctx,
>  			    const struct v4l2_ctrl_vp9_frame 
*dec_params)
>  {
> -	int bytes_per_pixel = dec_params->bit_depth == 8 ? 1 : 2;
> -
> -	return ctx->src_fmt.width * ctx->src_fmt.height * bytes_per_pixel;
> +	return ctx->dst_fmt.width * ctx->dst_fmt.height * ctx->bit_depth / 
8;

Commit message doesn't mention bit_depth change at all. While I think there is 
no difference between dec_params->bit_depth and ctx->bit_depth, you shouldn't 
just use ordinary division. If bit_depth is 10, it will be rounded down. And 
if you decide to use bit_depth from context, please remove dec_params 
argument.

Best regards,
Jernej

>  }
> 
>  static size_t mv_offset(const struct hantro_ctx *ctx,




