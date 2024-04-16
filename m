Return-Path: <linux-kernel+bounces-146127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F153E8A6115
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F6C4B212D1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2644A11C92;
	Tue, 16 Apr 2024 02:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sa8+G+iF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC08E545;
	Tue, 16 Apr 2024 02:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713235017; cv=none; b=qggtZTcpGZhl+MiyLQh3VsnDwXW/oK7wihd0ohjvQHxpD1Lx7DWq21O52lyeQgwS5DUoT1dFWqinUlvutwn9dYT0d13iMTEWUIQZW9uqAv1/Bmh5Pe5XysAq9nP+UtyGP/dvsTcJlx/bRlmFnQQcbm+/8vMsOkpTb9l2XFTzSJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713235017; c=relaxed/simple;
	bh=peXN1Y3UTbxhL5DXVIpUyA5+Cwu3ZFb+d4Y1g3j1jog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iCH/rFLctLpANOewLS9Zq5/3/h3O2EhROaZT+edlXM6t3DuVlFEy3jaM9sbjyALMnPoFWYNAXIsJehKCqKxkWkqbVOGKOyZQypDnJhdhyLvQ/OPg922XLg0r6hROLF0TYN2Vvif4/Jx2d0sEIrTM35JWO/Gnl+VgbQJsfc85Y9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sa8+G+iF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A84FC113CC;
	Tue, 16 Apr 2024 02:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713235016;
	bh=peXN1Y3UTbxhL5DXVIpUyA5+Cwu3ZFb+d4Y1g3j1jog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sa8+G+iFhBQ2A/8agFVKgaPwlRMuIxDa1TwYHlSuojIKgYua/IHWbM9PceBGhZHU7
	 0P/NkOXqkDFfMVZCKtlTAYGfAV/6jjMHwBRe3TaaRZ5+tHWuKC7ivTAUARsLFIkdVr
	 ywOiUvLHG2gCrlxLUNM5q6mkbLQJwV0WAXlfhZcRksZT8EYm4RY0aikPjkGGtiRV6z
	 o1KzNu3cO78hug2Siy1Q/yQbWVR2bS7PuPglTc3d6obj+DqLYT//heDcwpbJmA64Kx
	 9R8vimREFoxGC4GOZCSYUru+dOvbGkYwYDjBgtAvUbZhULCM95quA/8cyAxgcewYM6
	 2Eqa+YQwzGshQ==
From: Bjorn Andersson <andersson@kernel.org>
To: James Schulman <james.schulman@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>,
	Abel Vesa <abel.vesa@linaro.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: (subset) [PATCH 0/7] Xperia 1 V support
Date: Mon, 15 Apr 2024 21:36:53 -0500
Message-ID: <171323501053.861898.18063006393453475946.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240210-topic-1v-v1-0-fda0db38e29b@linaro.org>
References: <20240210-topic-1v-v1-0-fda0db38e29b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 12 Feb 2024 14:10:08 +0100, Konrad Dybcio wrote:
> DTS for the phone and some fly-by fixes
> 
> Patch 1 for Mark/sound
> Rest for qcom
> 
> 

Applied, thanks!

[2/7] dt-bindings: arm: qcom: Add Xperia 1 V
      commit: 212729551c4186a1a1cbd80379375b1b54488369
[3/7] arm64: dts: qcom: sm8550: Mark QUPs and GPI dma-coherent
      commit: 91fc74458d833dbc999aa04ca34c2a197711a0b6
[4/7] arm64: dts: qcom: sm8550: Mark APPS SMMU as dma-coherent
      commit: 93395f9a8d52b89868d75e278adaf002f99dec22
[5/7] arm64: dts: qcom: sm8550: Add missing DWC3 quirks
      commit: d18b5477dcea7775a562b3ba7aaa68772c8980ba
[6/7] arm64: dts: qcom: sm8550: Mark DWC3 as dma-coherent
      commit: 6e4f7e53991ca7e70dc7d5d9d66c833091e1f6ae
[7/7] arm64: dts: qcom: Add SM8550 Xperia 1 V
      commit: 39c596304e44781c1950ea0cbf178d6433ff9c71

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

