Return-Path: <linux-kernel+bounces-152927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8418AC63E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2B6DB20E88
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EBF4E1D9;
	Mon, 22 Apr 2024 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="iMiMME7Y"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40A64D58A;
	Mon, 22 Apr 2024 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773092; cv=none; b=Zw2iAFcVvR1i/vvBH0JDovQU4gRS6KY8nQ7p9+CoShUequLb3VMIXtUlRdqCTzWerAwqXbxm/YgLq0KTQpf7GNwdWNhxEzK2ooWMvyXFhsEHwxoLhs4HYkQ0d4uD6IOnpb9Cfh3c1dZilo6pdV2CX8cUQEUTYTzcxVDiCmbdvgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773092; c=relaxed/simple;
	bh=a/y3M4tVGVqIWndAYfIScsCyXZnjjrjZfPk1B6VQkN4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MIU3d/DNrQgr8hs67zsqK/3AkcrbEqfjKJ6QGFEE4SZawnTMSHXikpI8j7me9fSQvzzH1t1bW6xHS+zaYV/Vz3XTuipXJqR2lb8yGqdEjeFYv1H4ELRqku5SlXyt178UlbXXM28DkzgZNomrQFqsOMx6iOzUeqhNgE+iRjsaKf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=iMiMME7Y; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse.fritz.box (p5de45f24.dip0.t-ipconnect.de [93.228.95.36])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 830D12FC0064;
	Mon, 22 Apr 2024 10:04:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1713773080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xzuvPTfFvcjM2uMXBfD1KTqm3P/TieXDNEGrwapikE4=;
	b=iMiMME7YXBEr1eLKoeMfeAAHzPWxFuThbCLh8j2ha8+oxJWrxE17d+RKDFKKmRBNN/QOwZ
	/IQg5S+ALKhTXp1hAyGHf7q/oondPdoMlOFjNJ92LO4PsINeLuk3bWMMXxGmaH+BFf8nUN
	lshj9/vUDU7+PWIq+YAtCIaaz86O8J8=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: Christoffer Sandberg <cs@tuxedo.de>,
	Werner Sembach <wse@tuxedocomputers.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ACPI: resource: Do IRQ override on TongFang GXxHRXx and GMxHGxx
Date: Mon, 22 Apr 2024 10:04:36 +0200
Message-Id: <20240422080437.912886-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoffer Sandberg <cs@tuxedo.de>

Listed devices need the override for the keyboard to work.

Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org
---
 drivers/acpi/resource.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 59423fe9d0f29..6cc8572759a3d 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -630,6 +630,18 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "X565"),
 		},
 	},
+	{
+		/* TongFang GXxHRXx/TUXEDO InfinityBook Pro Gen9 AMD */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GXxHRXx"),
+		},
+	},
+	{
+		/* TongFang GMxHGxx/TUXEDO Stellaris Slim Gen1 AMD */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GMxHGxx"),
+		},
+	},
 	{ }
 };
 
-- 
2.34.1


