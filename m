Return-Path: <linux-kernel+bounces-161781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1DE8B5124
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B1F61C21668
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8AC10A13;
	Mon, 29 Apr 2024 06:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QQCYBg4o"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5603210A11;
	Mon, 29 Apr 2024 06:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714371375; cv=none; b=qqY/n2YjMLNFD1D5X4QXK33xe/23vJh2aOVx/1LRWrE+fQAs6OMZKhkQniw+0ROhBwOfYIbIcWUwyqwl2jnb8MhPjQeG+BqZRrvgEiN6XfFTiqNYv2f1dYXCnrtutqxrrZs1vY9HoWvn61WkOXxdJ9H7iIrMbQ3lZTOjuGJ3c04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714371375; c=relaxed/simple;
	bh=spBsOpIDMfUaTRRia/vfM81McqWgkJsOXeAqjdhoNWc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r+OjrZ4DV4ow+tvuhO8QvBRvQIHMe3x9AYnABeIs3Sx7GSWBCMxlGQ249e3pcwaP/QgKGPUFJAuGVq8D1MmnLWOiB9WBjOuYNIWDjjEhJ/ZMIT7veqhb22KVjfBAdKI3UiDzcb2fubsYoFDeE7I2NMagyu08w5w5p19wbiRrlFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QQCYBg4o; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43T6G5RA058391;
	Mon, 29 Apr 2024 01:16:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714371365;
	bh=haE9un+DuC+VuSiQ9xUVbM9pbeZ4PFkodh4uMtLzGak=;
	h=From:To:CC:Subject:Date;
	b=QQCYBg4oE/szyvkeHWdVOwXkAiXmNOXmHlm3B4rpPPH0iPI83c+q88BXDTCorvgMh
	 RZMKdUYKAf4MVMZKhrOh4gYlPnMH1IDjcMYKyIqc+f2qO9Iv9BUpkcYPnqDffE9LTN
	 Yr0BtP93sq4MVeCMfL+cQ3/PC9Q1RoBfp1sfWbho=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43T6G5N9128227
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Apr 2024 01:16:05 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Apr 2024 01:16:05 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Apr 2024 01:16:05 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43T6G4ne011810;
	Mon, 29 Apr 2024 01:16:05 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
	<nm@ti.com>,
        <s-vadapalli@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Chintan Vankar <c-vankar@ti.com>
Subject: [PATCH v2] arm64: dts: ti: k3-am625-sk: Add bootph-all property in phy_gmii_sel node
Date: Mon, 29 Apr 2024 11:46:00 +0530
Message-ID: <20240429061600.2723904-1-c-vankar@ti.com>
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

Add missing bootph-all property for CPSW MAC's PHY node
phy_gmii_sel.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

This patch is based on linux-next tagged next-20240426.

Link to v1:
https://lore.kernel.org/r/20240425095448.1946293-1-c-vankar@ti.com/

Changes from v1 to v2:
- Removed "bootph-all" property from "k3-am62-main.dtsi" and added it
  to "k3-am625-sk.dts".

 arch/arm64/boot/dts/ti/k3-am625-sk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index ae81ebb39d02..58b70a760648 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -297,3 +297,7 @@ partition@3fc0000 {
 &tlv320aic3106 {
 	DVDD-supply = <&vcc_1v8>;
 };
+
+&phy_gmii_sel {
+	bootph-all;
+};
-- 
2.34.1


