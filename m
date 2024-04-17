Return-Path: <linux-kernel+bounces-148345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687FC8A8139
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E9A281616
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BDC13C689;
	Wed, 17 Apr 2024 10:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="iSrq7iBg"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5126F13C67C;
	Wed, 17 Apr 2024 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713350570; cv=none; b=gDq8cWbDxPUZ6C6Qf+TnEKZz9+MKyPZE2MWqN/MFCU04XP4rcSGVnT0A1E4yetG1KkeKl9hPwvnerjParjTF2tCcQYI9zXhZ8Dfb4yjYR7GHW81ILb5h3aw84dEBf9TsK4OBuqKwSaQ5fe7/SLnkWnNffOlACPqJeMd/3LVGW90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713350570; c=relaxed/simple;
	bh=IrBuKUIq8kqO1Ly/fgTiZaO7HGYVB5Ybpch6CI1Yp4o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WSY6vhF3erzijcOd6sN7FnjF9um1YJta0dhE+gM6XFn1816xnt5hmUGPdhRZXQqzGrdl2oOCBVxtMx8nsHpHzl/R1hAmLujedPOKzTBcT7l/CJPjMeIChlf+whz3Z/CpP7U8PCauG2JdFKHqpniNON8ldoOyyvOCabDI34gEW2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=iSrq7iBg; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse.fritz.box (p5de45f24.dip0.t-ipconnect.de [93.228.95.36])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 73FE02FC005F;
	Wed, 17 Apr 2024 12:35:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1713350118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wCA6Haldgtd/UpE1DE6VbdPB++vH0tcbzN1r/TmSyfU=;
	b=iSrq7iBgz0uRl3OBas4+UCDM6oF1yo4Dn0PqQP7HT9+HGvA0qDEE5ZmMbfUiW0G4scRYqg
	h3FfGQpK3ZVBAFe74sYoOZ3xvulllVHKiXfY0Z17nQB1Qif8tt23BjJJ3QLtqlltWtmXse
	9G7i/55mYsEevcb14znKrl5kPB2EwcA=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: Christoffer Sandberg <cs@tuxedo.de>,
	Werner Sembach <wse@tuxedocomputers.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: resource: Do IRQ override on TongFang GXxHRXx and GMxHGxx
Date: Wed, 17 Apr 2024 12:35:09 +0200
Message-Id: <20240417103509.28657-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoffer Sandberg <cs@tuxedo.de>

Listed devices needs the override for keyboard to work.

Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org
---
 drivers/acpi/resource.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 59423fe9d0f29..deeb4e182687a 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -558,6 +558,18 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GM6XGxX"),
 		},
 	},
+	{
+		.ident = "TongFang GXxHRXx/TUXEDO InfinityBook Pro Gen9 AMD",
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_SKU, "GXxHRXx"),
+		},
+	},
+	{
+		.ident = "TongFang GMxHGxx/TUXEDO Stellaris Slim Gen1 AMD",
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_SKU, "GMxHGxx"),
+		},
+	},
 	{
 		/* MAINGEAR Vector Pro 2 15 */
 		.matches = {
-- 
2.34.1


