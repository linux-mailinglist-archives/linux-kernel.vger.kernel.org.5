Return-Path: <linux-kernel+bounces-127733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1BD895026
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E39284A8D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01A25EE82;
	Tue,  2 Apr 2024 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GI7y1VqX"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985223EA72
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054038; cv=none; b=EyaUpaIVSKcR5tHer4RF1LSgnlt9Fk0B7mMRVUa0pdgqPZimkwcLoGBj3ppdEiV8/s242BlyjgNz4O1cDdCVOjS2szaOwlmfHS700TyTv/1MIiUZhMzb/L1kT4k1iAugOTxmIz9s+sw4gd7AeqXs4+Ubk3hpCGT3KTikvpW1vKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054038; c=relaxed/simple;
	bh=qu9ShLrPQMIkNvbhjhLBUtPyucHuzPdWe9LUMWcl8vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s23tkW+/VxRpKxZ7M2WhZ+/Qy4xU07PdVK1MDWIY1arnipOzVzUaGTpYmc0ShVhAoqzDU9CrdxeIjDIXrW6OL0WeiT0MV9iVmINvRU3SHaUJ8ZMdVz5dqyf+W9LcRM1wV1PbmYSM50rOlZpy87OA9krztBxYd1gY3uvNkzNUUsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GI7y1VqX; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6151d2489b4so6960337b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 03:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712054035; x=1712658835; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MWwVzYWrWmvvKy3bQx9GVyakGKirqAQ+7eqOMn8Hdd4=;
        b=GI7y1VqXg4mxS1WS9UbTNigScyb9HKWlCrAZoIFEwQgJDrZOzTmw72WIqVNLr8hgVF
         WrWLNB8I6F5Voy4HEY4a0yJhxASfX+b8NfoTHWq/Icj/+6+P6KUcn9yIEnJc1DhX42kx
         SollTLK4n2WItiwpzZxzmxdaSKkdKVdgVtE3syjrl40VjGNV9lnjjTX0bVTd+d06QSQC
         x8IKzjyeiBLADYaUXLFJExFm36MzwvcB6V3yeYgPi8ucSMcf2DYDFZRrrHU2MEu9MuoA
         S1Y668159TQgu5xpF2TwCfKntztLIyLDqVpvYDTu/kOizjr19I1KX8QwDj7f7NyfiLo8
         1E7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712054035; x=1712658835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MWwVzYWrWmvvKy3bQx9GVyakGKirqAQ+7eqOMn8Hdd4=;
        b=Can6LpG55D7jdRIjPJxKVB/5CnQP4cuNR11U11+/pwy0BFDhBbMUnLF1J3pD2yV9oR
         EuyUDW+lvVDAyiqKyEf1/CSfS9mAI9HyLaAQzeRZgAIjlQJIZ4jx9A5sGZ//W+kTTf47
         cglnH8B3MB6yunYtKD+8PKwxVf0M2ylZvyUIZG9F7DHuPImIQ0Y9r1e7IkGOXaebYrjl
         X+QIB3WGcNSE481vt80uCEVcosfSfu0OFI0V+E5Jm0KvPTB3oq+UbIo8qffFrHVycZe9
         2yPokQW3F04iX7wOt/0tWcwAO+HcPyoHPC4Tw1/IJXGBKV3ffP1kHtXuOI9UWKb87hhj
         W7BA==
X-Forwarded-Encrypted: i=1; AJvYcCUg4qh515220Hr0F4ab+3nHnAxqhXykVbgRi+roQgiya+gzGN057SkzUCyOs3z3HNtqIXykxWG0S6+OJWtT96qa11KD5bjLOeZy4L0w
X-Gm-Message-State: AOJu0YwpbGrNK3/iPmjF7qbjdzt5Ez6xpJMDMHo75eCTfpepOHXG4a+v
	4UWqksWIPDpIxsmQKAedGH+VwF/+AIfwOrpCKOtwURPs4t2eSjT6Ame/3CrU/Q85h5XEIqvls49
	Jx9Oo/mtZ/v+ZKCtkb3vVW2Bd47Ueoz6DK7RTQ2i9MuMEsCN5
X-Google-Smtp-Source: AGHT+IGdA7+Mw3wgNp+BztbolUTPAWjuEexFLMEyJS8XuGlLJbUGAceuF7Y90mTButztt/iNjInqR50NU+ZERpjg38U=
X-Received: by 2002:a25:870e:0:b0:dc7:3165:2db1 with SMTP id
 a14-20020a25870e000000b00dc731652db1mr9075771ybl.49.1712054035607; Tue, 02
 Apr 2024 03:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401-typec-fix-sm8250-v3-0-604dce3ad103@linaro.org>
 <20240401-typec-fix-sm8250-v3-3-604dce3ad103@linaro.org> <7088e678-dd0a-4a5d-bef3-e0816a38ce60@linaro.org>
In-Reply-To: <7088e678-dd0a-4a5d-bef3-e0816a38ce60@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 2 Apr 2024 13:33:44 +0300
Message-ID: <CAA8EJpqdevzsN12m-EnxdFbCa5WgiSDMDhtjyf80th1NZwoD6Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] arm64: dts: qcom: sm8250: describe HS signals properly
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luca Weiss <luca.weiss@fairphone.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 12:42, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 01/04/2024 21:33, Dmitry Baryshkov wrote:
> > Instead
> > there is a HighSpeed signal lane between DWC3 controller and the USB-C
> > connector.
>
> I still don't think this is an accurate statement. The upstream names
> and labels should be followed for consistency but role-switching and the
> DP/DN lines on the type-c port are not related.

I fully agree with you. And that's why I'm replacing the labels. If
you open the bindings for usb-c-connector and for the snps,dwc3 host,
you will see that both bindings describe HS/SS ports. DWC3 also
describes a single port for usb-data-role switching, which can be used
instead of HS/SS ports, but usb-c-connector doesn't have this option.


-- 
With best wishes
Dmitry

