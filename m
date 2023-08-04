Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCB176FA72
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 08:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbjHDGvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 02:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbjHDGvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:51:19 -0400
Received: from out-118.mta1.migadu.com (out-118.mta1.migadu.com [IPv6:2001:41d0:203:375::76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260A55248
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 23:50:55 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691131854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zxLKOBj7wIHNRdSalkXgxfxEOVasPtHv6AvF944bYZE=;
        b=mvpRv1+bRyyifvUHQhFtMF1aGHzLQjXFyxTvOLG+1OCmGKyUN5wltRQBi2683v1N8R0pMd
        BLqR1EhtekRy4twLO9hfzdbukyI/ftgRrfhhToFBwJQ8nai5u73FuuNR9iYKTf5ZnjtCkh
        B5q3OUTb6CVz3SOgAxzRw6kb9w9c3hw=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
Subject: [PATCH 1/3] iocost_monitor: fix kernel queue kobj changes
Date:   Fri,  4 Aug 2023 14:50:37 +0800
Message-ID: <20230804065039.8885-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

When I use iocost_monitor on nvme0n1, this error shows up:
"Could not find ioc for nvme0n1"

There is no kobj in struct queue in recent kernel, it seems that the commit
2bd85221a625 ("block: untangle request_queue refcounting from sysfs")
move the queue kobj to struct gendisk.

Fix it by using mq_kobj which is at the same level with queue kobj.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 tools/cgroup/iocost_monitor.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/cgroup/iocost_monitor.py b/tools/cgroup/iocost_monitor.py
index 0dbbc67400fc..7aa076cb559e 100644
--- a/tools/cgroup/iocost_monitor.py
+++ b/tools/cgroup/iocost_monitor.py
@@ -221,7 +221,7 @@ ioc = None
 for i, ptr in radix_tree_for_each(blkcg_root.blkg_tree.address_of_()):
     blkg = drgn.Object(prog, 'struct blkcg_gq', address=ptr)
     try:
-        if devname == blkg.q.kobj.parent.name.string_().decode('utf-8'):
+        if devname == blkg.q.mq_kobj.parent.name.string_().decode('utf-8'):
             q_id = blkg.q.id.value_()
             if blkg.pd[plid]:
                 root_iocg = container_of(blkg.pd[plid], 'struct ioc_gq', 'pd')
-- 
2.41.0

