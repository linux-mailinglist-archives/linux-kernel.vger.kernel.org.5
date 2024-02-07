Return-Path: <linux-kernel+bounces-55941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C8E84C3D1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039441C2314E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D8414F90;
	Wed,  7 Feb 2024 04:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cpsox9op"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227A6134AC;
	Wed,  7 Feb 2024 04:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281208; cv=none; b=Ecsbrwq2Jt7Qy1vDlHTBEBzQbHPXwPborN8Ir7iAegJK/JU/NpRMt1dayDPWjJcsWJxKNJLjog93VFQMOTwbCLIoXE14m4du/3mxNiszQrgFdjsTuh26FDq9C9AhaiFKCOJ+SqqQEGVp4G6jB45gWFpkf3iig0M6CMqW1YYhXuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281208; c=relaxed/simple;
	bh=5Kg8lgp5mxT7O9V3bfE//DzBIpPh4KUnERcoqQoeuEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fEPJ57mJqYRWoyo1JiTFETckWW8sLe6OUAweHR9no7f7EQSwaj5Z488/tVDHmhtPSSw4RsrpnHZRYvtjkICPEaPqbYvRoKa7oe6R8XPJjeC2mOeogtWo579DdefE2H0PCsdjWlJ6zMG14v10zZH6M+3RadgPIyeUgqf9ZVgnx0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cpsox9op; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADCFC43394;
	Wed,  7 Feb 2024 04:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707281207;
	bh=5Kg8lgp5mxT7O9V3bfE//DzBIpPh4KUnERcoqQoeuEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cpsox9opuj1CuurCcKo5TEmuUy3FGfHAMC4PXtZVJV2a1QC90CaWcUCTBkYL5+8OM
	 oEi12HIBFDA7L5Wec2fYRc2djEOTNSbNdL6bCL0vsqdt1DX7sc/jCX42fz/+zRKZSa
	 lzQIDDfKOaq0nQNkFJdYS6oYyTYdRhkWA6hDiCFXK0dlMKRRTGNdsB73aL1shmPeJe
	 VXq0ftJXpjg5XFo5vWHY4stv15cj21oLeWAbWmKHf59d49AlkShXn4D+sti1/QdCOI
	 e2ezuQ44zDMfO9hxBKY5PYtSE+kIYT/y4dH1HeMrcIiBhNmanBrkV/xCjZswHPmxf5
	 BX68U+MRj004w==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: (subset) [PATCH v4 00/10] clk: qcom: Add TCSR, GPU, CAM and DISP clock controllers for X1E80100
Date: Tue,  6 Feb 2024 22:46:11 -0600
Message-ID: <170728117667.479358.14520068525261672033.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202-x1e80100-clock-controllers-v4-0-7fb08c861c7c@linaro.org>
References: <20240202-x1e80100-clock-controllers-v4-0-7fb08c861c7c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 02 Feb 2024 20:34:35 +0200, Abel Vesa wrote:
> This patchset adds all the missing clock controllers for Qualcomm X1E80100
> platform. Another important change is the dropping of the dedicated
> schema of the SM8650 DISP CC as a preparatory work for documenting the
> DISP CC compatible for X1E801800.
> 
> 

Applied, thanks!

[06/10] clk: qcom: clk-alpha-pll: Add support for zonda ole pll configure
        commit: c32f4f4ae1c6035b44bb4ca7a41fa4fd51244597
[07/10] clk: qcom: Add dispcc clock driver for x1e80100
        commit: ee3f0739035f5a73695ce2e62866585e6f762d0d
[08/10] clk: qcom: Add GPU clock driver for x1e80100
        commit: acddef6e17441b537225717a6701a9aadf170e51
[09/10] clk: qcom: Add TCSR clock driver for x1e80100
        commit: 06aff116199c1b7e57e1c796fa0a8bebeac8beea
[10/10] clk: qcom: Add camcc clock driver for x1e80100
        commit: 76126a5129b57a705a621c2711eed149c5be5873

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

