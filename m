Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7777F7EB4F5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbjKNQd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjKNQdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:33:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B2811B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699979632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=u12QSukl/sf9yDwpJ5WMUElypfqqvvHxept5As9gCMA=;
        b=BBIquyvchw81uNuNUN7nHQvhMQRSfJbzkzoFTvAAX9o3is0eIngo7Xro6C81cH1UnPqVeS
        mCQ47sFZRGZVMxfQF5fh9bXQjHGhoNlMUBpMnPBSBXG5scXoOKf8fTu0Rtlyqi0r5ynATD
        vP2qsg9MONpO5XP8Bsuj8vMm6+jWVvQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-snAvf6GpMGSW2NMVnMYu4w-1; Tue, 14 Nov 2023 11:33:47 -0500
X-MC-Unique: snAvf6GpMGSW2NMVnMYu4w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CF7B85C6EA;
        Tue, 14 Nov 2023 16:33:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.253])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3EC072026D66;
        Tue, 14 Nov 2023 16:33:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 14 Nov 2023 17:32:42 +0100 (CET)
Date:   Tue, 14 Nov 2023 17:32:39 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>
Cc:     Chuyi Zhou <zhouchuyi@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kui-Feng Lee <kuifeng@fb.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH 3/3] bpf: bpf_iter_task_next: use next_task(kit->task) rather
 than next_task(kit->pos)
Message-ID: <20231114163239.GA903@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114163211.GA874@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks more clear and simplifies the code. While at it, remove the
unnecessary initialization of pos/task at the start of bpf_iter_task_new().

Note that we can even kill kit->task, we can just use pos->group_leader,
but I don't understand the BUILD_BUG_ON() checks in bpf_iter_task_new().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/bpf/task_iter.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index d42e08d0d0b7..e5c3500443c6 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -978,7 +978,6 @@ __bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it,
 	BUILD_BUG_ON(__alignof__(struct bpf_iter_task_kern) !=
 					__alignof__(struct bpf_iter_task));
 
-	kit->task = kit->pos = NULL;
 	switch (flags) {
 	case BPF_TASK_ITER_ALL_THREADS:
 	case BPF_TASK_ITER_ALL_PROCS:
@@ -1016,18 +1015,15 @@ __bpf_kfunc struct task_struct *bpf_iter_task_next(struct bpf_iter_task *it)
 		goto get_next_task;
 
 	kit->pos = __next_thread(kit->pos);
-	if (!kit->pos) {
-		if (flags == BPF_TASK_ITER_PROC_THREADS)
-			return pos;
-		kit->pos = kit->task;
-	} else
+	if (kit->pos || flags == BPF_TASK_ITER_PROC_THREADS)
 		return pos;
 
 get_next_task:
-	kit->pos = next_task(kit->pos);
-	kit->task = kit->pos;
-	if (kit->pos == &init_task)
+	kit->task = next_task(kit->task);
+	if (kit->task == &init_task)
 		kit->pos = NULL;
+	else
+		kit->pos = kit->task;
 
 	return pos;
 }
-- 
2.25.1.362.g51ebf55

