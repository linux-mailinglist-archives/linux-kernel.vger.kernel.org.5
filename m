Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFFD781D46
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 11:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjHTJ4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 05:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjHTJ4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 05:56:43 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341211735
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 02:51:40 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id Xf5hqwKJwP8tnXf5uq04hi; Sun, 20 Aug 2023 11:51:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1692525099;
        bh=Rze1GZkpKnzRfLucS78BXnfSJ2SRLYcMjVrfmplMy4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=oRrRBwegpGnnVWLfiSW72uzV5MN9TE5X6I0HTMYnjLLNdSXilqvI84otb+CfcJtVh
         lOQxsCeVsBh2wnH0aGeBDWAKsoljl/a/YGvVkfCuqOrcJ0fzz5NpIhCUBqMwr8oZtD
         leQT3K6AFPXjL9h3KsyXzHZe1PFtxEPOIMxjdOS1kO3ozXJks6yuPDLv4RU+cPqJNy
         pSp5SKgfNMrjRvqbdEQMRuTjjKGASXNJVNM6n9dJ9fBomvNIzkNOoeB1tKNHjcXz7H
         cdBzNeSz+uwBkjZOZcGq9JATf75xjZIkQkrdIlkX5C+OgYVb2FPRkvZMaB4l18UdNf
         8u52WOATkrQsw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 20 Aug 2023 11:51:39 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Felix.Kuehling@amd.com, Arunpravin.PaneerSelvam@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/4] drm/amdgpu: Explicitly add a flexible array at the end of 'struct amdgpu_bo_list'
Date:   Sun, 20 Aug 2023 11:51:13 +0200
Message-Id: <247e082be64febc32a3404a9ea42acca91156ed0.1692524665.git.christophe.jaillet@wanadoo.fr>
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

'struct amdgpu_bo_list' is really used as if it was ended by a flex array.
So make it more explicit and add a 'struct amdgpu_bo_list_entry entries[]'
field at the end of the structure.

This way, struct_size() can be used when it is allocated.
It is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 5 +----
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h | 2 ++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index b6298e901cbd..571fed04eb7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -75,7 +75,6 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
 	struct amdgpu_bo_list_entry *array;
 	struct amdgpu_bo_list *list;
 	uint64_t total_size = 0;
-	size_t size;
 	unsigned i;
 	int r;
 
@@ -83,9 +82,7 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
 				/ sizeof(struct amdgpu_bo_list_entry))
 		return -EINVAL;
 
-	size = sizeof(struct amdgpu_bo_list);
-	size += num_entries * sizeof(struct amdgpu_bo_list_entry);
-	list = kvmalloc(size, GFP_KERNEL);
+	list = kvmalloc(struct_size(list, entries, num_entries), GFP_KERNEL);
 	if (!list)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
index 26c01cb131f2..368e50b30160 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
@@ -55,6 +55,8 @@ struct amdgpu_bo_list {
 	/* Protect access during command submission.
 	 */
 	struct mutex bo_list_mutex;
+
+	struct amdgpu_bo_list_entry entries[];
 };
 
 int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, int id,
-- 
2.34.1

