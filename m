Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E33A781D4B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 11:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjHTJ4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 05:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjHTJ4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 05:56:45 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1A0173E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 02:51:46 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id Xf5hqwKJwP8tnXf60q04iy; Sun, 20 Aug 2023 11:51:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1692525104;
        bh=GmGlyOuKr3DOh7EliZTmHtbJNAFzwthK3MIWxCPwYFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GD0ZWR9hTLrOkiw94GYsIjasnjD3BFeoabsOm43fC8opZyEe5XF4ueJ64eUe3WzKo
         StJOy8WhsIw+uKrXvawJFt7p+KUyIQl8y89LSSfDivbSrT/raG6jf2djzQWxXTyPQv
         ic8Euz+eVSIWbUvBgBpG7hZfhuX8QALQzCzAJDhN1wNT89gWOC8vVGjTIHgtH5DmFN
         tUl7HwTqt1FmN0/neMNbp0D92faBqP+cMY2oW8v2YD7+rz72/EhhBWf+1llrVHe5p9
         xu0aFjJQuNuj3OCDDcWFmznxi42Sx8lszkNEQzT2f+tcSwC0VEfZ1Doo0ATNM7HcmZ
         stovTdiCg1ftw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 20 Aug 2023 11:51:44 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Felix.Kuehling@amd.com, Arunpravin.PaneerSelvam@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 4/4] drm/amdgpu: Use kvzalloc() to simplify code
Date:   Sun, 20 Aug 2023 11:51:16 +0200
Message-Id: <349dde45fa2596bb218b29166931c6a38e4b9bde.1692524665.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1692524665.git.christophe.jaillet@wanadoo.fr>
References: <cover.1692524665.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvzalloc() can be used instead of kvmalloc() + memset() + explicit NULL
assignments.

It is less verbose and more future proof.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 6ea9ff22c281..6f5b641b631e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -78,17 +78,13 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
 	unsigned i;
 	int r;
 
-	list = kvmalloc(struct_size(list, entries, num_entries), GFP_KERNEL);
+	list = kvzalloc(struct_size(list, entries, num_entries), GFP_KERNEL);
 	if (!list)
 		return -ENOMEM;
 
 	kref_init(&list->refcount);
-	list->gds_obj = NULL;
-	list->gws_obj = NULL;
-	list->oa_obj = NULL;
 
 	array = list->entries;
-	memset(array, 0, num_entries * sizeof(struct amdgpu_bo_list_entry));
 
 	for (i = 0; i < num_entries; ++i) {
 		struct amdgpu_bo_list_entry *entry;
-- 
2.34.1

