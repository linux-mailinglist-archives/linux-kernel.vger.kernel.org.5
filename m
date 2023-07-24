Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A2F75F26B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjGXKNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbjGXKMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:12:44 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F1B7AA0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 03:05:06 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b947f8269eso979612a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 03:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690193086; x=1690797886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qE79rW9nQFdZueatbKkJSwG7PQvomLDBWPiy7CJ1pOw=;
        b=WfRohMff/qbfzm/k10e4i76J60vWByluEvFxd0BBG8UUPT/gVvUPQY0Bguv0DevtBW
         mkvYC2bIMQl+JefvTbfDffxbZC0MsreZmaSWOtFNsOJNUh6BI2dUPPIp807ky4Oy9M4y
         ikEsT7fJiyq+BvFhfC5/E7hjB9U/Urnt9YDhHeh4pBSqS+akYgpg8dU2TrP+C8kqIFgG
         lmGA3HeD8KQH808zgSG7r7uibObJPzJXU8gXf0ngtkjiz+NY0VYCwhUVb/EvRShmA/GR
         zhSH0uI4YI7GFAdOcvYRLyCzITMJM5j0JKZBa0Gr2jCff+rgBkb8AK7b83LdEsd53Uox
         DAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690193086; x=1690797886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qE79rW9nQFdZueatbKkJSwG7PQvomLDBWPiy7CJ1pOw=;
        b=UWzAp5b8qAm45bAChY1cME3DNL5kMg4RTSyx2iJ4H3SGgCAajtOepXyk3+i6aR+5Rk
         cb5DcN+u8PiCPPKgr3IPIbLEPkVSvmPPx8Q1qLTuAmSvE8+dFqEjwCoUgroO444rLLYh
         kN2ErcYhckjqO5Y/XLh1kGXxvmCBrnsgxwBSMcWyV73rGLXjS7RdzHzBwtwQM/QE0jt9
         TRTNnppO8ksheA8DT6XnrvmYO1cF8Q2WyalqKzRzoL/fG313J9yVmZXsdJAD6Um27oWD
         uX2ZS/fgTIIsSmmSrjHSLOFF7M6lAaHtbK9vrXBsU37CW9Y+P83aVRbbBRWpewip6mqA
         Timw==
X-Gm-Message-State: ABy/qLbC10pPbjQ+5tI6r2WJmy10gYfCzp3wF7KYB0wO353Ahj7811dT
        ryKaDkuDQr/Phw7Ir1NOfHnWb2SCS647s4gcRnY=
X-Google-Smtp-Source: APBJJlFDDpJsPsXaM9K0eN3GbgFDnugc0MZ81V5AeEkSNRv9osxW0v212MSH0egY7R7+BB7SiCdLdQ==
X-Received: by 2002:a17:902:e802:b0:1b3:d4bb:3515 with SMTP id u2-20020a170902e80200b001b3d4bb3515mr12388503plg.0.1690192254453;
        Mon, 24 Jul 2023 02:50:54 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:50:54 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 29/47] vmw_balloon: dynamically allocate the vmw-balloon shrinker
Date:   Mon, 24 Jul 2023 17:43:36 +0800
Message-Id: <20230724094354.90817-30-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the vmw-balloon shrinker, so that it can be freed
asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
read-side critical section when releasing the struct vmballoon.

And we can simply exit vmballoon_init() when registering the shrinker
fails. So the shrinker_registered indication is redundant, just remove it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 drivers/misc/vmw_balloon.c | 38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 9ce9b9e0e9b6..d216d4dc042e 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -380,16 +380,7 @@ struct vmballoon {
 	/**
 	 * @shrinker: shrinker interface that is used to avoid over-inflation.
 	 */
-	struct shrinker shrinker;
-
-	/**
-	 * @shrinker_registered: whether the shrinker was registered.
-	 *
-	 * The shrinker interface does not handle gracefully the removal of
-	 * shrinker that was not registered before. This indication allows to
-	 * simplify the unregistration process.
-	 */
-	bool shrinker_registered;
+	struct shrinker *shrinker;
 };
 
 static struct vmballoon balloon;
@@ -1568,29 +1559,27 @@ static unsigned long vmballoon_shrinker_count(struct shrinker *shrinker,
 
 static void vmballoon_unregister_shrinker(struct vmballoon *b)
 {
-	if (b->shrinker_registered)
-		unregister_shrinker(&b->shrinker);
-	b->shrinker_registered = false;
+	shrinker_unregister(b->shrinker);
 }
 
 static int vmballoon_register_shrinker(struct vmballoon *b)
 {
-	int r;
-
 	/* Do nothing if the shrinker is not enabled */
 	if (!vmwballoon_shrinker_enable)
 		return 0;
 
-	b->shrinker.scan_objects = vmballoon_shrinker_scan;
-	b->shrinker.count_objects = vmballoon_shrinker_count;
-	b->shrinker.seeks = DEFAULT_SEEKS;
+	b->shrinker = shrinker_alloc(0, "vmw-balloon");
+	if (!b->shrinker)
+		return -ENOMEM;
 
-	r = register_shrinker(&b->shrinker, "vmw-balloon");
+	b->shrinker->scan_objects = vmballoon_shrinker_scan;
+	b->shrinker->count_objects = vmballoon_shrinker_count;
+	b->shrinker->seeks = DEFAULT_SEEKS;
+	b->shrinker->private_data = b;
 
-	if (r == 0)
-		b->shrinker_registered = true;
+	shrinker_register(b->shrinker);
 
-	return r;
+	return 0;
 }
 
 /*
@@ -1883,7 +1872,7 @@ static int __init vmballoon_init(void)
 
 	error = vmballoon_register_shrinker(&balloon);
 	if (error)
-		goto fail;
+		return error;
 
 	/*
 	 * Initialization of compaction must be done after the call to
@@ -1905,9 +1894,6 @@ static int __init vmballoon_init(void)
 	vmballoon_debugfs_init(&balloon);
 
 	return 0;
-fail:
-	vmballoon_unregister_shrinker(&balloon);
-	return error;
 }
 
 /*
-- 
2.30.2

