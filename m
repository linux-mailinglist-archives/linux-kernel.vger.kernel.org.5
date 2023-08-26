Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E80A789865
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 19:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjHZRXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 13:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjHZRXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 13:23:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AB2FF
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 10:23:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693070589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=H4z6ddPD71QB2FfkwYPnBey6j3RLpCXyaGXlcozbiho=;
        b=OvTgWAruyp3InqZlgx6ybcW1OZ0/fLGOq99tESbOqhGBNIV1aIDMPiWyuRQo/yNs2Iby1p
        YbLCqSkahemqrSnuXFW1WnkDpluYvKQPMhMPS6GX/QPTnTR2WrVvt1vxUHcLKpNxW2YNs/
        QIqIXXQn2b3RKqrJKDJf8ufjfo9egTNgfS0LVXKUtlbqw8tyDOBI5DK3NVKBH+NYB5FbcH
        iBgUfZu1iGQ9dUI6bJ+tIxz412g7yFXAFFQIuCpehwNEybjfln1VouV2ZWZIbqsz//cYgx
        vh+VOpcUDSxZlhAu/a69/jLuRnrElr4uqM33dBWjCUzR2zdL6BLxv6AOeF5sOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693070589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=H4z6ddPD71QB2FfkwYPnBey6j3RLpCXyaGXlcozbiho=;
        b=ZWs+1lUQEbG/5aaw9qfjIldVNKG7nFLvpc2CaNiBaFV8WTPTNg9cByGlr4ETRDa4pTvsGf
        kZav9lfVALqCg+Bw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for v6.5
Message-ID: <169307056577.365848.9161706896082150847.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sat, 26 Aug 2023 19:23:09 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2023-=
08-26

up to:  9f5deb551655: genirq: Fix software resend lockup and nested resend


A last minute fix for a regression introduced in the v6.5 merge window. The
conversion of the software based interrupt resend mechanism to hlist missed
to add a check whether the descriptor is already enqueued and dropped the
interrupt descriptor lookup for nested interrupts.

The missing check whether the descriptor is already queued causes hlist
corruption and can be observed in the wild. The dropped parent descriptor
lookup has not yet caused problems, but it would result in stale interrupt
line in the worst case.

Add the missing enqueued check and bring the descriptor lookup back to cure
this.

Thanks,

	tglx

------------------>
Johan Hovold (1):
      genirq: Fix software resend lockup and nested resend


 kernel/irq/resend.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index edec335c0a7a..5f2c66860ac6 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -68,11 +68,16 @@ static int irq_sw_resend(struct irq_desc *desc)
 		 */
 		if (!desc->parent_irq)
 			return -EINVAL;
+
+		desc =3D irq_to_desc(desc->parent_irq);
+		if (!desc)
+			return -EINVAL;
 	}
=20
 	/* Add to resend_list and activate the softirq: */
 	raw_spin_lock(&irq_resend_lock);
-	hlist_add_head(&desc->resend_node, &irq_resend_list);
+	if (hlist_unhashed(&desc->resend_node))
+		hlist_add_head(&desc->resend_node, &irq_resend_list);
 	raw_spin_unlock(&irq_resend_lock);
 	tasklet_schedule(&resend_tasklet);
 	return 0;

