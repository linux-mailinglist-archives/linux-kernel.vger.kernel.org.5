Return-Path: <linux-kernel+bounces-159194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD31A8B2A85
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681A91F218FD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9DB156246;
	Thu, 25 Apr 2024 21:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JiqeVezK"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99492155A53;
	Thu, 25 Apr 2024 21:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079589; cv=none; b=Bqgy4wSkOW56PnJNqBq7E2aFe281m+q546fz6iU4UyiMBk/q7PRA7ZijpOfuGySbtTA07Y8IVBn1ypnMQphMF97AHaJq0toMv2rl4+JspYAOWPLt9YXD+M8IWkLeLKo+iAl9U8uCwoCewE+gO4YWUDDfLcknK1epTyl8HIZfFGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079589; c=relaxed/simple;
	bh=iR616uLN7mCalA+bSJ9E+MT1+OpJWAOtcIuvnK0HUJI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KxBwRx/tC7UGMCcyk7n8sSnSIrbMJVV/hsIoQA153dMVZcB8V8exz05qfqlLL/xdDzhDOQeYQy9DS4PwNwZmf5mPTL/5qMTgzw5ZGmxP+efw0H/UQ0ybPm56WqnqiNSx/LjAv6EnzmTZbxnkQlSNV8y+ZH2T5RJfvdCIoy1GiEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JiqeVezK; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43PLCcfZ076430;
	Thu, 25 Apr 2024 16:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714079558;
	bh=XaFgWFw58yNqK9nUClae9Qshi6JbU2Nx+VquSe0ABT8=;
	h=From:To:CC:Subject:Date;
	b=JiqeVezKOd/MzQDyRT4D7mB40bmq3crKe7yekb6b4Xui4Y41/h/uWrBKIdl410CDD
	 W0y+R6eMBNXG7LNQ8gFEB2g7QZkW2PCgzqBxc0Zs7WxJGP3y4PjhUidm4/31CPBtZe
	 nSxOW0iKAGDASVTnCooE4+nGmMAFspb0pX6jWCDA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43PLCcPu075672
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Apr 2024 16:12:38 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 16:12:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 16:12:38 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43PLCYHC038718;
	Thu, 25 Apr 2024 16:12:35 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>, <u-kumar1@ti.com>,
        <n-francis@ti.com>
Subject: [PATCH v4 0/6] arm64: dts: ti: k3-j7*: Add missing ESM and
Date: Fri, 26 Apr 2024 02:42:27 +0530
Message-ID: <20240425211233.2006233-1-n-francis@ti.com>
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

Add missing ESM and watchdog nodes for the sake of devicetree completion
of hardware description w.r.t Linux and ESM and WDT enablement on
U-Boot. This patch series adds the missing nodes for J721E and J7200.

Boot logs (updated for v3):
https://gist.github.com/nehamalcom/5dc94ab60f57df5d515d0a6d0da6e0d1

Changes since v3:
- added patch (6/6) for adding bootph-pre-ram in main_esm nodes (Udit)
- no change to boot logs

Changes since v2:
https://lore.kernel.org/all/20240412042537.666137-1-n-francis@ti.com/
- corrected register size for MCU watchdog instance in J7200 (Udit)
- added Reviewed-by tag (Udit)

Changes since v1:
https://lore.kernel.org/all/20240326122723.2329402-1-n-francis@ti.com/
- modified node name numbering to be in sync with TRM (Udit)
- disabled wkup_esm node in J721E (Udit)
- added patch (5/5) for MCU domain watchdog instances in J7200 (Udit)
Neha Malcom Francis (6):

arm64: dts: ti: k3-j721e-mcu: Add the WKUP ESM instance
  arm64: dts: ti: k3-j721e-mcu: Add the MCU domain watchdog instances
  arm64: dts: ti: k3-j721e-main: Add the MAIN domain watchdog instances
  arm64: dts: ti: k3-j7200-main: Add the MAIN domain watchdog instances
  arm64: dts: ti: k3-j7200-mcu: Add the MCU domain watchdog instances
  arm64: dts: ti: k3-j7*-main: Add bootph-pre-ram to main_esm

 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 28 ++++++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 26 +++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 94 +++++++++++++++++++
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      | 32 +++++++
 4 files changed, 180 insertions(+)

-- 
2.34.1


