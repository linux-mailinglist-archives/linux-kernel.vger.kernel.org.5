Return-Path: <linux-kernel+bounces-39320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 910FA83CEBB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4736E1F21127
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2265813AA47;
	Thu, 25 Jan 2024 21:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="TWYSqYbZ"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E972D2E3F0;
	Thu, 25 Jan 2024 21:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706218541; cv=none; b=ZrZ3fctHKoI5H+Douyua/lrfDFFFW7HucWn92SJ7Zg9/wKyThwkZKj8Gf3ibxSbsU56loWwZMk+E+n5V5YHf5TsHKVJ84ClC6sYgS9op8d5Ed77s5I0yCOntq7se+ncVl1p1RoEsfQmcex7TZc0p8V+iRgxQZvIBkP4f5MpKwzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706218541; c=relaxed/simple;
	bh=xwzEERa0LpwpmWrHFrbQSTMiruu5gYdBu0gwfhRk3Tk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QN6llk4RN82yhwfPcs+phdaJPwCYYMYEfmHmhZzyFR+8UXbhHVjzcU7wxVc2EwY3G0g2lqnpTVQjGJaeHkw4SbqmS522LM1uWZ83bcGSLUXUmv6muGtZIjuJmosR9oL2oj3hQbmKzJ/7FHt1hqrnTzd7RXXUocvmW8wB8ICmiBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=TWYSqYbZ; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1706218538; bh=xwzEERa0LpwpmWrHFrbQSTMiruu5gYdBu0gwfhRk3Tk=;
	h=From:Subject:Date:To:Cc;
	b=TWYSqYbZFRwJ6P8aghvGgILoRNGV+cSwdvJ4aHtK2VN5D7S1g2bXp3zNVX5qsPRE4
	 lDXoPyKfAIyaP+Hye7Lb++seXoDctbqUQ7i/mDeaDsLyE4NiYOo3AFuIba7M+larZA
	 LqQeW9Kcp869pMUS9TkmXoM4wYvUpMSnkAMPFMSA=
From: Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH v2 0/3] Add MDSS_BCR reset (+some more) for MSM8953
Date: Thu, 25 Jan 2024 22:35:11 +0100
Message-Id: <20240125-msm8953-mdss-reset-v2-0-fd7824559426@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA/UsmUC/32NSQ6DMBAEv4LmHEdeAjE55R8RB5ZxmAMGeRzEI
 v4ehwfk1KqWunoHxkDI8Mh2CDgT0+gT6EsGbV/7NwrqEoOW+iaVNmLgwZZ5yo5ZBGSMorBG2lo
 a51wOaTgFdLSc0leVuCeOY1jPj1n92r+6WQkpmsa2RWdatOX9uRkfP9dl3aA6juMLMVVYXrQAA
 AA=
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>, Vladimir Lypak <vladimir.lypak@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=984; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=xwzEERa0LpwpmWrHFrbQSTMiruu5gYdBu0gwfhRk3Tk=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlstQRRgkgxR37FOWDpRI4/p3qwRPTcdJSzFeGL
 djUqn0iJACJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZbLUEQAKCRBy2EO4nU3X
 VlSLD/0R3hX3GkXozWm73rdc8aYJQFbjaxGI7InWkngcvWJ9t/7f2c4rMEuQl/Oxtd/yzkHXBxU
 ZlmZMUoMRr6dBlsSwndzq2lh6U/A0tnb9rRIHUR+RvbgNZC2gTaaTN9Zb6xvl+zDD5NkhhBluzW
 dkoGKhI6RNrcAhw8Mc2Y3vkhtFLbB+T0jBSgbrxIkYGnxr3mjRpwoRI2OQqnrhnERXzcUTDp3b4
 6xZcztKg6l5Z98EdI0vKgbpYE5MdsBXoWJyCzkpdVP3pcfWOh3vBU+0+UuW2aPV+19kh5TTFGV7
 D8JMjoTWQN9DtBl5mcFZ7iaVYcYNEE1LHpPMPbyFwfQomljc5L5wgPBB4hh1ioRaHbfwBmZboKR
 Qq7Z7EcYKljGSfkZ3kgmqK3y+F2a3o6vUFVo2Jrt9Nq3VPmy+WljAp1/N4fKZiwsQ1RcB3i6RZm
 tORWDztQlsdqZzLyqOjC5ZyqdVRDbc+4k1MBEhaXIkI6XoeFWU63QS0P1nwwmXqbly7a5KcTL2w
 nVFsVKZMMushu6P/rRpNnx2QBPQYiQK2jDVIPkgoOcMttTDuLGVNxo5EWHg4kcSnNcgxQ2Sxewb
 QGCRqR6zpdcetaabKkoKEic/4ZJfuv+LXwAVupOozvfhr6Ded8G8tPUCFQy9ML2LmxC6Bm86XNh
 XMAGofh533qR/Sg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add the MDSS_BCR reset that is found in the GCC of MSM8953 so we can
make sure the MDSS gets properly reset before Linux starts using it.

Also add some others that have been found in the LK sources.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
- Add more resets from LK sources
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20240123-msm8953-mdss-reset-v1-0-bb8c6d3ce897@z3ntu.xyz

---
Vladimir Lypak (3):
      dt-bindings: clock: gcc-msm8953: add more resets
      clk: qcom: gcc-msm8953: add more resets
      arm64: dts: qcom: msm8953: add reset for display subsystem

 arch/arm64/boot/dts/qcom/msm8953.dtsi        | 2 ++
 drivers/clk/qcom/gcc-msm8953.c               | 4 ++++
 include/dt-bindings/clock/qcom,gcc-msm8953.h | 4 ++++
 3 files changed, 10 insertions(+)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240123-msm8953-mdss-reset-68308a03fff5

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>


