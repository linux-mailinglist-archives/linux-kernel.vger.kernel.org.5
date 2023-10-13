Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3F47C8D73
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 21:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjJMTE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 15:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjJMTE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 15:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3BD95
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 12:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697223850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W2bd7t672x7Ht0iwDNlV5Z1QF/m/zxxAw+Mep/2+SWM=;
        b=chJk0ROs3j49E3wOZY2+zWVdNjn676wKbYFnobRT9GCd1ZYYX/EvSDTmsiv/RxrQHE5Hht
        CG+xqXD5rqibw7k9v0GzQyZaHaeR1l4TWAKTgfiE+kOX+FQU0coMe+KRq6FD5nipiWx9PR
        7ZOShU70cPsGvkU28+3xra889ywRcj0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-vGBE6-tDPteZJmvR5owYpg-1; Fri, 13 Oct 2023 15:04:06 -0400
X-MC-Unique: vGBE6-tDPteZJmvR5owYpg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B3CC85A5BA;
        Fri, 13 Oct 2023 19:04:06 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.33.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 00BE62157F5A;
        Fri, 13 Oct 2023 19:04:05 +0000 (UTC)
From:   Audra Mitchell <audra@redhat.com>
To:     linux-mm@kvack.org
Cc:     raquini@redhat.com, akpm@linux-foundation.org, djakov@kernel.org,
        vbabka@suse.cz, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] tools/mm: Remove references to free_ts from page_owner_sort
Date:   Fri, 13 Oct 2023 15:03:46 -0400
Message-ID: <20231013190350.579407-3-audra@redhat.com>
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

With the removal of free timestamps from page_owner output, we no longer
need to handle this case or the "unreleased" case. Remove all references
to both cases.

Signed-off-by: Audra Mitchell <audra@redhat.com>
---
 tools/mm/page_owner_sort.c | 98 +++++---------------------------------
 1 file changed, 12 insertions(+), 86 deletions(-)

