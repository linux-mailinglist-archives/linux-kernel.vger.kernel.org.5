Return-Path: <linux-kernel+bounces-161147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E72EC8B47A1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 21:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228F01C20C6B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FE0152DF3;
	Sat, 27 Apr 2024 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjIsrio7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9160148854;
	Sat, 27 Apr 2024 19:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714246470; cv=none; b=sJoqjbaDrwVLpA/IhT1bT7eaXpcBv4ukLDSk086hSMoJ8Vstc+U69q7gPPAvhECaH3IWBUHt4sL3jJNb9mXg51ClpVCK2ITBK2IlWARMlWiaBfyLOsRNPSoDtCTiiS2iiXT+2AxRlken686u5RFZ3zZJoIm+f3mJKoeksw5+jfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714246470; c=relaxed/simple;
	bh=LR/oYNah2d4+Szbv/v/OLADxMTxxprYCXmTssAqOvt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SJ6xDs74n53YAqWzQ4XYcKk/uiEZF4NitQmI6ukvyKao9FGZCcHOTWeE9+bLokF4wEvfuO0Cfb+7mSVLMvAqgcmO0OarSwyhKRK85liq4bDvZex3/Kn0Hyt/D7ftrrSJrBLhqq/WF7KDto99tHq7lGgg/wcYVPPsdSjis1ZvG6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjIsrio7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CCFC4AF07;
	Sat, 27 Apr 2024 19:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714246470;
	bh=LR/oYNah2d4+Szbv/v/OLADxMTxxprYCXmTssAqOvt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tjIsrio7OgCAvCsV9oM7mfKrMNJm0PFzlHDN+TdQAYFmEPVKFd9HTXQpSqWQRW71W
	 Lhdph+O12FDXCeJxIx/8Cq/o7uzi6SCXsBVZCATolqsSH9z/CjUT06+NsRQhjE9UVK
	 gnmewnnjo1W12jdwl2RqNiJbnsNA1J4orV7qLzMGdaHu+Q+RLDY3lGKBe1deoujJc/
	 K2pAXOKmVdX72tGDdSaInOKfDCufUIdLw5Lth7Fnd6FxSFmqQHoFkAmlMPYQHORzum
	 fi97yXw2ri0qtU7BwfoHTiIlJgg+noFIQr6EhfpjV78MU+nBwZB2tG1LS0SxYP1Iy7
	 WKBSHZBQ22/Jw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Varadarajan Narayanan <quic_varada@quicinc.com>,
	Sricharan R <quic_srichara@quicinc.com>,
	Kathiravan T <quic_kathirav@quicinc.com>,
	Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v3] clk: qcom: clk-alpha-pll: fix rate setting for Stromer PLLs
Date: Sat, 27 Apr 2024 14:34:19 -0500
Message-ID: <171424646117.1448451.2219390632640064280.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240328-alpha-pll-fix-stromer-set-rate-v3-1-1b79714c78bc@gmail.com>
References: <20240328-alpha-pll-fix-stromer-set-rate-v3-1-1b79714c78bc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 28 Mar 2024 08:54:31 +0100, Gabor Juhos wrote:
> The clk_alpha_pll_stromer_set_rate() function writes inproper
> values into the ALPHA_VAL{,_U} registers which results in wrong
> clock rates when the alpha value is used.
> 
> The broken behaviour can be seen on IPQ5018 for example, when
> dynamic scaling sets the CPU frequency to 800000 KHz. In this
> case the CPU cores are running only at 792031 KHz:
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: clk-alpha-pll: fix rate setting for Stromer PLLs
      commit: f837535fcb32a0313e07dd8ac49c2cfa43b49260

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

