Return-Path: <linux-kernel+bounces-144579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FC38A4800
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C03282EB0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4703014265;
	Mon, 15 Apr 2024 06:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="agwCyOfn"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAC023D0;
	Mon, 15 Apr 2024 06:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713162289; cv=none; b=UqvsMS2pQ/4n8OuzlgjuwNr8r5GGWXIKaU9d/3iJf4dBt+ysO61adGVtrJYfEFlWulaaiy9UcM7Lflwc+cHGCqE4wuo5b+ONTEpIllwasTL4+eyfj7ulkjzrLnKz+dst5C4cECh5Fntu90hyU9VcTcwaWSumHArkmwRKCN1tf7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713162289; c=relaxed/simple;
	bh=KT8BNk9y8DfOBm/5Bkk+R01FcCgCVUM/PwdoKF6sl2c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q9fgUrEocIUG1CCHE1I0MGVt6C+PRenQj6NmkGZ+9SQ2NQI+6ydDgPNN3AgSS8KrPcoMJw8HJWiDTTkkFFDOC8dcEcodVd+QqIDl2EzLFEKwpiJIgjm3ldGFOTviPEJtkOuPwjmyVTcZ0oTDi99aCd+8BTemh1AF7tkLyTk+uTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=agwCyOfn; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43F6ORAp033631;
	Mon, 15 Apr 2024 01:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713162267;
	bh=E8jhSHq98eE41qwAiHMUbCpdjdy3rLP0+Gtn+Td+hfU=;
	h=From:To:CC:Subject:Date;
	b=agwCyOfn/Dx0X8DHEQe4p5tIMpprBmDaKGg0UR82nnPQ7LS9yM96OqNUOoccewcgV
	 OA0fnLCLXpSnB7qMwWBKwGOVN8mKQxmnEsUqhVj+KqUQe8LuouMLbOr9GdO6Q8vUt0
	 YrgiXxm66gaKGATZLTkozMiiNrBIRbOEcUROgJiI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43F6ORsa067697
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Apr 2024 01:24:27 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Apr 2024 01:24:26 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Apr 2024 01:24:26 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43F6ON6W129743;
	Mon, 15 Apr 2024 01:24:24 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        Udit Kumar
	<u-kumar1@ti.com>
Subject: [PATCH 0/4] Arranging mux and macro update
Date: Mon, 15 Apr 2024 11:54:13 +0530
Message-ID: <20240415062417.3281226-1-u-kumar1@ti.com>
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

This series aims to align ordering of pin muxes in following order
main_pmx0/1, wkup_pmx0/1/2/3 along with two fixes for 784s4-evm
and am69 for UART pin type.

Also, updating pin mux macro of J784S4 SOC instead of J721S2 for 784s4-evm
and am69 at few places.

Sorry for this cosmetic push, but usages of pin muxes was not consistent
across the platforms, and even for j784s4-evm wkup_pmx1 was coded at two
place.

For fixes, these errors should be caught during review but missed due to
cross reference is taken from tool's output.

Note to self, don't always rely on tool's output while reviewing the patch.

Boot logs
https://gist.github.com/uditkumarti/089777a8c31482a67be35aa0ab3cefe9 


Udit Kumar (4):
  arm64: dts: ti: k3-j784s4-evm: Arranging mux and macro update
  arm64: dts: ti: k3-am69-sk: Fix UART pin type and macro update
  arm64: dts: ti: k3-j7200: Arranging pin mux in order
  arm64: dts: ti: k3-j721s2: Arranging pin mux in order

 arch/arm64/boot/dts/ti/k3-am69-sk.dts         |  12 +-
 .../dts/ti/k3-j7200-common-proc-board.dts     | 132 +++++++++---------
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   |  31 ++--
 .../dts/ti/k3-j721s2-common-proc-board.dts    |  30 ++--
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  |  32 ++---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      | 116 ++++++++-------
 6 files changed, 175 insertions(+), 178 deletions(-)

-- 
2.34.1


