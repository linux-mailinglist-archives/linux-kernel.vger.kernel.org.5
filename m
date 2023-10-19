Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C897CF590
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345197AbjJSKpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345056AbjJSKpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:45:21 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A607189
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:44:58 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3ae18567f42so609213b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697712297; x=1698317097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmm0RwYxrj0JXQDj8pQ3b9oBOktC5ndB3VrLZPSOC60=;
        b=BiYeGZm7QPpiPlE80RhXwwnlV0WVDHrhQRGlQgpErgxDgHlxLlS3uD38vK1QDM8wO+
         sWgdJIn4iLGX7gtJod5EoFlcXLByKQzQWW2LCi+7r7DV0UR5z9K0Jp/UZR+fND1ICbqA
         hZMnAzWDP+cB0hPS4zzDeF77PwAJ7bFbNddVH6w7ryebf7VN7SGWrm7LWuHedwZEWoTs
         gy6u6ae3y5hqjKRhgRw5uy9lZe/pmpky/DPlAybXBrYP1xOWbCEc0joU8tE8nKkAsHzz
         RUnIq3k+tXn65pbN+x0GABLot/DnzQnq48+zbaW5XLAEZ0LQpmz/2arNBKEYQ7TTYtPy
         as7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697712297; x=1698317097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmm0RwYxrj0JXQDj8pQ3b9oBOktC5ndB3VrLZPSOC60=;
        b=ZaG2+5iOAHADn4bWMI52L8Ftg+BUmGYIfDOeT35fQePTq4LLgtX8ASVHputVcTejtL
         aV+6kJ4sEIvUb8MwC1Albw7u6MTMpkm7Yl6nSrSCY/TIY020PYKJDZl0HkWj/PJVgz3z
         ymbRQzT4CSoAJ6p5OoImQ4DIk62taeqt03/vgAGt+l2+CnHz3cY8DOJKhmg7anTeQaCR
         W9bSK9iLFjVBVlO6PZbqhv47Fmoqkdm1wp8eyIfLmI80mjRisltSjYNz8UqC6d+uZe0r
         afMC2VHCyYpuatVKMD+EWroq+qh8Se5ZUS9K5mZ7GU1Dprc11e1V6DRa8+rw+gSvhZiT
         azww==
X-Gm-Message-State: AOJu0YyYCIIWZWWVwoHdErdL7d8EzAQOBLTDk1wBS0W7lmOawQskU07p
        6I/SmwJSlWlbyyQV1h0IvWCpbQ==
X-Google-Smtp-Source: AGHT+IFiDIkhYOzfGoN681/kFFpCAAwqzqvfB3lbPDSQsZxI7AXL5sm4hMppeyEfPHO7n8o8xy1wWw==
X-Received: by 2002:a05:6358:d107:b0:168:a3a4:6dc2 with SMTP id jy7-20020a056358d10700b00168a3a46dc2mr1433432rwb.3.1697712297441;
        Thu, 19 Oct 2023 03:44:57 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id y13-20020aa79e0d000000b006bdfb718e17sm4812290pfq.124.2023.10.19.03.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:44:57 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, rppt@kernel.org, david@redhat.com,
        vbabka@suse.cz, mhocko@suse.com
Cc:     willy@infradead.org, mgorman@techsingularity.net, mingo@kernel.org,
        aneesh.kumar@linux.ibm.com, ying.huang@intel.com,
        hannes@cmpxchg.org, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 2/2] mm: memory_hotplug: drop memoryless node from fallback lists
Date:   Thu, 19 Oct 2023 18:43:55 +0800
Message-Id: <9f1dbe7ee1301c7163b2770e32954ff5e3ecf2c4.1697711415.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1697711415.git.zhengqi.arch@bytedance.com>
References: <cover.1697711415.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
Acked-by: David Hildenbrand <david@redhat.com>
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

