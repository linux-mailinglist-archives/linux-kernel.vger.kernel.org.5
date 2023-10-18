Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F227CE81F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjJRTt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjJRTtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:49:01 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F62136;
        Wed, 18 Oct 2023 12:48:58 -0700 (PDT)
Received: from smtp.gmail.com (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 0AFB44166B;
        Wed, 18 Oct 2023 19:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697658536;
        bh=G7TCMHI4oCzFilfHL+ENbckNckZnrbLoJwyPDTUJMfY=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=off3pYGxqrhP/ZOROGSot/iom+Qsa3Oo0XFxLOJ979EOZ91Y4nDmMW0fBtJN8/nPt
         DlbMarLAI95kNAuDsX2HXXPP5ftl+TfH55ZA91AbcPZjtTppyBKJPmVwfH6Grw3zfx
         HQ8xfrwcHi5HvYKH9ysrxnu0e43QZHJjGic3LWHh/EdIgFY0e14AbsSzM6xMGf1iPf
         45I9/kH5KxXOg7pm/k8sykdoQCH5zwNpbVC3sSg62HD62ELXt0ugxcqYXg3mcge/t1
         IeRkFY4DGu3auazlWszxM2fJZCahAnuxathnDutea9ZyxdAnvsjaE8mRBgQPxRhoGa
         HUEMao2v5FlwQ==
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>,
        Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [PATCH RT 09/12] bpf: Remove in_atomic() from bpf_link_put().
Date:   Wed, 18 Oct 2023 15:48:30 -0400
Message-Id: <20231018194833.651674-10-joseph.salisbury@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018194833.651674-1-joseph.salisbury@canonical.com>
References: <20231018194833.651674-1-joseph.salisbury@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v5.15.133-rt70-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


bpf_free_inode() is invoked as a RCU callback. Usually RCU callbacks are
invoked within softirq context. By setting rcutree.use_softirq=0 boot
option the RCU callbacks will be invoked in a per-CPU kthread with
bottom halves disabled which implies a RCU read section.

On PREEMPT_RT the context remains fully preemptible. The RCU read
section however does not allow schedule() invocation. The latter happens
in mutex_lock() performed by bpf_trampoline_unlink_prog() originated
from bpf_link_put().

It was pointed out that the bpf_link_put() invocation should not be
delayed if originated from close(). It was also pointed out that other
invocations from within a syscall should also avoid the workqueue.
Everyone else should use workqueue by default to remain safe in the
future (while auditing the code, every caller was preemptible except for
the RCU case).

Let bpf_link_put() use the worker unconditionally. Add
bpf_link_put_direct() which will directly free the resources and is used
by close() and from within __sys_bpf().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20230614083430.oENawF8f@linutronix.de
(cherry picked from commit ab5d47bd41b1db82c295b0e751e2b822b43a4b5a)
Signed-off-by: Joseph Salisbury <joseph.salisbury@canonical.com>
---
 kernel/bpf/syscall.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ad41b8230780..bcc01f9881cf 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2454,27 +2454,30 @@ static void bpf_link_put_deferred(struct work_struct *work)
 	bpf_link_free(link);
 }
 
-/* bpf_link_put can be called from atomic context, but ensures that resources
- * are freed from process context
+/* bpf_link_put might be called from atomic context. It needs to be called
+ * from sleepable context in order to acquire sleeping locks during the process.
  */
 void bpf_link_put(struct bpf_link *link)
 {
 	if (!atomic64_dec_and_test(&link->refcnt))
 		return;
 
-	if (in_atomic()) {
-		INIT_WORK(&link->work, bpf_link_put_deferred);
-		schedule_work(&link->work);
-	} else {
-		bpf_link_free(link);
-	}
+	INIT_WORK(&link->work, bpf_link_put_deferred);
+	schedule_work(&link->work);
+}
+
+static void bpf_link_put_direct(struct bpf_link *link)
+{
+	if (!atomic64_dec_and_test(&link->refcnt))
+		return;
+	bpf_link_free(link);
 }
 
 static int bpf_link_release(struct inode *inode, struct file *filp)
 {
 	struct bpf_link *link = filp->private_data;
 
-	bpf_link_put(link);
+	bpf_link_put_direct(link);
 	return 0;
 }
 
@@ -4351,7 +4354,7 @@ static int link_update(union bpf_attr *attr)
 	if (ret)
 		bpf_prog_put(new_prog);
 out_put_link:
-	bpf_link_put(link);
+	bpf_link_put_direct(link);
 	return ret;
 }
 
@@ -4374,7 +4377,7 @@ static int link_detach(union bpf_attr *attr)
 	else
 		ret = -EOPNOTSUPP;
 
-	bpf_link_put(link);
+	bpf_link_put_direct(link);
 	return ret;
 }
 
@@ -4425,7 +4428,7 @@ static int bpf_link_get_fd_by_id(const union bpf_attr *attr)
 
 	fd = bpf_link_new_fd(link);
 	if (fd < 0)
-		bpf_link_put(link);
+		bpf_link_put_direct(link);
 
 	return fd;
 }
@@ -4502,7 +4505,7 @@ static int bpf_iter_create(union bpf_attr *attr)
 		return PTR_ERR(link);
 
 	err = bpf_iter_new_fd(link);
-	bpf_link_put(link);
+	bpf_link_put_direct(link);
 
 	return err;
 }
-- 
2.34.1

