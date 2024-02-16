Return-Path: <linux-kernel+bounces-68674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F0E857E30
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829161F25C87
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E54312BF33;
	Fri, 16 Feb 2024 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AdH7f6E2"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C483112C7F3;
	Fri, 16 Feb 2024 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708091757; cv=none; b=XQqqy6fQ0CH4AfiJ90RrWzaVNcYBkEnQ3E/TYwTXeI+dVENj0l73gcF8BvdfceVj9JE8bqXfPPWe3Mm19ChE+/7bVCSRGc0B757nW6Rwv2SfHuSpORiIQyq4c15cFPt8w+zTsqlvFRABxWTructG0XvamIgFVbUsGukaJ6MXdDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708091757; c=relaxed/simple;
	bh=hr4Ayqw6EKQlkiAHhr4MoFClWx7QoWbU9AbvAEl8Iag=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZN8JzvZ4u9RGyDm6NcBmw3ZwUAw4RK9Qk/f/vDRSV/Ij1GE9lRYQhbdswP21RaNGiNWQuOOIvFHSTWldm7q7+HvinzWUbB4Uzt7H72BeptqsAD72WeAC1tJbVXFNk50ySlp4q5L31Z2/Z1KP9qjOITxRglRG09DjCJcYGux7g4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AdH7f6E2; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41GDtbeA102642;
	Fri, 16 Feb 2024 07:55:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708091737;
	bh=XV5UoA6Y5eHgbQSInqOCMuBwARWCVvY1oDfeRdkdTVI=;
	h=From:To:CC:Subject:Date;
	b=AdH7f6E2QukCzJoxbagk52ctndEeQkyrDIayIkv/CgzlFC7twT6/HGS/FiUgKUv3N
	 e3fywqKY1QSLEPVP/z/4B66crfgOpazQs1iGW3H7P2BWuLjsCSTxluK7hn+0XYyOJ1
	 0YMjbJ6o5FX3vOvdDR5Dkqtnwj+9pXozGyD93S2A=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41GDtbeA066615
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Feb 2024 07:55:37 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 Feb 2024 07:55:37 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 Feb 2024 07:55:37 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41GDtXrS127060;
	Fri, 16 Feb 2024 07:55:34 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <vaishnav.a@ti.com>, <u-kumar1@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 0/2] Add OSPI and Ethernet support on J722S EVM
Date: Fri, 16 Feb 2024 19:25:31 +0530
Message-ID: <20240216135533.904130-1-vaishnav.a@ti.com>
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

Hi,

This series adds support for Ethernet and OSPI NOR flash on J722S EVM.

EVM Schematics are available at:
	https://www.ti.com/lit/zip/sprr495

Test log (6.8.0-rc4-next-20240216):
  https://gist.github.com/vaishnavachath/b04e3be90af4cdec59fb0d9cc72441b9

For those interested, more details about this SoC can be found in the
Technical Reference Manual here:
            https://www.ti.com/lit/zip/sprujb3

Thanks and Regards,
Vaishnav

Siddharth Vadapalli (1):
  arm64: dts: ti: k3-j722s-evm: Enable CPSW3G RGMII1

Vaishnav Achath (1):
  arm64: dts: ti: k3-j722s-evm: Enable OSPI NOR support

 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 132 ++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

-- 
2.34.1


