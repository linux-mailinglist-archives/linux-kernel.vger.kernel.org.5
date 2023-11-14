Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B617EB4F3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjKNQdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbjKNQdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:33:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48AD182
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699979629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=2Mg3UCFMr1SH7PUf+Sl5YMeVrQDgFkP/RxqlBy+YY5Y=;
        b=KMLxl460hnji69qZ7WIoNEWpWS44Ei8hH6CpZZIXFIFrsOWvyAPmp4FiJqmqZV1c39vd4z
        iYkgXySYtQlgacst/95ZWpbJTcIHrFLUEWr4kiWeQOSO8zp/JQQbtTwiYGf2b/C4u0mHPN
        mfs2WeyZFheM3mzTjEkHT2rGLyvcO+8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-areqUpPuN-OXmCaWVP_OIg-1; Tue, 14 Nov 2023 11:33:45 -0500
X-MC-Unique: areqUpPuN-OXmCaWVP_OIg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24813811E93;
        Tue, 14 Nov 2023 16:33:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.253])
        by smtp.corp.redhat.com (Postfix) with SMTP id 46294493113;
        Tue, 14 Nov 2023 16:33:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 14 Nov 2023 17:32:39 +0100 (CET)
Date:   Tue, 14 Nov 2023 17:32:37 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>
Cc:     Chuyi Zhou <zhouchuyi@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kui-Feng Lee <kuifeng@fb.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH 2/3] bpf: bpf_iter_task_next: use __next_thread() rather than
 next_thread()
Message-ID: <20231114163237.GA897@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114163211.GA874@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lockless use of next_thread() should be avoided, kernel/bpf/task_iter.c
is the last user and the usage is wrong.

bpf_iter_task_next() can loop forever, "kit->pos == kit->task" can never
happen if kit->pos execs. Change this code to use __next_thread().

With or without this change the usage of kit->pos/task and next_task()
doesn't look nice, see the next patch.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/bpf/task_iter.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 51ae15e2b290..d42e08d0d0b7 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -1015,12 +1015,11 @@ __bpf_kfunc struct task_struct *bpf_iter_task_next(struct bpf_iter_task *it)
 	if (flags == BPF_TASK_ITER_ALL_PROCS)
 		goto get_next_task;
 
-	kit->pos = next_thread(kit->pos);
-	if (kit->pos == kit->task) {
-		if (flags == BPF_TASK_ITER_PROC_THREADS) {
-			kit->pos = NULL;
+	kit->pos = __next_thread(kit->pos);
+	if (!kit->pos) {
+		if (flags == BPF_TASK_ITER_PROC_THREADS)
 			return pos;
-		}
+		kit->pos = kit->task;
 	} else
 		return pos;
 
-- 
2.25.1.362.g51ebf55

