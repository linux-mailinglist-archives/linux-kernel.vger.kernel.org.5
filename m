Return-Path: <linux-kernel+bounces-95039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B3587487A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10DE1C21674
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1C91CFB5;
	Thu,  7 Mar 2024 07:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i+Det6AR"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF251CD3A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 07:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709795414; cv=none; b=N066JCTxyUJIttorqpralgMBn2Lnx/G9G/UEVWlDm1MfHgWa6F0TKN3qwt9l4KQAf+eTIqLGlPeVYP3nljcyz43IF4vwbsrhTfj7ORi/ZaUl4dd5eV52jUqYRZHSAqov/HcbidDq38RBPBcAtXa1UtgW+JG22bfGW9hQrKRU0z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709795414; c=relaxed/simple;
	bh=iIsL1hIIzLVdo3EvdubyzEYAlNqiTp0Fva8OC/K/Yqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWOjjI6M+RBeJ6ggfCyd9HHEwqFZ3vzVqVWxtlhQ5PjLnkCoeWeM9Kbd4x8rCvCz2B6/m3kNPSCLaMh+vnIkkNW5Tn2WqI1FgonrJ34BIIvE+51AtRoS8tavGDubphf9c3mqd7vbQ9SftQrV2XvH060q6zCWEDMRoT0kNE/KO44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i+Det6AR; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-609fb19ae76so63987b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 23:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709795412; x=1710400212; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOdlYANg5yyzhtxokbCF8iHDui5YEf/eOMq75HXldJA=;
        b=i+Det6ARNLnAM6ktc3qcK+DIUgRa7Q30VuypoKp4Kd8qWyLTfStV4VaNg2jKlnm6+e
         OTH/wM9SnfnUwVSt7BCvQUnwgckbKSbUzFnQ6h1vKaCnxAHGw9JaEmhoWeCBcXVvLg7e
         imznUf7DYTxSVB5uIId31uER/Y4EgNLjwwl1g5M9ykoM2beNFo8Fip/2YrFTq5uy0SVD
         jJRkVZZpuqO+3o90DgyAvLTmnJtLH/NxfezgqdlfplXJKFtv0epZX3JHRMGV8G/LXpBs
         L5J5b3rrSQ0dbMbUjvGZR/+r5iScSR9BiOiMLM5xA4WzOGHvAg/MKSfL2jHfv1la9/m8
         la0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709795412; x=1710400212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZOdlYANg5yyzhtxokbCF8iHDui5YEf/eOMq75HXldJA=;
        b=lhP8I+NvBhu1L7U77VhDhxKRmON+c5JXjMsyx5apgkMp3Ipnjq9NOomOrp0JNNSNfo
         WFms8RqXhmu2et7/xBt4l5WWtCQaoEArTIKm9hhzDPX47E+OBy/5tC6AakzAomF0KcXS
         F4JqLSm3G8JM7JSD5C+209v5y9UMtz2etjWAgySmqdhWbnWlJysMY/+nxRjaD/fSu23h
         0D2MR1WrSF6RaCJsce7tynKTf7egIkR4y7ACd6Rkf1HwY7X3NV/zh7Lf4/SJ/tEWQIAE
         pdrwR3ABo9ZcefyEkbKj5JReKAQ4NQxALC/jsRcj7kAbyidsFwH90Pmvbg9okpO/+VAi
         9Yhg==
X-Forwarded-Encrypted: i=1; AJvYcCVHgGzYXfd5Jd+ICIg9gY1ZWGSvSBaCSkrJX6Qj79wFNQsAT03LRjUiBd8BFIVNLQ186/5katix04lv1bap7Iooy71dmjjiCcAmbFk/
X-Gm-Message-State: AOJu0Yw8REHhlNpsbtEgnKM+A+dJm7SZpJ6zGRaRGhl151ILcJ0in9MQ
	PcCPf4fpy/VGdNoAMgfBGSM3OWaW7K/3aKipG/14GH08cSVDvs426pTWHS/LQIoLnU+wFvw4hmk
	BopU3qh6aIFlvyrIDtcf9y6f4XxuuoOwpvtn4Ag==
X-Google-Smtp-Source: AGHT+IGjs8z8efzkSOnSu/4bex0a0C192QBYugOC8sniWFtQg1nZ29rrlYvDNPFiEoAWJtXZjuAwEXr0RgUZ3ERb8QA=
X-Received: by 2002:a25:2e0c:0:b0:dcc:58ed:6ecc with SMTP id
 u12-20020a252e0c000000b00dcc58ed6eccmr13789547ybu.41.1709795412301; Wed, 06
 Mar 2024 23:10:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306200910.2732835-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20240306200910.2732835-1-volodymyr_babchuk@epam.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 7 Mar 2024 09:10:01 +0200
Message-ID: <CAA8EJppNopEF0DmgjCAJyxe8HRebD26Q8heKKLKbPstdfBOv6A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sm8150: add reset name for ethernet node
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 00:22, Volodymyr Babchuk
<Volodymyr_Babchuk@epam.com> wrote:
>
> Add reset-names property to the ethernet@20000 node. This patch does
> not change behavior on Linux, but it is needed for U-Boot, as it tries
> to find the reset by name, not by index.
>
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 761a6757dc26f..c2e65d6a2ac62 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -951,6 +951,7 @@ ethernet: ethernet@20000 {
>
>                         power-domains = <&gcc EMAC_GDSC>;
>                         resets = <&gcc GCC_EMAC_BCR>;
> +                       resets-names = "emac";

According to the snps,dwmac.yaml schema the "emac" is invalid here.
Only "stmmaceth" and / or "ahb" are permitted here.

>
>                         iommus = <&apps_smmu 0x3c0 0x0>;
>
> --
> 2.43.0
>


-- 
With best wishes
Dmitry

