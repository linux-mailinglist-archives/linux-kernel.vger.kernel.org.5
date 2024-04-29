Return-Path: <linux-kernel+bounces-162206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E38598B5791
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFEA285D05
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24C154736;
	Mon, 29 Apr 2024 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oa2FblC0"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C604254730;
	Mon, 29 Apr 2024 12:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392589; cv=none; b=HhPSdLC0lOc4xh4CtDazpSABBODEVf1IzWM8DpWQtqYfBRyW6vr03ViiVa05r1MQyLUDb+xe6pqQ8QsDS8MsWE70lKcW/k4t6qCUDd3mjjqZQrQAyTE12avgo+xc5C1NM8lwRkEvpS64BOSE48Z3M0iISzYl9sm6k3hH+A7M76c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392589; c=relaxed/simple;
	bh=5aRnSGcpCnvn8mGlt8kJeLwgq1dMAP+dd2bf2oZQm80=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mapNNoKQCvAq+eL1uxszwQzRCe02mHy/iyQm3h0Dmxn8FvncH8pHtYtir1p2O3tYCtfmF2o5dbj9e+S2/i1dBgHP7stKzh4JppR2xQAY+7buOhyclDfC/Ynzwxh+KpNIdD66Tf4rqambV1uIDupozbrJKePZnFwOV3WmLooi/R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oa2FblC0; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43TC9b42023668;
	Mon, 29 Apr 2024 07:09:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714392577;
	bh=Vm62BWXRBUN5Z2NXUfRDFZ+4KArLLz3rG4pECulTNUQ=;
	h=From:To:CC:Subject:Date;
	b=oa2FblC0WSZqVPpJ/qf7rVkjtHar6AhUkKnqn9FvQKep0gUS2ODZ7luipUG2azLRY
	 P32Tta3HUth5CYm1IgNvf2iy3PJuZsxeSEPWc5PLor4lqzQGAyxGBunXY1n4V19Zlc
	 lYRIiCaz7VdullnoJK9kMn5cRKrC1aEbXNcBzwoY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43TC9bwG009187
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Apr 2024 07:09:37 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Apr 2024 07:09:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Apr 2024 07:09:36 -0500
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43TC9XrE012367;
	Mon, 29 Apr 2024 07:09:33 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <srk@ti.com>, <rogerq@kernel.org>,
        <r-gunasekaran@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Add USB support for J722S EVM
Date: Mon, 29 Apr 2024 17:39:29 +0530
Message-ID: <20240429120932.11456-1-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

J722S has two USB instances. This series enables USB support for
both instances.

Ravi Gunasekaran (3):
  arm64: dts: ti: k3-j722s: Add support for SERDES0
  arm64: dts: ti: k3-j722s: Redefine USB1 node description
  arm64: dts: ti: k3-j722s-evm: Update USB0 and USB1 configuration for
    EVM

 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 58 +++++++++++++++
 arch/arm64/boot/dts/ti/k3-j722s.dtsi    | 93 +++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-serdes.h      |  7 ++
 3 files changed, 158 insertions(+)


base-commit: b0a2c79c6f3590b74742cbbc76687014d47972d8
-- 
2.17.1


