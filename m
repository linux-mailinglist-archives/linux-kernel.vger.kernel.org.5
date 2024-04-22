Return-Path: <linux-kernel+bounces-152805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C098AC47D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CABC1F21A2F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486B3482DD;
	Mon, 22 Apr 2024 06:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V/QMPY33"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E9B481C6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713768803; cv=none; b=UVLiC9VY6bONWnUhf6YAD8+6KlVz6OywIfUCyANjzRbqixJ+zMefgb2tyPEqOjNZosEKZNqtyqI0VR+Q6oR6h87SmoY3BwhVDK9AOjGUU6rflfUPbbcgRlkHAx+ukYzmdi0qvtfAqlIl2/E3bapneNnIMHQZS1RGKnpD8j41+oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713768803; c=relaxed/simple;
	bh=WyWHeoU/Ff7umbOe8XQrl/qZdNdvHSjb9SSotewTso8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKCDXmWpB0hINT+oy5LToNd/ZoQL4STs1S734sxny1D8ezWW1bHt/mfsbx1MKXlZ4s8SzixywpV0Ayy/SuJVaoG6hZXB6gUK0WbvKEd1lglG9ys0as9fTJR28JlmXqrnwiGmuAecgOvU4cuLJaJJN6AgGQRccYxalMu3qIpaLHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V/QMPY33; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7d9e70f388fso180202539f.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 23:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713768801; x=1714373601; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dg+W9++cTuSKiuuJU3BmFvsGHmcNsDKvQ8sCokwEeZM=;
        b=V/QMPY33gthdorvf/TLe8mOvKeYu1WDBKkJQsxqw77NFXa321kB7TqCIjxXObMt4av
         GIjjc+H2hy+CT7yPi7+YCN0R0Z65R6OwFjSDl0bYbSIdn1+D7XaJC5m9X0EA9+kP+Iwv
         BFczUZylB2H/67C/bKcerYqHyL8G2PdOOVhd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713768801; x=1714373601;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dg+W9++cTuSKiuuJU3BmFvsGHmcNsDKvQ8sCokwEeZM=;
        b=ldL1UFEYbnpqYkBH1NZTqroWzPZUI3lRb8E6ymn+GyTLLrTaBSCMy0L9hBNI+5e10E
         PYDbEIZldCdFeD0p8uOJTuRNNEA33QI2st6uXy8WJIDoMNGcB0nthnW9HAoP+3oNE725
         yG1sMDTqr7gU0p87X8D7tqgAAqzT6K86yI/2aoINa8KsaJrQ2bVWdq/pkSjM6fU6+0I8
         fOK0lHmgYb31Iaz4e/nofjouUReKWe/K988stgMrmJU38r/Pvj2SnYUwzJt2jlTLtpMU
         qWG4YY3tIKcqe8S1VmVDljyY3ZSrMIm6jmZ7QWv2qMCRkJX7wC+ctUq+nhGWW4V5odXj
         3Hxg==
X-Forwarded-Encrypted: i=1; AJvYcCVvi5xXXUNMD3NKVLRnwuuHr3aBDfgN+JrQW9hVjF6YKb99+h0wTk93JmGTUl1GHxjnVmmP8u3CHWOLURvYZpVJ1HsnD3QTDvHbAscd
X-Gm-Message-State: AOJu0YxLJkCqilVXMPiPNLNR+VyHM9NFzvf6NEM4Whd2JGd/gn9YpygF
	zEsN0lgiN0xcpVz7FRrEJ8m2XlJ3lVMmpc1Ud+bOCkyk4xFgSw0SAxPp8iOEFdwjefE/hxfY0ma
	msA==
X-Google-Smtp-Source: AGHT+IH4uDEJ5J1MpX4btJmHCQMCLIi9sr3TwGdwASxejDYvy7ebt9526tGBw7yMqvQdTQScqdkm8w==
X-Received: by 2002:a05:6602:21d1:b0:7da:1933:74dc with SMTP id c17-20020a05660221d100b007da193374dcmr11294609ioc.4.1713768801164;
        Sun, 21 Apr 2024 23:53:21 -0700 (PDT)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id im13-20020a0566026d0d00b007da5621eefasm1770621iob.55.2024.04.21.23.53.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 23:53:20 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7daa6bfe4c8so44958439f.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 23:53:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxgQ9ZT6FalBhTTe6bqMtSgpMqYF2N+oszd4IHg0i0Y0see6UhRQDKla2Z1oqia9eNDYMvG3D79Ae8I8QjRngAWAP68I0D/nHZwy13
X-Received: by 2002:a0c:ec88:0:b0:69b:1aec:88fb with SMTP id
 u8-20020a0cec88000000b0069b1aec88fbmr9872064qvo.23.1713768779447; Sun, 21 Apr
 2024 23:52:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419-fix-cocci-v2-0-2119e692309c@chromium.org>
 <20240419-fix-cocci-v2-6-2119e692309c@chromium.org> <124e35b3-5b0d-4bd7-848a-5c848b339157@linaro.org>
In-Reply-To: <124e35b3-5b0d-4bd7-848a-5c848b339157@linaro.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 22 Apr 2024 14:52:43 +0800
X-Gmail-Original-Message-ID: <CANiDSCt34D8-Ys+DbEQM0SyFdBF4WoV5_+xuuCjVbf22kT0xfw@mail.gmail.com>
Message-ID: <CANiDSCt34D8-Ys+DbEQM0SyFdBF4WoV5_+xuuCjVbf22kT0xfw@mail.gmail.com>
Subject: Re: [PATCH v2 06/26] media: stm32-dcmipp: Remove redundant printk
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: Martin Tuma <martin.tuma@digiteqautomotive.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Hugues Fruchet <hugues.fruchet@foss.st.com>, Alain Volmat <alain.volmat@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Sowjanya Komatineni <skomatineni@nvidia.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Sergey Kozlov <serjk@netup.ru>, Abylay Ospan <aospan@netup.ru>, 
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Dmitry Osipenko <digetx@gmail.com>, 
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>, 
	Sylvain Petinot <sylvain.petinot@foss.st.com>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Bryan

Thanks for your review

On Sun, 21 Apr 2024 at 07:15, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 19/04/2024 10:47, Ricardo Ribalda wrote:
> > -     if (irq <= 0) {
> <snip>
> > -             return irq ? irq : -ENXIO;
> > -     }
>
> You're dropping the original intent of the driver author there no ? when
> irq == 0 they want to return -ENXIO.

platform_get_irq() can never return 0.
https://lore.kernel.org/linux-media/cd4aac19-c4cf-4db0-a18c-42f1bf1441a8@moroto.mountain/

Let me add that to the commit message.

Thanks!

>
> ---
> bod



-- 
Ricardo Ribalda

