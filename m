Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57E77AC9E4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjIXN6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjIXN6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:58:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A654216;
        Sun, 24 Sep 2023 06:19:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82FEC433C8;
        Sun, 24 Sep 2023 13:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561571;
        bh=b67eFkGG4FA5qQvRlrX364tY9dG3aYyLchXpY55B+QM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FfWjLrjBUtrjGCepkiW4SpOoEJDnusyds8n/QZyffs+AKPAnF+BF0e4SN5+GF1Msm
         rD2ate45Ju+dCoEAnsZJZ46oTMtr2DLHXpz12p1jxWCkRNbDqlcDGY4OzUzx5Xap/9
         SDY7dIYJu+9oF+9a+P6+4cMcklrVum/OPgK4jCdnzDAXiFR8wQuEQGQ54ckxkCDDZf
         D1KfFw8uynygkn4FnkLN6DgwqByhV0hGtmWm+x4tspt5uowH20Xs6Z3aqLrJXXI/lM
         p6W/BOSPiUYPBEU9mpDTomnQuI/QJsay9dDZstCgv604gBXennvHavdq9txkARInlc
         57AmV2f4+Liqg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Francis <David.Francis@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Felix.Kuehling@amd.com, guchun.chen@amd.com, James.Zhu@amd.com,
        evan.quan@amd.com, marek.olsak@amd.com, Graham.Sider@amd.com,
        srinivasan.shanmugam@amd.com, Lang.Yu@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 14/18] drm/amdgpu: Handle null atom context in VBIOS info ioctl
Date:   Sun, 24 Sep 2023 09:18:51 -0400
Message-Id: <20230924131857.1276330-14-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131857.1276330-1-sashal@kernel.org>
References: <20230924131857.1276330-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.133
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
index e8485b1f02ed6..70d49b998ee9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -926,12 +926,17 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
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

