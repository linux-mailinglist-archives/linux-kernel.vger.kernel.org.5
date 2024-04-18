Return-Path: <linux-kernel+bounces-150059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1B48A99D3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD975B2209A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78AD161311;
	Thu, 18 Apr 2024 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="1/vZx6XE";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="CXp0RPkO"
Received: from e3i51.smtp2go.com (e3i51.smtp2go.com [158.120.84.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874891607B0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713443377; cv=none; b=OwU/vrJ6SPYR44kK/LSDR7S5nlJom73n6uywusYn9lYfRsJye5FRrwtzaToFBZrl2tIZWEX1PrbtaFmU7v7J0t3anN4JTUF1lhw44hmiBu75HdFep/iS04tHgX/ZJHip6L1q8CWa3ZKEpG72bBg2U9UIxBVjhof+g+XV23IZ5hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713443377; c=relaxed/simple;
	bh=7YaaphZZMBLHKh0x7dUPDPqq2nvh8VeZ8PMGp6jM9vA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MvoMB4lWD7ACL9wMRog2KQqagEXtFWmwirzdKwMMIQJ/dkHWmP9xulKNg0EnYLZem/aWOap11OvGGn3gAqxhJnAncrJo5/cRPAYALMv8sNlv+42lihbkQO6BBUDipk9JUNUSz7RYg4l4pSODqB9dKCZ0hfKmHf37/t7N/B3Kis0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=1/vZx6XE; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=CXp0RPkO; arc=none smtp.client-ip=158.120.84.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
Received: from [10.86.249.198] (helo=asas054.asem.intra)
	by smtpcorp.com with esmtpa (Exim 4.96.1-S2G)
	(envelope-from <f.suligoi@asem.it>)
	id 1rxQtK-wSFvR6-1O;
	Thu, 18 Apr 2024 12:29:26 +0000
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
Subject: [PATCH v2 3/5] arm64: dts: freescale: imx8mp-verdin: remove tx-sched-sp property
Date: Thu, 18 Apr 2024 14:28:57 +0200
Message-Id: <20240418122859.2079099-4-f.suligoi@asem.it>
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
X-OriginalArrivalTime: 18 Apr 2024 12:29:23.0767 (UTC) FILETIME=[0BA51C70:01DA918C]
X-smtpcorp-track: 1rxQtKwSFvR61O.mcmiue4mAFr26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpcorp.com;
 i=@smtpcorp.com; q=dns/txt; s=a1-4; t=1713443368; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe;
 bh=xB6lptXkbDQjGZizWOcUacyiIPjTOrnbOEU8DAe0Dnc=;
 b=1/vZx6XEtcpSjyFmNohs2aSpKz0Md3DVb94rzNx35BbCsE4rM0q40ugbtRrPN+t4EWurW
 TBkYAZ107QDVVxVjfq/G39ljz3CMuKPQtY9WPFMlc34jZgrxCCke3Vkc1b501klZp749LGZ
 pO7Y3Q419CLrCfy4hq8YTUcF1B2WX6T9treiFGiqSWnt1R84V+2q5M6DgXye2VwgJ0KbeSZ
 +28ZyqZM57XcADNVBsfe/hN3nZGTRqlR/dl1Cu64uEGkS1d7/D2Wxy0/yWMpnyJA4ULysKd
 5y2CBUl389itHQSCIH28Yx+YTY7uXi+4PaY9wcS0+/Cby+gsL8zLuTvSUT6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1713443368; h=from : subject : to
 : message-id : date; bh=xB6lptXkbDQjGZizWOcUacyiIPjTOrnbOEU8DAe0Dnc=;
 b=CXp0RPkO/tupCCZs2L5g9FWimVcXBjaMaXgnZk/QsscnjqUATZr415ZNZTuha4JK5YBAB
 ouqoebG4PR2HL2Ck4Eysj25z18KnqkRPuQFkZ2ZvBaDHExdSI+iP5X5F4P/rGuo653AlnxU
 mq0+jOFWIdWMHlLSSwLTG3ApcVoY0cMDOYUiTMVGr/PHV4WGVnxWAUMAOyNuE34MxJi0S4R
 /zPWqKTT+6tHGK5Hgwp6xOCbWIzX/CCsK+qeOvayl4aN4mgz3CYlW2uXyLGbTeq9Y6IVx/5
 1ElwlFQt853Xspn4X7GKDPF6M0fBHafO/FWBkAdYDBsnNgidEeMqNocELEtQ==

Strict priority for the tx scheduler is by default in Linux driver, so the
tx-sched-sp property was removed in commit aed6864035b1 ("net: stmmac:
platform: Delete a redundant condition branch").

So we can safely remove this property from this device-tree.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index faa17cbbe2fd..21d4b6a9a1af 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -260,7 +260,6 @@ queue4 {
 
 	mtl_tx_setup: tx-queues-config {
 		snps,tx-queues-to-use = <5>;
-		snps,tx-sched-sp;
 
 		queue0 {
 			snps,dcb-algorithm;
-- 
2.34.1


