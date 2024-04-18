Return-Path: <linux-kernel+bounces-150058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05018A99CD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F092C1C2148D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644C616078F;
	Thu, 18 Apr 2024 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="pSjHd+Nw";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="GM09GUoL"
Received: from e3i51.smtp2go.com (e3i51.smtp2go.com [158.120.84.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F5D15FCE1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713443373; cv=none; b=CUwcVp/d5U7zJrct6zKoeQ9I1wIfVtqH3GD18uIpazY9GIhlOsjXPcQbDsVIn27tGSVcz+/jGZMIKf92UK2dkwhNZtlKBizaND+3v1xVLp9mstCLIhcJ0kGql1IDmsT2/LOZ2xnviomU6q9PWBAjMEc6+//WK/O97VZzKH0ou14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713443373; c=relaxed/simple;
	bh=NL31cErW6LI9swDiDlefCuluc3s0/yO0eHrCdufFRzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fr8Fb93rEX8VQmme/vtWRexPToicwc5tL+PWwH+b3nDn3izhI4pr2WmDtPY7YtGMq291dFv9Bl9wS0BAT+gCUOQs3GPAh5pBl0CUfE3LTU54BZuVu6ph/4TVhVQ8VJlgRtnYZRszIQUvB14i6DKha8pRgfRQpCNwq0vxGFo+rk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=pSjHd+Nw; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=GM09GUoL; arc=none smtp.client-ip=158.120.84.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
Received: from [10.86.249.198] (helo=asas054.asem.intra)
	by smtpcorp.com with esmtpa (Exim 4.96.1-S2G)
	(envelope-from <f.suligoi@asem.it>)
	id 1rxQtJ-wSFvR6-13;
	Thu, 18 Apr 2024 12:29:25 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
	 Thu, 18 Apr 2024 14:29:23 +0200
From: Flavio Suligoi <f.suligoi@asem.it>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Flavio Suligoi <f.suligoi@asem.it>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 1/5] arm64: dts: freescale: imx8mp-beacon: remove tx-sched-sp property
Date: Thu, 18 Apr 2024 14:28:55 +0200
Message-Id: <20240418122859.2079099-2-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418122859.2079099-1-f.suligoi@asem.it>
References: <20240418122859.2079099-1-f.suligoi@asem.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 18 Apr 2024 12:29:23.0610 (UTC) FILETIME=[0B8D27A0:01DA918C]
X-smtpcorp-track: 1rxQtJwSFvR613.mcmhue4LmqptH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpcorp.com;
 i=@smtpcorp.com; q=dns/txt; s=a1-4; t=1713443366; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe;
 bh=beW9HQTGOr0BFT9gN6HwTnSdPZIL/FVSpOfiqm6uGb4=;
 b=pSjHd+NwE1xnitd06jVgQ86QmQFHxt4h90nmtpn6OvXMbSh4wFoVwIh2wHPXRYkk6hNAi
 kg1xRrsggyQDKsVlkFZpo/mnz7l7BuxKOAIlfa9Qpq0T1dLTYZK8dx+Jkc6kJR47IJnKghB
 MjIwiYutbCSY1WT1k/FfHQWgRhSAVewsIDf3gAL+EGVm0vabEOwu2ggcrrmADWcrFfK5Bwe
 VyFwR/oYKnbTkhPlEIwLlaRaqsvWjiZ4U97X1O+eyoI6OFE1kJ4GcjnbIh3WNO/jBkgX6Eg
 GJLvv+0oLqBSGvyTnkahLmalsOaUbn9fAiwItPymM3+CGF8HfDYgGkFwwqGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1713443366; h=from : subject : to
 : message-id : date; bh=beW9HQTGOr0BFT9gN6HwTnSdPZIL/FVSpOfiqm6uGb4=;
 b=GM09GUoL4qLeuORWqeUJI1oGCOTgKSTpad1SmVhZgT6kuO4AiDAhld/hLGIU+B2P8LP2h
 Oww5l6hj7RNP/Dycc6YesUl2RoduqsaHAGitDWmcSM3gcTVXGK0eMvXWYpmG+4YI5zCcNTF
 n4Vph6U301VtWVC8BPxGjKo39fMyjAp5/W0SXChuNalUhC28RQTuxJQxBdIM95HdH9ZVn1b
 YtyA/bUmAZcACAqPlQ1HdZoH1UijpPlG3GKvMTAxgcDeswyNUVQAGM8rzMew6FcSkECCAmY
 c2AIlVsY4+T0CkSkShs4nnpUQH27Oe7r6afa4ZdaD27gbxQTpy9p3AgPkGYA==

Strict priority for the tx scheduler is by default in Linux driver, so the
tx-sched-sp property was removed in commit aed6864035b1 ("net: stmmac:
platform: Delete a redundant condition branch").

So we can safely remove this property from this device-tree.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
index 8be251b69378..34339dc4a635 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
@@ -106,7 +106,6 @@ queue4 {
 
 	mtl_tx_setup: tx-queues-config {
 		snps,tx-queues-to-use = <5>;
-		snps,tx-sched-sp;
 
 		queue0 {
 			snps,dcb-algorithm;
-- 
2.34.1


