Return-Path: <linux-kernel+bounces-61343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E532B85114D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23E42854A6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F33C38FA9;
	Mon, 12 Feb 2024 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oWL2KptG"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3988F38F84;
	Mon, 12 Feb 2024 10:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734666; cv=none; b=G4mYZuQ2V2HYbfXXitpZUOtoLyC5EMuylUKD9XIrpV63eRYUXTN7e5i8+XBNNcmnlUbBjGeu2gFVKiTM0C0UX+DG+t05/lqlglx57B6njwl/At0yxSjEy63sm5T1/o8VtOkzvuB0vy5DnECkqnkrs8qlcOOt1/it/N3UiwYX9LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734666; c=relaxed/simple;
	bh=5hYF460/+htzfJ1okNx/pGu468s50PBHNVmfUoC+QnM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=neZEtHuu71O4grTNUNvjBmZf0bAQJSKq5a2o78dZnTjtml+sfyc/l1gUXHechilEQI1Ac3RCWvQvVUhtpxBuN2TAsSqxyl+NNB6WkZOJ+qSnYWHQ+C7i7Hi+RHb4tJdOTrWN933TJALT9snTQs2+ShKSl9BfWDkC6bfc4GxcQYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oWL2KptG; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CAiIZA115366;
	Mon, 12 Feb 2024 04:44:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707734658;
	bh=b4JbmEa2Ee7tdYYKJ1dwvz/r7NVCdNPG0jCwiAuAacM=;
	h=From:To:CC:Subject:Date;
	b=oWL2KptGhA4NlMwLucPzbn6vW9yD6cAg12hFipVrJJLMUQX2vMlJ62Rcm3/9Y4gSE
	 wCUb9kuZm8wikuGTd7Z/AQsDhpenB7SWKYgy3qchje/coCXFRf+2bfIvtvDqF1yUuQ
	 IlFyE07gmlVma2ZR+umBl2eaHdl5+m7HfqXMwUXQ=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CAiI04075965
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 04:44:18 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 04:44:18 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 04:44:18 -0600
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CAiHSB116417;
	Mon, 12 Feb 2024 04:44:18 -0600
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <b-kapoor@ti.com>
Subject: [RESEND PATCH v2 0/4] arm64: dts: ti: Modify pinmux for wkup_uart0 and mcu_uart0
Date: Mon, 12 Feb 2024 16:14:13 +0530
Message-ID: <20240212104417.1058993-1-b-kapoor@ti.com>
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

Changelog v1->v2:
 - Divided Pinmux and clock frequency patch(1/3) for J7200 into 2 patches
 - Change commit message to include wkup_uart0 for referring to the instance

Rebased to 20240212

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


