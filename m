Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F05805EDC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 20:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjLETyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 14:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLETyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 14:54:14 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE1AA5;
        Tue,  5 Dec 2023 11:54:21 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cfc9c4acb6so29817065ad.0;
        Tue, 05 Dec 2023 11:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701806061; x=1702410861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBZzT0/QbcprxNQTsHpzd6ven1aj0800Yb9/CoMbKBA=;
        b=JaHEW5NG9N4g2WwCC2nClWqC+0cKqCSR4aHci057CaRZZEu0/TmwvpaqSZTQa+2pdg
         rv63l77PYXQe5v5iGy9xgjYCNU7yMR+NWQRnJErQMiGZgI5V7uRhRvWqbXcnJr5D1Izz
         o+pOYe+RXiURTSjyflpWThGIr0RKc5HWAfSaWq0NoX//FiIanchdKev5ZGmHgWW0xRJC
         6Yuz4Kf1X3I3Y6/YXafRI8QCKQ5VMGKG/kNH5upcm7s/v4HtDqBGz3+BjpJLXPE+6Hna
         8UkUqwpmjOUqmaaLmhRUalxSKzYJXxc3GhzIxCTuNV5YI/sdL82hxkiQua3oJy3TGGqR
         iOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701806061; x=1702410861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBZzT0/QbcprxNQTsHpzd6ven1aj0800Yb9/CoMbKBA=;
        b=OH5TkFL5UBqlulU+oQgHtBEdTckLhXssKmdPyI+/tTuZjdbZhspoOT221kr+nh8ycS
         avoqsa9YWqHqlazetQTaCtM1tJDVaQnc/gRjBxcWIlL08SUjvVrUh8OgzYb47KlvvqgE
         XVWLrz0ea6QfvTBXQM5PVKb6bP3IeEKI4JtpV9Tr+wHIAe0wauYQWFSRVNBuz2d+msKC
         oxdAwv/VWSqG6mXH+iInoY4wq9tgjc/L4TOoLQtz00BBW4VjzLH1cj1keNYRhP4niWm2
         V8DcCvn/tMp/n5vvZQLurfAQaP7j5CLejOe+4eQe9lNv56jTZ3GItb9FavrrnqB0Cmu+
         DtXA==
X-Gm-Message-State: AOJu0Yxqyw98huwX1T0opIUi8mGPL3wHgxiNdM/X7KKYPvA61pI+ZLKp
        lnTQK2r4c5jtcJbogAqrBRM=
X-Google-Smtp-Source: AGHT+IHiN3u4lyG7cLPBE6NoEoYHDNHgelzGc9AxrA8KJTfHwHiCxIp8MO1xA3yLPhPxAMw1q8En6w==
X-Received: by 2002:a17:902:8696:b0:1d0:6ffd:6e8e with SMTP id g22-20020a170902869600b001d06ffd6e8emr3152372plo.134.1701806060641;
        Tue, 05 Dec 2023 11:54:20 -0800 (PST)
Received: from localhost (fwdproxy-prn-024.fbsv.net. [2a03:2880:ff:18::face:b00c])
        by smtp.gmail.com with ESMTPSA id c15-20020a170902d48f00b001d0cd9e4248sm876201plg.196.2023.12.05.11.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 11:54:19 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: [PATCH v8 3/6] zswap: make shrinking memcg-aware (fix)
Date:   Tue,  5 Dec 2023 11:54:19 -0800
Message-Id: <20231205195419.2563217-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130194023.4102148-4-nphamcs@gmail.com>
References: <20231130194023.4102148-4-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct function for the onlineness check for the memcg
selection, and use mem_cgroup_iter_break() to break the iteration.

Suggested-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index f323e45cbdc7..7a84c1454988 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -834,9 +834,9 @@ static void shrink_worker(struct work_struct *w)
 			goto resched;
 		}
 
-		if (!mem_cgroup_online(memcg)) {
+		if (!mem_cgroup_tryget_online(memcg)) {
 			/* drop the reference from mem_cgroup_iter() */
-			mem_cgroup_put(memcg);
+			mem_cgroup_iter_break(NULL, memcg);
 			pool->next_shrink = NULL;
 			spin_unlock(&zswap_pools_lock);
 
@@ -985,7 +985,7 @@ static void zswap_pool_destroy(struct zswap_pool *pool)
 	list_lru_destroy(&pool->list_lru);
 
 	spin_lock(&zswap_pools_lock);
-	mem_cgroup_put(pool->next_shrink);
+	mem_cgroup_iter_break(NULL, pool->next_shrink);
 	pool->next_shrink = NULL;
 	spin_unlock(&zswap_pools_lock);
 
-- 
2.34.1
