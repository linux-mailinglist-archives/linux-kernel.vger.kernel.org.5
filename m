Return-Path: <linux-kernel+bounces-65092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2768547A6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 889E42837A2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968BD1B7F8;
	Wed, 14 Feb 2024 10:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Qa9c28Sn"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608D818E28;
	Wed, 14 Feb 2024 10:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707908338; cv=none; b=j/TUSYdrknATaofj2kqtaPby/bmHxsjETiqn3BFjn6xoi89g4JV7thycmGI2r52di8mBDKrIpEEdULNEJH5p9dT3z7p88Frfsu0UUyWF2SP4JKQ9SohTvEKBE0a7xiRK5SAfOkMHYWaGDdewRPaLL9wJBHWxd+1HETk7aKRFfyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707908338; c=relaxed/simple;
	bh=D9W3wddn1DNq0E3157yBksZt4OFUqk368paNydM8nAg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qfUt18Vb0hZmqi9wkg/07RzSGCIQMVLpWfzBiE7WFZiT1ElTSLyN6x6mU9CX2iutMALDX/Q2pTFNktbXgshhA7AYEB3DbBjupxT+fGoXA1njag5ZTqmC5akdzdWErpV0QuHBqb829Q/eJUV2I19kJ7ycAV6vhd7a65L54cWq5Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Qa9c28Sn; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41EAwqtl027682;
	Wed, 14 Feb 2024 04:58:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707908332;
	bh=NSNw7akJQ/HXmwafuJmxqohDZ31UIzv46iojSA164sA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Qa9c28Sn+/L335B2NYUzwKExOb3k2dc5r8GAXJTw1zW5XqYxST3A7UQ78PgqQiYu9
	 ZEPjB9PORqWmnAxj12DTIMRZuneWyOXMK2XupvWYMFmDEBL7lBLcDMKVOh9OxI6E7D
	 Ov3xuhqDqOakG46Uds7Q8M/L1/SE7fhG0GtznpoA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41EAwqLP092584
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Feb 2024 04:58:52 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Feb 2024 04:58:51 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Feb 2024 04:58:52 -0600
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41EAwptx036563;
	Wed, 14 Feb 2024 04:58:51 -0600
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <b-kapoor@ti.com>
Subject: [PATCH v3 3/4] arm64: dts: ti: k3-j721s2-common-proc-board: Remove Pinmux for CTS and RTS in wkup_uart0
Date: Wed, 14 Feb 2024 16:28:45 +0530
Message-ID: <20240214105846.1096733-4-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214105846.1096733-1-b-kapoor@ti.com>
References: <20240214105846.1096733-1-b-kapoor@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Only Tx and Rx Signal lines for wkup_uart0 are brought out on
the Common Proc Board through SoM, but CTS and RTS signal lines
are not brought on the board. Thus, remove pinmux for CTS and RTS
signal lines for wkup_uart0 in J721S2.

Fixes: f5e9ee0b354a ("arm64: dts: ti: k3-j721s2-common-proc-board: Add uart pinmux")
Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index 361365bb5523..6371cb1c1fe7 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -190,8 +190,6 @@ J721S2_IOPAD(0x038, PIN_OUTPUT, 0) /* (AB28) MCASP0_ACLKX.MCAN5_TX */
 &wkup_pmx2 {
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x070, PIN_INPUT, 0) /* (E25) WKUP_GPIO0_6.WKUP_UART0_CTSn */
-			J721S2_WKUP_IOPAD(0x074, PIN_OUTPUT, 0) /* (F28) WKUP_GPIO0_7.WKUP_UART0_RTSn */
 			J721S2_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (D28) WKUP_UART0_RXD */
 			J721S2_WKUP_IOPAD(0x04c, PIN_OUTPUT, 0) /* (D27) WKUP_UART0_TXD */
 		>;
-- 
2.34.1


