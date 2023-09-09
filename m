Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE44799A42
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 19:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237293AbjIIR2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 13:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbjIIR2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 13:28:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4C9132
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 10:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694280445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u03sgd3fgOsRd0JFDZyPxvLZYkelxDPmhK1T2JbjEHY=;
        b=WDVYQTyeUnhdtPV+cHgCk9UKxK2jkMipZur3vooDcDE2m0tBKuVtMsYRRpnCvTPkwq3NzG
        Ld32fzOGzrvNeQSJM5G4unl4E0zxbGkVTJn8T9RYCDRHrOprPeBPYKnKWwK3vh9WSOGD4U
        M6zCDBtdKFk1pp5HYNELgJDbVm4N/co=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-WaTb0Ba5OHaX7dEJLZ-q2w-1; Sat, 09 Sep 2023 13:27:22 -0400
X-MC-Unique: WaTb0Ba5OHaX7dEJLZ-q2w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 828798030A9;
        Sat,  9 Sep 2023 17:27:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id 76BB440F063;
        Sat,  9 Sep 2023 17:27:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat,  9 Sep 2023 19:26:30 +0200 (CEST)
Date:   Sat, 9 Sep 2023 19:26:29 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] getrusage: use __for_each_thread()
Message-ID: <20230909172629.GA20454@redhat.com>
References: <20230909172554.GA20441@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230909172554.GA20441@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do/while_each_thread should be avoided when possible.

Plus this change allows to avoid lock_task_sighand(), we can use rcu
and/or sig->stats_lock instead.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/sys.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 097cbea62a72..67436d465be4 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1830,10 +1830,8 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 		r->ru_oublock += sig->oublock;
 		if (maxrss < sig->maxrss)
 			maxrss = sig->maxrss;
-		t = p;
-		do {
+		__for_each_thread(sig, t)
 			accumulate_thread_rusage(t, r);
-		} while_each_thread(p, t);
 		break;
 
 	default:
-- 
2.25.1.362.g51ebf55


