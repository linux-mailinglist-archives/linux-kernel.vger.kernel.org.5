Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D997DAF60
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 23:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjJ2W7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 18:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjJ2W7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 18:59:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAEC30E0;
        Sun, 29 Oct 2023 15:56:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235FFC433A9;
        Sun, 29 Oct 2023 22:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620173;
        bh=001YAmpLETxjsM9j7Vvl/WXpAl9mBPA1mEwrmF4EQAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eUSo1chgV/1QwDOuL4lMJw0aflRcbefarg4mIaCrhSmLID1NRw3ckUR8xzKXHR41J
         CAifWLXlcN0YsaPP/skQ6FwqSNlV7HAQDrX3CDEAofypDxO2/GtkSD/RU1CYJuvFMu
         N+1xaKhLM8SeZeuFHrm2s2QH1qE5VlpP2TN9lM8/Qq5Mqc8JwXv12ZfVlbbZ6TNNal
         bmM4KR1p8uCgYMDyQE2mn2esmTSfh2usIGWnpfvBgibLURFEtuh2miB0EbccacC16o
         tJg4te9cenjWUCzofVy78Apd5VbFo1DAeBwdN7SJO/C2oPYz7vKylCE3fheeZRLq9s
         v8K/SgMlXjW4Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Luben Tuikov <luben.tuikov@amd.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sasha Levin <sashal@kernel.org>, alexander.deucher@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        James.Zhu@amd.com, lijo.lazar@amd.com,
        pierre-eric.pelloux-prayer@amd.com, zhenguo.yin@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.5 38/52] drm/amdgpu: Unset context priority is now invalid
Date:   Sun, 29 Oct 2023 18:53:25 -0400
Message-ID: <20231029225441.789781-38-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luben Tuikov <luben.tuikov@amd.com>

[ Upstream commit eab0261967aeab528db4d0a51806df8209aec179 ]

A context priority value of AMD_CTX_PRIORITY_UNSET is now invalid--instead of
carrying it around and passing it to the Direct Rendering Manager--and it
becomes AMD_CTX_PRIORITY_NORMAL in amdgpu_ctx_ioctl(), the gateway to context
creation.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Alex Deucher <Alexander.Deucher@amd.com>
Link: https://lore.kernel.org/r/20231017035656.8211-1-luben.tuikov@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 0dc9c655c4fbd..092962b93064f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -47,7 +47,6 @@ const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM] = {
 bool amdgpu_ctx_priority_is_valid(int32_t ctx_prio)
 {
 	switch (ctx_prio) {
-	case AMDGPU_CTX_PRIORITY_UNSET:
 	case AMDGPU_CTX_PRIORITY_VERY_LOW:
 	case AMDGPU_CTX_PRIORITY_LOW:
 	case AMDGPU_CTX_PRIORITY_NORMAL:
@@ -55,6 +54,7 @@ bool amdgpu_ctx_priority_is_valid(int32_t ctx_prio)
 	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
 		return true;
 	default:
+	case AMDGPU_CTX_PRIORITY_UNSET:
 		return false;
 	}
 }
-- 
2.42.0

