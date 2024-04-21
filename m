Return-Path: <linux-kernel+bounces-152632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 082AA8AC1C5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C44F1F21079
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6AC50281;
	Sun, 21 Apr 2024 22:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8JAMcn7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DDF5025E;
	Sun, 21 Apr 2024 22:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713738584; cv=none; b=CKkC4cfXqTNNOmSCSVYgJOMhqL5JqkWkLNdbzsgrJC72f5kQMOJ1QQApKd14sdkgRi+RyHc6JNqTvTqQ+fU7e5fjEBHxdtXW4Sa+eBx+83rN9UnDerOdYBww4dHa5iPxU+Nob9m21oUHRW1wDFFrlpuze7JwIJKbfSpI5qfFsfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713738584; c=relaxed/simple;
	bh=pAMG5KWKT7pt63O48mYKDd15e3VnQ/Lf8St05kDp1TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rtW8ab+lwidp/U27x8DB1BKQlrsJAaQY34OIWF5dRoXTBekBKj3zAzj+eW6UMZmT0xrz39RrGMSoDtwu5syopO5EGlGLrloIqF2xHLPrdro16YjhTNZZgV8M2/Iz2vwy2yuRVmL8WZ5rqhEfzuvu34mzSKmZyL4lFqLxW6jcA4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8JAMcn7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0313C32782;
	Sun, 21 Apr 2024 22:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713738583;
	bh=pAMG5KWKT7pt63O48mYKDd15e3VnQ/Lf8St05kDp1TY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i8JAMcn7seJdgleCJhiekoejDhAOqEPqyXOk1N2payJSQm6DtGzsVEJ6nnmllv+Z/
	 BiGywAKfeRchCapQ1foS8grMUVC9QFPnFTK1yDdVwlk9+vT7SrF0fAg0aotGYvpOQi
	 pPKMt6SOADLfYRF2Kvi5BelVTjeNHsqKyz3lpp1YyJgwzB9Oh+ySzC33xT6MsV8OCq
	 AJH0JzI8hf4P7DrEZ9LmFlkxtrT6XTFOxpmeQwUQ9pjOWu7a2MO63BtzgI9xW9x4hR
	 zkWY6bO2SxmbSwlIGs/VsWUjKJIPWiOkPwuEYn/zizHdb6yBEHlepyB2kpfNLErFdf
	 avoMLjQtTBuKw==
From: Bjorn Andersson <andersson@kernel.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	Krishna Manikandan <quic_mkrishn@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/3] DisplayPort support for SM6350/SM7225
Date: Sun, 21 Apr 2024 17:29:17 -0500
Message-ID: <171373856758.1196479.7387802929964223775.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329-sm6350-dp-v2-0-e46dceb32ef5@fairphone.com>
References: <20240329-sm6350-dp-v2-0-e46dceb32ef5@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 29 Mar 2024 08:45:53 +0100, Luca Weiss wrote:
> Add the required changes to support DisplayPort (normally(?) available
> via the USB-C connector) on the SM6350/SM7225 SoC.
> 
> This has been tested on a Fairphone 4 smartphone with additional changes
> not included in this series (mostly just wiring up TCPM and the SBU
> mux).
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: sm6350: Add DisplayPort controller
      commit: 62f87a3cac4e70fa916914a359d3f045a5ad8b9b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

