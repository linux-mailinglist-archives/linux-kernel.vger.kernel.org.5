Return-Path: <linux-kernel+bounces-165161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1078B88D7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57B21F24786
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4889056754;
	Wed,  1 May 2024 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6rD372u"
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2273633CD1;
	Wed,  1 May 2024 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714561104; cv=none; b=XMWOjnl7YN/rSg03HKGsGHNJHV1egGFxqI+avEkjwJg4b8qYGeMI+H/pFQoYnQ0q7IsGF+vpUREXe5paMpemWMITRBp4ECearBcBAfsMhGVLcr6qABjD06yqo1Ew3CkKDSWFmmYENqUXG++Rsb9ojA4KkLAGNLE4jUm0NckK6ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714561104; c=relaxed/simple;
	bh=j/Xajgm4NK/lzgqgFTaDH7ZeBAQsVIQsUpgLf7xd+18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CD/z5xlI0pFk19sDJiMMz/jiat45mB8ovNBt9IrZLWgua05dwFDW5SyuxiJWFxo/3omjVKY7QNF1AjvBKGz0Yr5cWwI6FQAAZj2gqdHDipHzgGT5EtsUAH766XHwh9vqOGj99TpGPdGUrw597DG+YOMfQStnvVbeo4l/tu7N4ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6rD372u; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-34d7b0dac54so383507f8f.0;
        Wed, 01 May 2024 03:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714561101; x=1715165901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/Xajgm4NK/lzgqgFTaDH7ZeBAQsVIQsUpgLf7xd+18=;
        b=D6rD372uAobSJnckyljWWc4bOJed71WAjo6tB5TaKkWcw8NcWr986Mk745bH15nD2T
         R5NzIEkLToTr7jtjgVPa79T9OTHIg5kyHWE5S7u+4H229YLLQ2yE/FtQto82YRIQYDZR
         JqpSpH7kg1zHh5oKITNx44XhDBW1cbWZ7JG6gh00ylXNBQ2+yk8Q/3qxdYTFX3yCeZTd
         DO0nOJnHoIDhXpGqjO0k7Y3n/BCD4iA+k0l0jChBFpX2CsnN4Hze8VFguiUfdKTB7SVi
         QEGQ3tsWda/GcUMlrV5g70Biq3rT9jvv6X0T2hOmuG+1PzwFQZCEj1E5uDufVU0pEwTq
         bI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714561101; x=1715165901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/Xajgm4NK/lzgqgFTaDH7ZeBAQsVIQsUpgLf7xd+18=;
        b=fWWB+dh3xGN2ZRfmlESM4v6hl3+DQYT4ewdtlwO5dmjK171wkPHp0GFW4K4RuqpEQm
         92M8UC8PS77rbv/BsaLEwjg2IcMnoJGoJy6hVXJNnx2itGDtYlZ/rvbDLb4enFlw6HyL
         60QY9WLcWCbE9+WdQvWzE5iy6WAkQrIww9XnQdkQ7wAYRkCdf0YesiJ1+1nDAPC4G3SD
         cmIsDrYyr2bE0zgPGss8I00mSrcmba8e4yTUGJjR60PSWXYCmOb/JDwwFwZToRSVIkDR
         KHcbmPXQtQFVoEaL2M53bSFMpmsTmwxEsusXama4C8PKTEe7Gpc1Qy7lsaWUroWJWwMx
         RTKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0Yp1KEhu/OHfYzCIH8q9zSgbf/zVWeCcK8l31mIcfKxS7bKBj20EYD231W4+b3NZUNsENRaxfmXi/VkGmksscPVd6UiJ7WezUqic6bUFvaNoZmOSpHV3rFLj/OfCUSBqwbcG7Fkov6Q==
X-Gm-Message-State: AOJu0YxMAlPcbZUO9MH8uI572Umgs3xsiJ96dxkJxh1owqzzLfsIu0Ff
	Ipbj1cJzZscWuCYexN/KWijOWGiUwqNh3iyO1PenDXXc37/uQTOG2OJslBJLSdMkD7lpNUEQF9i
	6eYjWo/HA0rP7N4FXcAxA/79852s=
X-Google-Smtp-Source: AGHT+IHtZt1GnkElYxtQ+de9g9Z0CTksnHeTnCeTOMgHpQJQApOQPvfeWXhm9Dvmz8ahmZA+Re/IaJ8yF908J+rF3vY=
X-Received: by 2002:adf:f44a:0:b0:34c:c53e:f2ca with SMTP id
 f10-20020adff44a000000b0034cc53ef2camr2046993wrp.14.1714561101245; Wed, 01
 May 2024 03:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADFWO8EZWkXeAMcURgGGEmzVjiSxFTVAbKpsb2Qmv66EZiTc+A@mail.gmail.com>
 <eb9538fe-1d1a-40e0-a46f-3b4b5da3e8d7@linaro.org>
In-Reply-To: <eb9538fe-1d1a-40e0-a46f-3b4b5da3e8d7@linaro.org>
From: Petar Stoykov <pd.pstoykov@gmail.com>
Date: Wed, 1 May 2024 12:58:10 +0200
Message-ID: <CADFWO8Gz__4s2h6Led=oGAObjzkymc=vPsHzZ07HUFU_VCGfTw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add support for Sensirion SDP500
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh+dt@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Angel Iglesias <ang.iglesiasg@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 11:45=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 30/04/2024 17:27, Petar Stoykov wrote:
> > functions in use so it should be fine here too.
> >
> > All feedback is appreciated! Thank you for taking the time to review th=
is.
> >
> > v1->v2:
> > Many fixes suggested by Jonathan Cameron and Krzysztof Kozlowsk.
>
> No, be specific. What EXACTLY changed. This is way too generic.
> Considering entire indentation is broken, I could assume you actually
> did not implement feedback.
>
> Best regards,
> Krzysztof
>

Hi Krzysztof, I'll include all changes in v3 then (or as a response here?).
I just thought it was too much to list all changes.
And about the indentation, can you elaborate please?

