Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D3E7ABA09
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 21:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbjIVT1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 15:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjIVT1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 15:27:38 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86317AC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 12:27:30 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id jloFqD9PsGlzojloFq0RyT; Fri, 22 Sep 2023 21:27:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1695410848;
        bh=XEqKkQdd+1AGqY7DppYqYg8hkwbZVqfTt1fDBwsytHo=;
        h=From:To:Cc:Subject:Date;
        b=tzuTLQNT2FcvHWUhvK7u8I5xvd2KA5IRJCU1xjcCBN4l14vbvTpn2YO5G3N99N/iJ
         hBcGEeW26CUo24OMz22rm7R7kHw6+L9UiNn9p1RihPMY9pIFn50z7GsjgWYTCKf8hq
         Xk2ml88ep4HJsD9wm1TI+fpSCN3ITNY6nXlOcQvmGLuQBji6qGheyUzJs25Bc9c+rP
         6a61QFX1qkWHe5OzhUMSVPdemOGVORUV8YmY6sHZrkLKy+lnBZ72S5fJe4/UxuG34e
         p6B4dixT6ScxQcx+gFHVwUxGEovC9xubtfVh4LnikubTrm4NFY/d7Plxm0r5/+1EwQ
         Jm27Pr7yM5EWQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 22 Sep 2023 21:27:28 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd: Fix the size of a buffer in amdgpu_vcn_idle_work_handler()
Date:   Fri, 22 Sep 2023 21:27:25 +0200
Message-Id: <d8a9cda0c4c391458ddd63d1be88f2a757f6a5d0.1695410820.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be sure that fw_name is not truncated, this buffer should be
at least 41 bytes long.

Let the compiler compute the correct length by itself.

When building with W=1, this fixes the following warnings:

  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c: In function ‘amdgpu_vcn_early_init’:
  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:95:58: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
     95 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
        |                                                          ^
  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:95:9: note: ‘snprintf’ output between 12 and 41 bytes into a destination of size 40
     95 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 69939009bde7 ("drm/amd: Load VCN microcode during early_init")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index c93f3a4c0e31..f8cd55a0d1f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -88,7 +88,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
 int amdgpu_vcn_early_init(struct amdgpu_device *adev)
 {
 	char ucode_prefix[30];
-	char fw_name[40];
+	char fw_name[sizeof(ucode_prefix) + sizeof("amdgpu/.bin") - 1];
 	int r;
 
 	amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
-- 
2.34.1

