Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E80976FB87
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 09:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbjHDH6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 03:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbjHDH6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 03:58:13 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FD044B5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 00:57:45 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686bea20652so1706356b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 00:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691135864; x=1691740664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zMxhq1yiZbeuYK1cuOPzx7JANSxn1juq0pUBihEL+Wk=;
        b=cyFCTzgxWtiVhk0GN4aVnu4QKoUOxtDJ285NYT/WdtIMtJDdEURpJTFHP7/r6bXjV6
         L8P0q1S1aQVL0XZ83Y2GvLfNChQwxSAp23v6Z0Ggk6ewzwUZVUEJq+dP04Xd5aXcBWMO
         rwkKID50qG8Uedkg0KM6CqS+CltvwQomEMNoDZXFxdvxXrlgXEe2WCJrStu6gaOTpVg+
         6COTIYjMyWD2l0W45DWG3YrkIqUyIFSzZEODU4n52f54yIoB7fP+LVFOLh2zO3ZvfJ38
         kiL+DUNaBlV/kRc3tJrORJMZb7dOjqVRomaj4xKOPC5hpw9jIuTWV35DIcjhV7bt0EH3
         ULSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691135864; x=1691740664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMxhq1yiZbeuYK1cuOPzx7JANSxn1juq0pUBihEL+Wk=;
        b=M8REgBvFeq7SQMhaSI7k8a0j/SutbPu0OF5abkxi8B7SOhom/BXy9o6l0t1pFEiteO
         II5kjIT1Kkw19WEwn8KXZlBnjJSJWPHf4trLIxSlcP+g2Tahxte8XS1Dg7y+ADPJFC5Q
         ov4u4qK3xV/tLd/NgVnw39BQpVoPHdq9xg6IsZ7h5VC4Xaq+mfpUZ3igvczx1dA4r2wc
         GdWGMJRnEZJzrTQ1yGkmywMk0sCchCFsaWukepKndPrdKNxCueYhYjVxiz43clzozzml
         4YiA5OQLhUxClCxOQqRgpzvEY96pu7yPh0sM90r68eFddzOIcJKXzLgIhAiIy5+ueKA8
         csKQ==
X-Gm-Message-State: AOJu0YzQ/+VWrLkTmNcpniIXqT2m6niVrqvypS5MlvCUHQP7o72q66qY
        S5NPHMQ0/CTkxlFIVvcDbCZjwg==
X-Google-Smtp-Source: AGHT+IEINJci+rjslbHv2EkTaLQ/k76JUU6HiPJtghJgD8x05vOGcKrfPI4DZeP83cVwWdid5ntRbg==
X-Received: by 2002:a05:6a00:1a4b:b0:687:7b0a:fae4 with SMTP id h11-20020a056a001a4b00b006877b0afae4mr1578686pfv.0.1691135864729;
        Fri, 04 Aug 2023 00:57:44 -0700 (PDT)
Received: from Tower.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id x10-20020a056a00270a00b0068796c58441sm1016718pfv.60.2023.08.04.00.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 00:57:44 -0700 (PDT)
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
To:     minchan@kernel.org, senozhatsky@chromium.org, mhocko@suse.com
Cc:     david@redhat.com, yosryahmed@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [RFC PATCH RESEND v2 1/2] memcg: Add support for zram object charge
Date:   Fri,  4 Aug 2023 15:57:36 +0800
Message-Id: <20230804075736.207995-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compressed RAM(ZRAM) is currently charged to kernel, not
to any memory cgroup, which can escape their cgroup memory
containment if the memory of a task is limited by memcgroup.
it will swap out the memory to zram swap device when the memory
is insufficient. In that case, the memory hard limit will be
invalidated. So, it should makes sense to charge the
compressed RAM to the page's memory cgroup.

As we know, zram can be used in two ways, direct and
indirect, this patchset can charge memory in both cases.
Direct zram usage by process within a cgroup will fail
to charge if there is no memory. Indirect zram usage by
process within a cgroup via swap in PF_MEMALLOC context,
will charge successfully.

Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 include/linux/memcontrol.h | 12 ++++++++++++
 mm/memcontrol.c            | 24 ++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5818af8eca5a..24bac877bc83 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1819,6 +1819,9 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
 	rcu_read_unlock();
 }
 
+int obj_cgroup_charge_zram(struct obj_cgroup *objcg, gfp_t gfp,
+					size_t size);
+void obj_cgroup_uncharge_zram(struct obj_cgroup *objcg, size_t size);
 #else
 static inline bool mem_cgroup_kmem_disabled(void)
 {
@@ -1880,6 +1883,15 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
 {
 }
 
+int obj_cgroup_charge_zram(struct obj_cgroup *objcg, gfp_t gfp,
+					size_t size)
+{
+	return 0;
+}
+
+void obj_cgroup_uncharge_zram(struct obj_cgroup *objcg, size_t size)
+{
+}
 #endif /* CONFIG_MEMCG_KMEM */
 
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e8ca4bdcb03c..118544acf895 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3059,6 +3059,7 @@ struct obj_cgroup *get_obj_cgroup_from_page(struct page *page)
 	}
 	return objcg;
 }
+EXPORT_SYMBOL(get_obj_cgroup_from_page);
 
 static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages)
 {
@@ -3409,6 +3410,29 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
 	refill_obj_stock(objcg, size, true);
 }
 
+int obj_cgroup_charge_zram(struct obj_cgroup *objcg, gfp_t gfp,
+							size_t size)
+{
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return 0;
+
+	/*
+	 * Indirect zram usage in PF_MEMALLOC, charging must succeed.
+	 * Direct zram usage, charging  may failed.
+	 */
+	return obj_cgroup_charge(objcg, gfp, size);
+}
+EXPORT_SYMBOL(obj_cgroup_charge_zram);
+
+void obj_cgroup_uncharge_zram(struct obj_cgroup *objcg, size_t size)
+{
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return;
+
+	obj_cgroup_uncharge(objcg, size);
+}
+EXPORT_SYMBOL(obj_cgroup_uncharge_zram);
+
 #endif /* CONFIG_MEMCG_KMEM */
 
 /*
-- 
2.25.1

