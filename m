Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7977E3F01
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343805AbjKGMp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344248AbjKGMoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:44:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B98238384;
        Tue,  7 Nov 2023 04:31:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58B0C433CA;
        Tue,  7 Nov 2023 12:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699360319;
        bh=wvaUSrY3S8godRYePLky/TPd8j7ygIKj7p7gRhB3l/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MDMfjiNtsbpO+iZnYPtfVe4qHz6YR/7mxZ0qYuL7sj/1ZRjU1nfz6YA9D+CNkpa0L
         4MQrgmSnc+7S3noe7XccD0N3tvviizFOUk+1btstdk1O9HgEvYXtmDRYyU4i6e/ogG
         3+Jr3JzwqV9GgvbaHXyDnFULkDkPeSsCPVKM8V7B4ftRT2MyS8oPECugJa4qoTiBgY
         mXZ8DE09DAoRX6VN/PStXuwT6BNWlSdLTRCpWJJBGJ4CPbm0TpJ5g0eTSt9XGLtzzn
         b5zZ3BT4Gsow3ADI4jKLFmHYeFZ9ts0kjEIjBEDDCJyUF4BX+aZQX5omOstWQXzJq/
         OWQAURrvddaSg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Felix Held <felix.held@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 3/6] drm/radeon: Fix UBSAN array-index-out-of-bounds for Radeon HD 5430
Date:   Tue,  7 Nov 2023 07:31:34 -0500
Message-ID: <20231107123148.3763062-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107123148.3763062-1-sashal@kernel.org>
References: <20231107123148.3763062-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.259
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

[ Upstream commit c63079c61177ba1b17fa05c6875699a36924fe39 ]

For pptable structs that use flexible array sizes, use flexible arrays.

Suggested-by: Felix Held <felix.held@amd.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2894
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/pptable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/pptable.h b/drivers/gpu/drm/radeon/pptable.h
index 4c2eec49dadc9..94947229888ba 100644
--- a/drivers/gpu/drm/radeon/pptable.h
+++ b/drivers/gpu/drm/radeon/pptable.h
@@ -74,7 +74,7 @@ typedef struct _ATOM_PPLIB_THERMALCONTROLLER
 typedef struct _ATOM_PPLIB_STATE
 {
     UCHAR ucNonClockStateIndex;
-    UCHAR ucClockStateIndices[1]; // variable-sized
+    UCHAR ucClockStateIndices[]; // variable-sized
 } ATOM_PPLIB_STATE;
 
 
-- 
2.42.0

