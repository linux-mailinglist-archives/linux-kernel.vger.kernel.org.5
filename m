Return-Path: <linux-kernel+bounces-150061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4778A99D8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0F461C211B6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ECA161B43;
	Thu, 18 Apr 2024 12:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="ddRoCNt2";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="CBmjJQXx"
Received: from e3i51.smtp2go.com (e3i51.smtp2go.com [158.120.84.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED02161327
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713443380; cv=none; b=jgpzRjikMzjvHDWWFRf3cxA81P/AofSgUxmCfZZh6+VEktefC8A8P0W7rfm3vK0h6/qqMLlLzZg/AYLuL6Kb5+Cj0PXS2KbShr3Ue7X3yzCyHlPG9L7dcXAAu5RJJOMvbER8QSvLfyI2A93SeHAU624v+B+9QCQuCWTLW7vxIRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713443380; c=relaxed/simple;
	bh=derKY/X+teh30FJx4b/mrPAzhjIzp4HGT8MMH/0zktg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p9F3vFaNX3a5RSnwYI4CyiM23eZThKe0wxG5HzNJZ9ftG87NpL9ZMgE3386ueeFci1sWW4YZWk8Q6jdhGl9r9HEW0GbKt4ZMib8bupW/0EJRe6fvgtqmPSJxJ/rYn/+xXo6dgT2YfUbWoS20WzjpgKTKWQIgcmjUJ3MFa8Ewnlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=ddRoCNt2; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=CBmjJQXx; arc=none smtp.client-ip=158.120.84.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
Received: from [10.86.249.198] (helo=asas054.asem.intra)
	by smtpcorp.com with esmtpa (Exim 4.96.1-S2G)
	(envelope-from <f.suligoi@asem.it>)
	id 1rxQtK-wSFvR6-3A;
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
Subject: [PATCH v2 4/5] arm64: dts: qcom: sa8540p-ride: remove tx-sched-sp property
Date: Thu, 18 Apr 2024 14:28:58 +0200
Message-Id: <20240418122859.2079099-5-f.suligoi@asem.it>
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
X-OriginalArrivalTime: 18 Apr 2024 12:29:23.0845 (UTC) FILETIME=[0BB10350:01DA918C]
X-smtpcorp-track: 1rxQtKwSFvR63j.mcmiue4m_LLVY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpcorp.com;
 i=@smtpcorp.com; q=dns/txt; s=a1-4; t=1713443368; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe;
 bh=KyzVo69ICVJHxwsHXC+wYoJ2MHvwOdDQY4E0c7AHxy0=;
 b=ddRoCNt2FHkl4BC6f4Nv1wE/zwfkx4u5yuFH/OT7v7+3FPPTx1ONEriP10bjJ4M3GmMbs
 jYmAEiiklxOgGkIDHLPAp8BpZnNDB96yT51RZ+oA9BuA+QrkHxd1mqZiMvFSJ1uj+AQFCgR
 0kVE4RVSYGT5kH+3Xo2zR9dGG6Xx6MpWaRBZAHLZSF0eocZnc8ciL0asAMkq+Lc8n1dfsXB
 hCzgfKYmUAemK+hqfUci5MSBg6DhK8hzwqmiUlGJKohmvvLZW1Er/vsiGxiJOYwMeaHkXlq
 vn3o4M/xbIfZJppwKL/6Ar8XZ2s6tgPEyIWdoqQ3KxmU6H97Mo9qCoCfnoFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1713443368; h=from : subject : to
 : message-id : date; bh=KyzVo69ICVJHxwsHXC+wYoJ2MHvwOdDQY4E0c7AHxy0=;
 b=CBmjJQXxUaaYsG80pegYuozgowzGwCYwd+d875NcZQitNxMW2VFl2FncVDZrM+aWAZZqm
 1XlY+OhsZWw/v5Akk/oKz9btm084PCSRpn2Efz82Y1utNj7ACqgidsQXRQyEN4XBKTPmne2
 0e5g0jFPYSpY38IkeBDU4lBjYL/PxIYIPwYulG5nx00rj1RkMgFWjugeMdy2iFaNKUNn5pm
 tWBvv1JgcKVYm7tm4baZHHdKcYEcwG+JlOB0QeiKCscgR6wknEV+UK9aJRmXjUAuLBwl6jA
 m+a3JsNxHQR1ZSGRivLfNg/+nVf5PPJhkVx31StLKXHzhshkfMp3x++wHltg==

Strict priority for the tx scheduler is by default in Linux driver, so the
tx-sched-sp property was removed in commit aed6864035b1 ("net: stmmac:
platform: Delete a redundant condition branch").

So we can safely remove this property from this device-tree.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
index 177b9dad6ff7..11663cf81e45 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
@@ -225,7 +225,6 @@ queue3 {
 
 	ethernet0_mtl_tx_setup: tx-queues-config {
 		snps,tx-queues-to-use = <1>;
-		snps,tx-sched-sp;
 
 		queue0 {
 			snps,dcb-algorithm;
@@ -302,7 +301,6 @@ queue3 {
 
 	ethernet1_mtl_tx_setup: tx-queues-config {
 		snps,tx-queues-to-use = <1>;
-		snps,tx-sched-sp;
 
 		queue0 {
 			snps,dcb-algorithm;
-- 
2.34.1


