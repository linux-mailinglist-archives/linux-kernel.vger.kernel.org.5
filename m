Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA747D4F84
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjJXMKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjJXMKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:10:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9B910C8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698149357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=iZkArARh9BTcR7kL2t19I65TEaHt5O6mRvItemHD3G4=;
        b=NypWtWb7xFu1fSw7jJAWlaaETp4Kt0nK5WRngi7kXJSyiIz1zdXujuMLTJeb+vxa3VVJB/
        V4HolRiZGO9FLpUQqre0WCBg8rylEVOEQVsXeJ1TS7mbonJCodqXooTinBNdxrSBDiHhzR
        LoNZjXCJXodVgtdkqHv6NHvD1tmFWuw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-KvQp0O3iNNKk8r5KugO8QQ-1; Tue,
 24 Oct 2023 08:09:13 -0400
X-MC-Unique: KvQp0O3iNNKk8r5KugO8QQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 096AC280605F;
        Tue, 24 Oct 2023 12:09:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.12])
        by smtp.corp.redhat.com (Postfix) with SMTP id 889C4492BFB;
        Tue, 24 Oct 2023 12:09:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 24 Oct 2023 14:08:11 +0200 (CEST)
Date:   Tue, 24 Oct 2023 14:08:08 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Alexey Gladkov <legion@kernel.org>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 1/2] seqlock: fix the wrong
 read_seqbegin_or_lock/need_seqretry documentation
Message-ID: <20231024120808.GA15382@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Half of the read_seqbegin_or_lock's users are buggy (I'll send the
fixes), and I guess this is because the documentation and the pseudo
code in Documentation/locking/seqlock.rst are wrong.

Pseudo code:

	int seq = 0;
	do {
		read_seqbegin_or_lock(&foo_seqlock, &seq);

		/* ... [[read-side critical section]] ... */

	} while (need_seqretry(&foo_seqlock, seq));

read_seqbegin_or_lock() returns with the even seq, need_seqretry()
doesn't change this counter. This means that seq is always even and
thus the locking pass is simply impossible.

IOW, "_or_lock" has no effect and this code doesn't differ from

	do {
		seq = read_seqbegin(&foo_seqlock);

		/* ... [[read-side critical section]] ... */

	} while (read_seqretry(&foo_seqlock, seq));

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 Documentation/locking/seqlock.rst | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/locking/seqlock.rst b/Documentation/locking/seqlock.rst
index bfda1a5fecad..4bdf8d4ed2a2 100644
--- a/Documentation/locking/seqlock.rst
+++ b/Documentation/locking/seqlock.rst
@@ -218,13 +218,14 @@ Read path, three categories:
    according to a passed marker. This is used to avoid lockless readers
    starvation (too much retry loops) in case of a sharp spike in write
    activity. First, a lockless read is tried (even marker passed). If
-   that trial fails (odd sequence counter is returned, which is used as
-   the next iteration marker), the lockless read is transformed to a
-   full locking read and no retry loop is necessary::
+   that trial fails (sequence counter doesn't match), make the marker
+   odd for the next iteration, the lockless read is transformed to a
+   full locking read and no retry loop is necessary, for example::
 
 	/* marker; even initialization */
-	int seq = 0;
+	int seq = 1;
 	do {
+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
 		read_seqbegin_or_lock(&foo_seqlock, &seq);
 
 		/* ... [[read-side critical section]] ... */
-- 
2.25.1.362.g51ebf55


