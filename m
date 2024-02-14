Return-Path: <linux-kernel+bounces-65090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 598FA8547A3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15FD428288C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9881418EB1;
	Wed, 14 Feb 2024 10:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k1bT8Ze6"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B2D19473;
	Wed, 14 Feb 2024 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707908336; cv=none; b=Jlf3x4hxeoe7JI3+G/kPB7If4y1gKCh0AXleD02IRXHUPgIIVKYqCe6so5DdcsEKIE5cwHFZRqcjeDZNKaKyEG7AtxmLt4GPEI8hZm5L+xWozaJMEHMQ1XN/bh8iSMbkUfSAzgIHow3TFsf/pcl3D6gZVruNC+wNdSjoaS9Ni9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707908336; c=relaxed/simple;
	bh=qxEx1is+rHLu8sXjAQxdC0cDa5bG4byiwMMFn1yF/Do=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QE+QH5Tg3zOACMMlMLxKCxENMlUB1f+ysefYgNuBc1Qa98Xhzpjd9R4s4LXMMHk6Eyl2Tf/4dLoUrv70PTg4oOxdMlH2Ik4BjYnjGQqjVUrbMY+muAGSgGd+EiaHaUe7byn8POW9tmnnO0rajMdk6nkX8bng+cL6rtcSpgCaxyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=k1bT8Ze6; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41EAwlDe030229;
	Wed, 14 Feb 2024 04:58:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707908327;
	bh=1ZaRMwxoLh/RwYheULKH0st1GQ8R7ktaclahghQmrc8=;
	h=From:To:CC:Subject:Date;
	b=k1bT8Ze6sybteJ+7BWD14hefdAtyN+TElWOzWmmGYT9U0IZuHcJExSuWvPjkuMKw1
	 HtxNR0aATfp0X6TE+xqBr0BdLzmpVKOP0DRWpmMVoe9l8gClP5jnhroms4MI1CKd6v
	 NnBo0UaL7bnkKuAZaShaYC+ivH3mjAu9gwc8TpZE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41EAwlo1121623
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Feb 2024 04:58:47 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Feb 2024 04:58:47 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Feb 2024 04:58:47 -0600
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41EAwkCu070774;
	Wed, 14 Feb 2024 04:58:47 -0600
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <b-kapoor@ti.com>
Subject: [PATCH v3 0/4] arm64: dts: ti: Modify pinmux for wkup_uart0 and mcu_uart0
Date: Wed, 14 Feb 2024 16:28:42 +0530
Message-ID: <20240214105846.1096733-1-b-kapoor@ti.com>
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

WKUP_PADCONFIG registers for wkup_uart0 and mcu_uart0 lies under
wkup_pmx2 for J7200. Thus, modify pinmux for both of them. Also,
remove the redundant clock-frequency property from mcu_uart0 node.

Only Tx and Rx Signal lines for wkup_uart0 are brought out on
J721S2 Common Proc Board and J784S4 EVM, but CTS and RTS signal lines
are not brought out. Thus, remove pinmux for CTS and RTS signal lines
for wkup_uart0 in J721S2 and J784S4.

v1 Link : https://lore.kernel.org/all/20240208110602.931573-1-b-kapoor@ti.com/
v2 Link : https://lore.kernel.org/all/20240212104417.1058993-1-b-kapoor@ti.com/

Changelog v1->v2:
 - Divided Pinmux and clock frequency patch(1/3) for J7200 into 2 patches
 - Change commit message to include wkup_uart0 for referring to the instance

Changelog v1->v2:
 - Added Fixes tag in Commit message

Rebased to 20240214

Bhavya Kapoor (4):
  arm64: dts: ti: k3-j7200-common-proc-board: Modify Pinmux for
    wkup_uart0 and mcu_uart0
  arm64: dts: ti: k3-j7200-common-proc-board: Remove clock-frequency
    from mcu_uart0
  arm64: dts: ti: k3-j721s2-common-proc-board: Remove Pinmux for CTS and
    RTS in wkup_uart0
  arm64: dts: ti: k3-j784s4-evm: Remove Pinmux for CTS and RTS in
    wkup_uart0

 .../boot/dts/ti/k3-j7200-common-proc-board.dts | 18 +++++++++---------
 .../dts/ti/k3-j721s2-common-proc-board.dts     |  2 --
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts       |  2 --
 3 files changed, 9 insertions(+), 13 deletions(-)

-- 
2.34.1


