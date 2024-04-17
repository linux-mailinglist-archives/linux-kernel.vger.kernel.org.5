Return-Path: <linux-kernel+bounces-149177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D798A8CE2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B901F22298
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AE538FA6;
	Wed, 17 Apr 2024 20:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdwuKo15"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778E72C6A3;
	Wed, 17 Apr 2024 20:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713385662; cv=none; b=jfiZTGvSA4jvfjPTN/xkt90RYNeCsFqzYVSZMGclOwIrULyQEFWtnclkalqMyN1zf0+hyUHNixbJJU1wthb+u9sXaIbkNCyDTOgn26+IhaET7DRKgyLlrV0m1cSpIXHJFKuqz8zSoKx/lmryK/L9T820HWCnBikz/XaVkspCCW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713385662; c=relaxed/simple;
	bh=Z9pNx1Mt7ZGOKQJxFKT2T5nxfBwahM5BD/lPw2d3TJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rby56/REz1GdlTRLotMGSYNZPKLP4nFhy+dZnKKTG4Le9+84yybmhZUoZhDVeQ34wgW4Z0jECkyeGRCpF3dU2SXkZ8nh+a1zgivgY06pyFhXrH1TwXnA07xHuFYmqXXGirdil/bUgpqtTb9NEYvJUV+Fo2LJrtp1GSx3oW3OS88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdwuKo15; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516d0161e13so89435e87.3;
        Wed, 17 Apr 2024 13:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713385658; x=1713990458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wogXkpt1TDERRUg+fbxNgUqpjHmEeqKge3cy0SLNVDM=;
        b=XdwuKo15WT0/gLVdnQbabKaA79LZDPp0OyNdzivfpZzBsKx3Ra6q+TBZeuG5XSpKA8
         YD3WrTr3HusxRZOD6R6PUzmLhq6PUo/Drks1Tw0eWRCQRLxJqejF2WrNp6NQ1vNzlf+d
         OmU9aT4B4IrB0+NNBW38t7bKisVJLCR7vY6WYnfyCIRSWVDHiAZYiYnAKQoCRAu+SvjG
         goa7L/X1pnW5XJcjS+fFeFS0UZ72TXr0K8YWENlY3Ql9aL7suOOLN3jO24Kh4qqSMz/+
         Nac3bJ6DDyygjApWztotKeAjWdFU4gs32cdN/sfLvEP64941DZr4ZnWULD1Z8uQE3aJa
         eobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713385658; x=1713990458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wogXkpt1TDERRUg+fbxNgUqpjHmEeqKge3cy0SLNVDM=;
        b=Ie6zXliLhKTUmYwsLqOnaBmzjhAHdE0JfLhESybb3BNQiU/OFwfjMp9tGMFb6j4ehB
         AWQDeL4gZhunA/PzL1HJYlcauPHJcZqrcfecpMdo4pInrOB+xEvSjuGv36XDfAYjzGYl
         5KYYn+j2JEaPa0hbAQzSLIDJrzTDIV+Tt0YWKQBC4/wMU4MPTwgPj3Gw2gwU90ZqzW18
         Rr+D1tXd7Uop4pF3zlkREhHPsYz28K4ZbaFooH9yNBs8K51EN0KULL67+84/vd5W2wSv
         JmLgZ9ehcw1NoMb6GHfNvJYdBOQgS6rX6+CSuHETORGZBcNlPDPbCTX8ejj1NPDRdbCS
         ScUw==
X-Forwarded-Encrypted: i=1; AJvYcCUuglRWh60UmTfP7nN7bXohgbLtL6EwLqwrPfuZPLQzoiwnaWI6qPXiVgrf70Kd4Ci+dEUl4LiXyGNhjM8j0CLaryv9K93E6VG7+gi1
X-Gm-Message-State: AOJu0YysVHBgkcbP6Jjq/2KyLx9MfiT75LG6YwHHjOtwsjPicjx1rGM1
	65YKUuSXBeySnf+K+hmZIudixdWl5wRSyVSR4fRa09YusBsinzTv
X-Google-Smtp-Source: AGHT+IG/8iinXPJHUp/FHMLm9h7bKgFee2CBaZRIwsGGMcMcE1cL9w9/psU5OtGrj9VtdAuVdUaNlg==
X-Received: by 2002:a05:6512:158d:b0:519:591b:6d7a with SMTP id bp13-20020a056512158d00b00519591b6d7amr311208lfb.7.1713385658245;
        Wed, 17 Apr 2024 13:27:38 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id s3-20020a056402164300b00562d908daf4sm1565edx.84.2024.04.17.13.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 13:27:37 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 John Watts <contact@jookia.org>
Cc: linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>, John Watts <contact@jookia.org>
Subject:
 Re: [PATCH] ASoC: sunxi: sun4i-i2s: Fix pcm_formats type specification
Date: Wed, 17 Apr 2024 22:27:36 +0200
Message-ID: <1928580.taCxCBeP46@jernej-laptop>
In-Reply-To: <20240417-sunxi_s32_fix-v1-1-d82e451565c0@jookia.org>
References: <20240417-sunxi_s32_fix-v1-1-d82e451565c0@jookia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne sreda, 17. april 2024 ob 07:14:43 GMT +2 je John Watts napisal(a):
> pcm_formats should be a u64 as it is a SNDRV_PCM_FMTBIT_* not a
> SNDRV_PCM_FORMAT_*.
> 
> Also fix a small grammar error while we're here.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404170103.ySYwieqi-lkp@intel.com/
> Signed-off-by: John Watts <contact@jookia.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
> This is a quick fix for a type error found by the kernel test robot.
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 59830f2a0d30..5f8d979585b6 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -156,7 +156,7 @@ struct sun4i_i2s;
>  /**
>   * struct sun4i_i2s_quirks - Differences between SoC variants.
>   * @has_reset: SoC needs reset deasserted.
> - * @pcm_formats: available PCM formats
> + * @pcm_formats: available PCM formats.
>   * @reg_offset_txdata: offset of the tx fifo.
>   * @sun4i_i2s_regmap: regmap config to use.
>   * @field_clkdiv_mclk_en: regmap field to enable mclk output.
> @@ -176,7 +176,7 @@ struct sun4i_i2s;
>   */
>  struct sun4i_i2s_quirks {
>  	bool				has_reset;
> -	snd_pcm_format_t		pcm_formats;
> +	u64				pcm_formats;
>  	unsigned int			reg_offset_txdata;	/* TX FIFO */
>  	const struct regmap_config	*sun4i_i2s_regmap;
>  
> 
> ---
> base-commit: 66e4190e92ce0e4a50b2f6be0e5f5b2e47e072f4
> change-id: 20240417-sunxi_s32_fix-ef5354b40fb4
> 
> Best regards,
> 





