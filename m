Return-Path: <linux-kernel+bounces-24130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAE782B7FB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50081F253B9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E4259B6A;
	Thu, 11 Jan 2024 23:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CMHcxHp5"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2846759B5D;
	Thu, 11 Jan 2024 23:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 655E8C0000E4;
	Thu, 11 Jan 2024 15:15:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 655E8C0000E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1705014944;
	bh=0zK9IlUIaxglY1uUdlByTuJo2PKiDkOIZhKkGpO6xA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CMHcxHp5C+YRIBeq0K7N+oUN1fUdHBCzud8Ob3nw2/g/oK0xprx/CmDTRH7gHG07T
	 xIfupzM9+2OVqTEi9tMSUQqO859hYCH7xdyTEWtVOigHTHON+qyOe0u8TxcP3suEik
	 VhV4XGUMG2R5mhGxvANLDBTj1V9HkYdtz/Cfkz0w=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id B684418041CAC7;
	Thu, 11 Jan 2024 15:15:42 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] bus: brcmstb_gisb: Added support for 74165 register layout
Date: Thu, 11 Jan 2024 15:15:39 -0800
Message-Id: <20240111231539.783785-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111231539.783785-1-florian.fainelli@broadcom.com>
References: <20240111231539.783785-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BCM74165 introduces a new register layout which is different from
previously taped out chips, match the documented compatible and use the
appropriate table of register offsets.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/bus/brcmstb_gisb.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index b6dfe4340da2..65ae758f3194 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -96,6 +96,20 @@ static const int gisb_offsets_bcm7400[] = {
 	[ARB_ERR_CAP_MASTER]	= 0x0d8,
 };
 
+static const int gisb_offsets_bcm74165[] = {
+	[ARB_TIMER]		= 0x008,
+	[ARB_BP_CAP_CLR]	= 0x044,
+	[ARB_BP_CAP_HI_ADDR]	= -1,
+	[ARB_BP_CAP_ADDR]	= 0x048,
+	[ARB_BP_CAP_STATUS]	= 0x058,
+	[ARB_BP_CAP_MASTER]	= 0x05c,
+	[ARB_ERR_CAP_CLR]	= 0x038,
+	[ARB_ERR_CAP_HI_ADDR]	= -1,
+	[ARB_ERR_CAP_ADDR]	= 0x020,
+	[ARB_ERR_CAP_STATUS]	= 0x030,
+	[ARB_ERR_CAP_MASTER]	= 0x034,
+};
+
 static const int gisb_offsets_bcm7435[] = {
 	[ARB_TIMER]		= 0x00c,
 	[ARB_BP_CAP_CLR]	= 0x014,
@@ -393,6 +407,7 @@ static const struct of_device_id brcmstb_gisb_arb_of_match[] = {
 	{ .compatible = "brcm,bcm7400-gisb-arb", .data = gisb_offsets_bcm7400 },
 	{ .compatible = "brcm,bcm7278-gisb-arb", .data = gisb_offsets_bcm7278 },
 	{ .compatible = "brcm,bcm7038-gisb-arb", .data = gisb_offsets_bcm7038 },
+	{ .compatible = "brcm,bcm74165-gisb-arb", .data = gisb_offsets_bcm74165 },
 	{ },
 };
 
-- 
2.34.1


