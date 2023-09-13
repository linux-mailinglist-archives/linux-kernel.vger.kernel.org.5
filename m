Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B2279EDAD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjIMPwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjIMPv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:51:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2896E6D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694620265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=Bq0tWUbQ6rNODWWmwzdrtdls65kdWejnGNjG71Arkk8=;
        b=ZeUrb2YxWS8aPXyMnDXhOkzonEskBguFx4h8kZQ11kiv7+Xw83DR+43Cyao9iaS/eVPaQg
        XFchiOEiYi5X4gxisMuojhxx9R6U2cU3L38JuJSoGjp0rfa0q0ty+TwGP19H1jeO6BHASP
        QaG1S7AR+OeI6Sh0TKxHFP1+OKvVRoA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-rS34Ja5yP_a0pZ4Q5k8knA-1; Wed, 13 Sep 2023 11:51:01 -0400
X-MC-Unique: rS34Ja5yP_a0pZ4Q5k8knA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B957481652A;
        Wed, 13 Sep 2023 15:51:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4356D10F1BE7;
        Wed, 13 Sep 2023 15:50:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 13 Sep 2023 17:50:08 +0200 (CEST)
Date:   Wed, 13 Sep 2023 17:50:05 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] seqlock: introduce read_seqcount_begin_or_lock() and
 friends
Message-ID: <20230913155005.GA26252@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913154907.GA26210@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

See the comment in the patch.

NOTE: currently __seqprop_##lockname##_sequence() takes and drops s->lock
if preemptible && CONFIG_PREEMPT_RT. With the previous changes it is simple
to change this behaviour for the read_seqcount_begin_or_lock() case, iiuc
it makes more sense to return with s->lock held and "(seq & 1) == 1".

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/seqlock.h | 50 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 9831683a0102..503813b3bab6 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -1239,4 +1239,54 @@ done_seqretry_irqrestore(seqlock_t *lock, int seq, unsigned long flags)
 	if (seq & 1)
 		read_sequnlock_excl_irqrestore(lock, flags);
 }
+
+/*
+ * Like read_seqbegin_or_lock/need_seqretry/done_seqretry above
+ * but for seqcount_LOCKNAME_t.
+ */
+
+#define read_seqcount_begin_or_lock(s, lock, seq)		\
+do {								\
+	if (!(*(seq) & 1))					\
+		*(seq) = read_seqcount_begin(s);		\
+	else							\
+		seqprop_lock((s), (lock));			\
+} while (0)
+
+#define need_seqcount_retry(s, seq)				\
+({								\
+	!((seq) & 1) && read_seqcount_retry((s), (seq));	\
+})
+
+#define done_seqcount_retry(s, lock, seq)			\
+do {								\
+	if ((seq) & 1)						\
+		seqprop_unlock((s), (lock));			\
+} while (0)
+
+
+#define read_seqcount_begin_or_lock_irqsave(s, lock, seq)	\
+({								\
+	unsigned long flags = 0;				\
+								\
+	if (!(*(seq) & 1))					\
+		*(seq) = read_seqcount_begin(s);		\
+	else {							\
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))		\
+			local_irq_save(flags);			\
+		seqprop_lock((s), (lock));			\
+	}							\
+								\
+	flags;							\
+})
+
+#define done_seqcount_retry_irqrestore(s, lock, seq, flags)	\
+do {								\
+	if ((seq) & 1) {					\
+		seqprop_unlock((s), (lock));			\
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))		\
+			local_irq_restore((flags));		\
+	}							\
+} while (0)
+
 #endif /* __LINUX_SEQLOCK_H */
-- 
2.25.1.362.g51ebf55

