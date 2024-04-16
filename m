Return-Path: <linux-kernel+bounces-147677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B188A779E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33AF6B21C13
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF028120A;
	Tue, 16 Apr 2024 22:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AfR3tbSr"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33306BFCF;
	Tue, 16 Apr 2024 22:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713305827; cv=none; b=dMKfo528tP2WLCRyUrP4dEPcmrvGozidq+AWE/PHoUGHNNZ4zq1wwBW8dz11qpQYuELDgxIpDCbj5+jNh8y614PH+DbteRfOea7n+w8BR81DtvcURwTG1Z+1SEPMmuvDfq4xyAADXCK6OCHwBz6RZtD19JKwpuzTT/X7qD7J3lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713305827; c=relaxed/simple;
	bh=RQXLts+2Rn12zPZ12Grc51NYSJbRWnHadEoB87tXqiU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UhRq+W5C9+Vwu3Y9DD5PpK80c/yKvzZ0/4afS9jB3/IcVWiPuZ5d/h723muTeQ9de2Pdga3tBKCfn4BKu5BT9IxsJaC7uq71uc0ekzKEUxc16kDUHaSX16nJvPsjLE8VHR9lmg9cV/ndJ98KBGuWfeuInsgo2GeOZMIOMZ0h0eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AfR3tbSr; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43GMGng4005876;
	Tue, 16 Apr 2024 17:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713305809;
	bh=RWH/iQBiLInYxzD4x9yZTgA4icfQMVshpbXpgkbwrw0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=AfR3tbSr4ZVD+V3ispOeIr3f5V3KQNPis9zreLbUWEK3cYyOpMtB+YX5i0V08p7YU
	 1Nv87gUZkZv8KH1W78/7hMqrvoaUL2HcmWr54xq5ZFLogChfbu7g+zf2q0tyHUet91
	 ZX3ncphyc8Opb+siMlJg7ApDQYC1uOpEP4rFBxbM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43GMGnDw020612
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 16 Apr 2024 17:16:49 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 Apr 2024 17:16:48 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 Apr 2024 17:16:48 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43GMGmSq102285;
	Tue, 16 Apr 2024 17:16:48 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bhavya Kapoor <b-kapoor@ti.com>,
        Dasnavis
 Sabiya <sabiya.d@ti.com>
Subject: [PATCH v2 6/6] arm64: defconfig: Set CONFIG_MFD_TPS6594_I2C=y
Date: Tue, 16 Apr 2024 17:16:48 -0500
Message-ID: <20240416221648.3522201-7-jm@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240416221648.3522201-1-jm@ti.com>
References: <20240416221648.3522201-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

SK-AM62A-LP uses TPS6593x PMIC (interfaced over I2C) to power the SoC
and various other peripherals on the board [1].

Booting SD with UHS modes have a dependency on TPS6593x PMIC driver so
change to built in order to boot using SD boot at the higher speed modes.

Fixes: f9010eb938be ("arm64: defconfig: Enable TPS6593 PMIC for SK-AM62A")
Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v1:
- Add patch 6/6
---
 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2c30d617e1802..c994ba7b682dd 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -741,7 +741,7 @@ CONFIG_MFD_SL28CPLD=y
 CONFIG_RZ_MTU3=y
 CONFIG_MFD_TI_AM335X_TSCADC=m
 CONFIG_MFD_TPS65219=y
-CONFIG_MFD_TPS6594_I2C=m
+CONFIG_MFD_TPS6594_I2C=y
 CONFIG_MFD_ROHM_BD718XX=y
 CONFIG_MFD_WCD934X=m
 CONFIG_MFD_KHADAS_MCU=m
-- 
2.43.2


