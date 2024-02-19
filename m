Return-Path: <linux-kernel+bounces-71309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14BC85A34F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91883B2209F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59842EB1D;
	Mon, 19 Feb 2024 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i1+OfYRO"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542A02E84B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345848; cv=none; b=NueD2d9xliyowxyQmzagWTezXQN1w9C13WFdjxDDlQHYFoUradXb3u0TuUrOlOn15Sv7wF2dbkjdcsFVpyh4Ax7YqwU6aTmdb1cgye0dxYOruYCi1SFwFqJQ4Ebxy8pfL9x8DXGu0JC0bTYlpTH5YRZkeqmxmga950cvcW0LQ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345848; c=relaxed/simple;
	bh=6SSJUaw0nKKP3ZKsGMyfMQFocs8b5O1NPgxcoNxhRVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+0M8DWLvTA4xpebSxMRS8v7cBOo+da2sRrIgtUbodHRO7TOdR7pUztiEzCvql9igiAcky4k4jeWJvO3QERz4Usnbmc4F66xrEhECByr/aQ7SYUNF23JqmehVH6H+ySeJ+rH2HZodqTTjiAFyy8kcBSAORrflTrqOSoRNzhgxFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i1+OfYRO; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512b6d754e4so665632e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708345844; x=1708950644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7cz6IUziBIbxMgivwszuy8eOIkjtw8gK8yFchWpzBU=;
        b=i1+OfYROEjEYnJsKSPdC/CMVppRT001BAfBoejGxH2+o0s7GXoEhYOhHYbCMsoUbV2
         pfCEsaZiL6EHvQ4Hy3kVdMw45c3bSIhK3a8bnmvnjEwYH9N3XX7xoX8WvrGH/Z1Ez0NH
         SJiobKuOP5vhNFejuNo8yPVN2OEEUWdzwmVT7g+oDQTsulQfdh1u4W2hfZb6A2gQLNyx
         5JeAU+cFmob8Htnqyg0Z65BGjUInXE2J8vd8HLk3fZ+oIdQ2Fps3K4QXdhMXVxAbhjwh
         /bjwgEFKutFdRECayY9Y9BFHkVrRR/BHbtPmOG9AwnD6L1cI1taoKzQH6LQpXUoRVANh
         36sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708345844; x=1708950644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7cz6IUziBIbxMgivwszuy8eOIkjtw8gK8yFchWpzBU=;
        b=oy1jBzDsHjT54Vgf9z7JuThkn+blzn2bHQbQI0zTDTBfF93lm7KQbqPRQ2Mh6o0Z4z
         Gw7PUl3ntghSRX6Q+w4xl7bKtyxYJMERszKEhyWcMSG6lDY/ZivclJwje9e3a6nZytd0
         GJrwwPa4btBSG3r3/+J4dMmXKFr/GqmSsPj19JiIWuJ7feuvVPPDHd3zfE93hPW4p+UG
         5NSYRUnHh7cToE13Nw5+yNakFC3LXW5MhOs9y4o20+jTkeaTMmMVL34e6Gx4ybBTlmZK
         Y+iQrlIFY9zxrACdr4WGNCY+jCOauyJCkidoljezF23fccMSFOj5xNifUU/CDd6HrA9W
         QbZA==
X-Forwarded-Encrypted: i=1; AJvYcCW34Eqw9NkCF5hjwWILVD0/bMEUyAANEWdOHLsSZ4ZZgHqNZmh5OrbCWxZsym8K1XRdIR057mHSx15v7kLSbMysQVXNfobyhVIClZ2s
X-Gm-Message-State: AOJu0YwYrP1N+pmTdlFKNe+eTYtotT2H3Jg5Jq8tsonXv7cUyjoHOaCo
	ioCkLXqDnwsRrUpYNPdBRTZ3lVf4Z/cF2Akr23+/IH3fEV6cPIHPPdbhypnvPT0=
X-Google-Smtp-Source: AGHT+IGoP4Kc9T7+0vrUb3lFQohpsZ0w3oy4cAILJsX2XN0cHTj8EK4Nqbp0ilMeo3oHJesO9tXkfA==
X-Received: by 2002:ac2:5e8d:0:b0:512:912f:4bb with SMTP id b13-20020ac25e8d000000b00512912f04bbmr5296326lfq.68.1708345844597;
        Mon, 19 Feb 2024 04:30:44 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id i6-20020ac25226000000b00512bde4cddfsm90466lfl.148.2024.02.19.04.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 04:30:44 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Adam Skladowski <a39.skl@gmail.com>
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krishna Manikandan <quic_mkrishn@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] MSM8976 MDSS/GPU/WCNSS support
Date: Mon, 19 Feb 2024 14:30:30 +0200
Message-Id: <170834569497.2610898.8605974222285085772.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240121194221.13513-1-a39.skl@gmail.com>
References: <20240121194221.13513-1-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 21 Jan 2024 20:40:58 +0100, Adam Skladowski wrote:
> This patch series provide support for display subsystem, gpu
> and also adds wireless connectivity subsystem support.
> 
> Adam Skladowski (8):
>   arm64: dts: qcom: msm8976: Add IOMMU nodes
>   dt-bindings: dsi-controller-main: Document missing msm8976 compatible
>   dt-bindings: msm: qcom,mdss: Include ommited fam-b compatible
>   arm64: dts: qcom: msm8976: Add MDSS nodes
>   dt-bindings: drm/msm/gpu: Document AON clock for A506/A510
>   arm64: dts: qcom: msm8976: Add Adreno GPU
>   arm64: dts: qcom: msm8976: Declare and wire SDC pins
>   arm64: dts: qcom: msm8976: Add WCNSS node
> 
> [...]

Applied, thanks!

[2/8] dt-bindings: dsi-controller-main: Document missing msm8976 compatible
      https://gitlab.freedesktop.org/lumag/msm/-/commit/db36595c6889
[3/8] dt-bindings: msm: qcom,mdss: Include ommited fam-b compatible
      https://gitlab.freedesktop.org/lumag/msm/-/commit/3b63880de42b

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

