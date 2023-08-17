Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4D977FFFF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355313AbjHQVh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355356AbjHQVhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:37:38 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFEF10C7;
        Thu, 17 Aug 2023 14:37:36 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bdc8081147so10072525ad.1;
        Thu, 17 Aug 2023 14:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692308256; x=1692913056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VfBSoWR2VMdVe94DeOrM4dJxlWeWi9hCbvQq6BP8leQ=;
        b=ooeNolDTQvVzWf2zo5DcjLo0zaFOj4KtaIyw06AM53glPonl3hUVxydutbt3d/H9CJ
         f+vxbqJFtntaTuU4CzGcyIYDH9p+VwmFwMTTTDvjtS8v5FbxAJqMTczSApyRPW16HBnp
         RgMFZYVwwgdE6AO9PSpytdCh18VA2I/IVKdcX5EppaTF1O3Gu0nWlFyyNFNca/eZFLyi
         pw/BmMOH3uysAn/ltjoXjbR7KJj9xe5slf5Wxb2Kkz6WlRT0xqHOdaHRTdzYjQDoLdBV
         /pMO4wLh9pQn/bQ77zyhrLPhMVAxCodJoQT6zkN1h0AtseHP4mU35GIY4zCkeM2kIhXt
         ig1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692308256; x=1692913056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VfBSoWR2VMdVe94DeOrM4dJxlWeWi9hCbvQq6BP8leQ=;
        b=e1/AimRJYal5qLK3sxD9UASPQHDbfbUyipxgH+NZKia0rpRR3GAkJL4BWIrubsqMUi
         i/Co2oLwFao2zoihZurv8IFkhx1n05ZxpxDHwTL/6DMAEnmioN8IDe9CWTkLnt7boIhL
         +QOTWIBq/q1Z5mjITwpHO7XcW+l20nGrc2IviAZfEtghBjrdxrguvdxrr4jBRtSwvLj3
         bOKv4RbX8l/ZBB7KqR0hqbqpaubZRBu84xmW7/l+bWS6zWLP3AyrCSwZM6bcKbfhMGnC
         2UHD8LwyLoB0NDRc0q2CXJdTYB3lQGLmqQdC8Iqt6yQmsPa3hEMpdtwb+3al08OamYrR
         cQkg==
X-Gm-Message-State: AOJu0Yyu0Zx7cXL7LrHiSWerGmJNPAfuzQMvsnbUN7Yamjlb++y1hzoh
        /YImVvJAfcVjw5mvOLbDujURvwMRFNM=
X-Google-Smtp-Source: AGHT+IGhCNZ1M6WxLRZDhHgvhRaLi1UoeCIe3iYoAIHvyaW8/IAW6HFIhufDJb+oEn3k4h34lVliew==
X-Received: by 2002:a17:903:44e:b0:1bc:210d:6365 with SMTP id iw14-20020a170903044e00b001bc210d6365mr715384plb.2.1692308256327;
        Thu, 17 Aug 2023 14:37:36 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id u18-20020a17090341d200b001b9d95945afsm232379ple.155.2023.08.17.14.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 14:37:35 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        linux-media@vger.kernel.org (open list:SYNC FILE FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dma-buf/sw_sync: Avoid recursive lock during fence signal
Date:   Thu, 17 Aug 2023 14:37:28 -0700
Message-ID: <20230817213729.110087-1-robdclark@gmail.com>
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

If a signal callback releases the sw_sync fence, that will trigger a
deadlock as the timeline_fence_release recurses onto the fence->lock
(used both for signaling and the the timeline tree).

To avoid that, temporarily hold an extra reference to the signalled
fences until after we drop the lock.

(This is an alternative implementation of https://patchwork.kernel.org/patch/11664717/
which avoids some potential UAF issues with the original patch.)

Reported-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Fixes: d3c6dd1fb30d ("dma-buf/sw_sync: Synchronize signal vs syncpt free")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/dma-buf/sw_sync.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
index 63f0aeb66db6..ceb6a0408624 100644
--- a/drivers/dma-buf/sw_sync.c
+++ b/drivers/dma-buf/sw_sync.c
@@ -191,6 +191,7 @@ static const struct dma_fence_ops timeline_fence_ops = {
  */
 static void sync_timeline_signal(struct sync_timeline *obj, unsigned int inc)
 {
+	LIST_HEAD(signalled);
 	struct sync_pt *pt, *next;
 
 	trace_sync_timeline(obj);
@@ -203,9 +204,13 @@ static void sync_timeline_signal(struct sync_timeline *obj, unsigned int inc)
 		if (!timeline_fence_signaled(&pt->base))
 			break;
 
+		dma_fence_get(&pt->base);
+
 		list_del_init(&pt->link);
 		rb_erase(&pt->node, &obj->pt_tree);
 
+		list_add_tail(&pt->link, &signalled);
+
 		/*
 		 * A signal callback may release the last reference to this
 		 * fence, causing it to be freed. That operation has to be
@@ -218,6 +223,11 @@ static void sync_timeline_signal(struct sync_timeline *obj, unsigned int inc)
 	}
 
 	spin_unlock_irq(&obj->lock);
+
+	list_for_each_entry_safe(pt, next, &signalled, link) {
+		list_del(&pt->link);
+		dma_fence_put(&pt->base);
+	}
 }
 
 /**
-- 
2.41.0

