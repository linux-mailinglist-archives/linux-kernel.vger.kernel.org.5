Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A357AC8AC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjIXNTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjIXNSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:18:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F3ECC4;
        Sun, 24 Sep 2023 06:17:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A27C433C7;
        Sun, 24 Sep 2023 13:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561449;
        bh=lDq3UOUQY7o7x5pbXoiRH92AFPhE0J/Qm0xphQ23lAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jGnDGb/RIH4JhRL5JIVpeS/Q2akPYQ3LsAW8joAsbFsSM6QQKILmCqf9WMGOMa4RA
         qPoTfks+4TCFXbRaOeIN4ee7XmlWhJtOx7AzU4sycWZfUOXuOFFsmi3F0/YdEudtIg
         +B6WmJEPwsJqaBua9KWc21qIFWx2hSfCeD2vzsMsGQ2h014Xeewe8QUOb3W1mMHDiv
         HM7usWlXckM0Hm5KffVIOuOfIQKlM282lHEAThoz7eMypdBdmpKm3EuR4gdbyRQuXt
         NuC1BZ91eH8PgRA7yBlDaXaGRRAtxMUMArmEy39VxM+25WyjUABeEcEav/NKu7IE/N
         29lz6IIFAcYmA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Francis <David.Francis@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Felix.Kuehling@amd.com, guchun.chen@amd.com, Graham.Sider@amd.com,
        James.Zhu@amd.com, evan.quan@amd.com, marek.olsak@amd.com,
        srinivasan.shanmugam@amd.com, Lang.Yu@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.5 33/41] drm/amdgpu: Handle null atom context in VBIOS info ioctl
Date:   Sun, 24 Sep 2023 09:15:21 -0400
Message-Id: <20230924131529.1275335-33-sashal@kernel.org>
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

From: David Francis <David.Francis@amd.com>

[ Upstream commit 5e7e82254270c8cf8b107451c5de01cee2f135ae ]

On some APU systems, there is no atom context and so the
atom_context struct is null.

Add a check to the VBIOS_INFO branch of amdgpu_info_ioctl
to handle this case, returning all zeroes.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: David Francis <David.Francis@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index f678bdd5f353d..b9fc7e2db5e59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -940,12 +940,17 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			struct atom_context *atom_context;
 
 			atom_context = adev->mode_info.atom_context;
-			memcpy(vbios_info.name, atom_context->name, sizeof(atom_context->name));
-			memcpy(vbios_info.vbios_pn, atom_context->vbios_pn, sizeof(atom_context->vbios_pn));
-			vbios_info.version = atom_context->version;
-			memcpy(vbios_info.vbios_ver_str, atom_context->vbios_ver_str,
-						sizeof(atom_context->vbios_ver_str));
-			memcpy(vbios_info.date, atom_context->date, sizeof(atom_context->date));
+			if (atom_context) {
+				memcpy(vbios_info.name, atom_context->name,
+				       sizeof(atom_context->name));
+				memcpy(vbios_info.vbios_pn, atom_context->vbios_pn,
+				       sizeof(atom_context->vbios_pn));
+				vbios_info.version = atom_context->version;
+				memcpy(vbios_info.vbios_ver_str, atom_context->vbios_ver_str,
+				       sizeof(atom_context->vbios_ver_str));
+				memcpy(vbios_info.date, atom_context->date,
+				       sizeof(atom_context->date));
+			}
 
 			return copy_to_user(out, &vbios_info,
 						min((size_t)size, sizeof(vbios_info))) ? -EFAULT : 0;
-- 
2.40.1

