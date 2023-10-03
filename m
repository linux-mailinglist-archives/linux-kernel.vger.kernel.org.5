Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519747B74F2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbjJCXaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236820AbjJCXaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:30:03 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FAE11C
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:29:57 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6beff322a97so985397a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 16:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696375797; x=1696980597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sHOGbVO4yt56UuQA6X7B53h+Y2FMmkpmlA/gBYESKrU=;
        b=fA6WvqOX2yVHn25xoajqEX5lILQzqY0725LFgpkrgTzDCGDb6QZ3iUd/iQruXUZZfU
         TtWOf1ok6LXF8MQXS5DReYrspEpiNlBun8EjWCmc7ZpvxGAxqzvH9paq9sBuV8QCR7VB
         UYQxiwRKikQImpZ8f8ebEAdurnrDx7v61afXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375797; x=1696980597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sHOGbVO4yt56UuQA6X7B53h+Y2FMmkpmlA/gBYESKrU=;
        b=IZ4x0CUGDClUq+aKJaTq20SItcB6fnL8/yeTzE1ZEDkWM5rBjXIiBwtVH2kqcqVoeC
         gNsKJjkniUjnae9RJAxgunkeCb863GHARu/rYDc/peqBvF8Iwkcw2rjVm/la3+BHVPbB
         ycuwsQAUrJ4DzhECI6IKFcTzH5q0GLnrXvTPnX3GpkJE9i82sFNBa6Z/hUoGD3xrLn1u
         ZAsAMhAjGmvGU7W2Tnd9rS6rRTPaBAVLpWNmkiH3P9jd4zf/Ps7wemAdFHjEuBUAYSxT
         2+ABq7wQ0BGXFTDYKBPqTwFvzdbbwTT98cxoKn1VXIbM5P+XoNLRygkIQg7hZHjqnJI4
         rCvg==
X-Gm-Message-State: AOJu0YzW4EHEycE9BMQLOnZ8X9P+oddb3PpHf97uLV3nTRwdAFXNcOzv
        LG8moYrkfhrECDfbQ4TpxIHxcQ==
X-Google-Smtp-Source: AGHT+IE5Y1aTeSmZultlmhH08sL/6gXNiFbzPXi0v1PX93a6hQ7va5s5hktVz94Kc3mdmWYw273bWw==
X-Received: by 2002:a05:6358:3182:b0:143:1063:d1eb with SMTP id q2-20020a056358318200b001431063d1ebmr1010070rwd.17.1696375796777;
        Tue, 03 Oct 2023 16:29:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z20-20020a17090a8b9400b0026d54b2abe9sm134489pjn.37.2023.10.03.16.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:29:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] drm/amdgpu: Annotate struct amdgpu_bo_list with __counted_by
Date:   Tue,  3 Oct 2023 16:29:52 -0700
Message-Id: <20231003232952.work.158-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2647; i=keescook@chromium.org;
 h=from:subject:message-id; bh=1v/oxBN7ZqO28+dM0oWFTdo9vpsVEGznhHHT3hTYF8I=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHKPwyIdWSWld6J97atG9hIxpNtU0Dh7/kol1x
 NGYcBbZXXGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRyj8AAKCRCJcvTf3G3A
 JgEqEACpA4yYWb2KVzTOCIfwm8hujCVTSJPb/hR3KANtcMNWX25mFUB8inrRxZWNTJKlqnLkDzN
 VGPP1FbsCXD2NkpMv9Mi5rqHxnIYI4dPDjXghdQZo5wwWSmTJ0gDxcvYlhF68WAUuSdvzAYcuRR
 Ua+upzrG0Zxau1z8VFtdASoWxhl6W5HCuBWKVJzL8coLB2q2sxHBtdJC9utqgikQ+n0LXYRG5/V
 aIQWGc1WjEYexxVOe0SI0nqCGbvf/eSyWa7NM5pbGLR1oVDB4ThDda1/F+wHQ/qmoam8kolP2AJ
 oif+XR3OH8/MLa0+Kb/eK+eJEclZP7gav8nxBSgsB0gjyvfBjmVd5mIPJGIteGyclUcZWQVeb0l
 Kv+i+yrEZgNkEfh8Gflfov5ubL79ZXskKLGfkaJmMBAIm9kvZBbvzIrIzGxI9tuD3sRDd+CrqSU
 XlgByjZ5HUL2Uqwbuj+8V4e6ks6sp0HYyeN26gSl+Ta8yOR8L1c+HaJpeBpPhItyuMwXwEN8vV4
 WJCL05UQH36noU9sZ9FxQwYeP7wFkf6e4jOTjhPwjBMg3Lc9cDgUHaU3r+BizH/wpINJF9UCSmF
 ibq3bJCAyYdVnesvLjy+QzmKTpbLov9bkIJeuxtJ/uTrmRoaLQunBZ3qRodYL81VPJ74Nt+blMg
 vM2VNuF fGpQ1XFg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
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

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct amdgpu_bo_list.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-hardening@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 6f5b641b631e..781e5c5ce04d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -84,6 +84,7 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
 
 	kref_init(&list->refcount);
 
+	list->num_entries = num_entries;
 	array = list->entries;
 
 	for (i = 0; i < num_entries; ++i) {
@@ -129,7 +130,6 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
 	}
 
 	list->first_userptr = first_userptr;
-	list->num_entries = num_entries;
 	sort(array, last_entry, sizeof(struct amdgpu_bo_list_entry),
 	     amdgpu_bo_list_entry_cmp, NULL);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
index 6a703be45d04..555cd6d877c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
@@ -56,7 +56,7 @@ struct amdgpu_bo_list {
 	 */
 	struct mutex bo_list_mutex;
 
-	struct amdgpu_bo_list_entry entries[];
+	struct amdgpu_bo_list_entry entries[] __counted_by(num_entries);
 };
 
 int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, int id,
-- 
2.34.1

