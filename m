Return-Path: <linux-kernel+bounces-47623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A30845060
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C72529036A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CED23A8FC;
	Thu,  1 Feb 2024 04:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LrnTEvPm"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149AE3A8C5
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 04:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706762310; cv=none; b=EkjV11g+hXhoPz9QXLoVG+Nr7Fdx38PJcnFx0DpnXRhJJaL3Dxc9tz7uoDGdnhIzRMqEU9VkAX/ocbEdJiTjZ0yyMGhRgSg+8vlrcFs3bZD+HLe8PqV18VnuY5xxjXg6P8Tf9qrX1lMmn/nVEI2o21L96ZAnvmAekYoDUE3M90Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706762310; c=relaxed/simple;
	bh=xlp952QhQ9vxiVaZPe1VxvlXo4DhX8Ootnu7t88muQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPmtkJZtMteh/+eg4TDJI/bNOHuNxm7DzWamoGasZn//P8drlu4CwJWoD2VDheAnaw3HOxqBpSkbBZ/ZFFikDNBGpvblZj4RUmKt/biVcWLp4iL/I8HQMUo4qGNjzpSr3a8RJnhxDaaKaNHsxjeP9eWHR3N/AL0RLGmd2gLnuaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LrnTEvPm; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6040d9e52b9so5421697b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 20:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706762308; x=1707367108; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5YQRrCqKrxX0QGwWLOXM+qSJBKdpS7XuLXPk6PACHYY=;
        b=LrnTEvPm6dFZPlZIeCdcz3N/kI1Qz9QaIidJEKjRTfdODnQDZCDP/yIeamUJi2olUY
         De+qvAeJ9M8c4CEzEMdp+CHKzxQDWMFcVT2dSdALAj1vDUhKgXpgKwhkzMkXCqALLBhE
         oP04kXgoxuCW6ZGRXTLXDDC5LgCPNDsJCiwkAH8rm+r4g8EJwu2NzOfHPE9V9MXDMm4X
         0QGxUKLOTA2fe7q6QhZpqX/SgfotT6w9M94PJtZXnEjT4ffiMzxjxgNPR2ZK4JpzhaYP
         jCvP2PEwESsv81UVpVuGbb7/06AArzfL12yrQ8/BQzmL7TKhSLucBfcFW8c1U7me0I5E
         hsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706762308; x=1707367108;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5YQRrCqKrxX0QGwWLOXM+qSJBKdpS7XuLXPk6PACHYY=;
        b=decZKp3GIX0VVftGabuW0qGLqo5WSvucrWccwuAyF4vJ1Vl1SLyPiRlUcwdUj32jpR
         WifWDUS1R3gDPgTs5D4HFBfEUQwAqfQ+EHo9wAQwzDHYfvNSs2YKOsfC0t9DBztwZii4
         oDiH1UusOdECO+nki1aZkKxbqjUbKw9BSAneTuK4aewynx4+QSbat85KtDJY7irY6vTV
         bFbwg7jGjm0VXYS5t/N4QKE8IZjjZ2KR3feplQeGYxfVdAu6gLW1Sij36xm43vrkpkPB
         zrej4CRZ2bAD1D7q94GqVqNwRH7cxsQbUs2Mu/JF7uWjUD+adt7hkKukAbwatphZQrFd
         XfIA==
X-Gm-Message-State: AOJu0Yxqq+AImoXBWm5q81xQhavZSj19czvhDzjMEDJqWdFE+WjRa++t
	vTtGfC761nsyVjcrd7kXjB81FVX/Yn81i2Lrok5V7bdQZrQLYDbiu9ul8zskfmPgACxU/zIWIps
	msbvRJfu1NOh6l5ABr6HGNGLZBoPMkAfs9v7UwA==
X-Google-Smtp-Source: AGHT+IF9J2ngL1O+SFaYgJ97zecTCjLejp62QfeLNd9nH0Hds7iKb9x1nnxcTAIUm3azYuiukMqzFbXqj4pxxW93eI0=
X-Received: by 2002:a81:4f8d:0:b0:602:9161:2e73 with SMTP id
 d135-20020a814f8d000000b0060291612e73mr3274183ywb.29.1706762308049; Wed, 31
 Jan 2024 20:38:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA8EJpoMXkAd3EBf=p+nig8VWzY9tiUAWhfGJn3XOX1uSa=22Q@mail.gmail.com>
 <20240201040020.73949-1-amadeus@jmu.edu.cn>
In-Reply-To: <20240201040020.73949-1-amadeus@jmu.edu.cn>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 1 Feb 2024 06:38:17 +0200
Message-ID: <CAA8EJpoQ8O_atu9K=eG+NLQ_Ei64qvcQ6GoYyJjxJ_DGH2D2+Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: qcom: ipq6018: separate CPU OPP tables
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: andersson@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 06:00, Chukun Pan <amadeus@jmu.edu.cn> wrote:
>
> Hi, Dmitry
> > Straight to the board files, please, no need for additional includes.
>
> Is it possible to move the mp5496 node to mp5496.dtsi?
> Because ipq9574 also uses this mp5496 pmic.
>
> &rpm_requests {
>         regulators {
>                 compatible = "qcom,rpm-mp5496-regulators";
>
>                 mp5496_s1: s1 {
>                         regulator-min-microvolt = <725000>;
>                         regulator-max-microvolt = <1075000>;
>                         status = "disabled";
>                 };
>
>                 mp5496_s2: s2 {
>                         regulator-min-microvolt = <725000>;
>                         regulator-max-microvolt = <1062500>;
>                         status = "disabled";
>                 };
>
>                 mp5496_l2: l2 {
>                         regulator-min-microvolt = <1800000>;
>                         regulator-max-microvolt = <3300000>;
>                         status = "disabled";
>                 };
>         };
> };

Usually this is a bad idea, the regulator boundaries are board specific.

>
> > From your patches I had the feeling that you still want to limit the
> > high-frequency OPP entries if there is no PMIC.
>
> Sorry for this misunderstanding, the cpu max frequency is determined
> by the cpu_speed_bin. It's just that the efuse of the board I have
> without pmic are all 1.2GHz.

Ack, sounds good then.

-- 
With best wishes
Dmitry

