Return-Path: <linux-kernel+bounces-146810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1368A6B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE591C215D9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B9512C462;
	Tue, 16 Apr 2024 12:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mWBYVw7R"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DA712AAF4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271215; cv=none; b=iXq1Tzb13aMEsEu9cMw1GOjc/apOduDPfFnJvR0ddo5aqj+IHh9wk4w0T52sZlQ6Q2SnosmrHgAKsUi6F16ZSDHa1IeX2O6ulYmCg8a+snyrg/T9+JQcDKqSKhMDaZCEWv50fbRj3Xav5/JXBI7n2X8dmUFwnBQ9HP8P6GrLNl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271215; c=relaxed/simple;
	bh=qmhVGDCB3p9HB3TLlFjPrZ/6xvV+VH4aBoNpHmYC524=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2vneIavOZfgOf3+JOR4kDHJy4QHEW6SnkGH7ujTqsU3Nnix+NPavO8GdEiNAZcznwGV4VJtYR41YusG1aSHp5zQnvcKSBOlf2/YpCvCoT6QjsXTcdTBlCQF2cHVBSLo4n8TwYdtaKrrZ/mmLwKyLf38i4v0/0iNb91fASYH8tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mWBYVw7R; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dd14d8e7026so4098980276.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713271212; x=1713876012; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XocEjulw3kAiCxPyVJw1Ya87AMjOi1KyGw4TtHVGXCk=;
        b=mWBYVw7RCfJV1TzZT9Y+25z1rdh0Ea34oBx8ic3A13g2D4fw9qSpqHuoR4Ha7ooHEW
         n3ZnCLcXgq9J0AY6FH1lknlJekuei4bw1SzbbXgQLf9iVST9FPPK/KvSji5ZzYXTXUfo
         gOfFhBNtc8zjygZ3LbbAuc1GjNV+hRwH/r3oogmrM163wd/vqHeEK/dbaRl8+8xj2mAB
         i9253NYcF9I8Q2QfBn9y7bLUw5q1fMoV1RDDERhDaL3GG9gIHToD7+m888uenc3Ggkr0
         U5Qj3coGtfpVPeO+fiXjKGl3T2QNY6Zhlf25j+4DTOq2Trwu34XSWvit9PXpMYeap48R
         VaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713271212; x=1713876012;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XocEjulw3kAiCxPyVJw1Ya87AMjOi1KyGw4TtHVGXCk=;
        b=VZHnRYgb69aSvRT09Z9gyYsVCLH8/EAg+AJB+FpzAqlv/ECx6l5P+IqeA/vz0sjMat
         wbPuYGhfHoTJzu/RK2mFcRMxjZx3XMruk0chJcQPGe0aqfjIstwWi8gDgJpcYpf8Igmq
         c56vu6DzDvPcbtLkQhlbvg1GgNF4+dSpQF6ZEE+62XWt9g4u45K2Sd0Xl/SzMQniCMi1
         JuCbdotzLXoA+6t9gZL8rq1HEzq1vcIkGpIls/oNUM5kI3adfWEMYCyPvIxVswIWaoQ4
         JMHAJAliAegKrvjoJyi9vkyI4MwGMZTy1zbAFLYp7rOSf/wR+wIhVuD4VjFyOymDrxyG
         F1Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWrNFE/F2y/aIIYgcdp4kaAiDw+EGvn+5VCpjApDlzTjCF/BA91fOW4Eid/fFtdnpCZ/Hqy28wUQGBYaHtdOLJvh0asRjdVe29K3F1M
X-Gm-Message-State: AOJu0YyKgikRaxFpvV2+TKlgxLXaQ7w0b+MbJCSeb0FOsS1PI/54ps8h
	I/2zAuvGXUo7r+q293tSBCwuFSPpHvnXUePDc/Vtowqz4deFUQFZlIfThGxnsgee4XMMt3KOYXh
	CWdD+RRfcKNHz/HN4PwDSO4whIe/nm0AmhocSdQ==
X-Google-Smtp-Source: AGHT+IGJhFIyKEbY2TNHNPrCm3GRm5c6L7GB4Z/sH1BLsFZXKmx3pHDdVDxtNq7uyYtUlxMVzqOrk0oaE4WyfbJcIG8=
X-Received: by 2002:a25:bc4c:0:b0:dcb:fe58:a08b with SMTP id
 d12-20020a25bc4c000000b00dcbfe58a08bmr11907548ybk.15.1713271212014; Tue, 16
 Apr 2024 05:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416063600.309747-1-quic_mohs@quicinc.com>
In-Reply-To: <20240416063600.309747-1-quic_mohs@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 16 Apr 2024 15:40:01 +0300
Message-ID: <CAA8EJprABOeWrAm-PyeLF1ZM95qC17bxyZvEVpGG1Wz97KLYWQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] ASoC: codecs: wcd937x: add wcd937x audio codec support
To: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Banajit Goswami <bgoswami@quicinc.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_rohkumar@quicinc.com, quic_pkumpatl@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Apr 2024 at 09:36, Mohammad Rafi Shaik <quic_mohs@quicinc.com> wrote:
>
> This patchset adds support for Qualcomm WCD937X codec.
>
> Qualcomm WCD9370/WCD9375 Codec is a standalone Hi-Fi audio codec IC
> connected over SoundWire. This device has two SoundWire devices, RX and
> TX respectively supporting 3 x ADCs, ClassH, Ear, Aux PA, 2xHPH,
> 6 DMICs and MBHC.
>
> For codec driver to be functional it would need both tx and rx Soundwire devices
> to be up and this is taken care by using device component framework and device-links
> are used to ensure proper pm dependencies. Ex tx does not enter suspend
> before rx or codec is suspended.
>
> This patchset along with other SoundWire patches on the list
> have been tested on QCM6490 IDP device.
>
> Changes since v8:

I hope it's a typo here since the series is v2, not v9

>  - Split the patch per driver for easier review as suggested by Krzysztof
>  - Used devm_gpiod_get api to get reset gpio as suggested by Krzysztof
>
> Prasad Kumpatla (8):
>   ASoC: dt-bindings: wcd937x: add bindings for wcd937x
>   ASoC: codecs: wcd937x: add wcd937x codec driver
>   ASoC: dt-bindings: wcd937x-sdw: add bindings for wcd937x-sdw
>   ASoC: codecs: wcd937x-sdw: add SoundWire driver
>   ASoC: codecs: wcd937x: add basic controls
>   ASoC: codecs: wcd937x: add playback dapm widgets
>   ASoC: codecs: wcd937x: add capture dapm widgets
>   ASoC: codecs: wcd937x: add audio routing and Kconfig
>
>  .../bindings/sound/qcom,wcd937x-sdw.yaml      |   71 +
>  .../bindings/sound/qcom,wcd937x.yaml          |  119 +
>  sound/soc/codecs/Kconfig                      |   20 +
>  sound/soc/codecs/Makefile                     |    7 +
>  sound/soc/codecs/wcd937x-sdw.c                | 1148 +++++++
>  sound/soc/codecs/wcd937x.c                    | 3036 +++++++++++++++++
>  sound/soc/codecs/wcd937x.h                    |  655 ++++
>  7 files changed, 5056 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd937x.yaml
>  create mode 100644 sound/soc/codecs/wcd937x-sdw.c
>  create mode 100644 sound/soc/codecs/wcd937x.c
>  create mode 100644 sound/soc/codecs/wcd937x.h
>
>
> base-commit: 6bd343537461b57f3efe5dfc5fc193a232dfef1e
> --
> 2.25.1
>
>


-- 
With best wishes
Dmitry