diff --git a/tools/mm/page_owner_sort.c b/tools/mm/page_owner_sort.c
index 99798894b879..9c93f3f4514f 100644
--- a/tools/mm/page_owner_sort.c
+++ b/tools/mm/page_owner_sort.c
@@ -33,7 +33,6 @@ struct block_list {
 	char *comm; // task command name
 	char *stacktrace;
 	__u64 ts_nsec;
-	__u64 free_ts_nsec;
 	int len;
 	int num;
 	int page_num;
@@ -42,18 +41,16 @@ struct block_list {
 	int allocator;
 };
 enum FILTER_BIT {
-	FILTER_UNRELEASE = 1<<1,
-	FILTER_PID = 1<<2,
-	FILTER_TGID = 1<<3,
-	FILTER_COMM = 1<<4
+	FILTER_PID = 1<<1,
+	FILTER_TGID = 1<<2,
+	FILTER_COMM = 1<<3
 };
 enum CULL_BIT {
-	CULL_UNRELEASE = 1<<1,
-	CULL_PID = 1<<2,
-	CULL_TGID = 1<<3,
-	CULL_COMM = 1<<4,
-	CULL_STACKTRACE = 1<<5,
-	CULL_ALLOCATOR = 1<<6
+	CULL_PID = 1<<1,
+	CULL_TGID = 1<<2,
+	CULL_COMM = 1<<3,
+	CULL_STACKTRACE = 1<<4,
+	CULL_ALLOCATOR = 1<<5
 };
 enum ALLOCATOR_BIT {
 	ALLOCATOR_CMA = 1<<1,
@@ -62,9 +59,8 @@ enum ALLOCATOR_BIT {
 	ALLOCATOR_OTHERS = 1<<4
 };
 enum ARG_TYPE {
-	ARG_TXT, ARG_COMM, ARG_STACKTRACE, ARG_ALLOC_TS, ARG_FREE_TS,
-	ARG_CULL_TIME, ARG_PAGE_NUM, ARG_PID, ARG_TGID, ARG_UNKNOWN, ARG_FREE,
-	ARG_ALLOCATOR
+	ARG_TXT, ARG_COMM, ARG_STACKTRACE, ARG_ALLOC_TS, ARG_CULL_TIME,
+	ARG_PAGE_NUM, ARG_PID, ARG_TGID, ARG_UNKNOWN, ARG_ALLOCATOR
 };
 enum SORT_ORDER {
 	SORT_ASC = 1,
@@ -90,7 +86,6 @@ static regex_t pid_pattern;
 static regex_t tgid_pattern;
 static regex_t comm_pattern;
 static regex_t ts_nsec_pattern;
-static regex_t free_ts_nsec_pattern;
 static struct block_list *list;
 static int list_size;
 static int max_size;
@@ -181,24 +176,6 @@ static int compare_ts(const void *p1, const void *p2)
 	return l1->ts_nsec < l2->ts_nsec ? -1 : 1;
 }
 
-static int compare_free_ts(const void *p1, const void *p2)
-{
-	const struct block_list *l1 = p1, *l2 = p2;
-
-	return l1->free_ts_nsec < l2->free_ts_nsec ? -1 : 1;
-}
-
-static int compare_release(const void *p1, const void *p2)
-{
-	const struct block_list *l1 = p1, *l2 = p2;
-
-	if (!l1->free_ts_nsec && !l2->free_ts_nsec)
-		return 0;
-	if (l1->free_ts_nsec && l2->free_ts_nsec)
-		return 0;
-	return l1->free_ts_nsec ? 1 : -1;
-}
-
 static int compare_cull_condition(const void *p1, const void *p2)
 {
 	if (cull == 0)
@@ -211,8 +188,6 @@ static int compare_cull_condition(const void *p1, const void *p2)
 		return compare_tgid(p1, p2);
 	if ((cull & CULL_COMM) && compare_comm(p1, p2))
 		return compare_comm(p1, p2);
-	if ((cull & CULL_UNRELEASE) && compare_release(p1, p2))
-		return compare_release(p1, p2);
 	if ((cull & CULL_ALLOCATOR) && compare_allocator(p1, p2))
 		return compare_allocator(p1, p2);
 	return 0;
@@ -366,24 +341,6 @@ static __u64 get_ts_nsec(char *buf)
 	return ts_nsec;
 }
 
-static __u64 get_free_ts_nsec(char *buf)
-{
-	__u64 free_ts_nsec;
-	char free_ts_nsec_str[FIELD_BUFF] = {0};
-	char *endptr;
-
-	search_pattern(&free_ts_nsec_pattern, free_ts_nsec_str, buf);
-	errno = 0;
-	free_ts_nsec = strtoull(free_ts_nsec_str, &endptr, 10);
-	if (errno != 0 || endptr == free_ts_nsec_str || *endptr != '\0') {
-		if (debug_on)
-			fprintf(stderr, "wrong free_ts_nsec in follow buf:\n%s\n", buf);
-		return -1;
-	}
-
-	return free_ts_nsec;
-}
-
 static char *get_comm(char *buf)
 {
 	char *comm_str = malloc(TASK_COMM_LEN);
@@ -411,12 +368,8 @@ static int get_arg_type(const char *arg)
 		return  ARG_COMM;
 	else if (!strcmp(arg, "stacktrace") || !strcmp(arg, "st"))
 		return ARG_STACKTRACE;
-	else if (!strcmp(arg, "free") || !strcmp(arg, "f"))
-		return ARG_FREE;
 	else if (!strcmp(arg, "txt") || !strcmp(arg, "T"))
 		return ARG_TXT;
-	else if (!strcmp(arg, "free_ts") || !strcmp(arg, "ft"))
-		return ARG_FREE_TS;
 	else if (!strcmp(arg, "alloc_ts") || !strcmp(arg, "at"))
 		return ARG_ALLOC_TS;
 	else if (!strcmp(arg, "allocator") || !strcmp(arg, "ator"))
@@ -471,13 +424,6 @@ static bool match_str_list(const char *str, char **list, int list_size)
 
 static bool is_need(char *buf)
 {
-	__u64 ts_nsec, free_ts_nsec;
-
-	ts_nsec = get_ts_nsec(buf);
-	free_ts_nsec = get_free_ts_nsec(buf);
-
-	if ((filter & FILTER_UNRELEASE) && free_ts_nsec != 0 && ts_nsec < free_ts_nsec)
-		return false;
 	if ((filter & FILTER_PID) && !match_num_list(get_pid(buf), fc.pids, fc.pids_size))
 		return false;
 	if ((filter & FILTER_TGID) &&
@@ -528,7 +474,6 @@ static bool add_list(char *buf, int len, char *ext_buf)
 	if (*list[list_size].stacktrace == '\n')
 		list[list_size].stacktrace++;
 	list[list_size].ts_nsec = get_ts_nsec(buf);
-	list[list_size].free_ts_nsec = get_free_ts_nsec(buf);
 	list[list_size].allocator = get_allocator(buf, ext_buf);
 	list_size++;
 	if (list_size % 1000 == 0) {
@@ -554,8 +499,6 @@ static bool parse_cull_args(const char *arg_str)
 			cull |= CULL_COMM;
 		else if (arg_type == ARG_STACKTRACE)
 			cull |= CULL_STACKTRACE;
-		else if (arg_type == ARG_FREE)
-			cull |= CULL_UNRELEASE;
 		else if (arg_type == ARG_ALLOCATOR)
 			cull |= CULL_ALLOCATOR;
 		else {
@@ -616,8 +559,6 @@ static bool parse_sort_args(const char *arg_str)
 			sc.cmps[i] = compare_stacktrace;
 		else if (arg_type == ARG_ALLOC_TS)
 			sc.cmps[i] = compare_ts;
-		else if (arg_type == ARG_FREE_TS)
-			sc.cmps[i] = compare_free_ts;
 		else if (arg_type == ARG_TXT)
 			sc.cmps[i] = compare_txt;
 		else if (arg_type == ARG_ALLOCATOR)
@@ -679,8 +620,6 @@ static void usage(void)
 		"-P\t\tSort by tgid.\n"
 		"-n\t\tSort by task command name.\n"
 		"-a\t\tSort by memory allocate time.\n"
-		"-r\t\tSort by memory release time.\n"
-		"-f\t\tFilter out the information of blocks whose memory has been released.\n"
 		"-d\t\tPrint debug information.\n"
 		"--pid <pidlist>\tSelect by pid. This selects the information of blocks whose process ID numbers appear in <pidlist>.\n"
 		"--tgid <tgidlist>\tSelect by tgid. This selects the information of blocks whose Thread Group ID numbers appear in <tgidlist>.\n"
@@ -706,7 +645,7 @@ int main(int argc, char **argv)
 		{ 0, 0, 0, 0},
 	};
 
-	while ((opt = getopt_long(argc, argv, "adfmnprstP", longopts, NULL)) != -1)
+	while ((opt = getopt_long(argc, argv, "admnpstP", longopts, NULL)) != -1)
 		switch (opt) {
 		case 'a':
 			set_single_cmp(compare_ts, SORT_ASC);
@@ -714,18 +653,12 @@ int main(int argc, char **argv)
 		case 'd':
 			debug_on = true;
 			break;
-		case 'f':
-			filter = filter | FILTER_UNRELEASE;
-			break;
 		case 'm':
 			set_single_cmp(compare_page_num, SORT_DESC);
 			break;
 		case 'p':
 			set_single_cmp(compare_pid, SORT_ASC);
 			break;
-		case 'r':
-			set_single_cmp(compare_free_ts, SORT_ASC);
-			break;
 		case 's':
 			set_single_cmp(compare_stacktrace, SORT_ASC);
 			break;
@@ -800,10 +733,8 @@ int main(int argc, char **argv)
 		goto out_tgid;
 	if (!check_regcomp(&comm_pattern, "tgid\\s*[0-9]*\\s*\\((.*)\\),\\s*ts"))
 		goto out_comm;
-	if (!check_regcomp(&ts_nsec_pattern, "ts\\s*([0-9]*)\\s*ns,"))
+	if (!check_regcomp(&ts_nsec_pattern, "ts\\s*([0-9]*)\\s*ns"))
 		goto out_ts;
-	if (!check_regcomp(&free_ts_nsec_pattern, "free_ts\\s*([0-9]*)\\s*ns"))
-		goto out_free_ts;
 
 	fstat(fileno(fin), &st);
 	max_size = st.st_size / 100; /* hack ... */
@@ -864,9 +795,6 @@ int main(int argc, char **argv)
 				fprintf(fout, ", ");
 				print_allocator(fout, list[i].allocator);
 			}
-			if (cull & CULL_UNRELEASE)
-				fprintf(fout, " (%s)",
-						list[i].free_ts_nsec ? "UNRELEASED" : "RELEASED");
 			if (cull & CULL_STACKTRACE)
 				fprintf(fout, ":\n%s", list[i].stacktrace);
 			fprintf(fout, "\n");
@@ -880,8 +808,6 @@ int main(int argc, char **argv)
 		free(buf);
 	if (list)
 		free(list);
-out_free_ts:
-	regfree(&free_ts_nsec_pattern);
 out_ts:
 	regfree(&ts_nsec_pattern);
 out_comm:
-- 
2.41.0

