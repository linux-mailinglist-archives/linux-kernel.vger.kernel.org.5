Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FFD7E3F13
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343623AbjKGMrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbjKGMqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:46:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42F9269F;
        Tue,  7 Nov 2023 04:32:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254EAC433C8;
        Tue,  7 Nov 2023 12:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699360379;
        bh=KFrcW7rSCLWEXHGT0w+7HNBPfb870+6DeZ6CpF3nhyM=;
        h=From:To:Cc:Subject:Date:From;
        b=Blt486LZCd68eVMFRPWmou29ErzFPwNcFg1rOVxn5Z4kwFqira+IAbDRbTzOPD7Ik
         9BCAZdIttgDFWpjlNGIVFTlZpMCuJ+gBKusqW0FdwGuMEVgCsP90z8gVGms5eHxnim
         /rEcC2fEgCoa/V7jqrJbZb9J/2k0Ye24uPwMcO+5vMRFlYdRa50Kt+yWSmN5jhBkjx
         wfpKtxQ2Bh9WeDX94I4AJfKeXY6czWtHVmJ7s+q7vMgS0nw4KcXk5L95O8Yaftzr5A
         Y4VmoYNsq7r/cD6TtPLZ+gHeGz3W5qNfK1xE5Wl6W6DwDf1vJzJGlKoNTaXBRf1rEd
         REl4J0EzdE7CQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Felix Held <felix.held@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 1/4] drm/amd: Fix UBSAN array-index-out-of-bounds for SMU7
Date:   Tue,  7 Nov 2023 07:32:38 -0500
Message-ID: <20231107123256.3763357-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.328
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 760efbca74a405dc439a013a5efaa9fadc95a8c3 ]

For pptable structs that use flexible array sizes, use flexible arrays.

Suggested-by: Felix Held <felix.held@amd.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2874
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/include/pptable.h              | 4 ++--
 drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/pptable.h b/drivers/gpu/drm/amd/include/pptable.h
index 0b6a057e0a4c4..5aac8d545bdc6 100644
--- a/drivers/gpu/drm/amd/include/pptable.h
+++ b/drivers/gpu/drm/amd/include/pptable.h
@@ -78,7 +78,7 @@ typedef struct _ATOM_PPLIB_THERMALCONTROLLER
 typedef struct _ATOM_PPLIB_STATE
 {
     UCHAR ucNonClockStateIndex;
-    UCHAR ucClockStateIndices[1]; // variable-sized
+    UCHAR ucClockStateIndices[]; // variable-sized
 } ATOM_PPLIB_STATE;
 
 
@@ -473,7 +473,7 @@ typedef struct _ATOM_PPLIB_STATE_V2
       /**
       * Driver will read the first ucNumDPMLevels in this array
       */
-      UCHAR clockInfoIndex[1];
+      UCHAR clockInfoIndex[];
 } ATOM_PPLIB_STATE_V2;
 
 typedef struct _StateArray{
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h b/drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h
index 1e870f58dd12a..d5a4a08c6d392 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h
@@ -179,7 +179,7 @@ typedef struct _ATOM_Tonga_MCLK_Dependency_Record {
 typedef struct _ATOM_Tonga_MCLK_Dependency_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries; 										/* Number of entries. */
-	ATOM_Tonga_MCLK_Dependency_Record entries[1];				/* Dynamically allocate entries. */
+	ATOM_Tonga_MCLK_Dependency_Record entries[];				/* Dynamically allocate entries. */
 } ATOM_Tonga_MCLK_Dependency_Table;
 
 typedef struct _ATOM_Tonga_SCLK_Dependency_Record {
@@ -194,7 +194,7 @@ typedef struct _ATOM_Tonga_SCLK_Dependency_Record {
 typedef struct _ATOM_Tonga_SCLK_Dependency_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries; 										/* Number of entries. */
-	ATOM_Tonga_SCLK_Dependency_Record entries[1];				 /* Dynamically allocate entries. */
+	ATOM_Tonga_SCLK_Dependency_Record entries[];				 /* Dynamically allocate entries. */
 } ATOM_Tonga_SCLK_Dependency_Table;
 
 typedef struct _ATOM_Polaris_SCLK_Dependency_Record {
-- 
2.42.0

