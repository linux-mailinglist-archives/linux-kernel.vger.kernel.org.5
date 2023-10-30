Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663897DBFD2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 19:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjJ3S0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 14:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjJ3S0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 14:26:20 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03248C1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 11:26:17 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c9e072472bso32647595ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 11:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698690377; x=1699295177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R62SThzKu31JyxEJEDyEUmzwekn6rEpi3haubFsFBjA=;
        b=YVIriJDWmyGm48+HeCfVwGl0oBBgjDfbSG4AjWv5t1N2k2osSN5g1o/SRoG92lVmGR
         i48iuBjcTczMVAktj44dDUmhiJmbES+71YevPnLlePjE/R7OFSNCxKRxNzii3KkYnz9y
         QhBqhJoA29dVsoenBsMgbeRimNzMVre2Aw4oP6QSeDaU4F+cWwH554FPknISvSBSO/Tm
         bQhA2/gBx0ZzzaGq8xhJg22DsQtSS+EYKWdC35N60iLTRx1aI5sq0vx4b5a/7KLP2cty
         W2eCYZBlRzbp8FEzdLmVkx9EufpF3d7ao0wvMmvUZ925V9Ba0+j2qX+TWZZ80TIc90U+
         8N1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698690377; x=1699295177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R62SThzKu31JyxEJEDyEUmzwekn6rEpi3haubFsFBjA=;
        b=NUZ65M+PqmElOk2n06eefcrQvlF74v+RZiRW2X+sG1dvs2AGDqXo4LaIs+y2FT1inN
         vqinpOYDddPvBGTZNndoIHIMkCEf9JeOD+rXj9FCv4k/D4K4fYCWUqVrn5qPz2lfXlHi
         WxJORpa5tvx6PIe0icSY/BAMUdrJ1zoqfiJ14byyLdYC6nqcfxP0AGcsHIOdB9wy5MDF
         JHWKeyTUWQIJRzmFmcpeiGGNkgWYIrSY6+x2Vb9vCnGQmsgsBZOawUL1ULwv6FSR8hw0
         jUUwwCiMURW1KRsmsGO5MJ04e8RN9JhaJxzLEYdLizMoQiYRChwIQ/cxr7pFdqNfG2vq
         G3hg==
X-Gm-Message-State: AOJu0YwzCUFiAKR533WexZ+eTnkPgwUAKnwdLeuI+k8AHCRltnFeCJqd
        V7qHply4tkyC3Ae+mie7lO8=
X-Google-Smtp-Source: AGHT+IGsopBprn9bNgbQiLpNlqHvZ5wikCH3OsB5zmYg0zrLqmiVVOeyrP0uwwqFijBn5HkdQecXjQ==
X-Received: by 2002:a17:902:d082:b0:1cc:2091:150f with SMTP id v2-20020a170902d08200b001cc2091150fmr5623248plv.1.1698690377299;
        Mon, 30 Oct 2023 11:26:17 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902684c00b001b9f032bb3dsm6754237pln.3.2023.10.30.11.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 11:26:16 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/gpuva: Fix comment typo
Date:   Mon, 30 Oct 2023 11:24:00 -0700
Message-ID: <20231030182400.31590-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Just something I noticed in passing.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 include/drm/drm_gpuva_mgr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_gpuva_mgr.h b/include/drm/drm_gpuva_mgr.h
index ed8d50200cc3..26a2c0880bac 100644
--- a/include/drm/drm_gpuva_mgr.h
+++ b/include/drm/drm_gpuva_mgr.h
@@ -189,7 +189,7 @@ static inline bool drm_gpuva_invalidated(struct drm_gpuva *va)
  * struct drm_gpuva_manager - DRM GPU VA Manager
  *
  * The DRM GPU VA Manager keeps track of a GPU's virtual address space by using
- * &maple_tree structures. Typically, this structure is embedded in bigger
+ * &rb structures. Typically, this structure is embedded in bigger
  * driver structures.
  *
  * Drivers can pass addresses and ranges in an arbitrary unit, e.g. bytes or
-- 
2.41.0

