Return-Path: <linux-kernel+bounces-55199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8341284B90D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695DA1C25204
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D681A137C51;
	Tue,  6 Feb 2024 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ypv4GNO+"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFD6137C32
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232271; cv=none; b=jAmAlKALrj0RtwIharY7Bnl+ecSFQ1EZUACr/vdFURrXd+sD8fbhobX1Vpb9COdUR5RER//oAkJ/FxCiDSxz95XyjiBG2Rd/CHVtg/MmJPGomXPDPss9VxEeM4GBAjUbvFPWyEhYRp/uiVMkaoDdEDUa1OVqW504NW8JnOzoCyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232271; c=relaxed/simple;
	bh=52BRVFLdK1qe4Ymca2cm8/Pnx8d4g6f28T31akBpkBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fv3deBGefAZDAT+Oz6kNAvoaAgQODxpcpHDLBdHiOeCq3YbCmBNhnEYnkQmGnTey+UQ75E2SpA57C+daARTka2m1Q9Vgp7Q/iDcm8mIr5FwqeXf/RSxQzbaKH7xptjoFwzoL3X0wMWCQSQhJ47zelM0Hz1FklN2rv6dVpBgafJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ypv4GNO+; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55ff4dbe6a8so5076609a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 07:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707232267; x=1707837067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BjQKrJiqto5Ob+/v96nV9FtvyMGmkQizdinJfF9BpvA=;
        b=ypv4GNO+M9L4+p7HhFJaLQoBjb/98uHtGwO7G+iTQRPHrVo1Vm7J3A2wmx0jpq4Of0
         i8ozAWUt9W5Yv0XWlpbpYMrrHCFjTRJtzEA8iboteTB+nV1QmAhwoymnuO8VtjixvFeL
         CPiLAxJiguyNQJxY5eQIb6RlQSF3IJliQlJz09O8CvVkaVAhBwFZEwfZJaFHHnxhQc43
         Q5pgKnr4TY+DYIFDrd+6iOmGel3UiCml5rOJmYjUpQbhHAdVnMe7uHv5WHINCZo4WYui
         wHGidmOox95k9GhVyhgj3QKvvJ8vfXs9tagpUaZuUWJngweYrtNeAHplnvjBwKI2yWFz
         H1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707232267; x=1707837067;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BjQKrJiqto5Ob+/v96nV9FtvyMGmkQizdinJfF9BpvA=;
        b=oWNepOp6LhbCTR+OEEw33LMQXj97/Nr/v8rd+QbS2foO7HcS3XZT0uTsB+hBDi49Um
         n0D/p9oXIZlu+U0MkxlenBHr81aaK9z+urSx0/ppa3aPnsVLj8vkT7sxaQpKkR/aJiJr
         oFoNrcLPKdxDugK/GPAj+DYTt8JulVW6b80AXf6Ts9YbovVBxenowRDmm9FZd4exUod7
         YcKl39uCOCaNsjHN53vJjFrMZCA5shYPbyl7C2dubb83wNjfJJI2Jan9FoxecrDjro75
         82uJcNMQ1tuSYxp/VWtv597B+dvc1rT8//Y159k9A+MuDLQSYsy6jN9LBnx6zgAw9Ki8
         ORVw==
X-Gm-Message-State: AOJu0YxQ/OYY2kFC5b/HdMnSMxwmjaD/FEdErlgcip/RzEPZCbvy5RMe
	7nJ4szLODZZUWMgxipYhB5suPhBCZx9qlE75Yv7w9GtB3kg+6nuin73L4pgR6+rWF5Y4nz8fMQH
	S
X-Google-Smtp-Source: AGHT+IEWuOCt8voz4u+MBpvA4hP3K9km7MbtGtHA6Mv+jBPk9rsHCMaPnCNkcUZWrixdQ7z0/q5ymA==
X-Received: by 2002:a17:906:6d6:b0:a37:e8fb:1649 with SMTP id v22-20020a17090606d600b00a37e8fb1649mr1637365ejb.56.1707232267526;
        Tue, 06 Feb 2024 07:11:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUpfUWzNOin8Ev9feQsK28lEv8UY0ytQSJdQbrL0dFp3df/wU1rkIi0XWIR+aedXQuVIQ+IECaHKD3CF9ZI/qNZAqfN4Zf4BHDYckYLgx32eiSYvGe7YIk1fuuFSVizeqs7XgsZlVDMntB+zN0F1jtZVVgaYCdOVTviENfQlW4JMbuzm4iXFVqd8j/p98p+uTZWiUUUmPx+3sI+RySJ4tEDABdeq3H2ciFF4JAvcU6vmXN9YbRaTPAAwi2Lclnl9fgxtZhU61QLEBtclp2uGB85QDKPNL1CwAyUJTzFiCFXwO7e/2XpHKhsbqjtmb/yKrzL8qQNsYW6JS7VWBh5aoeW102u+H8B4WTJ2d6EfzI7+hFSdw1aLDw2Z+eBKdgP8sX04McHhz8ZNx39/2sG8carxkbv4HTmZQeD4Q==
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id f14-20020a170906048e00b00a378377030csm1252795eja.41.2024.02.06.07.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 07:11:07 -0800 (PST)
Message-ID: <594a9b63-0e3d-4ab9-a1c4-bd25ee40d9c7@baylibre.com>
Date: Tue, 6 Feb 2024 16:11:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] drm/mediatek: dsi: Replace open-coded instance of
 HZ_PER_MHZ
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 chunkuang.hu@kernel.org
Cc: fshao@chromium.org, p.zabel@pengutronix.de, airlied@gmail.com,
 daniel@ffwll.ch, matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20240206120748.136610-1-angelogioacchino.delregno@collabora.com>
 <20240206120748.136610-6-angelogioacchino.delregno@collabora.com>
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240206120748.136610-6-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 06/02/2024 13:07, AngeloGioacchino Del Regno wrote:
> In mtk_dsi_phy_timconfig(), we're dividing the `data_rate` variable,
> expressed in Hz to retrieve a value in MHz: instead of open-coding,
> use the HZ_PER_MHZ definition, available in linux/units.h.

-- 
Regards,
Alexandre

