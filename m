Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E622678FFB6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350133AbjIAPMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350114AbjIAPMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:12:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC8010F0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693581067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0WkSoySUBrZdyHF12ktpxBNhTKhwA2sIbutQLbHd7Fo=;
        b=WfsFhDZE0O3OLaivDFmHTY45qcafG8+zXe5fg95ivsRW4Tydor832QWWQ1PmDMrR5wyhUe
        SVeQojb1wO0HmxfQgtnCa0yHgMgcEKlLSvocTP0ywzzUJV0A2iisDTgZLOZzIk4kVCdNsx
        J27CmNz3eVeVmB6LrNyx7TQ9DDG0sGA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-128-aqVpX8ZPPA6Dv3QM9t5dSw-1; Fri, 01 Sep 2023 11:11:03 -0400
X-MC-Unique: aqVpX8ZPPA6Dv3QM9t5dSw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29CC71817904;
        Fri,  1 Sep 2023 15:11:03 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.39.193.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B0432012F37;
        Fri,  1 Sep 2023 15:11:02 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 2/4] tracing/filters: Fix double-free of struct filter_pred.mask
Date:   Fri,  1 Sep 2023 17:10:37 +0200
Message-Id: <20230901151039.125186-3-vschneid@redhat.com>
In-Reply-To: <20230901151039.125186-1-vschneid@redhat.com>
References: <20230901151039.125186-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a cpulist filter is found to contain a single CPU, that CPU is saved
as a scalar and the backing cpumask storage is freed.

Also NULL the mask to avoid a double-free once we get down to
free_predicate().

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/trace/trace_events_filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index c06e1d596f4b9..eb331e8b00b61 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1773,6 +1773,7 @@ static int parse_pred(const char *str, void *data,
 		if (single) {
 			pred->val = cpumask_first(pred->mask);
 			kfree(pred->mask);
+			pred->mask = NULL;
 		}
 
 		if (field->filter_type == FILTER_CPUMASK) {
-- 
2.31.1

