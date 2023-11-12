Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C547E90D3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 14:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjKLNbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 08:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjKLNam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 08:30:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEED55A7;
        Sun, 12 Nov 2023 05:29:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204B4C433C8;
        Sun, 12 Nov 2023 13:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699795750;
        bh=FOqA2q9hhC9QlW/0kTIsL1+ZrJz1HAhBPkHYU8qG0fk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f25zoUMV/SnY2HLFOFeyBigkbwAzbdevtqWcB/VDAWZsZwYQtFjZ7PLe0f0bQV/ZJ
         XXHDphXrCRgmZc7l0AFsnipn677pqzw667/mzZCIT4FxjsdvCo20slBF5QXXJSI0TL
         fylBiNiAW1tZ5CK74MuC7uCqFUm6bbzrcoenPalZTlExfYS1ryBuz6qbscArW+hg6o
         aKi9HoVpnq5E3hrQVWra59+t4BSLPrP3R/dSB2LXdOTSanD/uCemQqOFxL1xlXC7Qe
         SX9aN8rdCEdQArQPWhv/pfI0vUSrN8MLtIkg9jwyicdhK131usHGtoYsmGkslJMLaf
         kAdC6kvMGXx7A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sasha Levin <sashal@kernel.org>, airlied@linux.ie,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 5/6] drm/amd: Fix UBSAN array-index-out-of-bounds for Powerplay headers
Date:   Sun, 12 Nov 2023 08:28:59 -0500
Message-ID: <20231112132902.176672-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231112132902.176672-1-sashal@kernel.org>
References: <20231112132902.176672-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.260
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 49afe91370b86566857a3c2c39612cf098110885 ]

For pptable structs that use flexible array sizes, use flexible arrays.

Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2039926
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/powerplay/hwmgr/pptable_v1_0.h    |  4 ++--
 .../drm/amd/powerplay/hwmgr/vega10_pptable.h  | 24 +++++++++----------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h b/drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h
