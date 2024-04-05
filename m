Return-Path: <linux-kernel+bounces-133250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A43989A139
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56052287D29
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B29172BAB;
	Fri,  5 Apr 2024 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="1HfKyv/k";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="eQhHp9uZ"
Received: from e3i57.smtp2go.com (e3i57.smtp2go.com [158.120.84.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8A517278C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330983; cv=none; b=QnduQw8ZM0mSWVBCZB4HLosLvYN8IX8Zy5URoGn3iLHEMq2T5IvRjuOqFx702qOi41/gA6pNBk7X9k2yjpAr8oOCQ6pn+DhOv5S3BKnlt9zE8xoBkPkbQkCopkrQdwrWZghFLN9h1dxAdPtuMVwa+i8l2fxsTW3DQQY7efSG47Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330983; c=relaxed/simple;
	bh=0pYDM4UNhKfS+fr+khXSp9jVPuhVAFWiMJpP1HoiGpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ah1Ao7q7O2PO61x6podO4OJpLUXw/7+0N53dAeqg0Z9PRv+VlpBmkK8WOAypAj+aHrMhMBQHqbauO6LQmbO4APaLfhSruqSGJ5ntMz7ZpMBM+QPtJ0OplB/SIO/hIuFz1deb/0Ft+vK++EkA/5BO/Kkt/BTSDdhzXoamApzIURQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=1HfKyv/k; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=eQhHp9uZ; arc=none smtp.client-ip=158.120.84.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
Received: from [10.86.249.198] (helo=asas054.asem.intra)
	by smtpcorp.com with esmtpa (Exim 4.96.1-S2G)
	(envelope-from <f.suligoi@asem.it>)
	id 1rslV4-04gIYl-08;
	Fri, 05 Apr 2024 15:29:06 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
	 Fri, 5 Apr 2024 17:29:01 +0200
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
	Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH 6/6] dts: qcom: sa8775p-ride: remove tx-sched-sp property
Date: Fri,  5 Apr 2024 17:28:00 +0200
Message-Id: <20240405152800.638461-7-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405152800.638461-1-f.suligoi@asem.it>
References: <20240405152800.638461-1-f.suligoi@asem.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Apr 2024 15:29:01.0798 (UTC) FILETIME=[FC7B6060:01DA876D]
X-smtpcorp-track: 1rs_V404gmY_08.EuMGjfTsidY9Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpcorp.com;
 i=@smtpcorp.com; q=dns/txt; s=a1-4; t=1712330949; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe;
 bh=ZlqPPXH5bNJhEltSGKCBrMvzg4Eqwu2ZB1ba92tVMY8=;
 b=1HfKyv/kiha/S0an6NEB3vcR189SgrnbIWBIPAlhKWUx7DzV92AftJTZA0hVnSN0BN8rg
 yx2DfaKK7uY2Sv7R0/0/AcpMdKNowXT8j1NmuSEgNJVWVGhrfuhhvho2Hmywg4TD0R5DQI2
 1dRYGuR/aUiAiN8l/3lpbY0ywIoI8G+HNHq9+n8X8fYgqgJdBpK81eh3WLkvIz1lzbM1tIc
 BVwASEWDhMK8qcBFvP8EWUkRiAytLxNtIsyJlUarOsQgwxEkO9ZVoiZl81AjWlHlm4vPeez
 Lxju3WvXXBzuUyV1qm/YI6B1crchYVzFEb7f8BZFG5ZVXbkasYfYbgKQ5qUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1712330949; h=from : subject : to
 : message-id : date; bh=ZlqPPXH5bNJhEltSGKCBrMvzg4Eqwu2ZB1ba92tVMY8=;
 b=eQhHp9uZNMWfZC0wmUJS7F0A7Bmy0dfumIlLxloWDU/eXMiL1XtY/TEkfEsk8nEfgszMm
 p7ZJVAUXqY1cDzVwtlLq6KlUZ8N9iOmE0j447Z/k+G3NmkRoa6iAWzTmkO9ZEU9LO5hG7mo
 JdaJxv/wGBb2jYTV7eDu0yrLbEmaX5o2/cVo29FubzCR2ElIUHIMepOAlNe4HYN1BwczEnZ
 QUDm40WLC15SGQ0C4b0+4Q84cR8LDTwni3MypVfYoeGQ4jiqU7SSH0HojRXL2ieTfuArNLc
 mz8gKdZAWBQINgMwUwmEsarIy5yd2zaDt2Rc2cyjmqxCTXir0lwgcPNfO3qA==

The property "tx-sched-sp" no longer exists, as it was removed from the
file:

drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c

by the commit:

commit aed6864035b1 ("net: stmmac: platform: Delete a redundant condition
branch")

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index 26ad05bd3b3f..2e1770e07f45 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -334,7 +334,6 @@ queue3 {
 
 	mtl_tx_setup: tx-queues-config {
 		snps,tx-queues-to-use = <4>;
-		snps,tx-sched-sp;
 
 		queue0 {
 			snps,dcb-algorithm;
@@ -404,7 +403,6 @@ queue3 {
 
 	mtl_tx_setup1: tx-queues-config {
 		snps,tx-queues-to-use = <4>;
-		snps,tx-sched-sp;
 
 		queue0 {
 			snps,dcb-algorithm;
-- 
2.34.1


