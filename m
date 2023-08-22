Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C485B783F77
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbjHVLhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbjHVLhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:37:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821F710C9;
        Tue, 22 Aug 2023 04:37:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8E1263EF3;
        Tue, 22 Aug 2023 11:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EE7C433CB;
        Tue, 22 Aug 2023 11:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692704186;
        bh=BUn+ZG7l7mvWNRrnhgObu6L6qmyW5XyOD9l/p3KAUn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ai4z5zHWUuVZdD1iwgV1n562Uh0KSaZwt5q39InwE+WxYPcTWpHTTWxuJ0zTuCeX8
         lqfiZi5zskrE6HOb3TcdN4vxUkObzPIoTB0krokcCUxbmejuu05Wk+GcLiyaNOjz6j
         2xc598akMGhvBB1B4NOy0GAvmfA3L6XH/1ImFcSoZ+KOzLuWmQPwhap91gxA1Dx1Ev
         PWyae0Se13K2o1C3XIoCBJCag3niQNXnjbzz/5yx58YcH1BsWvOc8HfSto5wsXnWIS
         xlujIAjDAlygcFATtXjkUX/yDi+UDkvJXUdRIz+I+Qa6zr0AlvBG915TgbQLjlwC2H
         wJACVx52eZllg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        Sasha Levin <sashal@kernel.org>, Xinhui.Pan@amd.com,
        airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.4 11/11] drm/amdkfd: disable IOMMUv2 support for Raven
Date:   Tue, 22 Aug 2023 07:35:53 -0400
Message-Id: <20230822113553.3551206-11-sashal@kernel.org>
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

[ Upstream commit 091ae5473f96ced844af6ba39b94757359b12348 ]

Use the dGPU path instead.  There were a lot of platform
issues with IOMMU in general on these chips due to windows
not enabling IOMMU at the time.  The dGPU path has been
used for a long time with newer APUs and works fine.  This
also paves the way to simplify the driver significantly.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Tested-by: Mike Lothian <mike@fireburn.co.uk>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 9c8197573dee7..224e057d2dbbf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -185,11 +185,6 @@ static void kfd_device_info_init(struct kfd_dev *kfd,
 
 		kfd_device_info_set_event_interrupt_class(kfd);
 
-		/* Raven */
-		if (gc_version == IP_VERSION(9, 1, 0) ||
-		    gc_version == IP_VERSION(9, 2, 2))
-			kfd->device_info.needs_iommu_device = true;
-
 		if (gc_version < IP_VERSION(11, 0, 0)) {
 			/* Navi2x+, Navi1x+ */
 			if (gc_version == IP_VERSION(10, 3, 6))
@@ -283,7 +278,6 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			gfx_target_version = 90000;
 			f2g = &gfx_v9_kfd2kgd;
 			break;
-#ifdef KFD_SUPPORT_IOMMU_V2
 		/* Raven */
 		case IP_VERSION(9, 1, 0):
 		case IP_VERSION(9, 2, 2):
@@ -291,7 +285,6 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			if (!vf)
 				f2g = &gfx_v9_kfd2kgd;
 			break;
-#endif
 		/* Vega12 */
 		case IP_VERSION(9, 2, 1):
 			gfx_target_version = 90004;
-- 
2.40.1

