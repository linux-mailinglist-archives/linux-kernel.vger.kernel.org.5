Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68ED07E2E9C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjKFVHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbjKFVHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:07:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F668D78
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699304773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XmQVU6t74ex4eso68OgbidZVE99nykXUpQNQesplaTI=;
        b=Vuj+fMfO0up3UOfyeYBZObUGeidF1Z6QqupBtbwNxabgwNiiVScvJGqKQ9jM6KNs/+Y/zf
        o2NJOL70KMslc4wo8mD3hAoFgR7zXDyCznmUgejx+iTR5tBraVkPEG8X5VlzlVmGZzhvg4
        LAWT/wEXVeBb1XGY16EZmSnkyj2YwE4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-gw2tMBDePVuaeSbAcBUdnw-1; Mon, 06 Nov 2023 16:06:10 -0500
X-MC-Unique: gw2tMBDePVuaeSbAcBUdnw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B38D9845DCE;
        Mon,  6 Nov 2023 21:06:09 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4781FC1290F;
        Mon,  6 Nov 2023 21:06:09 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Mario <jmario@redhat.com>,
        Sebastian Jug <sejug@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 3/3] cgroup: Avoid false cacheline sharing of read mostly rstat_cpu
Date:   Mon,  6 Nov 2023 16:05:43 -0500
Message-Id: <20231106210543.717486-4-longman@redhat.com>
In-Reply-To: <20231106210543.717486-1-longman@redhat.com>
References: <20231106210543.717486-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rstat_cpu and also rstat_css_list of the cgroup structure are read
mostly variables. However, they may share the same cacheline as the
subsequent rstat_flush_next and *bstat variables which can be updated
frequently.  That will slow down the cgroup_rstat_cpu() call which is
called pretty frequently in the rstat code. Add a CACHELINE_PADDING()
line in between them to avoid false cacheline sharing.

A parallel kernel build on a 2-socket x86-64 server is used as the
benchmarking tool for measuring the lock hold time. Below were the lock
hold time frequency distribution before and after the patch:

      Run time        Before patch       After patch
      --------        ------------       -----------
       0-01 us        14,594,545         15,484,707
      01-05 us           439,926            207,382
      05-10 us             5,960              3,174
      10-15 us             3,543              3,006
      15-20 us             1,397              1,066
      20-25 us                25                 15
      25-30 us                12                 10

It can be seen that the patch further pushes the lock hold time towards
the lower end.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/cgroup-defs.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index ff4b4c590f32..a4adc0580135 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -491,6 +491,13 @@ struct cgroup {
 	struct cgroup_rstat_cpu __percpu *rstat_cpu;
 	struct list_head rstat_css_list;
 
+	/*
+	 * Add padding to separate the read mostly rstat_cpu and
+	 * rstat_css_list into a different cacheline from the following
+	 * rstat_flush_next and *bstat fields which can have frequent updates.
+	 */
+	CACHELINE_PADDING(_pad_);
+
 	/*
 	 * A singly-linked list of cgroup structures to be rstat flushed.
 	 * This is a scratch field to be used exclusively by
-- 
2.39.3

