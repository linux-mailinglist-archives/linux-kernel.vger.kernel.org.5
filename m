Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A71783F4F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbjHVLgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbjHVLgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:36:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3A2E57;
        Tue, 22 Aug 2023 04:36:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47776648AA;
        Tue, 22 Aug 2023 11:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DEFC433C9;
        Tue, 22 Aug 2023 11:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692704183;
        bh=75J9/pni/vfFweNHQD5uWW1Hmst6YLx5pwNV2EOSED4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ad7FixdyXfGcfqpMK1tym9KJjRt4U3sBQrbUtVia8EZKagXb3RJkDKXTLIvv1BwU7
         3uGG4tG1ia/MWdfhNM9JurAuQpbXa4JUvoBC0c3FYebet35Ty5KoGViivMMpGwEaxP
         QlFrtSoF0zsZSVkAFv8uiF50UceWjY5JlTQ/KvNwf1hFO8qIFwLSNZfpHr5Hz+o+QC
         fheUJpvuDsNF0/GnXPfX/XDSRcZvlZGioPyhmiqeSWV27azx0xUK8s0ueUAGprW6X3
         xVCOV9aGw63Z5ykO7ZTEMpEJmRMshs9GRHOfLMPip7QHL1ul+TNGcCUraqEz/CHH6/
         S05PknCnIIfPw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        Sasha Levin <sashal@kernel.org>, Xinhui.Pan@amd.com,
        airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.4 09/11] drm/amdkfd: ignore crat by default
Date:   Tue, 22 Aug 2023 07:35:51 -0400
Message-Id: <20230822113553.3551206-9-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230822113553.3551206-1-sashal@kernel.org>
References: <20230822113553.3551206-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.11
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
index 475e470273540..ee0cc35d68a84 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1543,11 +1543,7 @@ static bool kfd_ignore_crat(void)
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

