Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B718799A41
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 19:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbjIIR1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 13:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236371AbjIIR1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 13:27:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B73912C
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 10:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694280411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=HG6Yn0fD2kZPoFDcORRGozf+b3SCd3TUNd5VwyngIMQ=;
        b=LzaP/HRe5VCNvwNyK5Sq/KkCgq8C0Fis8UcCMTN0ExdLRWoCzFXbgPWDxCojHFoATXGbCX
        Rv+0XP6S1tRMCPlEJ+RO/7h70eVZW33YJ+Bs49nvzi7Ecxv+tL7pBrvsgUbNsVL+1PE/8g
        M20RspVnca/FSDPUVBxkhW/L7eX9rxk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-coX7q9YbMbyW4NLMWVm3zQ-1; Sat, 09 Sep 2023 13:26:48 -0400
X-MC-Unique: coX7q9YbMbyW4NLMWVm3zQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0C298015AA;
        Sat,  9 Sep 2023 17:26:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id D849F2012F37;
        Sat,  9 Sep 2023 17:26:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat,  9 Sep 2023 19:25:56 +0200 (CEST)
Date:   Sat, 9 Sep 2023 19:25:54 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] getrusage: add the "signal_struct *sig" local variable
Message-ID: <20230909172554.GA20441@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes, cleanup/preparation.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/sys.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 2410e3999ebe..097cbea62a72 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1786,6 +1786,7 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 	unsigned long flags;
 	u64 tgutime, tgstime, utime, stime;
 	unsigned long maxrss = 0;
+	struct signal_struct *sig = p->signal;
 
 	memset((char *)r, 0, sizeof (*r));
 	utime = stime = 0;
@@ -1793,7 +1794,7 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 	if (who == RUSAGE_THREAD) {
 		task_cputime_adjusted(current, &utime, &stime);
 		accumulate_thread_rusage(p, r);
-		maxrss = p->signal->maxrss;
+		maxrss = sig->maxrss;
 		goto out;
 	}
 
@@ -1803,15 +1804,15 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 	switch (who) {
 	case RUSAGE_BOTH:
 	case RUSAGE_CHILDREN:
-		utime = p->signal->cutime;
-		stime = p->signal->cstime;
-		r->ru_nvcsw = p->signal->cnvcsw;
-		r->ru_nivcsw = p->signal->cnivcsw;
-		r->ru_minflt = p->signal->cmin_flt;
-		r->ru_majflt = p->signal->cmaj_flt;
-		r->ru_inblock = p->signal->cinblock;
-		r->ru_oublock = p->signal->coublock;
-		maxrss = p->signal->cmaxrss;
+		utime = sig->cutime;
+		stime = sig->cstime;
+		r->ru_nvcsw = sig->cnvcsw;
+		r->ru_nivcsw = sig->cnivcsw;
+		r->ru_minflt = sig->cmin_flt;
+		r->ru_majflt = sig->cmaj_flt;
+		r->ru_inblock = sig->cinblock;
+		r->ru_oublock = sig->coublock;
+		maxrss = sig->cmaxrss;
 
 		if (who == RUSAGE_CHILDREN)
 			break;
@@ -1821,14 +1822,14 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 		thread_group_cputime_adjusted(p, &tgutime, &tgstime);
 		utime += tgutime;
 		stime += tgstime;
-		r->ru_nvcsw += p->signal->nvcsw;
-		r->ru_nivcsw += p->signal->nivcsw;
-		r->ru_minflt += p->signal->min_flt;
-		r->ru_majflt += p->signal->maj_flt;
-		r->ru_inblock += p->signal->inblock;
-		r->ru_oublock += p->signal->oublock;
-		if (maxrss < p->signal->maxrss)
-			maxrss = p->signal->maxrss;
+		r->ru_nvcsw += sig->nvcsw;
+		r->ru_nivcsw += sig->nivcsw;
+		r->ru_minflt += sig->min_flt;
+		r->ru_majflt += sig->maj_flt;
+		r->ru_inblock += sig->inblock;
+		r->ru_oublock += sig->oublock;
+		if (maxrss < sig->maxrss)
+			maxrss = sig->maxrss;
 		t = p;
 		do {
 			accumulate_thread_rusage(t, r);
-- 
2.25.1.362.g51ebf55


