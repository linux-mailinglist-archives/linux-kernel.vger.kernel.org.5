Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C5D78EDC2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346175AbjHaMzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243034AbjHaMzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:55:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE550CF2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693486497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cMsX5nBfb23hEuPzCptzvRIDXnrXr0QfihjCT9ZyFbI=;
        b=bmHz8MF6eBFP4FJyOcWIF5WdEUSnp9y/t97aqk1bSZoLrzXsb58e7/VECppv92nOEOjuYA
        SLNuqSVVPLCdzBSXmbzhQDmZyYQ6xfjgqw0BkUH3FsJiwo+PhVSr/yiDy8qtThyQ7eEiIk
        XFkmnSfBbL9F9+jm+Omt/gPTwsmgIuA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-SOzm8YnbNm2aPAHakOuC6g-1; Thu, 31 Aug 2023 08:54:53 -0400
X-MC-Unique: SOzm8YnbNm2aPAHakOuC6g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A796858EED;
        Thu, 31 Aug 2023 12:54:53 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.16.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4D8F1121315;
        Thu, 31 Aug 2023 12:54:52 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        zhengyejian1@huawei.com
Subject: [PATCH] tracing: zero the pipe cpumask on alloc to avoid spurious -EBUSY
Date:   Thu, 31 Aug 2023 08:55:00 -0400
Message-ID: <20230831125500.986862-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pipe cpumask used to serialize opens between the main and percpu
trace pipes is not zeroed or initialized. This can result in
spurious -EBUSY returns if underlying memory is not fully zeroed.
This has been observed by immediate failure to read the main
trace_pipe file on an otherwise newly booted and idle system:

 # cat /sys/kernel/debug/tracing/trace_pipe
 cat: /sys/kernel/debug/tracing/trace_pipe: Device or resource busy

Zero the allocation of pipe_cpumask to avoid the problem.

Fixes: c2489bb7e6be ("tracing: Introduce pipe_cpumask to avoid race on trace_pipes")
Signed-off-by: Brian Foster <bfoster@redhat.com>
---

Hi,

I ran into this problem just recently on one of my test VMs immediately
after updating to a v6.5 base. A revert of the aforementioned commit
addressed the problem. I'm not terribly familiar with the tracing code,
but on further inspection I noticed the cpumask doesn't appear to be
initialized anywhere. I suppose this could alternatively do a
cpumask_clear() or whatever after allocation, but either way this
addresses the problem for me.

Please CC on replies as I'm not subscribed to the list. Thanks.

Brian

 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8e64aaad5361..2656ca3b9b39 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9486,7 +9486,7 @@ static struct trace_array *trace_array_create(const char *name)
 	if (!alloc_cpumask_var(&tr->tracing_cpumask, GFP_KERNEL))
 		goto out_free_tr;
 
-	if (!alloc_cpumask_var(&tr->pipe_cpumask, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&tr->pipe_cpumask, GFP_KERNEL))
 		goto out_free_tr;
 
 	tr->trace_flags = global_trace.trace_flags & ~ZEROED_TRACE_FLAGS;
@@ -10431,7 +10431,7 @@ __init static int tracer_alloc_buffers(void)
 	if (trace_create_savedcmd() < 0)
 		goto out_free_temp_buffer;
 
-	if (!alloc_cpumask_var(&global_trace.pipe_cpumask, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&global_trace.pipe_cpumask, GFP_KERNEL))
 		goto out_free_savedcmd;
 
 	/* TODO: make the number of buffers hot pluggable with CPUS */
-- 
2.41.0

