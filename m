Return-Path: <linux-kernel+bounces-33878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58284837042
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDF97B2CB3F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3127A5025F;
	Mon, 22 Jan 2024 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dcc0Q0fc"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088F04F5FD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946223; cv=none; b=uCIR1WAZuXRwoH7+JdeSdYVL3/KnFb0ObRVrnudYwk1FDLRTDbdhXyGL45gmMf2zNCHcmPFsF20zrH2euVKt3sWZlZQ9s5dE29Sd2F2ie6SM1jxYaOxFwycZKSN6A3qsOGQqR+839RmBeSNOtF6U/YgogRqY2/BA5y/YZ/2tlyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946223; c=relaxed/simple;
	bh=ovPm9FWfpmW1Rg0fw3HpdXXlLm8m1fro2KhS//RmoLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KA6Bb7gO5/v4t6taYmnZ4moHljnFl4BcWYbPGyeQ0uOicDeaR3bP0ax2yizYeJPt4y5RV8MMG1kkiC4362buSyzSwuEToR7wmoXVbG4NATSjKciY4+ALJNXBcT5eThyeKUlBqDKmxFf+esXszktfI5UJ+6zxUMvbKhHKzzcs9vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dcc0Q0fc; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-db3a09e96daso2712668276.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705946221; x=1706551021; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aqpR5P27BmvNeH02hK3tf04DLb+Qs+1ykFP4zK0aXJw=;
        b=dcc0Q0fczkHStcQFuxJ3hn6cJK8Gg7m+osypZWfDZCjq2IzGUIwTr6AjrPqUB7+wSY
         yCGJUWFk87pDr9kgp+1JpB205LscD9fcsCVdRgoqELPy8DR/FFKOn9GIQ1Si7bOvm9Qc
         gY8hwWSNOlxg2fLM65cveaTCdCvPC07DakBHOhHDZxJPv14anYDj8OysfNVjBtvhEU9W
         Tlwf89g2bhFb7hFMQDdimXDctdrwteN0xIvfjw7XsH+Ynie2f081++UxHAjSivAz1+Pn
         6b0ogQEC4bLh4SmEep9YjipkS1E5puAMle7VS9ANf3nSqQI0P8LF4WN0Wr712hPUeqLm
         SKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705946221; x=1706551021;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqpR5P27BmvNeH02hK3tf04DLb+Qs+1ykFP4zK0aXJw=;
        b=xJpNSRmWSlVSH/8fRNEeNIenoS2zifx5y0yJB8QGA2gu5NAseaaEfwcd0MQi7IKesv
         F8hEe9JwEyK/JzglmHlBeJzxCMSIO0Wc12dWu8ThNK3vx4YVYC+BoSTiOPWcpT2x1h7N
         YeTISHcFhKSqpvYI1NiNo6dZ9p4LpQmVDcPmpaYrXMbmhY+s06eC5tIWY6lWThNoMfex
         DxcaUtMNAsnwngdz7DwLnq/EkVRGpzlGUlwxVvfxrqV31ceN2OEVH9fZMWg+ItDsbYiR
         ImqiMkW+spYnwRtcx1WHGjBd44PRoQslAMXz6AHIJquuTwmJTV1ii9BfV8ClMXN6JrnM
         0m7A==
X-Gm-Message-State: AOJu0Yz+IoSWq0ZGWg8DcoGuF6/V68i44hzxbA8A1gPSnTtBYBT9dQAp
	LW8rWiVyoLMNLT/3DjTv8/Z2Coo/QYvRvM/d33fnzfI78q/J2D+HPjtE4bM4jzMjxSLJeZj5QI1
	8WR1NvUtjMTt8KDE9L5lOBEUR89bRtvQzng0rGw==
X-Google-Smtp-Source: AGHT+IF95AgmkjnL4++VXNUaz/+6iHpGMvRzLQ/F97qNFWQHodUEo2XCob0DxHxVTjRLVMHQ5Obqg7vbardt70otFSU=
X-Received: by 2002:a05:6902:2213:b0:da0:400e:750c with SMTP id
 dm19-20020a056902221300b00da0400e750cmr3066988ybb.27.1705946219438; Mon, 22
 Jan 2024 09:56:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122-topic-qdf_cleanup_pinctrl-v1-0-0c619ea25091@linaro.org> <8c9b157b-4698-70a3-57b7-c588998eeda7@quicinc.com>
In-Reply-To: <8c9b157b-4698-70a3-57b7-c588998eeda7@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 22 Jan 2024 19:56:48 +0200
Message-ID: <CAA8EJprDk=HnqWJ_F5zdUKMPFPpx1RD9KN-KQP9yopP6LMh_fw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Remove QDF2xxx pinctrl drivers
To: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 19:43, Jeffrey Hugo <quic_jhugo@quicinc.com> wrote:
>
> On 1/22/2024 4:57 AM, Konrad Dybcio wrote:
> > The SoC line was never productized, remove the maintenance burden.
> >
> > Compile-tested only.
> >
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> > Konrad Dybcio (2):
> >        pinctrl: qcom: Remove QDF2xxx support
> >        arm64: defconfig: Remove QDF24XX pinctrl
> >
> >   arch/arm64/configs/defconfig           |   1 -
> >   drivers/pinctrl/qcom/Kconfig.msm       |   7 --
> >   drivers/pinctrl/qcom/Makefile          |   1 -
> >   drivers/pinctrl/qcom/pinctrl-qdf2xxx.c | 164 ---------------------------------
> >   4 files changed, 173 deletions(-)
> > ---
> > base-commit: 319fbd8fc6d339e0a1c7b067eed870c518a13a02
> > change-id: 20240122-topic-qdf_cleanup_pinctrl-98e17cdb375b
> >
> > Best regards,
>
> NACK.
>
> This was productized, there are some out in the wild, and the platform
> is still in (limited) use.
>
> I'd like to see support hang around for a few more years yet.

The problem is that... its support is pretty strange. I can see
pinctrl, ethernet and quirks for the platform in GIC-ITS and PL011
drivers. Is this enough to get the platform into the useful state? I
can imagine that "QCOM2430" ACPI handle was used for USB hosts on that
platform, but I don't remember when we last tested DWC3 with the ACPI.

So, all this boils down to the question whether mainline (or something
close by, LTS for example) is actually used and tested on these
devices?

-- 
With best wishes
Dmitry

