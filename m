Return-Path: <linux-kernel+bounces-150831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06908AA563
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873361F22A08
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3807A1A0AF2;
	Thu, 18 Apr 2024 22:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qjods+hv"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3030B199E9D;
	Thu, 18 Apr 2024 22:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713478515; cv=none; b=a1eu87s8hTRlXesf1dPCwg5PgflFp0AE9/6CdvHX7i8yzM86Gq1hfvlKiQWcYOSAIlCMN/aTY6gV/cPWkoA0mMYD75+s3E6yKPbuv+e/ACsYtGsZHIMKfyC9OGf31ajEJvVTEaOfHw9mrdf4MiT0QnNxPlzcY4dN+IgsNA2LbwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713478515; c=relaxed/simple;
	bh=yJaOhXzqLgjdGHuksVy7jLzd5j8RtX20tYRL/kEouFo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TdFZJkOUFfA5qveURqyU7YmcA+PcPJLDFI8Esb+KMeTZYHqziVdu/cWqoSXZCH1tKHBT9e4drIlr7r8gpIsDUH+k/j1nvJn1ov8fl4Yxc21Bt1wohVYFdod8hq4D9MQ3OHzkJp3BYrKZaH+GKKqQR1JRQ3ngTuzZ8fBHR54tT2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qjods+hv; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43IMEIo3042845;
	Thu, 18 Apr 2024 17:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713478458;
	bh=9MF25iSQnNM7CjjSN7CKn+MGXLKYAcGZX20SFvxvAbQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=qjods+hvrTFWw0cbNsoowVMr+gsg8XKeZGaQ1NcfmdJ7cAmn//S0PRY0g9BPdIBro
	 JkJbpTHcT/m+JIHnM0w8aNuPnHDWOICswNm9xrtot25N8Ou5U/rhWhNBx51z2BUPjO
	 JfQ73VuRefEElIrd7zITySo28DESidbSsbJHf0GY=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43IMEIMt030832
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Apr 2024 17:14:18 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Apr 2024 17:14:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Apr 2024 17:14:17 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43IMEHqu111027;
	Thu, 18 Apr 2024 17:14:17 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>
CC: David Lechner <david@lechnology.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH 6/7] counter: ti-eqep: Allow eQEP driver to be built for K3 devices
Date: Thu, 18 Apr 2024 17:14:16 -0500
Message-ID: <20240418221417.1592787-7-jm@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240418221417.1592787-1-jm@ti.com>
References: <20240418221417.1592787-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

TI K3 SoC's support eQEP hardware, so add ARCH_K3 to the depends
so the TI eQEP driver can be built for K3 devices.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/counter/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 497bc05dca4df..d30d22dfe5774 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -138,7 +138,7 @@ config TI_ECAP_CAPTURE
 
 config TI_EQEP
 	tristate "TI eQEP counter driver"
-	depends on (SOC_AM33XX || COMPILE_TEST)
+	depends on SOC_AM33XX || ARCH_K3 || COMPILE_TEST
 	select REGMAP_MMIO
 	help
 	  Select this option to enable the Texas Instruments Enhanced Quadrature
-- 
2.43.2


