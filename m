Return-Path: <linux-kernel+bounces-11974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A2581EE63
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0E11F21136
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECA2446B0;
	Wed, 27 Dec 2023 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNFg7DyU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306FE44398;
	Wed, 27 Dec 2023 11:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16964C433CC;
	Wed, 27 Dec 2023 11:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703674849;
	bh=knNjm5GTWZxbTLw8nktRbNFhNLFF444JFPC5ORd7bP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RNFg7DyUpVUDS3oh6nSwaqwYiuRtUNX0gDiR74j4C0W+zIOMEWwwxR3R/B9XCPbMX
	 E62s9fYn9XCT8TUSSKKmxZhOU1C//8zQfWCcX4/bq7fMirdZ2N3wkzQCtdBS9g8tff
	 4dfJTv2YA1YmCEvmhm8cwkTid7l+zIq8qlSy1RBpzviIAQI5Av6HUAoHVFAX6ypEed
	 EBO25ITr/NJZofi92g7pifxf4uFkmiXRIn7Udh09RUsu2QOOM+wCT6sn9Yvtbgj7fD
	 erPrl/GZjA023uZF9Q+xZSpWorOIU43Cp/7ABT38PhtGFnZibIU+Vu8/Yc+YG8bRUc
	 6EpPt/KU01Zew==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Fang Xiang <fangxiang3@xiaomi.com>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH v4 1/3] ACPICA: MADT: Add GICC online capable bit handling
Date: Wed, 27 Dec 2023 12:00:36 +0100
Message-Id: <20231227110038.55453-2-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227110038.55453-1-lpieralisi@kernel.org>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20231227110038.55453-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPICA commit 16f0befdeddf25756f317907798192bbaa417e5e

Implement code to handle the GICC online capable bit management
added into ACPI v6.5.

Link: https://github.com/acpica/acpica/commit/16f0befd
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Robert Moore <robert.moore@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 3751ae69432f..2b4dd2c3348f 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1046,6 +1046,7 @@ struct acpi_madt_generic_interrupt {
 /* ACPI_MADT_ENABLED                    (1)      Processor is usable if set */
 #define ACPI_MADT_PERFORMANCE_IRQ_MODE  (1<<1)	/* 01: Performance Interrupt Mode */
 #define ACPI_MADT_VGIC_IRQ_MODE         (1<<2)	/* 02: VGIC Maintenance Interrupt mode */
+#define ACPI_MADT_GICC_ONLINE_CAPABLE   (1<<3)	/* 03: Processor is online capable  */
 
 /* 12: Generic Distributor (ACPI 5.0 + ACPI 6.0 changes) */
 
-- 
2.34.1


