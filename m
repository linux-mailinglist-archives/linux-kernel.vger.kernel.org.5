Return-Path: <linux-kernel+bounces-155229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE6D8AE72B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E241F2624C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1588412E1DB;
	Tue, 23 Apr 2024 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="STZkVB2x"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAF97E765
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877128; cv=none; b=WDiIxgl6QvzJhZDAWgE3YzLAys1P7cY4LNWBck0YQeSphD+xx9EVHMRFOgCeh0Y7MLVyuyj7UOCAKp5wnVIgT2/W4GQO4uSYQTxHqskbwBkw0kAAzD/rbzc0jI5IP+AhOBvgz/S2dsOOMkAKm40myC83oTmQkiRF5Yd1nEpClQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877128; c=relaxed/simple;
	bh=C38jNkPQIY9PbuFlXsBJRUbs0C33ZReaOCMWgYaSpZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k58jjb83nIVbES6/Uo1n3Osej+LYW+tB52eOICmTimDajIW0ICbhsRc816hyoArZtmvqfV1DHbxpHBKvs+kmB5e9DLCEaXxo5vCic4yz6F5ne3HTZN9KfygiAMlU08HlEVkTgreqx1sbdKeZKUnDgsbJir0qwFET74fzNW3GMUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=STZkVB2x; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51acc258075so4693587e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 05:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713877124; x=1714481924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dfWMwHQIpw4zS3iFGNbv1FwxyBMpqPbqqndAtgdwOvo=;
        b=STZkVB2xoG0zGbe9KBS4l7UH0vv9pJ3uqHQVktFP/nzt+wghIG27zyNGC56W9J9hmI
         43DRQKtRQuosG2bct4YVMylVhh9nwYUWGUHEjKysZqPw/UHR0Uv92W6WkJ0VXYuc6Smt
         BWaYwKmgUQqEtvxBpoVKqlqkHVk+h6/R8Wcg5q3JKvCZrO7Dt2NG9E9C1VGhlsxgHqtW
         eM8gSV9mnZX/Wo+t5Y5LkTyZh04tvNZkxqBRol+vp/On7hTRtDhbhRnZ9Adk0t5xzTLP
         eZCtyJhWnyfGsrra6IeeNbX8ocQs3AxL5W99M3RJo9TCZvLiWJFcoiJoH2DrkgU89iNR
         HNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713877124; x=1714481924;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dfWMwHQIpw4zS3iFGNbv1FwxyBMpqPbqqndAtgdwOvo=;
        b=jHSDtFUjOKtF/GgOkKbQf42ZJkOZI54TVffTQl1meX2jGi168Gyfvxg3sbAMXTdrY0
         oXeVCruDxRpU3g+tccy3MmBiLri3I9rnozVMeNX+h8IMP2S8ge9K0ZtvwASplhvXnSia
         t9ohABoAN89kdHIgGp5qNhyt2Zs8rbPoed8X2tiCl+k/fAZvnqlhdULeOSzYzPbDyn/z
         ttPSpJGYwXbY4r9FyBRITWoeAIZMqvh3gz8F7MBgQRaeBpNoDiu3/B78+OwBcOwf3+dc
         FvSm7b9STc1esMOQzXW1Lgr1F7WeT/govcSNETUVdC6igMq0QuTNUTeDLffxMMsAOIzy
         s7sA==
X-Forwarded-Encrypted: i=1; AJvYcCXd41nKYLoUG+B0ek/lrJS+zaTuxMzMMC3uFMhS0sdm9TSF0toScF034eOb+Qubl49z9uimTRdQxJAR0xv1JhWS+rbQ/CZmh/WzH/9m
X-Gm-Message-State: AOJu0YzUtFY5WngSYMu9DlQathWjtk27mQUMX98XQXbXMCtUHr++JyeF
	EBDVD6+vWAcgQxVLdKFO4UyXeGTqwA/qZFltfcnexLNkr5yZN4SgaHAqo47Itc8=
X-Google-Smtp-Source: AGHT+IHFPonFyfwcyDEJAcAqUSp9XGi8YlceLjdGzBOHf719wJg692YC5McvPpN7AvR2TgPu+w13Xw==
X-Received: by 2002:a05:6512:3712:b0:516:c8e5:964e with SMTP id z18-20020a056512371200b00516c8e5964emr6801237lfr.21.1713877123745;
        Tue, 23 Apr 2024 05:58:43 -0700 (PDT)
Received: from [172.30.205.0] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id c12-20020ac2414c000000b0051ae53e9afbsm1148796lfi.92.2024.04.23.05.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 05:58:43 -0700 (PDT)
Message-ID: <a7194edd-a2c8-46fc-bea1-f26b0960e535@linaro.org>
Date: Tue, 23 Apr 2024 14:58:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/6] arm64: dts: qcom: ipq9574: Add icc provider
 ability to gcc
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, djakov@kernel.org,
 dmitry.baryshkov@linaro.org, quic_anusha@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240418092305.2337429-1-quic_varada@quicinc.com>
 <20240418092305.2337429-7-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240418092305.2337429-7-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/18/24 11:23, Varadarajan Narayanan wrote:
> IPQ SoCs dont involve RPM in managing NoC related clocks and
> there is no NoC scaling. Linux itself handles these clocks.
> However, these should not be exposed as just clocks and align
> with other Qualcomm SoCs that handle these clocks from a
> interconnect provider.
> 
> Hence include icc provider capability to the gcc node so that
> peripherals can use the interconnect facility to enable these
> clocks.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---

If this is all you do to enable interconnect (which is not the case,
as this patch only satisfies the bindings checker, the meaningful
change happens in the previous patch) and nothing explodes, this is
an apparent sign of your driver doing nothing.

The expected reaction to "enabling interconnect" without defining the
required paths for your hardware would be a crash-on-sync_state, as all
unused (from Linux's POV) resources ought to be shut down.

Because you lack sync_state, the interconnects silently retain the state
that they were left in (which is not deterministic), and that's precisely
what we want to avoid.

Konrad

