Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407C67FFCF7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376776AbjK3Unv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376408AbjK3Uno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:43:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C43171D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701377029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DlJxse7VR/q1n51PSliVgyIuHZ/VI5Kr3VkztHHMLrk=;
        b=PlUujg4HuExQyzI+8Qk9BynFsuH4LQQBw19QfnMjqhN2cT5xMQk/Ha3OKicIdBJb7tocW0
        HVgsl8DbKLHqbblq3d7TU7OhffiDHVyII9l+a1NGuFF8gznf4MbD5tKp2WQ0cCPt4l6fob
        jzrpejI34OItPiIBxct34DI7PbtDhQQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-iFhoK-N_OQq3aTIK0XPlnA-1; Thu, 30 Nov 2023 15:43:45 -0500
X-MC-Unique: iFhoK-N_OQq3aTIK0XPlnA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8020185A785;
        Thu, 30 Nov 2023 20:43:44 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3269E40C6EB9;
        Thu, 30 Nov 2023 20:43:44 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Mario <jmario@redhat.com>,
        Sebastian Jug <sejug@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup v5 2/2] cgroup: Avoid false cacheline sharing of read mostly rstat_cpu
Date:   Thu, 30 Nov 2023 15:43:27 -0500
Message-Id: <20231130204327.494249-3-longman@redhat.com>
In-Reply-To: <20231130204327.494249-1-longman@redhat.com>
References: <20231130204327.494249-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
       0-01 us         9,928,562          9,820,428
      01-05 us           110,151             50,935
      05-10 us               270                 93
      10-15 us               273                146
      15-20 us               135                 76
      20-25 us                 0                  2
      25-30 us                 1                  0

It can be seen that the patch further pushes the lock hold time towards
the lower end.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/cgroup-defs.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 37518436cfe7..5a97ea95b564 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -496,6 +496,13 @@ struct cgroup {
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

