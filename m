Return-Path: <linux-kernel+bounces-70742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49A2859BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703C6282655
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3C51F958;
	Mon, 19 Feb 2024 05:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2urc97Dx"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B441E514
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 05:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708321501; cv=none; b=nSQPwYUdkIiAXSZ+vMYiwl0NXQ2mPzqDYk7DTObchn2bVJm2YeOdp3FpLB3+SzuvvdU1Bt38ynQXW6/sdpNurBQJ214AK6OH7wxTDWxTnuRcoVw8Lk7+ApgImLRxSOmSxb5Dknm+meloW0AElnxisCXovzP/q60IpvXSOF2oT2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708321501; c=relaxed/simple;
	bh=OJ/7gh6BxJ5xH1hakE6NVsUnvxSnxDqUZPLl7n5aWsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/+aLjaAbKhlzeDu2VqaCtKI3Aal0np37jAzaAv/c5Hg7bgNTqcv3lr4DD3sT72LbTd2rtNSFW4qE9E//LislG8kByGMUQERAjv8Wyr3bpkvKlY0jM0zGHQORh6kxB/fDEtx0pjX9igx3QZb0QnmE78QWlz7sCgWnb8D9KErdhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2urc97Dx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4126149228bso29445e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 21:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708321498; x=1708926298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJ/7gh6BxJ5xH1hakE6NVsUnvxSnxDqUZPLl7n5aWsM=;
        b=2urc97DxRKyv/cM1ZheAF3u4DLzu5LhQHVW7nY9o06yQ90eajo1PpqaI2m7Fyj46GC
         LZmOm5K0sqndbjBM83wIZih5wFbxUlZk2cvGx8xR+1EBLoxSpcVd+4xNwDrPUvBcnAOy
         LMZWkmqEhWF0Eqgn5mrXj9mSqMFe7uHN5xBijjLnDvkRH88SgYMUnhSHSroFwJlAIWp9
         qwZdlysFI9KiJUqy/OI/5GaMRf0YsVfwQVczv0aVvR6b8ok5wPACVcQLKbsJtoGUnnYS
         TgD+Fwd2mAP0wqWEG6WIIqj5TwD6egX422hCyNjjY3GlQxGm32Qj9PRn1QbpAbRxKlqm
         Kyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708321498; x=1708926298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJ/7gh6BxJ5xH1hakE6NVsUnvxSnxDqUZPLl7n5aWsM=;
        b=LyFXsrs5fjeW/GUJK/jqK+c0LDvXc29ogbRwDRqpqJbfG7wKHmDoZO5Dqyr8xKNGLK
         Apu3iiwF4erLAGnuJGP0Vc0MYhtMN37v5BoV2Rzm7BlJTSGUzEiCb3lqOM/07QshUDqX
         tGo2oWvEqVRdqnmLRqTjEqh/ewtmFkoiuoCN8pbXLw0AjYMXxG/fN+kMjauvyjTUze6x
         u7WBTLIPMxdmrreTIiZAOtqjQYv2sC1VOdZ3SfqNor5NPA0fYSRX57yPRBJtAcAOd7Pn
         hahCE26X2Hw5pQaSf2HxTX1GEi07pBtd83ef3R33imqUR6s5IxW0b6NFgrgASon3jsAR
         SnxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIRq+XlGX2PZOzPtPPQ8hwglltFdSgZLV/ndBgxCR5T5b6XdVe2uIwBhz1cjXl9pNjL0T2/PLNrTDa8fthrdaQ2YVwlFBJsT+5a1Cn
X-Gm-Message-State: AOJu0YwwJIivs+2sp+i+2OrTzubsQQ1HaQsI2IFnad1oH6I/ubfSbNO6
	s/fcIukzEZPuBHPSOZq3GuMt4mkoJjbrIdu2WtHfqobxk3BzGUbeCT8HAuWjUwDFDdlzISguFOF
	y1qDFgki97zGd5j6ujHUQgl6rzYLVbjkFt7LQ
X-Google-Smtp-Source: AGHT+IGWLQQ2GC773uxMPABnGURWWInWGHbiOz1QQvI4PiJ37j/Kp9b1Mh8sarYZOkO+ogysMCcTy/S0eb5rjQNn56k=
X-Received: by 2002:a05:600c:6029:b0:412:60b0:25c8 with SMTP id
 az41-20020a05600c602900b0041260b025c8mr157816wmb.0.1708321498239; Sun, 18 Feb
 2024 21:44:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240218050224.33426-1-niliqiang.io@gmail.com>
In-Reply-To: <20240218050224.33426-1-niliqiang.io@gmail.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Sun, 18 Feb 2024 21:44:47 -0800
Message-ID: <CAE2F3rA1Lb_ayrLQTw+urtNSMoBg9q6CmcSsP7_dZwbfiYygsw@mail.gmail.com>
Subject: Re: [PATCH] drivers/iommu: Ensure that the queue base address is
 successfully written during SMMU initialization.
To: "ni.liqiang" <niliqiang.io@gmail.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, "jin . qi" <jin.qi@zte.com.cn>, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 9:02=E2=80=AFPM ni.liqiang <niliqiang.io@gmail.com>=
 wrote:
> If there are no memory barriers, how can we ensure this order?

 The SMMU registers are accessed using Device-nGnRE attributes. It is
my understanding that, for Device-nGnRE, the Arm architecture requires
that writes to the same peripheral arrive at the endpoint in program
order.

