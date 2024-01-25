Return-Path: <linux-kernel+bounces-39341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7676183CEF9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2955B27A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5377E13B7A5;
	Thu, 25 Jan 2024 21:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="gLTXPjoG"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AF4131E4F;
	Thu, 25 Jan 2024 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219793; cv=none; b=IJKtUxhSAQNYBnpM3mQJhvMo9YjcKge17AIZkl4pLz93nisxxIO/GRl4TH+AgOIlDYf7TsmIdbnH/9JbbK5IlPLP6S0Gkr9VFO4Rhe0xArpP8zDrxOfVvx1ZtntCAU720Ghj5KwCu1xNMZyYuG4/L+JJq7zmiJw2aKEmdXY/rAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219793; c=relaxed/simple;
	bh=b7Y6SDBxaY7d2ufdRgw40VrIGg/JPSikCPGoPt4otcU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cZknTNSD1uopJqvhqSWanTBX52zvcXqXCT7iN9RJwXoHlIuCP59+fhRxavaKnjAAZdKYZ2/74P5Dy5YmKt5OnAkdQBtzxBukMpDFTcFt4lmPRxqVXY9321n/O8uu0Hk6t4akxfM4PuwurvJJ4gW2Ly7VVdtCw1Wcl6jKBp8kjlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=gLTXPjoG; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1706219789; bh=b7Y6SDBxaY7d2ufdRgw40VrIGg/JPSikCPGoPt4otcU=;
	h=From:Subject:Date:To:Cc;
	b=gLTXPjoG2oB1f5FyD097277HHw1LhrAzecH/DRwqdnznSFUYLB/jWXlCs+9tyFxP6
	 c8KLTyK0Em76VnvEOCHMF9VPQ505ynf9hHHUIu3X5zp4tyZtVN44o5mpTWZRUIGRcc
	 SXeJY70LFYKXJRMOnsqo/KrAd87ySr6+82+zxVns=
From: Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH RFC 0/2] Add GPU support to MSM8953 SoC
Date: Thu, 25 Jan 2024 22:56:24 +0100
Message-Id: <20240125-msm8953-gpu-v1-0-f6493a5951f3@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAjZsmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDI0Mj3dziXAtLU2Pd9IJSXZNkAwtTYzPTNFNLEyWgjoKi1LTMCrBp0Up
 Bbs5KsbW1AFPUyvJiAAAA
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Vladimir Lypak <vladimir.lypak@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2377; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=b7Y6SDBxaY7d2ufdRgw40VrIGg/JPSikCPGoPt4otcU=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlstkJfc3l2laEi7sRN3lqVds6XpkA0MzjRBHOf
 nwFNvAq0lmJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZbLZCQAKCRBy2EO4nU3X
 VhAsEADDLcuQHxd9v+Kxexh0y3s9hvictSjNkBDZ5R/NiVYX6qa9VHKiAGjVfPKAyvipzhz1N5e
 pbko36jzoRLC4VFPzxVZLxidssu8v40pxBK37fqPph5SVAyNQKKelKoTl8ZKYk+P3drW1TJzc/y
 BjOg3TGhC5JIXrOUTHuwSrxb7NODZ+l+lUxc0+JC//VwbU8hCXCQAFrDRidFROPUlCwhZ+MKzEs
 cjJcnc/483dv3e8wgTHL8zgwZXKs62tmvKH68ptkw5iIZC2rwsDTjh+OU7+EjArzJwPZ84O5l54
 A5ZOLTCy6qXqKT6TdGe1f1LzTw+7DEoFcZa7aOJpWBM5LbduUvyWQIwN1AXWbwEPigNaLcj/QsX
 IQS/6RS/tkoCzoGwzQl5w5aA1EyHq+pETY/46nx71sY0tagjDG5dbyeIkzJcItPwDTTFCExptmC
 9w/q2Y1vRBUcphG8OpdRtZ94g/h2R6n+W2l+MRxmCYat0diWxN/ty4o6ttA4sctEBVf7euz1key
 Kvq+8pS6sUWIXqQTqpnDdCFfpWPaiavbbECTbXKTVk4xkZan9E9bcON4hVaS0x7tW2rBy39Rvj9
 fX0mXT1NHsZLE/hqP/TTt14vU86R6QPgTsbuzX2HlNc06dcPXDQdA4afgqP+61MXILJs/nHH9Qk
 B8q1CsiS9LtX9iA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add the GPU IOMMU and GPU nodes to the msm8953 dtsi so GPU can work.

First of all, functionally this series looks fine, tested on
sdm632-fairphone-fp3.

Secondly and the reason this is marked RFC for now is basically just dt
bindings check fail, and some questions regarding IOMMU compatible.

Basically I'm unsure what compatible (or even driver) IOMMU should use.
qcom,msm-iommu-v2 is now in the patchset which seems to be okay, and
also should handle the gfx3d_secure secure context correctly. Apart from
some special handling there qcom,msm-iommu-v1 compatible is equivalent
on the driver side.

Currently the dt bindings say qcom,msm8953-iommu should be followed by
qcom,msm-iommu-v1 which is the case for apps_iommu. But if we use
qcom,msm-iommu-v2 for gpu_iommu then we can't re-use the same
qcom,msm8953-iommu I think.

Possible solutions:
1. Switch apps_iommu to use qcom,msm-iommu-v2 in dts & bindings? Since
   there's basically no special handling for either in the driver I
   don't forsee any problems. Then we can also use -v2 for gpu_iommu no
   problem.
2. Use qcom,msm-iommu-v1 for gpu_iommu? From some testing it also seems
   to work, I guess because the secure context is never used?
3. Use arm_smmu driver for gpu_iommu? Vladimir Lypak has suggested that,
   but that would at least need some more patching to work on msm8953.
   I probably don't have the motivation to take this on myself. Also
   what benefit would it bring?

Hope I haven't rambled too long here and it's somewhat understandable.

Please let me know what you think, which direction we can take to
resolve this.

(Also GPU clock-names dt-schema check fails but that seems to be the
 case on more a5xx GPUs also)

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Vladimir Lypak (2):
      arm64: dts: qcom: msm8953: Add GPU IOMMU
      arm64: dts: qcom: msm8953: Add GPU

 arch/arm64/boot/dts/qcom/msm8953.dtsi            | 146 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts |   2 +-
 arch/arm64/boot/dts/qcom/sdm450.dtsi             |  14 +++
 arch/arm64/boot/dts/qcom/sdm632.dtsi             |   8 ++
 4 files changed, 169 insertions(+), 1 deletion(-)
---
base-commit: 0e21aa976976d5fba8cd1f8f64bcce49beb5f895
change-id: 20231212-msm8953-gpu-4c085365f594

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>


