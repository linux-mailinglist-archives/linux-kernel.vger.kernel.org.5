Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F91E783F97
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbjHVLiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbjHVLiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:38:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53ACBE46;
        Tue, 22 Aug 2023 04:37:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4840C6539F;
        Tue, 22 Aug 2023 11:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A886C433C7;
        Tue, 22 Aug 2023 11:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692704238;
        bh=RT2yH3IRbxVwpbXO8souw3b1hiBtsDsDo2KMzcNbGls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sN7QL1NY5WHd9Gk3AV0135FVWHzU0jzjmB2yGfe/cU8pldSlYKRgXgSIi3hoaXVM9
         /ZSZ47Jz24kgRp4BBl121qJxbXmaJsDRTlxPHzthWhR/xImAv+F0xdCYH3HnXQUKrd
         yGzVCvPZzSZq4xOUrDiAmQ6CRR03EdvgjnOWKbIOkW677CjbUjqm9oI4nmlOmQctHB
         4/+/HhOh4PBIRMzdB/q3cnAS9pvEewXTE0BGTp5M6g1IiXU6jcIaXPUAbHeheWsUTB
         CUG8cZHabM45u54O6l4BXPBzlqUofKL3LdQu0UhsDg3ymxfTYm6nCVtwaoJw2oKeEB
         prTQe0kSOl4PA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        Sasha Levin <sashal@kernel.org>, Xinhui.Pan@amd.com,
        airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 6/6] drm/amdkfd: ignore crat by default
Date:   Tue, 22 Aug 2023 07:36:58 -0400
Message-Id: <20230822113658.3551550-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230822113658.3551550-1-sashal@kernel.org>
References: <20230822113658.3551550-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.127
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit a6dea2d64ff92851e68cd4e20a35f6534286e016 ]

We are dropping the IOMMUv2 path, so no need to enable this.
It's often buggy on consumer platforms anyway.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Tested-by: Mike Lothian <mike@fireburn.co.uk>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index e574aa32a111d..46dfd9baeb013 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1523,11 +1523,7 @@ static bool kfd_ignore_crat(void)
 	if (ignore_crat)
 		return true;
 
-#ifndef KFD_SUPPORT_IOMMU_V2
 	ret = true;
-#else
-	ret = false;
-#endif
 
 	return ret;
 }
-- 
2.40.1

