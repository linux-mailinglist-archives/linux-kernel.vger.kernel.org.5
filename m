Return-Path: <linux-kernel+bounces-157333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6228B0FF2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813DF1C24181
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F398616D4EB;
	Wed, 24 Apr 2024 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="N1tPo0oD"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCFF1635D1;
	Wed, 24 Apr 2024 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976465; cv=none; b=Q6UQgf/mTunVfYI9/wHCksV2NCeXD+GAKw6N3Uu8DdHp1tGE+/HjdD4OfJr3f/Nllj2lsPORi0PMWHeLzwldiJV/5RQu6rocOzQMlqWcld5OvX+B3h2pIBvF9jJy8CjHktx6ea4xSLP/EtZrt5YWFK4CQuvV94PS8g2v7M3ejK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976465; c=relaxed/simple;
	bh=CE/vE82s42dTzKYS5OV7+jlr832co3EMcLKt1GJy/LU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fSABXSrnkijHINfY9KGf9Z6KNfUYTCHr7SEYkcmZkfBTBL/xtSIf55oue33F26RsxsNMT7PC6F+QCJVdZa7iDlUz+AntIC1iYFSwHwkxEFKlt2HDgQVgHtxs58hwP6zlk731pniA+g0m3VlMKMksHfzJeZqsbRG3dCoG7INhFdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=N1tPo0oD; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1713975863; bh=CE/vE82s42dTzKYS5OV7+jlr832co3EMcLKt1GJy/LU=;
	h=From:Subject:Date:To:Cc;
	b=N1tPo0oDHNUJKrHdwC3afgjMS88y0jAwKcFTOXSclWWzqY2sg0RmeffascYRwiR4L
	 VZrhZrjPVDaUh+2fW/NDrSD3TcYd1oxY6MGqygxDjeYDK3ak+h8MOu3s8U8Bt2XhaT
	 GmFld39DxQ11NNuLV8QqdC71JKLHx+xHHhl8hd+Y=
From: Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/7] Use mboxes instead of syscon for APCS (arm32 & arm64)
Date: Wed, 24 Apr 2024 18:23:53 +0200
Message-Id: <20240424-apcs-mboxes-v1-0-6556c47cb501@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABkyKWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDEyNj3cSC5GLd3KT8itRiXUOj1FSzZAPDRNMkYyWgjoKi1LTMCrBp0bG
 1tQDmXRhhXQAAAA==
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1765; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=CE/vE82s42dTzKYS5OV7+jlr832co3EMcLKt1GJy/LU=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmKTIlZXfpVu3W4tlAjddI/JmsM2Ii7RShTsP4V
 si674OdD3eJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZikyJQAKCRBy2EO4nU3X
 VlPSD/4pG1g+DbW+6eg7lH+c1hYJ0hjd48VZ7jE9MqEPZW5tAJPgA+09VMzSPV8lA2OBnOz/7El
 crbRLL7aOHiMN1+6bsDsyJ8d6m5Qq+3npbCDQWd14MgtS8/D3jIMkR4B4yLyrpBEuHslP+TVb6/
 rjMppyGPF9XYHZMy6dmMmSnbB9RybPLtVzeKv4z0JTQnpbgPsheIPByQFrrkG48pDPipDsAwLQV
 9zXJERAYQS4blrmN54pr8c0TuAmVm3pz163N0zgcI3xC5Dfp+czF42yyK8zDyyIwkOnlpHBCbGn
 woR/cm59KVKBt/mDhKR8OiPc0twpjA3J92SehY5H8de4XiMZc37k9tajRqx+x6I21NiRw+rTDyc
 NqemIlc4jMmETsDObaHop2VaTkBJspfxeLhQTq+mISLtC4gULg0Q5E33ZEFaetTAYsAwrkpcw1I
 vYPDtf1jiKV+dzSAkqDuxaszpK2CNL3wC5D9wx7/80dOkuxmDe6nbEeA+ND2cs+oVqsfnqBqRVp
 l7nZAqCYj2rv/TsAYPrsiLnksg5AIlAiPzdL9HTujUH2HAE1pkf1qghRUdBRt5lIs4SFlffErSa
 32U04n/F+XOnNVuzlUa+b9TdtUvg1ZxfMpm+1msVyzB2wjZ+gtNDnsJm4iZDrQzGvxk2K2k1M0/
 UkfmtRmlNNXRBcg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

The first patch is for removing a bogus error warning I've noticed while
developing this on msm8226 - there the patches are also coming later for
this SoC since apcs is getting hooked up to cpufreq there also.

Apart from usages from the qcom,smsm driver (patches coming!) all other
usages of the apcs mailbox now go via the mailbox driver - where one is
used, so some arm32 boards will continue using "qcom,ipc*" properties in
the short or long term.

Only compile-tested apart from msm8953 (tested on sdm632-fairphone-fp3)
and msm8974 (tested on msm8974pro-fairphone-fp2), but I don't expect any
complications with this.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Luca Weiss (7):
      rpmsg: qcom_smd: Don't print error during probe deferral
      ARM: dts: qcom: msm8974: Use mboxes properties for APCS
      arm64: dts: qcom: msm8916: Use mboxes properties for APCS
      arm64: dts: qcom: msm8939: Use mboxes properties for APCS
      arm64: dts: qcom: msm8953: Use mboxes properties for APCS
      arm64: dts: qcom: msm8976: Use mboxes properties for APCS
      arm64: dts: qcom: msm8994: Use mboxes properties for APCS

 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 14 +++++++-------
 arch/arm64/boot/dts/qcom/msm8916.dtsi    | 10 +++++-----
 arch/arm64/boot/dts/qcom/msm8939.dtsi    |  4 ++--
 arch/arm64/boot/dts/qcom/msm8953.dtsi    | 10 +++++-----
 arch/arm64/boot/dts/qcom/msm8976.dtsi    |  8 ++++----
 arch/arm64/boot/dts/qcom/msm8994.dtsi    |  6 +++---
 drivers/rpmsg/qcom_smd.c                 |  3 ++-
 7 files changed, 28 insertions(+), 27 deletions(-)
---
base-commit: 43173e6dbaa227f3107310d4df4a3bacd5e0df33
change-id: 20240423-apcs-mboxes-12ee6c01a5b3

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>


