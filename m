Return-Path: <linux-kernel+bounces-31415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B43832DF9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDBE6283899
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93F556442;
	Fri, 19 Jan 2024 17:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="N8D4R0Ss"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7633854F91;
	Fri, 19 Jan 2024 17:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684596; cv=none; b=FvtczOlYNtZ93ZjiuVTHOFa37UyRUBk2x4htOofNCnEl+IVXa8g2UkVICm74QfXamIgMwtCBn3HW6/36aQ7T23vr32hS1eee7h3LCKt/SUR5hYtEjS4BFIC5ZbM0glGCOvgnDlWTspmyEkDf84uypJON8CIHmXeeupaJVcSnvn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684596; c=relaxed/simple;
	bh=nOFb+8eWiDJeXgunzTOnnRw2Vd7jAoIJDSb41ydXzxI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qls9VfGGVrv3pvAmxwkkIpakGWz1m0/W61mpFXtZwfjCZszNsCI4BhC18EOSTETlIN4Jjq3WaXidZUTpybLzCbWi5qw7WEwJoI9fptQKqpZTNlW30NMrQebRj9pYN3fj5wAA/bBjgf9oMyNuz+W10JK8r+F40tttHf9K4WojaGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=N8D4R0Ss; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40JHGOLP079059;
	Fri, 19 Jan 2024 11:16:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705684584;
	bh=xWmaNoVpOaeR7vN0ATKz52uexUlY3K/5QtXjxIYd9xc=;
	h=From:To:Subject:Date;
	b=N8D4R0SsrsPqYUsOZtTVoeznFQJz3oH9PQb1FWQMdgyRFEfg5ZM5ehUaVqWBTQHVP
	 chFafx0HLve7NpOGu8mc2eQNHiU7niR1zHfAab2sn1bZBaQHRMzgGtjcPUEoRulOt7
	 8PuKgYBGVciF3lmqX3FrVJwIZ23UEWJ0+rTs6f4k=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40JHGOg8085917
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 19 Jan 2024 11:16:24 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Jan 2024 11:16:24 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Jan 2024 11:16:23 -0600
Received: from TI.dhcp.ti.com (ti.dhcp.ti.com [10.24.68.115] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40JHGKRC010957;
	Fri, 19 Jan 2024 11:16:21 -0600
From: Apurva Nandan <a-nandan@ti.com>
To: Apurva Nandan <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH] arm64: dts: ti: Add phase tags for memory node on J784S4 EVM and AM69 SK
Date: Fri, 19 Jan 2024 22:46:19 +0530
Message-ID: <20240119171619.3759205-1-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

memory node are required for bootloader operation on TI K3 J784S4 EVM
and AM69-SK boards for finding the memory size during early boot stage.

So, align Linux device tree by adding phase tag marking 'bootph-all',
which is to enable for all bootloader stages.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts    | 1 +
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 8da591579868..ec61ed66b43d 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -33,6 +33,7 @@ aliases {
 
 	memory@80000000 {
 		device_type = "memory";
+		bootph-all;
 		/* 32G RAM */
 		reg = <0x00 0x80000000 0x00 0x80000000>,
 		      <0x08 0x80000000 0x07 0x80000000>;
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index f34b92acc56d..616f5b5bd07d 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -31,6 +31,7 @@ aliases {
 
 	memory@80000000 {
 		device_type = "memory";
+		bootph-all;
 		/* 32G RAM */
 		reg = <0x00 0x80000000 0x00 0x80000000>,
 		      <0x08 0x80000000 0x07 0x80000000>;
-- 
2.34.1


