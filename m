Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414577A2E66
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 09:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbjIPHbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 03:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbjIPHa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 03:30:29 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBE710D4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 00:30:23 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id hPkzqXWcGBLWLhPkzqni2a; Sat, 16 Sep 2023 09:30:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694849422;
        bh=FCzGUfVfl3gyXvyMuMWEuajChRiIpmEDWmkcE4/V2oA=;
        h=From:To:Cc:Subject:Date;
        b=bj5eJ+EpYft4no84HOrXdiDq5nzVL9vVG65EmhQgoM+uUPmKRJwuX5QWFsk0LsTgm
         pqPKT8vemhX3ZmpzoDYR2+sVOn2MEeAN1cRnp6rRRcFwTyTTVPdrr8xj5oa8WHq9NL
         Qw9wmVBBCqnwycFUd9TVZzp1UkpYdcNyLV9fFXubg9jZ7Jp1X1WZyBZFdpqMaR3XrB
         cehOkz8dLPiWpFCfMXc4yDqhAOrWS49eT1eZUEqpM/N0zdhSigyBL2O3LZ8fR16E0a
         IOyerjRtCULOvgQAIN0/Rs0lLOQ7dKFGQoXKp2oJHpTBU/uAH1bjzOW0To80ZaPSmY
         W1nIE7qwIxp/w==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 16 Sep 2023 09:30:22 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-bcachefs@vger.kernel.org
Subject: [PATCH] bcachefs: Use snprintf() instead of scnprintf() when appropriate
Date:   Sat, 16 Sep 2023 09:30:19 +0200
Message-Id: <9a998be3e2dbedcd3a9eae5f81ae6dcc6c0f98c4.1694849375.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snprintf() and scnprintf() are the same, except for the returned value.
When this value is not used, it is more logical to use snprintf() which is
slightly simpler.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/bcachefs/super.c | 2 +-
 fs/bcachefs/tests.c | 2 +-
 fs/bcachefs/trace.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index 2990eed85adf..773ea93e44c1 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -1180,7 +1180,7 @@ static void bch2_dev_attach(struct bch_fs *c, struct bch_dev *ca,
 {
 	ca->dev_idx = dev_idx;
 	__set_bit(ca->dev_idx, ca->self.d);
-	scnprintf(ca->name, sizeof(ca->name), "dev-%u", dev_idx);
+	snprintf(ca->name, sizeof(ca->name), "dev-%u", dev_idx);
 
 	ca->fs = c;
 	rcu_assign_pointer(c->devs[ca->dev_idx], ca);
diff --git a/fs/bcachefs/tests.c b/fs/bcachefs/tests.c
index c907b3e00176..72f9bf186f9c 100644
--- a/fs/bcachefs/tests.c
+++ b/fs/bcachefs/tests.c
@@ -926,7 +926,7 @@ int bch2_btree_perf_test(struct bch_fs *c, const char *testname,
 
 	time = j.finish - j.start;
 
-	scnprintf(name_buf, sizeof(name_buf), "%s:", testname);
+	snprintf(name_buf, sizeof(name_buf), "%s:", testname);
 	prt_human_readable_u64(&nr_buf, nr);
 	prt_human_readable_u64(&per_sec_buf, div64_u64(nr * NSEC_PER_SEC, time));
 	printk(KERN_INFO "%-12s %s with %u threads in %5llu sec, %5llu nsec per iter, %5s per sec\n",
diff --git a/fs/bcachefs/trace.h b/fs/bcachefs/trace.h
index 19264492151b..da303dd4b71c 100644
--- a/fs/bcachefs/trace.h
+++ b/fs/bcachefs/trace.h
@@ -450,7 +450,7 @@ TRACE_EVENT(btree_path_relock_fail,
 			c = six_lock_counts(&path->l[level].b->c.lock);
 			__entry->read_count	= c.n[SIX_LOCK_read];
 			__entry->intent_count	= c.n[SIX_LOCK_intent];
-			scnprintf(__entry->node, sizeof(__entry->node), "%px", b);
+			snprintf(__entry->node, sizeof(__entry->node), "%px", b);
 		}
 		__entry->iter_lock_seq		= path->l[level].lock_seq;
 		__entry->node_lock_seq		= is_btree_node(path, level)
-- 
2.34.1