index 1e870f58dd12a..8f6ecbbfa5738 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h
@@ -337,7 +337,7 @@ typedef struct _ATOM_Tonga_VCE_State_Record {
 typedef struct _ATOM_Tonga_VCE_State_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries;
-	ATOM_Tonga_VCE_State_Record entries[1];
+	ATOM_Tonga_VCE_State_Record entries[];
 } ATOM_Tonga_VCE_State_Table;
 
 typedef struct _ATOM_Tonga_PowerTune_Table {
@@ -416,7 +416,7 @@ typedef struct _ATOM_Tonga_Hard_Limit_Record {
 typedef struct _ATOM_Tonga_Hard_Limit_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries;
-	ATOM_Tonga_Hard_Limit_Record entries[1];
+	ATOM_Tonga_Hard_Limit_Record entries[];
 } ATOM_Tonga_Hard_Limit_Table;
 
 typedef struct _ATOM_Tonga_GPIO_Table {
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_pptable.h b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_pptable.h
index c934e9612c1b5..794889917ea1b 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_pptable.h
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_pptable.h
@@ -129,7 +129,7 @@ typedef struct _ATOM_Vega10_State {
 typedef struct _ATOM_Vega10_State_Array {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries;                                         /* Number of entries. */
-	ATOM_Vega10_State states[1];                             /* Dynamically allocate entries. */
+	ATOM_Vega10_State states[];                             /* Dynamically allocate entries. */
 } ATOM_Vega10_State_Array;
 
 typedef struct _ATOM_Vega10_CLK_Dependency_Record {
@@ -169,37 +169,37 @@ typedef struct _ATOM_Vega10_GFXCLK_Dependency_Table {
 typedef struct _ATOM_Vega10_MCLK_Dependency_Table {
     UCHAR ucRevId;
     UCHAR ucNumEntries;                                         /* Number of entries. */
-    ATOM_Vega10_MCLK_Dependency_Record entries[1];            /* Dynamically allocate entries. */
+    ATOM_Vega10_MCLK_Dependency_Record entries[];            /* Dynamically allocate entries. */
 } ATOM_Vega10_MCLK_Dependency_Table;
 
 typedef struct _ATOM_Vega10_SOCCLK_Dependency_Table {
     UCHAR ucRevId;
     UCHAR ucNumEntries;                                         /* Number of entries. */
-    ATOM_Vega10_CLK_Dependency_Record entries[1];            /* Dynamically allocate entries. */
+    ATOM_Vega10_CLK_Dependency_Record entries[];            /* Dynamically allocate entries. */
 } ATOM_Vega10_SOCCLK_Dependency_Table;
 
 typedef struct _ATOM_Vega10_DCEFCLK_Dependency_Table {
     UCHAR ucRevId;
     UCHAR ucNumEntries;                                         /* Number of entries. */
-    ATOM_Vega10_CLK_Dependency_Record entries[1];            /* Dynamically allocate entries. */
+    ATOM_Vega10_CLK_Dependency_Record entries[];            /* Dynamically allocate entries. */
 } ATOM_Vega10_DCEFCLK_Dependency_Table;
 
 typedef struct _ATOM_Vega10_PIXCLK_Dependency_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries;                                         /* Number of entries. */
-	ATOM_Vega10_CLK_Dependency_Record entries[1];            /* Dynamically allocate entries. */
+	ATOM_Vega10_CLK_Dependency_Record entries[];            /* Dynamically allocate entries. */
 } ATOM_Vega10_PIXCLK_Dependency_Table;
 
 typedef struct _ATOM_Vega10_DISPCLK_Dependency_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries;                                         /* Number of entries.*/
-	ATOM_Vega10_CLK_Dependency_Record entries[1];            /* Dynamically allocate entries. */
+	ATOM_Vega10_CLK_Dependency_Record entries[];            /* Dynamically allocate entries. */
 } ATOM_Vega10_DISPCLK_Dependency_Table;
 
 typedef struct _ATOM_Vega10_PHYCLK_Dependency_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries;                                         /* Number of entries. */
-	ATOM_Vega10_CLK_Dependency_Record entries[1];            /* Dynamically allocate entries. */
+	ATOM_Vega10_CLK_Dependency_Record entries[];            /* Dynamically allocate entries. */
 } ATOM_Vega10_PHYCLK_Dependency_Table;
 
 typedef struct _ATOM_Vega10_MM_Dependency_Record {
@@ -213,7 +213,7 @@ typedef struct _ATOM_Vega10_MM_Dependency_Record {
 typedef struct _ATOM_Vega10_MM_Dependency_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries;                                         /* Number of entries */
-	ATOM_Vega10_MM_Dependency_Record entries[1];             /* Dynamically allocate entries */
+	ATOM_Vega10_MM_Dependency_Record entries[];             /* Dynamically allocate entries */
 } ATOM_Vega10_MM_Dependency_Table;
 
 typedef struct _ATOM_Vega10_PCIE_Record {
@@ -225,7 +225,7 @@ typedef struct _ATOM_Vega10_PCIE_Record {
 typedef struct _ATOM_Vega10_PCIE_Table {
 	UCHAR  ucRevId;
 	UCHAR  ucNumEntries;                                        /* Number of entries */
-	ATOM_Vega10_PCIE_Record entries[1];                      /* Dynamically allocate entries. */
+	ATOM_Vega10_PCIE_Record entries[];                      /* Dynamically allocate entries. */
 } ATOM_Vega10_PCIE_Table;
 
 typedef struct _ATOM_Vega10_Voltage_Lookup_Record {
@@ -235,7 +235,7 @@ typedef struct _ATOM_Vega10_Voltage_Lookup_Record {
 typedef struct _ATOM_Vega10_Voltage_Lookup_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries;                                          /* Number of entries */
-	ATOM_Vega10_Voltage_Lookup_Record entries[1];             /* Dynamically allocate entries */
+	ATOM_Vega10_Voltage_Lookup_Record entries[];             /* Dynamically allocate entries */
 } ATOM_Vega10_Voltage_Lookup_Table;
 
 typedef struct _ATOM_Vega10_Fan_Table {
@@ -329,7 +329,7 @@ typedef struct _ATOM_Vega10_VCE_State_Table
 {
     UCHAR ucRevId;
     UCHAR ucNumEntries;
-    ATOM_Vega10_VCE_State_Record entries[1];
+    ATOM_Vega10_VCE_State_Record entries[];
 } ATOM_Vega10_VCE_State_Table;
 
 typedef struct _ATOM_Vega10_PowerTune_Table {
@@ -432,7 +432,7 @@ typedef struct _ATOM_Vega10_Hard_Limit_Table
 {
     UCHAR ucRevId;
     UCHAR ucNumEntries;
-    ATOM_Vega10_Hard_Limit_Record entries[1];
+    ATOM_Vega10_Hard_Limit_Record entries[];
 } ATOM_Vega10_Hard_Limit_Table;
 
 typedef struct _Vega10_PPTable_Generic_SubTable_Header
-- 
2.42.0

