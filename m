Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9772D7C8D74
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 21:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjJMTFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 15:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjJMTFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 15:05:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CF5BF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 12:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697223854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zR5p3ioGj44ReczmQkXwckrYVMKEAFkp4XWCVgfnl84=;
        b=S7vm8MUJfBKHRToOJzXWHYHQK8xMj4nepiIWZ5dxKGCwpk6GsPU+6CJjr5YcJ1ECEL0n4G
        vEX0bn2lBWsN8S4QnxJDA9tVe8Rd4yLqv00uFv11Wu77atiE6vCAUVl/NYdkX8Z0k9pYP2
        VSH7yZgnGmdrUDr0pXg7IR1Mfo8y+Os=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-TnrzPz-tMWW8slqjaMdDHg-1; Fri, 13 Oct 2023 15:04:10 -0400
X-MC-Unique: TnrzPz-tMWW8slqjaMdDHg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82CEF185A795;
        Fri, 13 Oct 2023 19:04:06 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.33.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 482022157F5A;
        Fri, 13 Oct 2023 19:04:06 +0000 (UTC)
From:   Audra Mitchell <audra@redhat.com>
To:     linux-mm@kvack.org
Cc:     raquini@redhat.com, akpm@linux-foundation.org, djakov@kernel.org,
        vbabka@suse.cz, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] tools/mm: Filter out timestamps for correct collation
Date:   Fri, 13 Oct 2023 15:03:47 -0400
Message-ID: <20231013190350.579407-4-audra@redhat.com>
In-Reply-To: <20231013190350.579407-1-audra@redhat.com>
References: <20231013190350.579407-1-audra@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of allocation timestamps being included in page_owner
output, each record becomes unique due to the timestamp nanosecond
granularity. Remove the check in add_list that tries to collate each record
during processing as the memcmp() is just additional overhead at this
point.

Also keep the allocation timestamps, but allow collation to occur without
consideration of the allocation timestamp except in the case were
allocation timestamps are requested by the user (the -a option).

Signed-off-by: Audra Mitchell <audra@redhat.com>
---
 tools/mm/page_owner_sort.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/tools/mm/page_owner_sort.c b/tools/mm/page_owner_sort.c
index 9c93f3f4514f..7ddabcb3a073 100644
--- a/tools/mm/page_owner_sort.c
+++ b/tools/mm/page_owner_sort.c
@@ -203,6 +203,21 @@ static int compare_sort_condition(const void *p1, const void *p2)
 	return cmp;
 }
 
+static int remove_pattern(regex_t *pattern, char *buf, int len)
+{
+	regmatch_t pmatch[2];
+	int err;
+
+	err = regexec(pattern, buf, 2, pmatch, REG_NOTBOL);
+	if (err != 0 || pmatch[1].rm_so == -1)
+		return len;
+
+	memcpy(buf + pmatch[1].rm_so,
+		buf + pmatch[1].rm_eo, len - pmatch[1].rm_eo);
+
+	return len - (pmatch[1].rm_eo - pmatch[1].rm_so);
+}
+
 static int search_pattern(regex_t *pattern, char *pattern_str, char *buf)
 {
 	int err, val_len;
@@ -443,13 +458,6 @@ static bool is_need(char *buf)
 
 static bool add_list(char *buf, int len, char *ext_buf)
 {
-	if (list_size != 0 &&
-		len == list[list_size-1].len &&
-		memcmp(buf, list[list_size-1].txt, len) == 0) {
-		list[list_size-1].num++;
-		list[list_size-1].page_num += get_page_num(buf);
-		return true;
-	}
 	if (list_size == max_size) {
 		fprintf(stderr, "max_size too small??\n");
 		return false;
@@ -465,6 +473,9 @@ static bool add_list(char *buf, int len, char *ext_buf)
 		return false;
 	}
 	memcpy(list[list_size].txt, buf, len);
+	if (sc.cmps[0] != compare_ts) {
+		len = remove_pattern(&ts_nsec_pattern, list[list_size].txt, len);
+	}
 	list[list_size].txt[len] = 0;
 	list[list_size].len = len;
 	list[list_size].num = 1;
-- 
2.41.0

