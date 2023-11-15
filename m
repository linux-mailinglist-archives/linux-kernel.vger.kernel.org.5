Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51ED87E0D6E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 04:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345861AbjKDDO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 23:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbjKDDOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 23:14:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A73D6C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 20:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699067603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XmQVU6t74ex4eso68OgbidZVE99nykXUpQNQesplaTI=;
        b=MfhWmoQEMiiewXFHr0+pWOsUiZ0JJq+sLGdg8DwztwkARIWC+gBwun3UiCf7X2moDRLkn7
        fE1uRFrG9XqEq4mUevGEZFmfWEF1wTsq6yKW17OpbSNQuT1FCdNfKBDzRFfese57cUQ63o
        HPBiI17VrYke9LyAwwLslHtuXD5gEAA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-OUuOja0NPyqBrgMW7m7vhg-1; Fri,
 03 Nov 2023 23:13:19 -0400
X-MC-Unique: OUuOja0NPyqBrgMW7m7vhg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D11B1C05148;
        Sat,  4 Nov 2023 03:13:19 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 987BAC1290F;
        Sat,  4 Nov 2023 03:13:18 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Mario <jmario@redhat.com>,
        Sebastian Jug <sejug@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3 3/3] cgroup: Avoid false cacheline sharing of read mostly rstat_cpu
Date:   Fri,  3 Nov 2023 23:13:03 -0400
Message-Id: <20231104031303.592879-4-longman@redhat.com>
In-Reply-To: <20231104031303.592879-1-longman@redhat.com>
References: <20231104031303.592879-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
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

