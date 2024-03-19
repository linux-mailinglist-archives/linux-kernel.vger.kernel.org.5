Return-Path: <linux-kernel+bounces-107306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEC487FAD1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5451C21B04
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACBF7D414;
	Tue, 19 Mar 2024 09:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b6gNmsnr"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F517C6CC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710840932; cv=none; b=KPnbbjkU7nObfv1QC9TrFENaVCE1VyGKyeFx9LJqZzvdIsg8ss2FzvdF1wmIy9iBSe3aBV9YvQ5UOQBHPkO81PXZaMhs7evIvGezql3ROxvK8sSCOEtwvHa1+fc8TgSVdxBhh78OC5iA4CkZmu99ZFMSxKqoJg9c6Opx7nkNFSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710840932; c=relaxed/simple;
	bh=crQWSKqhD5O72VBc1PHOdc8Vc/RicEqwpfQSKOep/cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=coB1ZU/5pmtLTOmXS/P1u8gfcU2efyKlIKM/dXIEEy09TTG9428Hku96m8kCRy2ON/USX0oAo5bbaxK/f5MwBWzHIm38jUpZUxjLbtwIflqoklVCAe2Iofgh3HmpLi1Dm3IM0fljD0ywRmsCSuxnrEIwJd1wQGrJA9xEAj21fwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b6gNmsnr; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-60a0579a968so57179417b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710840929; x=1711445729; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xR46scEd5OGiZdVCXg0rQe3a9fCq5Vz9qpEb1ZYc0XU=;
        b=b6gNmsnrlDhEMG0w61H6qwwb/96aNwwVk/MN8Nx88cHqo/3dUKrxbH23DG16cIr/L2
         IgETHEOxZI/PM1+QKg9OP7ST3kNQH99YpCpWkdUzohjehxZQQe0ttbKfSsNVbt5CHR3E
         bkgjCU/B3eVBkDqnB+YXHoGkGP6MeLnj/isyjtthiPd7GIGswd4FDviVUIQFj3hxL+RP
         8GR48Iet0KYgXxeXYajSgYkgcdslZHMXYBlZ5NygphVZkzh8qF1k1MCkgAlAgwIjp3TI
         8a+dw1AGR03Hup43ZdJ2FgkRZeE95BHpC9ZYorVd7XmKj9UYQVuyf98SShB0+szRPIw9
         mfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710840929; x=1711445729;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xR46scEd5OGiZdVCXg0rQe3a9fCq5Vz9qpEb1ZYc0XU=;
        b=ONoewZQM70Wz9P+KhoLJy3qygpAs1t/20PGR2yAnmZl6Y8PyiVKLv3torNllC8hA4P
         WRtNh/i8y1bJj6cZ2LlTJpZNs2O6wuWbVRDbMYhcRa8s4U27+SdxsussgjwQdq2LUcDG
         A2zSYDJktJgfZzAeMHQ4BQNFBpDLHOtowESfWXAMyGXk63DDmuaHAvNpy/GXj7J7epnt
         ykqqHpWuPQQ+qoXTx7+kI8qOylSBGAa/SBF9nm+xD7Ne+1QpV1mfjyk8dOK6EtwATVoh
         KEy5Nv0d8f8/e+FmY/Ni8q3iMuouffM967bIFK/Q6w67vx7O8OGgI8fvjcHi1YxsYVTk
         WQ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKggSvjPPM67ybLd413/GDxAQAPQ0ulUfcx5F9wAmTJnDHrWnudVk5VEyqWBTT2y393MceO12FaVmLBEuR32cdGrJnC36C8vV2gbsY
X-Gm-Message-State: AOJu0YxuinbThqd/DStmk0yCi+J+8k52nh0K0T84cx/YMvbDOiPdKk20
	9uwldn182mHUOTRq9zvtYznFpHdRim4CZpDoUNsXnSTv5Azmg0OaN2fVtqfnuGFW6Y361nTuUnx
	P4SV+i0jqbCkMCNbH5CdnemQPNvoW7jDVFrliLg==
X-Google-Smtp-Source: AGHT+IH99r/kvvmJRAw/ZWjt48XmIun30VNYQDPLxn70UqEVweorAxmCjp8Gd6tgaqNqP65M7MNy+IGg5wrYdgB82h4=
X-Received: by 2002:a0d:f003:0:b0:60c:c986:5ea with SMTP id
 z3-20020a0df003000000b0060cc98605eamr13991538ywe.42.1710840928785; Tue, 19
 Mar 2024 02:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319090729.14674-1-quic_kbajaj@quicinc.com>
In-Reply-To: <20240319090729.14674-1-quic_kbajaj@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 19 Mar 2024 11:35:17 +0200
Message-ID: <CAA8EJpojQg2BHvR5kZtRxyXWRKy6zV=88_bdcuMH+QE-n4k73A@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add USB Support on Qualcomm's QDU/QRU1000 Platform
To: Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 11:08, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>
> This series adds support of USB3 PHY support for Qualcomm's QDU/QRU1000 Platform.
>
> ---------
> Changes in v2:
> * Dropped extra lines
> * Sorted the tables alphabetically
> * Link to v1: https://lore.kernel.org/linux-arm-msm/20240311120215.16845-1-quic_kbajaj@quicinc.com/

So, this is v2, but you didn't mark patches as v2. Please use b4 for
sending patches. It can handle patch revisions automatically.

>
> Komal Bajaj (4):
>   dt-bindings: phy: qcom,usb-snps-femto-v2: Add bindings for QDU1000
>   dt-bindings: phy: qcom,qmp-usb: Add QDU1000 USB3 PHY
>   dt-bindings: usb: dwc3: Add QDU1000 compatible
>   phy: qcpm-qmp-usb: Add support for QDU1000/QRU1000
>
>  .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   |  2 +
>  .../bindings/phy/qcom,usb-snps-femto-v2.yaml  |  1 +
>  .../devicetree/bindings/usb/qcom,dwc3.yaml    |  3 ++
>  drivers/phy/qualcomm/phy-qcom-qmp-usb.c       | 49 +++++++++++++++++++
>  4 files changed, 55 insertions(+)



-- 
With best wishes
Dmitry

