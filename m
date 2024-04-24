Return-Path: <linux-kernel+bounces-156506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D748B0381
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C198285436
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0FC15820E;
	Wed, 24 Apr 2024 07:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WnpN93T0"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAA443AB4;
	Wed, 24 Apr 2024 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945281; cv=none; b=BjxzVLrxw6cQzYPz66iaaMAqmlX2aiKvfsnjQUqyv76UmpeVYijq1l0DvYNuSyl+tXa5ACLtf/QeJew3EytlRqaqNVE5PGbVnBTkARAsQt/o0m9GkloOAAXVZSE1NbASNzBdA3I8ZiraGiueHOvwCYXgN+mlmqk4c/SHZzeOvmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945281; c=relaxed/simple;
	bh=1B8qdzLONfVMeH9J3V4F+yJjzmAlYYXQZZm5lzjyVoM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o8HZjxAlBGGYVKogUrKcQmCIuWEhi4g+O79fbjyuueWNl/r8ZcwAUveXMzow+Y1gTLwoEHjpFibPwZdolrwPUJSWuCp+z3B4CyWNjsaorancxnssxYjjarahTg0K2VczkRLG83coxs5Erk7yTZ31KBMYKaSXbWyieZ6PD8FuOtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WnpN93T0; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43O7sXeX072289;
	Wed, 24 Apr 2024 02:54:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713945273;
	bh=QNVsYdCubuCPHCd6LiLsZVOY/rNOwVxqulkS/c9tRh4=;
	h=From:To:CC:Subject:Date;
	b=WnpN93T0rUmnnrqaUBzyxHwTWRUDiJykmCprSBEEEoNOK9KcNPKg7tM2TaYV+WBbA
	 h1mddeXORlSFlC6jdCib1KtyyELJDUgyj3SA12hvLHF2vRaho60uKw9hJZxtG+tsDD
	 q0PN/GFIp9Dy43FRQi8qR5Tql7b2xfh+C2RKuYBc=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43O7sXvt128831
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Apr 2024 02:54:33 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Apr 2024 02:54:33 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Apr 2024 02:54:33 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43O7sTEM023008;
	Wed, 24 Apr 2024 02:54:30 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <n-francis@ti.com>, <m-chawdhry@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        Udit Kumar
	<u-kumar1@ti.com>
Subject: [PATCH 0/2] Adding main esm Address range
Date: Wed, 24 Apr 2024 13:24:21 +0530
Message-ID: <20240424075423.1229127-1-u-kumar1@ti.com>
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

This series adds address range for main domain esm
for J721S2 and J784S4 SOC.

Udit Kumar (2):
  arm64: dts: ti: k3-j721s2: Add main esm address range
  arm64: dts: ti: k3-j784s4: Add main esm address range

 arch/arm64/boot/dts/ti/k3-j721s2.dtsi | 1 +
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi | 1 +
 2 files changed, 2 insertions(+)

-- 
2.34.1


