Return-Path: <linux-kernel+bounces-47563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EFA844F75
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695381C23F48
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7833A8C5;
	Thu,  1 Feb 2024 03:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="peiXCw02"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDCA3A1A8
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 03:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706757365; cv=none; b=d+vilKLXUqGL/E6vlPnmt1k51HeTwGYHS86koUGp4MHSl7mfVw43J1Pcxd3FSsF0RhNuy5mM1f7FNzUGwwzL1CUzlFKS3m2i/zSqESqZhqCuG26v6h7QTurDerXcXYYqVRf7ri7OjxaH+Y5NXvnHdX+bJBBQGtxXGH645K5tKKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706757365; c=relaxed/simple;
	bh=USfJhqFmZ3yrsa898v4BZsVQ7dzPpLsAqmreXrQ3fZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCxEJxoGnxg1h7QSNe0svpS+A0RGBqFdVGx7E3/XEP2eWOScvPkr93fWwPL2nwV3W21S7S9HzMfQKREFu1wzTapjF6Pl02mU12asAT6qGEOrvZ59XClTqPKl+2nbrnJsPGMILeZBW9szFHc2ruYX+Ujplxa3mqCtFvZaxzPYj1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=peiXCw02; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5ffdf06e009so4693687b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 19:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706757362; x=1707362162; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ySMnKqaStIfd+gO/JecJswbCVZ1hpxvBLcFq3H3GbP0=;
        b=peiXCw02zpl40Qmhc+cMhVPtOMElABe9RFPXlQ4U+AOq6rJsfzN2BPvTcY0Wo91UoA
         ewsqdsgMJwg3Yal3HUCjkmUlSorT5g6uMwekMSpRKb+tf7NIwgOPEVJgHF/1pTKXw5kA
         xZBoTMF61Lfnz/dCQZYxp8YNwni/WCnd0ifiWz+S1kCxvJ1P8A12gJe9WmqcxaTEw9bT
         4U+ubw5iNCAouto1TWgLx3tA4mdEaS8qgu2//FvCLpoWOlZl/Y55r0ujXIA/8PIVVZzz
         lPQrAhuHwfMS9/Qjnfs+FKO2PbF9W9opbNB+lB2bC2p7cGKNmo9cvdHNdy3NBeFKsJYa
         P/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706757362; x=1707362162;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ySMnKqaStIfd+gO/JecJswbCVZ1hpxvBLcFq3H3GbP0=;
        b=E7B+sUYqnTcf902YsE2huoOjFc3qw7TPBfa7SYlz/cwWSHcMyPw9Dqnabaq8uzl0YG
         3+Irq9lPcjIlHSEa5HJmr+WpE8R/mztObBQCvGGc5MqXgjH5ycBPdEV4htLd3HLPZyx+
         5tTSbH0hh8lR8RmTsokP1IBOCJKrg6I629T6ZQC/lfUq9FUOygFcqxWf62x4xXVNs4Zn
         7x5awdJgutZworBZf8wuOufoBQK2lB5XEv9GzC+Yb/qQHDQprbg73XpxAERfmuyOfW/1
         23ZBmIXRGTTp5zgCwZK9rjfSRmcy5jmLh7x74pdbXmzIUVrjpqVGZRIi+Ap/nu1bG4mX
         BrKw==
X-Gm-Message-State: AOJu0YyLsclhPxlo7aMWx409Sd4V9FJgMXzpilycEU07H1XT2+3enOWL
	vL0ZDpelRGxu9aJs28ZxoiaQlCxtlLb/6AgcTUWi+qQL07CnJi2QjYOfDpIb0ZziGBpB3hT4gC4
	Qdf//OiRI8R0/1uAG1Ws0M0gd1xwZ9PqEN0EigA==
X-Google-Smtp-Source: AGHT+IEL1JBFAvnwKqmlgQqAa19wqbd0K9EGqGaaOWn6zsX2P8KDMBibxSIw3H0972y4b4IEDsIRrGQdTwH0DgNQMaA=
X-Received: by 2002:a05:690c:806:b0:604:ed9:9f49 with SMTP id
 bx6-20020a05690c080600b006040ed99f49mr1072363ywb.41.1706757362557; Wed, 31
 Jan 2024 19:16:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA8EJppDQAdnceYhL_=Di0n5j3W0F2+7ntpNMxpXBXgnYoh_uQ@mail.gmail.com>
 <20240201030828.12515-1-amadeus@jmu.edu.cn>
In-Reply-To: <20240201030828.12515-1-amadeus@jmu.edu.cn>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 1 Feb 2024 05:15:51 +0200
Message-ID: <CAA8EJpoMXkAd3EBf=p+nig8VWzY9tiUAWhfGJn3XOX1uSa=22Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: qcom: ipq6018: separate CPU OPP tables
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: andersson@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 05:08, Chukun Pan <amadeus@jmu.edu.cn> wrote:
>
> Hi, Dmitry
> > I went on and checked ipq6018.dtsi. It will need to be reworked before
> > we can continue with PMIC-less devices.
>
> > Obviously, the PMIC is not a part of the SoC. So please move the
> > "qcom,rpm-mp5496-regulators" node to the board files together with the
> > cpu-supply properties that reference that regulator.
>
> Thanks a lot for your advice, now things are clearer.
> My idea is as follows:
>
> 1. Add all frequencies supported by SoCs in ipq6018.dtsi
>
> 2. Move cpu-supply and mp5496 nodes to ipq6018-mp5496.dtsi

Straight to the board files, please, no need for additional includes.

>
> &CPU0 {
>         cpu-supply = <&ipq6018_s2>;
> };
> ...
>
> &rpm_requests {
>         regulators {
>                 rpm-mp5496...
>                 ipq6018_s2...
>         };
> };
>
> > The SoC itself supports all listed frequencies, so it is incorrect to
> > split the opp tables from the ipq6018.dtsi. Instead please patch the
> > PMIC-less boards in the following way:
>
> > #include "ipq6018.dtsi"
> > &cpu_opp_table {
> >  /* the board doesn't have a PMIC, disable CPU frequencies which
> > require higher voltages */
> >  /delete-node/ opp-1320000000;
> >  /delete-node/ opp-1440000000;
> >};
>
> Thank you but no need. The CPUFreq NVMEM driver will give the CPU
> maximum frequency based on the cpu_speed_bin and opp-supported-hw.

From your patches I had the feeling that you still want to limit the
high-frequency OPP entries if there is no PMIC.

>
> Thanks,
> Chukun
>
> --
> 2.25.1
>


-- 
With best wishes
Dmitry

