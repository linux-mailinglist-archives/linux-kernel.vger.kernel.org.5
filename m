Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1EB7D0E16
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377092AbjJTLFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376745AbjJTLF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:05:28 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27526CA
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:05:24 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1e9c28f8193so191698fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697799923; x=1698404723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvNzbx+wE6QPfE2MeeEi/ZV40Dr0N1fCnVWImcOfsdE=;
        b=hapDtMvyN44CDAOhrzoxwO5qHGanr2x4kcwwsv+qdtX1sv0NEHMj9F1XxrKEyVlVhw
         h8nlm0L/25h0IPzQBs03Gp0S1UYiJEfB3CW/yHPIawk97nDmgCiRj35+gadEcQDkH6wF
         OYRYGTORDRbX4nFbI9N2f+MOINoAcMTpc/hNV8gj7dhjewA6IotdHjsKEislkJOKcA3F
         fdBXBO2ZH6egZCsatlUVP79ZNG3fIuHucOPmbpilqrfssx2pkPRw3/LeDc5YCA4XXvvH
         +DAT2lZKJLAr/PzWB/+VEDmIH3uYuJ+WTDt1ZXseqESvAOo96s1F2zUdrkWCvJ/68ujC
         b8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697799923; x=1698404723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvNzbx+wE6QPfE2MeeEi/ZV40Dr0N1fCnVWImcOfsdE=;
        b=bm5AZu6c4ib37AK3wugU25midYzekl3VsQige6XV6srOWWKJ9/1oyoDAc2FMdnMoHK
         LT6kJNyPWuDoE+SysOrWoSdMQbKh9qLU3Wuhzb1g5e4Z9M+poBHjGQ6k1q7BarPFAo89
         /ES2Tg5w6eAsnTRgbn7Pdl8KmdFDJa6TMDIybOeai6eZ+4bhaXAKnDCu7167G0jcAYAx
         R6PYLDW1o4QX+3umXG2JKoiFTwWj/Z2tUJyZQLRdY98K1+xrndsmsx9vly4XeShMiRKw
         bVYSs30JjzYfqhJWPOPfV6+5uF+6SjciJHINoqayBrsISwLjnL8rR945Od7JTxMvgRkh
         /Bqg==
X-Gm-Message-State: AOJu0YxNeCHT9lcX8q2jyd+P3RtBBv7+FSoMiWYCkNuqjKGmHwkKvmhZ
        vbgb9PqG5TpBWmZQj5UuP1qnNg==
X-Google-Smtp-Source: AGHT+IEZbrCU3UtQrs961bnYFojXLZPVOeYgp6UFfxmFOYWwqhfMWrAExdDU7Tw6uXfIF3bbdxeRGw==
X-Received: by 2002:a05:6358:72a:b0:168:a3a4:6dc2 with SMTP id e42-20020a056358072a00b00168a3a46dc2mr1251379rwj.3.1697799923312;
        Fri, 20 Oct 2023 04:05:23 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id z6-20020aa79f86000000b006be4bb0d2dcsm1323865pfr.149.2023.10.20.04.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 04:05:22 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, rppt@kernel.org, david@redhat.com,
        vbabka@suse.cz, mhocko@suse.com
Cc:     willy@infradead.org, mgorman@techsingularity.net, mingo@kernel.org,
        aneesh.kumar@linux.ibm.com, ying.huang@intel.com,
        hannes@cmpxchg.org, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 2/2] mm: memory_hotplug: drop memoryless node from fallback lists
Date:   Fri, 20 Oct 2023 19:04:46 +0800
Message-Id: <63a3648aa6d49ad2dcf8c885d6a874e6c91624a0.1697799303.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1697799303.git.zhengqi.arch@bytedance.com>
References: <cover.1697799303.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In offline_pages(), if a node becomes memoryless, we
will clear its N_MEMORY state by calling node_states_clear_node().
But we do this after rebuilding the zonelists by calling
build_all_zonelists(), which will cause this memoryless node to
still be in the fallback list of other nodes. This will incur
some runtime overhead.

To drop memoryless nodes from fallback lists in this case, just
call node_states_clear_node() before calling build_all_zonelists().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
---
 mm/memory_hotplug.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index d4a364fdaf8f..f019f7d6272c 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -2036,12 +2036,16 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	/* reinitialise watermarks and update pcp limits */
 	init_per_zone_wmark_min();
 
+	/*
+	 * Make sure to mark the node as memory-less before rebuilding the zone
+	 * list. Otherwise this node would still appear in the fallback lists.
+	 */
+	node_states_clear_node(node, &arg);
 	if (!populated_zone(zone)) {
 		zone_pcp_reset(zone);
 		build_all_zonelists(NULL);
 	}
 
-	node_states_clear_node(node, &arg);
 	if (arg.status_change_nid >= 0) {
 		kcompactd_stop(node);
 		kswapd_stop(node);
-- 
2.30.2

