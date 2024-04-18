Return-Path: <linux-kernel+bounces-150834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D2A8AA56A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B3A1C21D4B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2601BED8D;
	Thu, 18 Apr 2024 22:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="alhx/ILv"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFA0199EB8;
	Thu, 18 Apr 2024 22:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713478516; cv=none; b=SiOuXHIMBMtFBG3KqkTzvWgUJ/Xgcn8e3RMZ2sFaIdx6tTsaJAEDZlAil5jLSzJVJzgs17wJt0cvdBirBpDtNGoYOSIJ6xFzxgAv5PXpzu+BCEt9tw6s2M/VnCsUvRrVpep/9sOvELwz2q+lXrg1Gr7bc3600xk6uThu8HuVN5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713478516; c=relaxed/simple;
	bh=eYdgec8c5xQ7QfSdXEkUrs0hZD5r+DLtp1GPDT+x1/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4ZtjwDCUp1Uv65sJOX9sc1XN+R8YMl2zbjUKmCX3cJBBu6YGSrJdPHJZwQadHsq55hQ4ESK2h7tpyec9Ock25uTJYni8k84XiXjsSX9N6XqfpoSO9VCgKza98AdH5hR7Rk4U/aBwwD5vqMfekuHjM2tAZqpcZdwcTF4K2Q5oRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=alhx/ILv; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43IMEIs6042849;
	Thu, 18 Apr 2024 17:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713478458;
	bh=YvKikMi9SpSnNO/8MzpfVDPH6rLrUCpnxZZoT+RxDl8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=alhx/ILvv8ks//XRKP2sZYwPB0AXRFoidQ6bWrWG8Rl3P+GFbo1L4AEdcVRvuvcqN
	 mxzChYCmDDdlMsK5ctVfv/+PsmAEFGeU5R0zJqLxCBNsgh9WFSVXhz5KoTRJzHz/9w
	 khUxEL/zhjQlTzi3L6pu4TAOv47/LPwLbQAvakLA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43IMEIDl031597
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Apr 2024 17:14:18 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Apr 2024 17:14:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Apr 2024 17:14:17 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43IMEHqv111027;
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
Subject: [PATCH 7/7] arm64: defconfig: Enable TI eQEP Driver
Date: Thu, 18 Apr 2024 17:14:17 -0500
Message-ID: <20240418221417.1592787-8-jm@ti.com>
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

TI K3 SoC's support eQEP hardware, so enable TI eQEP driver
to be built as a module.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2c30d617e1802..23d11a1b20195 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1593,6 +1593,7 @@ CONFIG_INTERCONNECT_QCOM_SM8550=y
 CONFIG_INTERCONNECT_QCOM_SM8650=y
 CONFIG_INTERCONNECT_QCOM_X1E80100=y
 CONFIG_COUNTER=m
+CONFIG_TI_EQEP=m
 CONFIG_RZ_MTU3_CNT=m
 CONFIG_HTE=y
 CONFIG_HTE_TEGRA194=y
-- 
2.43.2


