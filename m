Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F62A7CF16E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbjJSHio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbjJSHij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:38:39 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A564A126
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:38:18 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ca79b731f1so8971725ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697701098; x=1698305898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cxQgxjhn9SWJh0Wr98V4tbQtLJu0AylqKOEAskAE6c=;
        b=OBaLRyDgvCRHOiC6+ZemxGRI6j6EhGoUYZqiYe0y2G7GYFfC3lKxefHzD31d20NxDl
         m9atCDAhJKY2hSjyV+cYxZcLmjKEBfYJXupBqR6TQExTEbrkwOVQh+NI79BJ0M9/k9Z4
         IGFgGTbJ56CHrH9Gi2B2nwU0TmZHMEuHlK9GZeoHJgv7r05XUrQag9KYA8hR8VRAQnvn
         4enqSTymp78wYrcIlsuPA5NZ8SIeEycnLOaIbgYJiEawqL6bb85ajv1Yge1cRgECasXz
         mwPayUP9EmgTWg2T1apEM/MslUje7FaeyQuNKiDVCJiQrkxB4HNpXYGAR1PRAecz1P4x
         xMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697701098; x=1698305898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cxQgxjhn9SWJh0Wr98V4tbQtLJu0AylqKOEAskAE6c=;
        b=u8EQHRa2wZeF3x9dMzqFj/aGM6h6gVsGL+bG6rRGGMymtHvItUCqShZY+S4v2oKNwe
         eiyBbFYNBsnM6xyhGdCnb6x3Wjd5H1FKwvZwqb2AtnsftdXi9yXEuorEO/wvU2GgxhHV
         8sveum6GahxchqBb3ASkCK29O45OvPAk2UPBznNNARxuYBD51rXhM0dFYNtmVKcGboVv
         quavbPhog68/8pYwCsAf+4skLW2ui+BTnaSzYdysrBml5in7vOVQUbCoDgY4Cpfv5+s2
         3LjUazBLfAi/YWpnBHkdtmcbq2uE2c3XU8O7wrrlbl9k4MdYX5vNsKQ2nOlPpAP9+Alb
         zreA==
X-Gm-Message-State: AOJu0Yy/5FNhMb/5QamNZGye58cytNxeuPGarepCcuerpmETIf+57kUX
        s5B3MBiAOlDQl2/zjvuqZMuxUw==
X-Google-Smtp-Source: AGHT+IGvwXjKO2gI3oQizjHqmOSqlFdkK+0M6Y0XsSvKGyl352MhRurSwVqrutcSYvAcfs/K9fOVcg==
X-Received: by 2002:a17:903:705:b0:1ca:273d:232 with SMTP id kk5-20020a170903070500b001ca273d0232mr1566517plb.0.1697701098152;
        Thu, 19 Oct 2023 00:38:18 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902854900b001c5d09e9437sm1194306plo.25.2023.10.19.00.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 00:38:17 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, rppt@kernel.org, david@redhat.com,
        vbabka@suse.cz, mhocko@suse.com
Cc:     willy@infradead.org, mgorman@techsingularity.net, mingo@kernel.org,
        aneesh.kumar@linux.ibm.com, ying.huang@intel.com,
        hannes@cmpxchg.org, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 2/2] mm: memory_hotplug: drop memoryless node from fallback lists
Date:   Thu, 19 Oct 2023 15:36:27 +0800
Message-Id: <32c12381941f347ebafb9cb5bc9f0a4a535ff646.1697687357.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1697687357.git.zhengqi.arch@bytedance.com>
References: <cover.1697687357.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

To drop memoryless node from fallback lists in this case, just
call node_states_clear_node() before calling build_all_zonelists().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/memory_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index d4a364fdaf8f..18af399627f0 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -2036,12 +2036,12 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	/* reinitialise watermarks and update pcp limits */
 	init_per_zone_wmark_min();
 
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

