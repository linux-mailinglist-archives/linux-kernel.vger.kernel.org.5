Return-Path: <linux-kernel+bounces-135872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E11D389CC76
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5921F251F9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D049146589;
	Mon,  8 Apr 2024 19:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="m4J8Ei+2"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E7B14387F;
	Mon,  8 Apr 2024 19:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712604743; cv=none; b=ENjuruHk9sjKnzkEB97NRO+h7BQwEh9iTlaSe9RR7hym6ouTIMaAoR/UUxsMg0YtodBWwHa4WjmULyvaW71wk3YdxFYUkPEul0KGYUmSp+51FjNIB9+qY4JvLVH4DhX58WqtP5Ym3uGu27pYZzcqpK7ME9mZsB+O1DrK96fV/ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712604743; c=relaxed/simple;
	bh=zudAXqpn9mf3HFPDC+kTT1cgsGZk40aZNFOEPMKKCdQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oaT/f7yMBDh4fP6nlTqIzL0Jg32c4UTaSgqABZhlv8IdsUFxogkKzOs00xsfy3pnonaP7UabBkcWryEMWYvHWy6SCMu7f5jSeoOmlhK3K1LEDL1BWASKQ8s0iHvHQc1CDx8O058IhcUrtrM4p7eglTSs8ixs7luBzgIdZ5QUSqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=m4J8Ei+2; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1712604739; bh=zudAXqpn9mf3HFPDC+kTT1cgsGZk40aZNFOEPMKKCdQ=;
	h=From:Subject:Date:To:Cc;
	b=m4J8Ei+2+YMhlAzpnX3J616asokoPkpL7aBW6ieKHhjSLpFtokP3SR6nSwO6qD1MI
	 HrpTU6uraXs87OzuxZTVq9syQX06ffYGRIcjrXOkMR98ljYg5i3wZpAwsbo05fjj84
	 ZFRnRz92DhDV1dMMiRvxPCMRLUP3Du3RjnMzNxGw=
From: Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/2] Fix msm8974 apcs syscon compatible
Date: Mon, 08 Apr 2024 21:32:02 +0200
Message-Id: <20240408-msm8974-apcs-v1-0-90cb7368836e@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADJGFGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDEwML3dziXAtLcxPdxILkYt0kc3Mz0zSzpMQkS0sloJaCotS0zAqwcdG
 xtbUA/bOByF4AAAA=
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=668; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=zudAXqpn9mf3HFPDC+kTT1cgsGZk40aZNFOEPMKKCdQ=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmFEY5QnYa4UqJ3YQ50ncYaHeLlY7gISmJKDML+
 HxP5t4P97WJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZhRGOQAKCRBy2EO4nU3X
 VjGSEAC02drA53tQrn15NIkINyAsUiqu0R1lDucjuNd6OXkwSM8+DNRZR0kh6Cvu4vKpfBpM8F9
 6De0HGyqRYIV2beakDYuVkIvh5PJxJIM0mfrdECDsYb2oIVtbNgbMfllLJOWM0i7keP6JYeyZya
 JBq3qDjb4DHu1Bj1YWqVrgVgbGRQSoH08F79PXW3Db9IZcmWoN87zv2dX2uQ+k5RBVELvWSZaBn
 oCwtBZ+J06ifvTixxDFuk118PgXuz7E9/076UqQl9r8K9CkseUJl83rnw5ThM0Prfp/M5N+2R+m
 98CUl5Uhcvv9VkueBpMvPp7YgLWOCBn/+E4PzPKuBReVY/X5kvFuaLqSf3NIA0BlE6qbJyCiX5D
 X2r02xFjvfNxbw00qVZ8c2+uKWrLgRs4PJtHniNzjhEeOVFfdrlEJ92+EzClO0rIQuRG06n9/Dd
 AU/7oK25DQqepqC/mmdGHGIrT4UGXUVqxAZTyehFfkRVH3Iix7GYHQznxLVB0p/EvLBVweFL10I
 bTWfWda1bbE4Kui9RTkCV1TSTyLP5yUterrNPvqsfBSbeI8h3WDm+kc6URm8wb33R71MHUUNctw
 jBtYJ/nMl8XEieSE9mWgz7c4Z9X/OSZSJBs5alIdI4Na31gqmqAm558g3Rq/TlYsmFdhLIk7Xu+
 p0Bp1JlWWHth+Ig==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Finally fix a warning about the apcs-global syscon used on msm8974 that
has been around forever.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Luca Weiss (2):
      dt-bindings: mailbox: qcom: Add MSM8974 APCS compatible
      ARM: dts: qcom: msm8974: Use proper compatible for APCS syscon

 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml          | 1 +
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi                            | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)
---
base-commit: 8568bb2ccc278f344e6ac44af6ed010a90aa88dc
change-id: 20240408-msm8974-apcs-b7765f6bab99

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>


