Return-Path: <linux-kernel+bounces-133243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A64A89A11D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5B01C235D4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A45E171066;
	Fri,  5 Apr 2024 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="EofkeaEr";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="Vq8lE3CX"
Received: from e3i57.smtp2go.com (e3i57.smtp2go.com [158.120.84.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C950B171063
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330960; cv=none; b=kdxsYOJr3iTA6ncxWnaMOo+yVtv51y77gNzsjy9yYEHjJjZzTbx5G4tRCIi+PaOskpTfYpn3gZwr4Py2rjIGFTVc+4ddvdlwvsRM0hxAvw9e0XveAH89HqCoUat0E/7+OKIe//1nSSILzjQv/GzdLWHqoGwibZoSV3S43/PGZcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330960; c=relaxed/simple;
	bh=/85FrgtiGyeXI3NXKIEzWRrmclnbRTUZJ58KJVorq4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F/025M2rNV54MXECJnbWZLKkJcuF4lvUYwWRYuNVZb4bV6H+zOSlMSWAGTC4Pq8vynAczTliKsnUuBwPrXYJ9d/+x1T6QxY4JVlEhapV1RmSo9lM9f9IJjX8Yfx8oVFvYexHbiBJnwTdZHtHS8ik3Vxbq3LFPvxMZq2R3IqieQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=EofkeaEr; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=Vq8lE3CX; arc=none smtp.client-ip=158.120.84.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
Received: from [10.86.249.198] (helo=asas054.asem.intra)
	by smtpcorp.com with esmtpa (Exim 4.96.1-S2G)
	(envelope-from <f.suligoi@asem.it>)
	id 1rslV2-04gIYl-0v;
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
Subject: [PATCH 3/6] arm64: dts: imx8mp-evk: remove tx-sched-sp property
Date: Fri,  5 Apr 2024 17:27:57 +0200
Message-Id: <20240405152800.638461-4-f.suligoi@asem.it>
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
X-OriginalArrivalTime: 05 Apr 2024 15:29:01.0558 (UTC) FILETIME=[FC56C160:01DA876D]
X-smtpcorp-track: 1rs_V204gmY_0v.EuMEjfTIqu-Os
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpcorp.com;
 i=@smtpcorp.com; q=dns/txt; s=a1-4; t=1712330945; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe;
 bh=oi48LbG1I/VP5W3WKG7O4Eeo5cePw11MKZR9VfWSCRk=;
 b=EofkeaErPz/Q9ScdoQuAOQZDXVWE0Ys1XN8HGOW7WTlpHsmjp9meRx+P1WE/+sIpxDnK+
 WOGZ3OW5JJy0dcnW2BzfHDUHVkSWuF9I/BrUf05ZPMfLAqSfdP+LcirloBNkXPDJvTC/ict
 b6zwfnhUJVO2kpu8Whml4fg7lhfDQxjHIrTY1djmfqtiYHe8Y0gdRjy88rQYgwD8Fx12BGf
 7cdoaRLBJWNuyOJDBekzjRExKUdJz3fYa3vw7igPrKzuRBdsWay2FG7dkQCr0E1NVNcmJVY
 0Dcgdqt9ZQ4l18+VwwD4nAcF6Dof3mLUwD4bvOSLdi6kE4HN25dajMHucvXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1712330946; h=from : subject : to
 : message-id : date; bh=oi48LbG1I/VP5W3WKG7O4Eeo5cePw11MKZR9VfWSCRk=;
 b=Vq8lE3CXNAJHILzS7R7uSVk28Eu0RoapB0x2JhpwzQk7tQw0wjEqllK25XuLyEktb6qy0
 gRi3sQHZ5GDCc22+OHTOO0HXrUo55R9Yo3YiouKd0JNytTutItubxQTMCvJYottF+hyns5M
 ubhW4mppD4BA3wYllDg2wxNn/mazWUi1OxuDpYY4wTqN4XXnuoKm7TFdQxQoaT1qSX5bFaQ
 qdaNYE1ABEpWJ4nZg9DrDehpBbiwNcmiq/23suqyhnU3DjQeFyqtvJhQFj6t0bxqUM5N1Ff
 HBEWbRWy6/BkfpwqrENs6AD6AszRRY1UHo4NrL5NVEUngv/qYJCYgLHFn19g==

The property "tx-sched-sp" no longer exists, as it was removed from the
file:

drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c

by the commit:

commit aed6864035b1 ("net: stmmac: platform: Delete a redundant condition
branch")

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 8be5b2a57f27..bb1003363e3e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -251,7 +251,6 @@ ethphy0: ethernet-phy@1 {
 
 	mtl_tx_setup: tx-queues-config {
 		snps,tx-queues-to-use = <5>;
-		snps,tx-sched-sp;
 
 		queue0 {
 			snps,dcb-algorithm;
-- 
2.34.1


