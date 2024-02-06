Return-Path: <linux-kernel+bounces-55189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842BA84B8FD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD33289DB3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBEB135A57;
	Tue,  6 Feb 2024 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ShA3DbGG"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5455133299
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232183; cv=none; b=fW/XOteZYlAr8rc7k8kjGcaRalASOPPpJVr6LF7LAo9yrWZ8g3bAMbEVSXq3ZJ7DPfqtCTLMGnsunppg0vNYJp1jGnDxvzkc70wcEHO3eW0aS7MOfKgt1a66VQm+FkDz9tckgGPn5KNepEu/XOjVMBl2npCWDlRhkp7UEZiKt3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232183; c=relaxed/simple;
	bh=0oTgsZorF72M4MtGiHWvVgoALAqOILr1VnSmmmHka+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hTDiyqnNVMF2OeTTmVL2fBgEwLjiPqkeN90DZyvIAQKQ4IQZKGTgFRvTJ3nJujQ27K79nIfEXybZq5EUkFL1T+/VZuA1rGdv4kYK3+1O/JbWpueyjWi1FkweM/f4lZFz0VEyxFTdK0WfXRERYXLkG0owG7t0LakZm2iec5TSXIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ShA3DbGG; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d0abdde3easo27781591fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 07:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707232179; x=1707836979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WwVsqoGAIzE5l9Xu7dUQGRgCnLWg+E4gxnq7lDMjVy0=;
        b=ShA3DbGGq4S9Nf8+tfbTInhSaWp+jrm/qA+ZTQfTB/76b+sATE/CQwg7gVpe2xx62a
         hWjN5T16+RPZ63l/HlEx+M6KdXSVZjTIBV9MsL+sYPEGzsT2XPRy9rPUo3eeKG/OUvQb
         sNSsRH7drhNKYcAomG+WyhCTWWg3Y1ciKyoNsK5uTFw7nLnGv7UG2fZwEYlDCuFJl+EW
         hlOig/sJn0MW6P9/G7y1GkQq4hv6P5/W8NGW0hAcdIF1IDLzKmgLotCPWTsx0wyqIvG/
         1vTKCRsDgR2JUK5kREBZqrxZVmw2Cmw9gbUutqq/PuKpUJj2gXsC6iF9fSwzQLXHw11Y
         84nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707232179; x=1707836979;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WwVsqoGAIzE5l9Xu7dUQGRgCnLWg+E4gxnq7lDMjVy0=;
        b=kXhjucWrkmytHqt1hWWWonJtstsphWCmXDtNUOQtHt+rWgVrRkBKnnyumeow1+yASn
         Wg3yanSL8cbBPyxuzJFSk7DvGZnRIELjv4q7GAXcVVHj6hX6eXFR3bou1/84qCZk3Op7
         vetEi7R81TUpIjTKvA0UDLDa5vK12+0Ucxt7wmegu2oPdb1pmtUvIGaTqJfGVnmFd9RB
         bE435edY+bAUgYxM4BEnucUFYZGX/wEhSKbffdjvGPS8kBIAr8xZpot1bKyTkBKvV9X4
         oVecNTVcwaNiH2DAyEy4A8BJLJzHZgC3J2D4N/LIu2Y3mVTg/dwjotIR4upPuy1+A75b
         BI0g==
X-Gm-Message-State: AOJu0YxjYbt/ikn8NGXDKdnJTvPsJDSFJ7n07uR4rdJC6dz2M8pQjG5X
	PPPJ8PtOFkqA5kahQnC2WQ+GRN3q2Ek9slRCFS/qzzt2oon0g+eimmx5QCO0bAY=
X-Google-Smtp-Source: AGHT+IHIK03nqgzi0UIQjD/r5eQ2ej+6ZZNo5AQO8975rLcfk1byiQAQT6jFYjw/zsDV+iNnbg9VtQ==
X-Received: by 2002:ac2:5147:0:b0:511:3bd4:6a97 with SMTP id q7-20020ac25147000000b005113bd46a97mr2159245lfd.7.1707232178665;
        Tue, 06 Feb 2024 07:09:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVGkNAqTncHn8u9NySFFtDQqD8pscjT/JrKzey5HdYBYNb9Vz4cfuYJr7DavYYjySH0mR6+iOdinYPmM90PzTNIRnozIZN09rANAAbPujFAAY77eZBTuNuh80moOl4xO1aEGGxkyrKIEMMkZbFVyfaXr7OR1pn8OMlHfFW5voh4+4ayQFTuW/ADqVzBD4GFghg/qcCiL2gi/kUGqBklehKOZ/R0xTI5FrR8HuNeBPimYzIU5g8d/5hDTmzeiq89/xIGjYKgh6YadASA8qRf00j4DMprLo64d/4xKv5aE+Dq4INDxNnV4o2jO0kucyFKF46JqsNL7flwfzbEvNHqKstOIlemSLSTf6ClwPVh/JZX2A4VOdYuacC0kjNiGhd2aoIH1RPcw2oej+1wkclZL4mdFWY44actr5ic6g==
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id f14-20020a170906048e00b00a378377030csm1252795eja.41.2024.02.06.07.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 07:09:38 -0800 (PST)
Message-ID: <f5942f06-c4c5-4b5f-bcfb-10b7976d38be@baylibre.com>
Date: Tue, 6 Feb 2024 16:09:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] drm/mediatek: dsi: Use bitfield macros where
 useful
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 chunkuang.hu@kernel.org
Cc: fshao@chromium.org, p.zabel@pengutronix.de, airlied@gmail.com,
 daniel@ffwll.ch, matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20240206120748.136610-1-angelogioacchino.delregno@collabora.com>
 <20240206120748.136610-5-angelogioacchino.delregno@collabora.com>
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240206120748.136610-5-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 06/02/2024 13:07, AngeloGioacchino Del Regno wrote:
> Instead of open coding bitshifting for various register fields,
> use the bitfield macro FIELD_PREP(): this allows to enhance the
> human readability, decrease likeliness of mistakes (and register
> field overflowing) and also to simplify the code.
> The latter is especially seen in mtk_dsi_rxtx_control(), where
> it was possible to change a switch to a short for loop and to
> also remove the need to check for maximum DSI lanes == 4 thanks
> to the FIELD_PREP macro masking the value.
> 
> While at it, also add the missing DA_HS_SYNC bitmask, used in
> mtk_dsi_phy_timconfig().

-- 
Regards,
Alexandre

