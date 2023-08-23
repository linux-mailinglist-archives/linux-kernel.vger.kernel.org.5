Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E08785E62
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237765AbjHWRQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237761AbjHWRQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:16:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36660198
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 10:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692810946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=WHgUcwnsySq6BgUpxdOLmSZh8dZaqGXaEYCOH3Xe4HI=;
        b=EEiRYBz/wCPNnR0SjZH6tj6iKjbkVb9kwn7MI5Yp1PAzsh43Fa97DikUqxfhKJ/2E3NVE4
        2qioqZ2slIugU+iCz2CHPj1wdEMizJru9KGuHD10NbFqYV23/SrwJEYYsQMpUZ9+YKPbcc
        dsuQvjbYVBHYrmA0dMkJg+7jOJH9jBI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-JRdb96DJOyC0gtKYV4hGvw-1; Wed, 23 Aug 2023 13:15:44 -0400
X-MC-Unique: JRdb96DJOyC0gtKYV4hGvw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12EEC8D40A4;
        Wed, 23 Aug 2023 17:15:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.210])
        by smtp.corp.redhat.com (Postfix) with SMTP id CDCADC15BAE;
        Wed, 23 Aug 2023 17:15:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 23 Aug 2023 19:14:58 +0200 (CEST)
Date:   Wed, 23 Aug 2023 19:14:55 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        David Laight <David.Laight@ACULAB.COM>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] __kill_pgrp_info: simplify the calculation of return
 value
Message-ID: <20230823171455.GA12188@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to calculate/check the "success" variable, we can kill it and update
retval in the main loop unless it is zero.

Suggested-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/signal.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 128e9bb3d1a2..c0acdfd4c81b 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1460,16 +1460,21 @@ int group_send_sig_info(int sig, struct kernel_siginfo *info,
 int __kill_pgrp_info(int sig, struct kernel_siginfo *info, struct pid *pgrp)
 {
 	struct task_struct *p = NULL;
-	int retval, success;
+	int ret = -ESRCH;
 
-	success = 0;
-	retval = -ESRCH;
 	do_each_pid_task(pgrp, PIDTYPE_PGID, p) {
 		int err = group_send_sig_info(sig, info, p, PIDTYPE_PGID);
-		success |= !err;
-		retval = err;
+		/*
+		 * If group_send_sig_info() succeeds at least once ret
+		 * becomes 0 and after that the code below has no effect.
+		 * Otherwise we return the last err or -ESRCH if this
+		 * process group is empty.
+		 */
+		if (ret)
+			ret = err;
 	} while_each_pid_task(pgrp, PIDTYPE_PGID, p);
-	return success ? 0 : retval;
+
+	return ret;
 }
 
 int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
-- 
2.25.1.362.g51ebf55


