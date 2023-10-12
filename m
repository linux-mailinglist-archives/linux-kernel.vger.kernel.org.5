Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92537C7A35
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443038AbjJLXFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443052AbjJLXFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:05:23 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CE6E7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:04:57 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-693400e09afso358086b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697151897; x=1697756697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MjY6Bfa7hXy3EtsVkBFJvcxDVqkLy8yAMFEk0tgy2ww=;
        b=FwKxfCORdKGCkpYs8q/7h2nm6KnkQSHSDBLJd3Hu3X5dZAY26gZjPKl7hdPgBf2PXY
         Yb8bWtg/9elAzYL+qyKwJmffHvQNsekkiWAlCdC1f1XIW8DlXTF58HBT1p0oRtCTcOGn
         9g973lk7zBbvl+9zhnrwg/ZlpUWbp+9iuA6CEHm/WaJ6qxTEKluaigA20REqhOUmlsi2
         3Bk1v3mDyuiz+UflRIHaIvM9TEkkdWUiLnAzvDMT++RtwmIsyGXDtLqKOnQrvkKcnGkj
         7wb72gqCs2IxaI7dIHUYNBL+h+YEP3SLKFfYEh3iVOsuXFlfJEAvAGsEsUsvud3eI1ww
         dznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697151897; x=1697756697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MjY6Bfa7hXy3EtsVkBFJvcxDVqkLy8yAMFEk0tgy2ww=;
        b=He5R1br+iB66bmPSJufwwWvWDzgN1+V885mekdvisqtSC91Y+B8pVD8mSlAPhD8RD/
         67MPE0O/LQbFKui6UrIefqdwW0qy5wjivKMJbpA9VtySZ5mhyzFBn9GRG9PV07Mzgdsq
         Q+U0zNTQ7SueC9rcXdGEucFVkipZ/jMaIV7IAa9YnJIDfvk6PGZAzgTL40X/Bf3hzITV
         y1efpf05JgIxa3kJ/NMvcZkdNRS1cvIZBxYvLJUUQbhnEVjOUDe/c0TdpVh0e0VyqBpD
         OH7W6qfr1w5l1Ev7YsQ/KbvyhzW+aMrZ2nRFi0fuF3pQ1ElHIOvKQyW6O3jLmcXg6rMQ
         1UHA==
X-Gm-Message-State: AOJu0YziaBQ5C5XRUqLUy6XIpCwV4QJk/i0ttaJQQM05UK940mZCsY+P
        TNXeQkCehP5v93Ud5sAyAIk=
X-Google-Smtp-Source: AGHT+IH+4v5f93VcvRkHnnVgNR/Vyt3EU7gWUCAaBPEj/wJkDgmWUDn2+fSuZCy+1+14UNBZQ7kIzw==
X-Received: by 2002:a05:6a00:2e92:b0:692:b3d4:e6c3 with SMTP id fd18-20020a056a002e9200b00692b3d4e6c3mr27619108pfb.0.1697151896807;
        Thu, 12 Oct 2023 16:04:56 -0700 (PDT)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id e4-20020a62ee04000000b006889664aa6csm12193998pfi.5.2023.10.12.16.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 16:04:55 -0700 (PDT)
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     zhenyuw@linux.intel.com, zhi.a.wang@intel.com
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@gmail.com, daniel@ffwll.ch,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] drm/i915/gvt: Optimize mmio_offset_compare() for efficiency
Date:   Fri, 13 Oct 2023 07:04:49 +0800
Message-Id: <20231012230449.2109078-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
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

The original code used conditional branching in the mmio_offset_compare
function to compare two values and return -1, 1, or 0 based on the
result. However, the list_sort comparison function only needs results
<0, >0, or =0. This patch optimizes the code to make the comparison
branchless, improving efficiency and reducing code size. This change
reduces the number of comparison operations from 1-2 to a single
subtraction operation, thereby saving the number of instructions.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/gpu/drm/i915/gvt/debugfs.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/debugfs.c b/drivers/gpu/drm/i915/gvt/debugfs.c
index baccbf1761b7..998d82a259c8 100644
--- a/drivers/gpu/drm/i915/gvt/debugfs.c
+++ b/drivers/gpu/drm/i915/gvt/debugfs.c
@@ -48,11 +48,7 @@ static int mmio_offset_compare(void *priv,
 
 	ma = container_of(a, struct diff_mmio, node);
 	mb = container_of(b, struct diff_mmio, node);
-	if (ma->offset < mb->offset)
-		return -1;
-	else if (ma->offset > mb->offset)
-		return 1;
-	return 0;
+	return ma->offset - mb->offset;
 }
 
 static inline int mmio_diff_handler(struct intel_gvt *gvt,
-- 
2.25.1

