Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39EC783FAE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbjHVLiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbjHVLiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:38:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B3AE50;
        Tue, 22 Aug 2023 04:37:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5728653A9;
        Tue, 22 Aug 2023 11:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6E3C433C7;
        Tue, 22 Aug 2023 11:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692704245;
        bh=bLV1Oul/+3CAMawbNhlLErzDeDDRG0Wd8DXwh938PNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ETV1sBRLTyKai9YixH5AShvsKuGC3AiNj9IpBN004O/n/+oAxjjC6OKud+PKTT8q0
         0oqLBWkQW3L1KDR19XTGU4l8ea5JONFEN6AmT6wYGwfeMlrO8pn2YTNqBKI/9bp4bx
         X8Wa6f6aDEd5SRgUhOKX8GP9NpJL+Woj5C0U7wKS2quHdDehMB29Ev6L8p1kHkwTUB
         ZvKy3LSl8obljnfHiRqWFKRBCUUzsAqcljeQq4suLwjQOG/q9tWCM3FkhLuLu0WR/O
         UGHNOKlKTlaVXNFuHo32VR5pebn69Uf8SJgDA6Z7SnSM38Sl1jfsy+roT67HuscSN6
         I8TJvYcP2BGlQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        Sasha Levin <sashal@kernel.org>, Xinhui.Pan@amd.com,
        airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 3/3] drm/amdkfd: ignore crat by default
Date:   Tue, 22 Aug 2023 07:37:19 -0400
Message-Id: <20230822113719.3551639-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230822113719.3551639-1-sashal@kernel.org>
References: <20230822113719.3551639-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.191
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
index 86b4dadf772e3..61fea0d268b96 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -749,11 +749,7 @@ static bool kfd_ignore_crat(void)
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

