Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA2579C9D3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjILIZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjILIZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:25:51 -0400
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DC2BB9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:25:47 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-cWlgkLV_OwuGzDlYigOlnA-1; Tue, 12 Sep 2023 04:25:11 -0400
X-MC-Unique: cWlgkLV_OwuGzDlYigOlnA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05089101FAB0;
        Tue, 12 Sep 2023 08:25:11 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F02ED40C6EA8;
        Tue, 12 Sep 2023 08:25:09 +0000 (UTC)
From:   =?UTF-8?q?Tom=C3=A1=C5=A1=20Glozar?= <tglozar@gmail.com>
To:     nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com,
        linux-kernel@vger.kernel.org, Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH] nd_btt: Make BTT lanes preemptible
Date:   Tue, 12 Sep 2023 10:24:40 +0200
Message-ID: <20230912082440.325189-1-tglozar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomas Glozar <tglozar@redhat.com>

nd_region_acquire_lane uses get_cpu, which disables preemption. This is
an issue on PREEMPT_RT kernels, since btt_write_pg and also
nd_region_acquire_lane itself take a spin lock, resulting in BUG:
sleeping function called from invalid context.

Fix the issue by replacing get_cpu with smp_process_id and
migrate_disable when needed. This makes BTT operations preemptible, thus
permitting the use of spin_lock.

Fixes: 5212e11fde4d ("nd_btt: atomic sector updates")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 drivers/nvdimm/region_devs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 0a81f87f6f6c..e2f1fb99707f 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -939,7 +939,8 @@ unsigned int nd_region_acquire_lane(struct nd_region *nd_region)
 {
 	unsigned int cpu, lane;
 
-	cpu = get_cpu();
+	migrate_disable();
+	cpu = smp_processor_id();
 	if (nd_region->num_lanes < nr_cpu_ids) {
 		struct nd_percpu_lane *ndl_lock, *ndl_count;
 
@@ -958,16 +959,15 @@ EXPORT_SYMBOL(nd_region_acquire_lane);
 void nd_region_release_lane(struct nd_region *nd_region, unsigned int lane)
 {
 	if (nd_region->num_lanes < nr_cpu_ids) {
-		unsigned int cpu = get_cpu();
+		unsigned int cpu = smp_processor_id();
 		struct nd_percpu_lane *ndl_lock, *ndl_count;
 
 		ndl_count = per_cpu_ptr(nd_region->lane, cpu);
 		ndl_lock = per_cpu_ptr(nd_region->lane, lane);
 		if (--ndl_count->count == 0)
 			spin_unlock(&ndl_lock->lock);
-		put_cpu();
 	}
-	put_cpu();
+	migrate_enable();
 }
 EXPORT_SYMBOL(nd_region_release_lane);
 
-- 
2.39.3

