Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045157A3C69
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 22:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241021AbjIQUa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 16:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241033AbjIQUae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 16:30:34 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676AF101
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 13:30:28 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6903a452dfaso2411661b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 13:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694982628; x=1695587428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmN3G4bFpi6nAbIJp8nMJiK+WmgTcWevUBMw6pAf8Vk=;
        b=hDdpJ+RnMscZTxuRoAob/9vaCK3YMtANVoEhJvkT4sTZ6uOm5KeFzQG95dT+t4VZsn
         fOEfqsRUEW9H1o/dbo0I6DVIVWbJANR7gXWoA3/gD/mYO2Ul7z+Yb1aeJVwScdZyX5o5
         f13a2ZuGRgKdEZTzmjlf49CiatE5gs7miRxbb3ujzYv9kJ4+jNowZzX9FvCvS2Ry8+81
         P6GeLxQ8/sDWaP59fB5+83VY1lE1ndcdXffe7M3EE4ZRlQbxAex8QVvRyE6RdOV4Skbn
         t1fqCmZmbyQBbd77/+fKoV6fmquxv+qRRC8IM9R1ChMx3TNpk2DwyLUHK23o7J4rS1EQ
         zf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694982628; x=1695587428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmN3G4bFpi6nAbIJp8nMJiK+WmgTcWevUBMw6pAf8Vk=;
        b=WJLCSiMz5aQ9u0b7P9S3PcI5/Wb6cxVX4uCHq+rJQm0ZiNv73Xa8+z1uER3O33pCOJ
         mmiHVKIUWGH+X4Jhb7jeW/spWE31I3r6GGiISlwE3B9XKnb2NJexfFlqiSHpNjp4aiTd
         pcB+B1nbFixgLFCqeQJS3DtjwswhCWwR+/T2LN0tTGJBMn9yzPyj6CXO0uTZUS7JuJgK
         Gze01GMsAuzEX63TQj4DTjn/JymElmoWKiV2kAxwN4kRQIOAHntl089etCZvGXnBHl3f
         QrTBTMt8Afke89MyPhJKqof3yygjlGBS4Ne/3E8NQXazUFX9xO1tRzVKyxobROEfg2Zf
         28pg==
X-Gm-Message-State: AOJu0YzeFf7r9gTZfCc4Q6sPb9kxjlpQgBCEdrhojSs294Lqmqn7pIXt
        JSlzwwPEgTLJ7/kG/HH46yaWUsFbpKMWmRL9z3Q=
X-Google-Smtp-Source: AGHT+IECasCq4QXMYQn3wUZn42e5l+bVc7WPy0pGFsbORQGQ9sFW5lXlpsfwRKvUNRjABaQXLFFhQQ==
X-Received: by 2002:a05:6a20:8e0f:b0:134:d4d3:f0a8 with SMTP id y15-20020a056a208e0f00b00134d4d3f0a8mr7470800pzj.3.1694982627806;
        Sun, 17 Sep 2023 13:30:27 -0700 (PDT)
Received: from yqt-VirtualBox ([139.227.189.216])
        by smtp.gmail.com with ESMTPSA id jk15-20020a170903330f00b001b9fef7f454sm4534874plb.73.2023.09.17.13.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 13:30:27 -0700 (PDT)
From:   Piro Yang <piroyangg@gmail.com>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Piro Yang <piroyangg@gmail.com>
Subject: [PATCH v2] staging: vme_user: using __func__ to replace function's name in printk
Date:   Mon, 18 Sep 2023 04:30:19 +0800
Message-Id: <20230917203019.79180-1-piroyangg@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <9548bc1c-23c9-427f-446e-61f051f14f9c@gmail.com>
References: <9548bc1c-23c9-427f-446e-61f051f14f9c@gmail.com>
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

Fix issue relating to prink message:
	*using __func__ to replace function's name

Issue found by checkpatch

Signed-off-by: Piro Yang <piroyangg@gmail.com>
---
Changes in v2:
  - Firstly, fix only one type of Waring by checkpatch.
	using '"%s...", __func__' substitute for function's name of printked information

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index 5960562dcd96..de404c6765f3 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -418,7 +418,7 @@ int vme_slave_get(struct vme_resource *resource, int *enabled,
 	image = list_entry(resource->entry, struct vme_slave_resource, list);
 
 	if (!bridge->slave_get) {
-		printk(KERN_ERR "vme_slave_get not supported\n");
+		printk(KERN_ERR "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -568,7 +568,7 @@ int vme_master_set(struct vme_resource *resource, int enabled,
 	image = list_entry(resource->entry, struct vme_master_resource, list);
 
 	if (!bridge->master_set) {
-		printk(KERN_WARNING "vme_master_set not supported\n");
+		printk(KERN_WARNING "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1552,7 +1552,7 @@ int vme_lm_set(struct vme_resource *resource, unsigned long long lm_base,
 	lm = list_entry(resource->entry, struct vme_lm_resource, list);
 
 	if (!bridge->lm_set) {
-		printk(KERN_ERR "vme_lm_set not supported\n");
+		printk(KERN_ERR "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1588,7 +1588,7 @@ int vme_lm_get(struct vme_resource *resource, unsigned long long *lm_base,
 	lm = list_entry(resource->entry, struct vme_lm_resource, list);
 
 	if (!bridge->lm_get) {
-		printk(KERN_ERR "vme_lm_get not supported\n");
+		printk(KERN_ERR "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1625,7 +1625,7 @@ int vme_lm_attach(struct vme_resource *resource, int monitor,
 	lm = list_entry(resource->entry, struct vme_lm_resource, list);
 
 	if (!bridge->lm_attach) {
-		printk(KERN_ERR "vme_lm_attach not supported\n");
+		printk(KERN_ERR "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1658,7 +1658,7 @@ int vme_lm_detach(struct vme_resource *resource, int monitor)
 	lm = list_entry(resource->entry, struct vme_lm_resource, list);
 
 	if (!bridge->lm_detach) {
-		printk(KERN_ERR "vme_lm_detach not supported\n");
+		printk(KERN_ERR "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1725,7 +1725,7 @@ int vme_slot_num(struct vme_dev *vdev)
 	}
 
 	if (!bridge->slot_get) {
-		printk(KERN_WARNING "vme_slot_num not supported\n");
+		printk(KERN_WARNING "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
-- 
2.25.1
