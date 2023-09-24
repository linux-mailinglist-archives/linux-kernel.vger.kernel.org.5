Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04477AC89F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjIXNSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjIXNS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:18:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6BE1729;
        Sun, 24 Sep 2023 06:17:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15355C433C9;
        Sun, 24 Sep 2023 13:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561438;
        bh=AkESHVaIEK/Q0N156xWN9b9wJHZIeDxy8gc9Dgudzoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DfeKXIX/TxbigZcVVBWGNMuiOjc1bScZaEOW+u3v1vEJ+WSiJFArA7Id95QrSIeHL
         lzzNqrJNUv3eN7skJQJW657B3qcMolg8Ao4gU7mmiJMfsWHwbo7619cRPNLQQzRs68
         DROWe8PzQs9o6vbf13j396Rc8fnV/3jkYB1Vqkq8w8Yjzxm/mitX1oQyruGQzJvvcR
         GEbbS55vErLG3gz7VnzFthx0HvqIpKrb0GnkynbS3Cjy3JkuApRauLoFm7XoaJ/mK2
         iMF6s3LmKt1voHnWQ7eno6gEPXRjrpOqaYq45X7Lgn/JuAXtgzFGwPtl/mfFCSAC4D
         FBOujhyhiiA3g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Timmy Tsai <timmtsai@amd.com>, Sasha Levin <sashal@kernel.org>,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, mario.limonciello@amd.com, candice.li@amd.com,
        Hawking.Zhang@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.5 30/41] drm/amdgpu/nbio4.3: set proper rmmio_remap.reg_offset for SR-IOV
Date:   Sun, 24 Sep 2023 09:15:18 -0400
Message-Id: <20230924131529.1275335-30-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131529.1275335-1-sashal@kernel.org>
References: <20230924131529.1275335-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.5
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

[ Upstream commit ab43213e7afd08ac68d4282060bacf309e70fd14 ]

Needed for HDP flush to work correctly.

Reviewed-by: Timmy Tsai <timmtsai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
index d5ed9e0e1a5f1..e5b5b0f4940f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
@@ -345,6 +345,9 @@ static void nbio_v4_3_init_registers(struct amdgpu_device *adev)
 		data &= ~RCC_DEV0_EPF2_STRAP2__STRAP_NO_SOFT_RESET_DEV0_F2_MASK;
 		WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP2, data);
 	}
+	if (amdgpu_sriov_vf(adev))
+		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
+			regBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 }
 
 static u32 nbio_v4_3_get_rom_offset(struct amdgpu_device *adev)
-- 
2.40.1

