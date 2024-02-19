Return-Path: <linux-kernel+bounces-71459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2BF85A598
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1F71C21AD8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B16A364AD;
	Mon, 19 Feb 2024 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oYQ7QyPK"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBAD37155
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708352150; cv=none; b=TrtKI3TiBY9iNx4j1/vOnOomfikCgDnBd4UxMcaM0/1yDmtZjQLoNpqyLsPRC9kIqeuosgfe6BRLHR11zk2pEODrNAGyxs+MwgoZ+IF3JEqv0fUym9PHOb5O9V1XA/EO43qAl6g/uDF8BqvbY94jngEZUVPDM6QnWRQ9onf+b7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708352150; c=relaxed/simple;
	bh=4DPLBwTn1xD36bWpSPaGvzOXf4/1hjvap+dI7URkrQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYwgFN3UNuvFu4RW1sqD67VcDTp0h9V0UbDbZoX/IEu/S91+93+AucTB6Nl+2DCK9gAfqAnbP6erMJW6eBbc5yVCFF7nP+6RTSLWnetJ3w34phOdAZZoxiMeaKSOLGcHT8hhx8q+BEMs830wKutzWavCUbZOmPnfEAsa9ZOzxUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oYQ7QyPK; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6080beb19ddso19686357b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708352147; x=1708956947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DPLBwTn1xD36bWpSPaGvzOXf4/1hjvap+dI7URkrQM=;
        b=oYQ7QyPKwZrJxc/1vWnh+IdWeVJWVKMLO9KhD2PtbYvEiDGEIvVKCSoTEFI3hvTEBe
         XTcAWQ6x1AiaQRpo0wzhihVhYAYYv30KhR0oVYuozJS83n64XybRQskSrzLwqt1VVKRW
         +DTACQ1MdDP1xuTKa7BTfLjOkdNK+4eSGpp4eRYMgu26XiX/LCTnj6sKbhg27n2IgCHP
         4I5hnn7Eicz6fbMRKixnOh1Df9c2TeVPNKaXxGv04RRCb3pMZfAJ4NUElButyrt87k8Y
         c8QNjroMSLFESAkVJX4LMWAvnjyB7gVChuPMANpGgkfzEG0nkcQmhU4gw774K0gMtIrC
         hZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708352147; x=1708956947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DPLBwTn1xD36bWpSPaGvzOXf4/1hjvap+dI7URkrQM=;
        b=Uv5KMyihI5Q6WuvVFW+u/31qRwkO8pvvH84OhNsFUL8KHMnE9dhnw7UqwfBepHA1a9
         /C1X2QgG1WVFeGuyRsAyaN/3cZ7gGYUYmOF6Lva58WgNBVdrjzd8ZDXA/xno7+FogjDi
         pg3JaiwX1x3b626xof/NGNey9pwTuxpPdr/Lgpvl66wCzjjqznfCgEuebl7zh6rbFUvz
         R9ejdbTSqqZOuYj4IDSRGcQ8cvr8CG8wMGSyCfiVimTyzE7bmwWMyy3kWmXsicP/KLCu
         UeiJkT24D4BB1lLrujjJ8nmqyDkODPqy/MQBX7oNjRhyQGX3zkoknq+hOuW4C5aEXh8n
         Oakg==
X-Forwarded-Encrypted: i=1; AJvYcCW+0K66YqnTjbo0w2rGAlVchHVKWXvov/V8Nz3DvubFkZnPoyuWOdx5kDFJeNtnKYdSporeW15l1ai3ctkCqSo3Rfebgs5VoDKc7tWf
X-Gm-Message-State: AOJu0Yx/IqG8ZvvNLH7FalRQkOiBk8O1qTZh4VEAMv0aPu6NZaWxQtGj
	A6N54CQKOsftjY4GS5eYJXUq+kuzJ85RnN0kWfWDhPU4OVZ/H4WqL6EFc4cS2oUEDHgOB28tEKl
	kRCYohSbaCLxtEjsE1TqzuChq9TL0GiMFq5Y+kA==
X-Google-Smtp-Source: AGHT+IEGRelqWe2dTiOY9iPHsVWt5SGUzoFQvr/GztPD4++Mw1yGR+nXAuOs79zdC55kYgkbpeTBWZqjsyVHDwYA5+0=
X-Received: by 2002:a05:690c:a81:b0:607:b85e:2d21 with SMTP id
 ci1-20020a05690c0a8100b00607b85e2d21mr13022466ywb.24.1708352147092; Mon, 19
 Feb 2024 06:15:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215-mbly-i2c-v1-0-19a336e91dca@bootlin.com> <20240215-mbly-i2c-v1-5-19a336e91dca@bootlin.com>
In-Reply-To: <20240215-mbly-i2c-v1-5-19a336e91dca@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 19 Feb 2024 15:15:36 +0100
Message-ID: <CACRpkdYZTrEKdGfN-EiOTWtQhhMHVqk5zCjmcAuUZq9aWesqFQ@mail.gmail.com>
Subject: Re: [PATCH 05/13] i2c: nomadik: simplify IRQ masking logic
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	Gregory Clement <gregory.clement@bootlin.com>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 5:52=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:

> IRQ_MASK and I2C_CLEAR_ALL_INTS are redundant. One masks the top three
> bits off as reserved, the other one masks the reserved IRQs inside the
> u32. Get rid of IRQ_MASK and only use the most restrictive mask.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Yeah, more readable like this definitely.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

