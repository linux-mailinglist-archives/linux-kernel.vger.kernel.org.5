Return-Path: <linux-kernel+bounces-55238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D8F84B97D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89C011F223D8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F641339BE;
	Tue,  6 Feb 2024 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E258QZgn"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EE6132C3A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233056; cv=none; b=L31PVifCWxVtCHh3HBpK8LDGLze06h+6ykb8hYO65ZKuWvaIlHaM8/f6xyMGYxuJPMay1E5RhryswMeNlLlzmTAbO/biTBzyrO7WyfUIPBkScRx2kdHVzIW/iVoEJ6TzWCezFSNMvAywgoHpj1kD8J15nIsR+qOoGNhZnZO6Hpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233056; c=relaxed/simple;
	bh=hHm4Q8JVMYdENzwtT36U+XnX2Z39/xB+HNLY+rDjGnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6nziVXB2oFAk2lUBVCg97KMi50XwkQP4mYrgnW0VfwFRNOeEfnpSe7I3I1LUz1PjmSWree0t1VisNP9sVqvLbYW0G20D3WVFa6OX6qVtF6Hfkq1TFoB/Ej88LdKUBzExdIux9jlhU9gQpWaQ1QXJLkDfUR+VjoAmraZ6Jg9kEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=E258QZgn; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so144713766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 07:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707233052; x=1707837852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c6oZEpefRF0Tyn24g9i4ewrS1OGMx8/CRX4tNeqvynA=;
        b=E258QZgnvfNNgMXFt+Dnt6OzEwqWrOfIDEY/URjC5crjRtSGFi7a3cBRcI0nOJfrVA
         khdyAij1jsf4RORpId33Lqz83thkRMkzoo0y8zs9UjBr/kdsefkOOjf+h7b2K3sEFbZ2
         ZYgyjeYrEIJ5k6X0nH1hn3NBHP8sfPDx9UpBNHWhxI4o8THJDNPn8GYm8piOVEcnhAen
         o3gvbVXW8J9A/lgpzCBSvxzBSNR3FfkN6Kuelnef2UitK3zT4WgKZkgNSNa4YNH+q/0g
         P8NQo7HqYSqwiY+GPxieGLlRmdZfsFhkui+nOu2rz1LQd+YzlC3iF7+y5q/E1cbqzPTT
         Q4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707233052; x=1707837852;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6oZEpefRF0Tyn24g9i4ewrS1OGMx8/CRX4tNeqvynA=;
        b=YfSaDEo7RhAVoonA6T/uhww4ydTM2RGjh6d8CaKcdip0ublAxrpiT/Spf7n5WSVjfs
         MyMbb8U7PyqzP3zWTJaEbgtq5KsTNvAFcmplevTuwwbml66TrSSU5U/1SN0oQ57IBZ1X
         p5AuK+YSSRbCVn2PIYNAv8EDuM1tT0CdLG02VN4qb21y043FsemgfypyKPeuWrQ+Ltng
         6RiXKczX3HYC7MvWTD/zDM42cqAmMXmyh4pVnOusYlhpLPNMatEoD4LE4NepSJUVXZPp
         lGxE9r5KB0qq6YPXohciQXvHBAL+bi0gv2sb7SP+YkdM0PjKq7TJvMUPhxSObav3iZHa
         JGxA==
X-Gm-Message-State: AOJu0YzbpPg4QWBCxseN5V8k6mWS/ktvfdBqXjpLSzPVCWO2NgGseTO2
	t2R7QuITZ03KhYhFk/ThYQNELebAmYoO820RsyiVm4YdOUgnYMd5g1YcCwhGoNo=
X-Google-Smtp-Source: AGHT+IECn1jgZhlrG7/6jnwm37Zc7btXkbtdP+hBe0rhldbgW5nxFV90J4gPvjCdN1SPFQYj6LTRow==
X-Received: by 2002:a17:906:f90f:b0:a36:f672:5dab with SMTP id lc15-20020a170906f90f00b00a36f6725dabmr3379018ejb.16.1707233052557;
        Tue, 06 Feb 2024 07:24:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUVPrzdjhB8UqYzeAqOPAW1mFIJ+nEKHTmOwLUcBxGgvscPTDBVF8z1qZTrHEFsvtpNhdImONs8V8ARS+FNS9Pxl/Zw05V/dFmhstQfk5/XNeatnegHKoIO8eR1DzgVzZmbqd+f/vpMbFtwGlxnFeIt5og1MDpqdLVxs5KvI3/tbpSZNzf+L7FDLSdRpGbYHqMLqCO7QvpK1YztVlBkmhJwKBjWsvDM2+8EDnTUw6gOR1aeT/oNfYbf6k5TvQH774/Z3iiBzAXBW5xd0IfA1fFHmPtyyYIibzTu5oi4A6ltGVhQBuQodgQIWk8RRq/g/Y2hN9cnFj/9gelQ2Bd8CeYa6ibQ6nt4SgxzeweuMR+KtddOS1Rns9BdHrLg1Uu6Ybhzo2N9SC7TeQCX7V5GP2TfdQvVEvVfnD/veg==
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id ca3-20020a170906a3c300b00a35d6482fdbsm1270170ejb.77.2024.02.06.07.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 07:24:12 -0800 (PST)
Message-ID: <282d07cf-97b4-423f-b148-42a5d5ff9d10@baylibre.com>
Date: Tue, 6 Feb 2024 16:24:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] drm/mediatek: dsi: Use
 mipi_dsi_pixel_format_to_bpp() helper function
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 chunkuang.hu@kernel.org
Cc: fshao@chromium.org, p.zabel@pengutronix.de, airlied@gmail.com,
 daniel@ffwll.ch, matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20240206120748.136610-1-angelogioacchino.delregno@collabora.com>
 <20240206120748.136610-10-angelogioacchino.delregno@collabora.com>
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240206120748.136610-10-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 06/02/2024 13:07, AngeloGioacchino Del Regno wrote:
> Instead of open coding, use the mipi_dsi_pixel_format_to_bpp() helper
> function from drm_mipi_dsi.h in mtk_dsi_poweron() and for validation
> in mtk_dsi_bridge_mode_valid().
> 
> Note that this function changes the behavior of this driver: previously,
> in case of unknown formats, it would (wrongly) assume that it should
> account for a 24-bits format - now it will return an error and refuse
> to set clocks and/or enable the DSI.
> 
> This is done because setting the wrong data rate will only produce a
> garbage output that the display will misinterpret both because this
> driver doesn't actually provide any extra-spec format support and/or
> because the data rate (hence, the HS clock) will be wrong.

-- 
Regards,
Alexandre

