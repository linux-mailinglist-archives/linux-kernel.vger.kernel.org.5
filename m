Return-Path: <linux-kernel+bounces-44373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4231F842113
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29CE2899E2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81F6627F0;
	Tue, 30 Jan 2024 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qKybQbYR"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E816167F;
	Tue, 30 Jan 2024 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610060; cv=none; b=sFo7yp7QDLumt0tqF62fyIo0e39qums+K8ZekeI9l8goN+IJfPkjC9uVd8e7W0SkJ0eCY6yLQXF70ALIGLsKLGBXteOR5Sbq0PVwCF55V0Uhy+UhAKebtFxwV2eSTU2jjatgkwrK10tylE3fj17y2VmE5SupNkUyIpTkVjMSKck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610060; c=relaxed/simple;
	bh=aLjn7XdEU5hEK88QNTI8hwCbrNs3SPjY/+JYHUKLmp4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kSzXOSiifD6MwIOVJdE1CqUlqs0K8drsOazEy7e/+HJGyvg8th0kk5Csq9lEt1iFrnaQ4hVGxpR9bLGZY5XtsJ9PpC1VTiq+xtGzxg7xo+KQzmb5ghC2whGXr8QDrKUjePPyIlmP8PFOkvTwa4Yhty9Rbs7VmJUajn6aPsH8edI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qKybQbYR; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40UAKjgg074529;
	Tue, 30 Jan 2024 04:20:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706610045;
	bh=sQdNNGJrcLvORd9w+S9qN3BK+TSWNWilRLsu+br/HRg=;
	h=From:To:CC:Subject:Date;
	b=qKybQbYRVi/EWXw06T84P5ayVnhgMVBycxtHp73uIdSzRNTLml3LMXpaPOzL5kjSe
	 Idspi1m8dchGp9KZg9UViNvG4N29WKpPYM3Y7OdR36HClSYJO0DnUWMusOCXM0YArp
	 KtjzpFOAnINd3FvrL5KDmnzQvdECQJuT5LKoLkHo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40UAKjfY065733
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jan 2024 04:20:45 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 04:20:45 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 04:20:45 -0600
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40UAKiwc047975;
	Tue, 30 Jan 2024 04:20:45 -0600
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <b-kapoor@ti.com>
Subject: [PATCH 0/3] arm64: dts: ti: k3-j7200: Add support for  multiple CAN nodes in J7200
Date: Tue, 30 Jan 2024 15:50:41 +0530
Message-ID: <20240130102044.120483-1-b-kapoor@ti.com>
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

Add CAN Nodes for 18 CAN instances present in main domain and 2 CAN
instances present in the mcu domain. CAN instance 0 in main domain is
enabled on transceiver 0 in J7200 SoM. CAN instance 0 and 1 in mcu
domain and CAN instance 3 in main domain is enabled on transceivers
1, 2 and 3 respectively on common processor board.

Rebased to next-20240130

Bhavya Kapoor (3):
  arm64: dts: ti: k3-j7200: Add support for CAN nodes
  arm64: dts: ti: k3-j7200-som-p0: Add support for CAN instance 0 in
    main domain
  arm64: dts: ti: k3-j7200: Add support for multiple CAN instances

 .../dts/ti/k3-j7200-common-proc-board.dts     |  83 ++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 270 ++++++++++++++++++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |  30 ++
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   |  35 +++
 4 files changed, 418 insertions(+)

-- 
2.34.1


