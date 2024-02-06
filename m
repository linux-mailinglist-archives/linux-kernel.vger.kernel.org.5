Return-Path: <linux-kernel+bounces-55143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E7A84B863
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F59E1F26031
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B90A132C0C;
	Tue,  6 Feb 2024 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="scbHvk29"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416BA12BF3B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231104; cv=none; b=Ka2yMNQOQibJ7t4X2vHZKglDCKTNle24V3XD8s+/puEhKtsicaLCYxdNkbj9Re27gxSSldq4pU9xIKCNl/09C13wpMpc6QPT05cWy4tjOiorxAj+rTdC6ARyDUCIl+gxTVOXepSoMQK2jfFBTenyEtQN0TdXslnvXmo+NhmMpm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231104; c=relaxed/simple;
	bh=RX9h8Gk2Az9Z2xtuxoRpWQXcmWahlB3msZHC4F0rGAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CHLJHxXOxyw79yrPK2t93IU7ejYZ0TovhZ+NN3qreWzBYyLB8CwH2F/CSGQEJNPfgrA2yHAtmO+CyMbYg+bQf1/WQ98DkZzAnvVV9OGy2REwfxSfpzi5LsxGH3nEEBmuLGV3HTaTf+AHP/rcjLz8HA0iTjYEcRNz2xpUkCtN+4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=scbHvk29; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55783b7b47aso1295461a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 06:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707231100; x=1707835900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vXiKICFUMp4cupYFDlAs4KtUHT8wkU7NDkai+RaSVpk=;
        b=scbHvk29dRkW/Ykn9mmtkR4yAlDt56dAQu6XyQwxOubWUsnfXuhudD1VVaE15KO0c8
         2GZluGkQ8VEvn6mz0hLKHwMxNMf5qDMXjepZ9o5JxCdzpbzd0TTZsKpXAfMG6kfk/A9F
         /qOSJxDQoa/dKowErB+DN+tuFt5dFpQGTvk5DDy/Wjc4px2wFEMHyaAa/8WYAdPmNjku
         MQcztNs0zdZzB38wI14UuSn2JfDjZfNCgETeUdz/H157PnGbALIYk9hMDUF3SpL8nkwN
         UygEr6t/qmugUyTP7W+sZxaxvgbRNJgPAlzf2tkCWHjMqIG9pcWYNzzaqGwZPmCmHpSq
         vD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707231100; x=1707835900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vXiKICFUMp4cupYFDlAs4KtUHT8wkU7NDkai+RaSVpk=;
        b=CJoU+2RNWSfXuVecn/u4ss5pHsSENtECeFRAgftp2B39uN2DzJdDytPBrb1jPx/YdP
         CnQ0cOOzh2jsQ0hfrUgjo4wmeGoljhXKPrJqJuLXV86061/TTdKLJO6ik6YOBMTRuMyB
         8gl7s0zNatUbUeNk8aFXGdwZVuDQaDgkr4esAELSo3QSDZbM/d9RcCIhjqWmOZZavDNN
         N/vtK19LENqXFZkLNEGb3UJW6WUof+3iF4tau68hxwoAd8iKPBxmvRJrCfLBNhOfGPdu
         AmThPzkUrZ/Cv5sjgIQkNbfb1+Lh2DF/IEp5pfEnBIOVH8dHnVbIxvalUCO3oTdDPLu1
         DSHw==
X-Gm-Message-State: AOJu0Yx778tn9xKjjj9xhiXBEJ5rkpxs6wpao3H1LrTBHmvMX7iVbLOn
	3AHjYyduF95o1DccGb1382H6U65/+cO51TUkXV2IVz6E1+qOWL9JZ8ebsd2I+Lw=
X-Google-Smtp-Source: AGHT+IGk/qAzmQdexrg//Spd63iGrgIA/GzcXA+iMKVhkBJiYtjxKIuf/ZU7NrSaSJk3CzFARyyORA==
X-Received: by 2002:a17:906:b30b:b0:a37:28e9:bfdc with SMTP id n11-20020a170906b30b00b00a3728e9bfdcmr2112593ejz.27.1707231100398;
        Tue, 06 Feb 2024 06:51:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWTqHSLrCXjFvE9Ul/QpJL+/GDuRyHitBIP/6fB8Teb21BawmrIMsaAkLtWbVD/1fuSeIp4tnlbj1FlEtNcsDjBZBuuCxRpdqv4Rbw1/0BlH1POEjjfMjbqqmc8pZcg5l1hc8E3Y0DpZ3vMXowY0gRoW0vRDePzr22Bty2PWPDkN64BgBK3OMnWBmVknsdGSzEGWt+mpapQ2N17qgZ7G3cNyo2+dEAHJ6Mwd5OAsWe/leT2nGe2b1wabbjziFMgWfjCwtt3GvX01vw69jTZwI1k0Z9gBLQcK4flOn3WgSObajdEcI+/de7T99EmBurySdMF9gt+e9F5hChjCaVGU5FHGgcqhp9MjWxHSnc35kUR9mKHW8UZg85Vyvx70N1RZdzt5/buyVJnjycYl1OTgtZ/SC83U1f4QQ2bSA==
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id d20-20020a1709061f5400b00a3785efe1c4sm1231091ejk.85.2024.02.06.06.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 06:51:39 -0800 (PST)
Message-ID: <06d0f56f-c27f-4d6a-9a88-e2932de29bf3@baylibre.com>
Date: Tue, 6 Feb 2024 15:51:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] drm/mediatek: dsi: Fix DSI RGB666 formats and
 definitions
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 chunkuang.hu@kernel.org
Cc: fshao@chromium.org, p.zabel@pengutronix.de, airlied@gmail.com,
 daniel@ffwll.ch, matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20240206120748.136610-1-angelogioacchino.delregno@collabora.com>
 <20240206120748.136610-3-angelogioacchino.delregno@collabora.com>
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240206120748.136610-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 06/02/2024 13:07, AngeloGioacchino Del Regno wrote:
> The register bits definitions for RGB666 formats are wrong in multiple
> ways: first, in the DSI_PS_SEL bits region, the Packed 18-bits RGB666
> format is selected with bit 1, while the Loosely Packed one is bit 2,
> and second - the definition name "LOOSELY_PS_18BIT_RGB666" is wrong
> because the loosely packed format is 24 bits instead!
> 
> Either way, functions mtk_dsi_ps_control_vact() and mtk_dsi_ps_control()
> do not even agree on the DSI_PS_SEL bit to set in DSI_PSCTRL: one sets
> loosely packed (24) on RGB666, the other sets packed (18), and the other
> way around for RGB666_PACKED.
> 
> Fixing this entire stack of issues is done in one go:
>   - Use the correct bit for the Loosely Packed RGB666 definition
>   - Rename LOOSELY_PS_18BIT_RGB666 to LOOSELY_PS_24BIT_RGB666
>   - Change ps_bpp_mode in mtk_dsi_ps_control_vact() to set:
>      - Loosely Packed, 24-bits for MIPI_DSI_FMT_RGB666
>      - Packed, 18-bits for MIPI_DSI_FMT_RGB666_PACKED

-- 
Regards,
Alexandre

