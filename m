Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAA67C8D76
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 21:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjJMTFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 15:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjJMTFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 15:05:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A37FC0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 12:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697223871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mbcGDdPDyjQuCaqCE5MIIL6VIXi6uhOqjz8GCAoYgAs=;
        b=QEJ7308yCLN7gdXapeovVij1isOyneLaHBywaDGmaGzM/QiG7Qsudtsb2XZx3KM48Hee7h
        B1D9ASSM+Gcxpw0YOUoz1lx+zMC1M9uqyOdaJqOdwGxMcM/C+eHk/7a+z0D35rCXWWmgvy
        3fF1fXzTmg6Gy7njbh4xMxEBO+0WzQw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-jTkVSu38NWqJ-9Hlh8G7xw-1; Fri, 13 Oct 2023 15:04:07 -0400
X-MC-Unique: jTkVSu38NWqJ-9Hlh8G7xw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9D661029F40;
        Fri, 13 Oct 2023 19:04:06 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.33.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F2432157F5A;
        Fri, 13 Oct 2023 19:04:06 +0000 (UTC)
From:   Audra Mitchell <audra@redhat.com>
To:     linux-mm@kvack.org
Cc:     raquini@redhat.com, akpm@linux-foundation.org, djakov@kernel.org,
        vbabka@suse.cz, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] tools/mm: Fix the default case for page_owner_sort
Date:   Fri, 13 Oct 2023 15:03:48 -0400
Message-ID: <20231013190350.579407-5-audra@redhat.com>
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

With the additional commands and timestamps added to the tool, the default
case (-t) has been broken. Now that the allocation timestamps are saved
outside of the txt field, allow us to properly sort the data by number of
times the record has been seen. Furthermore prevent the misuse of the
commandline arguments so only one compare option can be used.

Signed-off-by: Audra Mitchell <audra@redhat.com>
---
 tools/mm/page_owner_sort.c | 61 +++++++++++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 8 deletions(-)

diff --git a/tools/mm/page_owner_sort.c b/tools/mm/page_owner_sort.c
index 7ddabcb3a073..5a260096ebaa 100644
--- a/tools/mm/page_owner_sort.c
+++ b/tools/mm/page_owner_sort.c
@@ -66,6 +66,16 @@ enum SORT_ORDER {
 	SORT_ASC = 1,
 	SORT_DESC = -1,
 };
+enum COMP_FLAG {
+	COMP_NO_FLAG = 0,
+	COMP_ALLOC = 1<<0,
+	COMP_PAGE_NUM = 1<<1,
+	COMP_PID = 1<<2,
+	COMP_STACK = 1<<3,
+	COMP_NUM = 1<<4,
+	COMP_TGID = 1<<5,
+	COMP_COMM = 1<<6
+};
 struct filter_condition {
 	pid_t *pids;
 	pid_t *tgids;
@@ -644,7 +654,7 @@ int main(int argc, char **argv)
 {
 	FILE *fin, *fout;
 	char *buf, *ext_buf;
-	int i, count;
+	int i, count, compare_flag;
 	struct stat st;
 	int opt;
 	struct option longopts[] = {
@@ -656,31 +666,33 @@ int main(int argc, char **argv)
 		{ 0, 0, 0, 0},
 	};
 
+	compare_flag = COMP_NO_FLAG;
+
 	while ((opt = getopt_long(argc, argv, "admnpstP", longopts, NULL)) != -1)
 		switch (opt) {
 		case 'a':
-			set_single_cmp(compare_ts, SORT_ASC);
+			compare_flag |= COMP_ALLOC;
 			break;
 		case 'd':
 			debug_on = true;
 			break;
 		case 'm':
-			set_single_cmp(compare_page_num, SORT_DESC);
+			compare_flag |= COMP_PAGE_NUM;
 			break;
 		case 'p':
-			set_single_cmp(compare_pid, SORT_ASC);
+			compare_flag |= COMP_PID;
 			break;
 		case 's':
-			set_single_cmp(compare_stacktrace, SORT_ASC);
+			compare_flag |= COMP_STACK;
 			break;
 		case 't':
-			set_single_cmp(compare_num, SORT_DESC);
+			compare_flag |= COMP_NUM;
 			break;
 		case 'P':
-			set_single_cmp(compare_tgid, SORT_ASC);
+			compare_flag |= COMP_TGID;
 			break;
 		case 'n':
-			set_single_cmp(compare_comm, SORT_ASC);
+			compare_flag |= COMP_COMM;
 			break;
 		case 1:
 			filter = filter | FILTER_PID;
@@ -728,6 +740,39 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
+	/* Only one compare option is allowed, yet we also want handle the
+	 * default case were no option is provided, but we still want to
+	 * match the behavior of the -t option (compare by number of times
+	 * a record is seen
+	 */
+	switch (compare_flag) {
+	case COMP_ALLOC:
+		set_single_cmp(compare_ts, SORT_ASC);
+		break;
+	case COMP_PAGE_NUM:
+		set_single_cmp(compare_page_num, SORT_DESC);
+		break;
+	case COMP_PID:
+		set_single_cmp(compare_pid, SORT_ASC);
+		break;
+	case COMP_STACK:
+		set_single_cmp(compare_stacktrace, SORT_ASC);
+		break;
+	case COMP_NO_FLAG:
+	case COMP_NUM:
+		set_single_cmp(compare_num, SORT_DESC);
+		break;
+	case COMP_TGID:
+		set_single_cmp(compare_tgid, SORT_ASC);
+		break;
+	case COMP_COMM:
+		set_single_cmp(compare_comm, SORT_ASC);
+		break;
+	default:
+		usage();
+		exit(1);
+	}
+
 	fin = fopen(argv[optind], "r");
 	fout = fopen(argv[optind + 1], "w");
 	if (!fin || !fout) {
-- 
2.41.0

