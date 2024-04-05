Return-Path: <linux-kernel+bounces-133248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418AE89A135
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0FD528732C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E004B172766;
	Fri,  5 Apr 2024 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="jFb5whcb";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="Xs19+5Dm"
Received: from e3i57.smtp2go.com (e3i57.smtp2go.com [158.120.84.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B82F171E79
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330979; cv=none; b=pV08fCYivz8HXaIRFjXYS3B7BfD36K0CpDM0k/H3zFP5n1hiCujmvqkHQXy/cBQbzGDwa4+wFvp+nOhps0rI9kIK5+5DUfLR8XnjddSA4GICJRKM4DkOJSOpGKQJ+K2HlGPAfwlH3U9eZmm0daQPwPmkzhQq1XzQ3g6B/Z5Way0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330979; c=relaxed/simple;
	bh=fat/r3HbU9fmQ9BZUSIoNdkoDjoqNHVWvYNMh5bZGac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=srGsgy1I0jNhtWLkSawVsfyhjNRk5iuwvacMg7InUdNxNSjmlZTNNy99FNJQWhzZjxl3o6CiG0IBInZDEb5nE6D7c2DYaf+w/i/5p+8gaJkrSj9bIsC+ZucQWZXmRBcK19RlH+FTzeJ0Xvemvz0gluIyLnpYnFpFt6L44/FCcvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=jFb5whcb; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=Xs19+5Dm; arc=none smtp.client-ip=158.120.84.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
Received: from [10.86.249.198] (helo=asas054.asem.intra)
	by smtpcorp.com with esmtpa (Exim 4.96.1-S2G)
	(envelope-from <f.suligoi@asem.it>)
	id 1rslV2-04gIYl-2n;
	Fri, 05 Apr 2024 15:29:04 +0000
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
Subject: [PATCH 4/6] arm64: dts: imx8mp-verdin: remove tx-sched-sp property
Date: Fri,  5 Apr 2024 17:27:58 +0200
Message-Id: <20240405152800.638461-5-f.suligoi@asem.it>
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
X-OriginalArrivalTime: 05 Apr 2024 15:29:01.0641 (UTC) FILETIME=[FC636B90:01DA876D]
X-smtpcorp-track: 1rs_V204gmY_2n.EuMEjfTIQg3iN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpcorp.com;
 i=@smtpcorp.com; q=dns/txt; s=a1-4; t=1712330947; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe;
 bh=z6/lBWhbzIHfLCrRTM1SzzPe1OKp0Fc/uUJ7RPvyKV8=;
 b=jFb5whcbVZV6M/TMJJINBu7vYNWGIQdKzdUBTO+z8hHQBHu9PS6TLYg/Nu7/DwRskuGt5
 /UTNP6xr0n0ip2w/5gFBlnNK3jUBtrfW4JHBogvN0dl5i45Ynb0AltCJFTpPWJ1iPpYQwdP
 hJhRMzPJjlVIQFMnjOIybM7RFmtdsAZdHmdxPM+hXGY72rMF5CWtSaYqHdOxm9bhHmT4o4e
 SiOd3NQHzIPYwUGXliglcnzC7kYU2wtkSzQF+BFVLrfBHr1CjxHRKA+uI0+pRuGTqL+xzC4
 SYskHASjfK/aXXY16LGQjZ3i7Zv9l2XS5l86kvsnyx+o/6WlFku4gjleI0qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1712330947; h=from : subject : to
 : message-id : date; bh=z6/lBWhbzIHfLCrRTM1SzzPe1OKp0Fc/uUJ7RPvyKV8=;
 b=Xs19+5Dmf4Qwzcrghb9tf8KilcwcFqUup582Ecl0dIDSOXGOPk+PWYaQ/CUlw0mRo3gis
 rZnnN9rYWYGil9Bpe7ScXGiYousnEnzwRRfsp+695HeOHKj5g0k0qhYmAAzQ7e0OCy+MAmS
 XFdRSgX62NPAytMyDw2OjOuJUWopfzaev34TUdCfrqrjUVLnWWV6a1BfAjBQEcbNqA/y+60
 JWJkUlfmQTYFSC3pYsqBkVXzsxvD2pN2kWRm4GN1F6MWRWwUBdYoz7ES0NppU6XjmLzunVE
 u5nSOhRsbO1CTcPYVVIGvAF7yDw61kXS4IdPitgcP4RVIZ4IHIvgx0uXUn3A==

The property "tx-sched-sp" no longer exists, as it was removed from the
file:

drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c

by the commit:

commit aed6864035b1 ("net: stmmac: platform: Delete a redundant condition
branch")

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index f033d4310305..5b1b36a7ad38 100644
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


