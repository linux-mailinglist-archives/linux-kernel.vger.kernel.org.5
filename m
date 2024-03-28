Return-Path: <linux-kernel+bounces-122749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3C688FC8D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383E5297D61
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0FA55E6C;
	Thu, 28 Mar 2024 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv874rs7"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1587B3EB;
	Thu, 28 Mar 2024 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711620646; cv=none; b=ZcW7LkMdW3Ai2vbt8n0DHfHuRkhGMem675uTsmDlQAzTe0lbBvGp3A1cYlIIFQ48NuduWBFN87+AABWMAV9nMLzPcLtJ3kAgyLUqogKxMsTaTBXbfRyPeyRtq7VeKkboTstCrcWOJ5j1R+2OAbgIlIsgddEpKSHISen0eB54kRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711620646; c=relaxed/simple;
	bh=4OFMzfSjsi+Q3F9miHZNiDNu34RwznmjJpdOMvmx/K0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYwf59CpmF/Qrneos68P2MV6mXUueKpyYwttKgjPWTyYGG8VWmrE9M/YCVB5KagE2eeeBw0y7VxPpTGhDpXXKLedcQAi1znOTQfSd8Ox+eeB/nfk7qYTvcMOQyeHOtdr9qrgC/O4lD8n20/aZZiMgINZf2Blv4L0iogkGILq7os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gv874rs7; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso734807276.0;
        Thu, 28 Mar 2024 03:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711620644; x=1712225444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OFMzfSjsi+Q3F9miHZNiDNu34RwznmjJpdOMvmx/K0=;
        b=gv874rs7ergRs+0qgBG3IaU6XJg2G1WvAVoWvPsKm2+t+kvHXf8Nk91rvdp64Lh+us
         7YsW82YHBq7GASi+D4Iz+0c0EqdXpxHJG88cXenAg+019XM5Ig1eyOD1PRFvliTNmqCJ
         oyrsebU9QWThbs9lRyxpPPDrxGcSYnIi0yyCMLekqSUJOHi4231ZtBUPXpEGODmzWpJh
         zhCawFYos3xJkUqhTDTHvh6JE9UvUlUmT/+TUs7yOzbawW7kicXoDR0oJXy0rpYAagwe
         OOMwOyYgeXiL9E5b89RRmdJZt9wUeSwY2WBymy7ovnlLm6ES3u8o3NcH75M/PAaxKFyL
         aCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711620644; x=1712225444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OFMzfSjsi+Q3F9miHZNiDNu34RwznmjJpdOMvmx/K0=;
        b=l4Gco9/MlEZ8LMki2xzYKgr/VjwMgxkGZbbEn+a4AuH+UduHqMwTYezQNPA5S7g4Ab
         QsaUtRHT9bGp7wQdtH0ZpjjXosDtPuzqcpEaxGCZX8R5qIy6aHXdJZh1e/A4R3xYqvZn
         /2vtZ1zgC/brmF8d8pu1q+/3XzhN1tfaMcMYkfLma8pJdry3imbqS9MoqM81Vr5s3zLB
         Cpfv+A0bPac4i4M/9WYVjloh2tF4illG5JKAY+0GheK1uJQVgSrFwjx31IMh0r8vMYSO
         o2Rf2zkxD9NSjd2hyrx9BNildPs/ypywKmkTnrLCrROBPePC+5octVoMEFX5N0EmoICo
         vC/g==
X-Forwarded-Encrypted: i=1; AJvYcCWPLedpUSs37uMKYqHCE1JVp267/rsmkRW1l4VlMj9CGLODoM9xTpB64AuxKLkUC7r0gp+Wm+zwiPPYxY3uJ4OLZw2DGVH4uhVI0y0BujLYJmIDmWQAxce7aVi0GteyMNDi+I3dUYCCMoQjiIB/uuirykW0bxzuuFg0Fdt736u4nSc/tA==
X-Gm-Message-State: AOJu0Yy5zcKotsaYdre+D8GJLyKvhXbm6exntiBjxn9J5LOFHhSHQQ/p
	uMzVqHKEdk1QaRaC4L8neyWQHKc5XU8mo8PHFMkUcsTFavwOkHCFdLd7b0bc5Gvfp1/ZSfgRqSc
	Zl6xg0RnDXQmQdKkaBNdmwFaBD08=
X-Google-Smtp-Source: AGHT+IFukCslxPd/D0/jvlNCrO+ycmsage3+usxF2H6UDkL4liECpcOIMAqmKRuAcfwWuukRPEjBvZXrFUP4B28rsAk=
X-Received: by 2002:a25:8606:0:b0:dc2:2d75:5fde with SMTP id
 y6-20020a258606000000b00dc22d755fdemr2282719ybk.29.1711620644317; Thu, 28 Mar
 2024 03:10:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327220320.15509-1-l.rubusch@gmail.com> <20240327220320.15509-5-l.rubusch@gmail.com>
 <9ab1fc70-fd01-437b-9020-49618924ab30@linaro.org>
In-Reply-To: <9ab1fc70-fd01-437b-9020-49618924ab30@linaro.org>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Thu, 28 Mar 2024 10:57:43 +0100
Message-ID: <CAFXKEHboRLGwLMKk19Az3gA2eYAZwbSKaZbFY=9U-8H915+r0Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] dt-bindings: iio: accel: adxl345: Add spi-3wire
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 10:22=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 27/03/2024 23:03, Lothar Rubusch wrote:
> > Add spi-3wire because the device allows to be configured for spi 3-wire
> > communication.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
>
> I don't understand why after my last message you still ignore my
> feedback, but fine. I'll ignore this patchset.

This is sad. I refrased the comment to the patch and tried to stress
more on the device instead of the driver. Wasn't this the point of
your criticism to the patch?

So, instead of answering to your last email, I posted the modified
patch as answer. I think I considered your feedback to the best of my
understanding. I'm sorry, it is certainly not my intention to ignore
you. I appreciate your direct feedback.

I'll write an answer to the last email right away.

> Best regards,
> Krzysztof
>

