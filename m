Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80617DF684
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347630AbjKBPdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345328AbjKBPdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:33:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F8AFB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ldnPYKUyHMdijInwVZoC1NuQUIqnzmW6aookZYRZh1U=; b=jahtwHNhX+yr0vKRzO1fhTymzt
        SLnwIxFZMgFhCVyxgCoHHeHHNal4O09ds8khll2mHqBKCDVh1dg2ozVPmfCLnj1HDCscJXKAOx2eX
        Ee3F4Kb5E8i3CTw3G4yB+MVmOgYao23eRwYHX4UqNBoo4R/keJ47nkef3A28xvpucksuTa99bXHb3
        ZW43WHCx7msUMSWBXjVDb+1D1Hb+R6OMJ9U7Jo1IMe6/becw+Moi5BFHjwsuOCeCEbCAiVuL+MJoK
        iFR/PUCJJU0V312y8oU8NDuqXEHCEFTrLny4nBVxCbIIoheFbGQeGydTLEw4m7Viz9C3J0D2Xgiab
        tZ/njmDA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qyZgU-0005PD-UQ; Thu, 02 Nov 2023 15:32:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 4397930098F; Thu,  2 Nov 2023 16:32:39 +0100 (CET)
Message-Id: <20231102152018.069585432@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 02 Nov 2023 16:09:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com
Subject: [PATCH 03/13] perf: Simplify perf_fget_light()
References: <20231102150919.719936610@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce fdnull and use it to simplify perf_fget_light() to either
return a valid struct fd or not -- much like fdget() itself.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/file.h |    7 ++++++-
 kernel/events/core.c |   22 +++++++++++-----------
 2 files changed, 17 insertions(+), 12 deletions(-)

--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -59,6 +59,8 @@ static inline struct fd __to_fd(unsigned
 	return (struct fd){(struct file *)(v & ~3),v & 3};
 }
 
+#define fdnull __to_fd(0)
+
 static inline struct fd fdget(unsigned int fd)
 {
 	return __to_fd(__fdget(fd));
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5802,18 +5802,17 @@ EXPORT_SYMBOL_GPL(perf_event_period);
 
 static const struct file_operations perf_fops;
 
-static inline int perf_fget_light(int fd, struct fd *p)
+static inline struct fd perf_fdget(int fd)
 {
 	struct fd f = fdget(fd);
 	if (!f.file)
-		return -EBADF;
+		return fdnull;
 
 	if (f.file->f_op != &perf_fops) {
 		fdput(f);
-		return -EBADF;
+		return fdnull;
 	}
-	*p = f;
-	return 0;
+	return f;
 }
 
 static int perf_event_set_output(struct perf_event *event,
@@ -5864,10 +5863,9 @@ static long _perf_ioctl(struct perf_even
 		int ret;
 		if (arg != -1) {
 			struct perf_event *output_event;
-			struct fd output;
-			ret = perf_fget_light(arg, &output);
-			if (ret)
-				return ret;
+			struct fd output = perf_fdget(arg);
+			if (!output.file)
+				return -EBADF;
 			output_event = output.file->private_data;
 			ret = perf_event_set_output(event, output_event);
 			fdput(output);
@@ -12401,9 +12399,11 @@ SYSCALL_DEFINE5(perf_event_open,
 		return event_fd;
 
 	if (group_fd != -1) {
-		err = perf_fget_light(group_fd, &group);
-		if (err)
+		group = perf_fdget(group_fd);
+		if (!group.file) {
+			err = -EBADF;
 			goto err_fd;
+		}
 		group_leader = group.file->private_data;
 		if (flags & PERF_FLAG_FD_OUTPUT)
 			output_event = group_leader;


