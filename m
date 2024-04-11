Return-Path: <linux-kernel+bounces-141678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19648A21EE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54C99B21F5A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A93D47768;
	Thu, 11 Apr 2024 22:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u1a3iG+8"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796EB45C10;
	Thu, 11 Apr 2024 22:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712875987; cv=none; b=e1Vi9yZ/9s9ON/PQxGKKaJ4PIvHGskXJkPlUtKuzX8uN+9BqAqxBvcP0dGtSMruVSM3t9uVE4srHvPCX+N8whuZKDJWqiq1EvtgUomdOu5+IW1oiIuRzbEyj+6QfWi4m7ow/q5Z5l3OCtOi7Cr/zWibXfge2U+6TREPS2/SG0n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712875987; c=relaxed/simple;
	bh=W5IOIauvdcqC7Pu61JrL4Nqqv2GxapZeP3kf7mWwtBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=quwW+2IwNk6NOPHKKv75GkmgX8qwdb11mF3IxYHQDUfsG2lzoa4zdJaZ4hhm3S1lUa+sPnfN/BaG9LvUeENYtXkhb9zmrpu5K9KAy08QDky0saMpcmDVqEMeqmrUbDceYyiQ1hY1i9mex9t45ZHWRIo/bWEpc23Y8DC0vCGV+gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=u1a3iG+8; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43BMqwO2106827;
	Thu, 11 Apr 2024 17:52:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712875978;
	bh=U5vGaNlkeZBsjgOImgjsk8+GhPmZ/Wnc8cLNrjW4OwY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=u1a3iG+8WMQFLsaUGuF+sny4IT0HYhrWg9PG5zA+jlCxtVThU/KJ0VsVKIoe/Er6o
	 9lNbmJoNV4coTm6dvDBN1RgPdpPFZhbCfs2xvuhC2f/A8dHdTi9gA05y1/FecJTI98
	 aNcOIA0w/+R39RC/ScyRJ+zB32per4pVYs026brg=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43BMqwZo083776
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Apr 2024 17:52:58 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Apr 2024 17:52:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Apr 2024 17:52:57 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43BMqv7c002381;
	Thu, 11 Apr 2024 17:52:57 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bhavya Kapoor <b-kapoor@ti.com>,
        Dasnavis
 Sabiya <sabiya.d@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 6/7] arm64: dts: ti: k3-am69-sk: Remove HS400 mode support for eMMC
Date: Thu, 11 Apr 2024 17:52:56 -0500
Message-ID: <20240411225257.383889-7-jm@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240411225257.383889-1-jm@ti.com>
References: <20240411225257.383889-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Dasnavis Sabiya <sabiya.d@ti.com>

The eMMC fails to enumerate intermittently on HS400 mode. Also
observing multiple CQE recovery warnings.
Update the sdhci0 node to disable HS400 and set HS200 mode for
eMMC node.

Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 50de2a448a3a6..a677bb9200a35 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -906,6 +906,7 @@ &main_sdhci0 {
 	non-removable;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
+	no-mmc-hs400;
 };
 
 &main_sdhci1 {
-- 
2.43.2


