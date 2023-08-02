Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A5976CD43
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbjHBMoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbjHBMoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:44:00 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5980E4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:43:39 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b8b4748fe4so44252945ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 05:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690980219; x=1691585019;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxJzp9ATBmLdL264ZO+clCh18DN/3lFofn79g2q4smk=;
        b=Rrio5nTp2Ow3RU0Y0RsLR0psF9tZECzn3JAi8aF6qwvOO0RnczEnOOLmrsFE0LCG0U
         zpd4s8KAim7VlJZJ+l4EGQOVWeT10CtBxyN4CVGSuunXNIPQW2C9lZEibQby//mqygZf
         DC3OStYjeULGvwpnQlQsRZ+hbEW29SBtS2eGhHgptG5hry5bisZF6Ol/dssWLIyceNLI
         FOzYHgBeydZFj0/vnEFeP8K30FGmUgvVSv+KXD9Qx11l5shqPuR1rdem725uVwc1o94g
         zJ8WRmaEtoekpKoFd/CSy/M2owNJU/vlFGMBjFdTr0VcIG2JjRvSv6OQmtSij5RLmrFw
         5K2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690980219; x=1691585019;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxJzp9ATBmLdL264ZO+clCh18DN/3lFofn79g2q4smk=;
        b=FEElpyTM7zE2TZoLlH2ZB4rGNBi0j6oOUarSOKcOuATMzu+G/bQ1FL7c18vC/eXFsL
         6SA5yf2EEjiB9O/CyCRzPMjMtEepUCcCVEHm9P24rWSC6XzeBzIBDi19TYuMTUQq9gHI
         3RSRrYEkNPInLkExr2wD0MH99anr3xexA4r1xpjrZInBIiwfXe602SgfsVtPi1lvY/i8
         P9nXXlzu3wjJ2QQ3jjNt3fucH7v3aKOWNbHJJhrmNfSDwjVQ7mI5/UwHYmcTqYjpoco1
         9pqd4m2MZqL7Izd6exmiMPYB8sFZR0omyf8Gsu9W+HphMdYBX81RA6sqB5HDWPpYdzp0
         xNFA==
X-Gm-Message-State: ABy/qLaE2kpuprjofewQ8TNSsChTHzHtKO1ytHEFPTlc75zKIldfgNAg
        yRFFx+D1POd1/SwXXlpSX2o=
X-Google-Smtp-Source: APBJJlFR2J588uPiHI1YzTLZ55kMA2lE8AX2sgpHFFtcZqji+j6pH21aKU+hVDcmg4NVKrq88xje3w==
X-Received: by 2002:a17:902:e741:b0:1b0:307c:e6fe with SMTP id p1-20020a170902e74100b001b0307ce6femr17124366plf.10.1690980218855;
        Wed, 02 Aug 2023 05:43:38 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id m24-20020a170902bb9800b001bbbbda70ccsm12311217pls.158.2023.08.02.05.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 05:43:38 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        akpm@linux-foundation.org
Cc:     ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] ocfs2: cluster: fix potential deadlodddck on &o2net_debug_lock
Date:   Wed,  2 Aug 2023 12:43:20 +0000
Message-Id: <20230802124320.15827-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

&o2net_debug_lock is acquired by timer o2net_idle_timer() along the
following call chain. Thus the acquisition of the lock under process
context should disable bottom half, otherwise deadlock could happen
if the timer happens to preempt the execution while the lock is held
in process context on the same CPU.

<timer interrupt>
        -> o2net_idle_timer()
        -> queue_delayed_work()
        -> sc_put()
        -> sc_kref_release()
        -> o2net_debug_del_sc()
        -> spin_lock(&o2net_debug_lock);

Several lock acquisition of &o2net_debug_lock under process context
do not disable irq or bottom half. The patch fixes these potential
deadlocks scenerio by using spin_lock_bh() on &o2net_debug_lock.

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock. x86_64 allmodconfig using gcc
shows no new warning.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 fs/ocfs2/cluster/netdebug.c | 40 ++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/ocfs2/cluster/netdebug.c b/fs/ocfs2/cluster/netdebug.c
index 35c05c18de59..bc27301eab6d 100644
--- a/fs/ocfs2/cluster/netdebug.c
+++ b/fs/ocfs2/cluster/netdebug.c
@@ -44,17 +44,17 @@ static LIST_HEAD(send_tracking);
 
 void o2net_debug_add_nst(struct o2net_send_tracking *nst)
 {
-	spin_lock(&o2net_debug_lock);
+	spin_lock_bh(&o2net_debug_lock);
 	list_add(&nst->st_net_debug_item, &send_tracking);
-	spin_unlock(&o2net_debug_lock);
+	spin_unlock_bh(&o2net_debug_lock);
 }
 
 void o2net_debug_del_nst(struct o2net_send_tracking *nst)
 {
-	spin_lock(&o2net_debug_lock);
+	spin_lock_bh(&o2net_debug_lock);
 	if (!list_empty(&nst->st_net_debug_item))
 		list_del_init(&nst->st_net_debug_item);
-	spin_unlock(&o2net_debug_lock);
+	spin_unlock_bh(&o2net_debug_lock);
 }
 
 static struct o2net_send_tracking
@@ -84,9 +84,9 @@ static void *nst_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	struct o2net_send_tracking *nst, *dummy_nst = seq->private;
 
-	spin_lock(&o2net_debug_lock);
+	spin_lock_bh(&o2net_debug_lock);
 	nst = next_nst(dummy_nst);
-	spin_unlock(&o2net_debug_lock);
+	spin_unlock_bh(&o2net_debug_lock);
 
 	return nst;
 }
@@ -95,13 +95,13 @@ static void *nst_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	struct o2net_send_tracking *nst, *dummy_nst = seq->private;
 
-	spin_lock(&o2net_debug_lock);
+	spin_lock_bh(&o2net_debug_lock);
 	nst = next_nst(dummy_nst);
 	list_del_init(&dummy_nst->st_net_debug_item);
 	if (nst)
 		list_add(&dummy_nst->st_net_debug_item,
 			 &nst->st_net_debug_item);
-	spin_unlock(&o2net_debug_lock);
+	spin_unlock_bh(&o2net_debug_lock);
 
 	return nst; /* unused, just needs to be null when done */
 }
@@ -112,7 +112,7 @@ static int nst_seq_show(struct seq_file *seq, void *v)
 	ktime_t now;
 	s64 sock, send, status;
 
-	spin_lock(&o2net_debug_lock);
+	spin_lock_bh(&o2net_debug_lock);
 	nst = next_nst(dummy_nst);
 	if (!nst)
 		goto out;
@@ -145,7 +145,7 @@ static int nst_seq_show(struct seq_file *seq, void *v)
 		   (long long)status);
 
 out:
-	spin_unlock(&o2net_debug_lock);
+	spin_unlock_bh(&o2net_debug_lock);
 
 	return 0;
 }
@@ -191,16 +191,16 @@ static const struct file_operations nst_seq_fops = {
 
 void o2net_debug_add_sc(struct o2net_sock_container *sc)
 {
-	spin_lock(&o2net_debug_lock);
+	spin_lock_bh(&o2net_debug_lock);
 	list_add(&sc->sc_net_debug_item, &sock_containers);
-	spin_unlock(&o2net_debug_lock);
+	spin_unlock_bh(&o2net_debug_lock);
 }
 
 void o2net_debug_del_sc(struct o2net_sock_container *sc)
 {
-	spin_lock(&o2net_debug_lock);
+	spin_lock_bh(&o2net_debug_lock);
 	list_del_init(&sc->sc_net_debug_item);
-	spin_unlock(&o2net_debug_lock);
+	spin_unlock_bh(&o2net_debug_lock);
 }
 
 struct o2net_sock_debug {
@@ -236,9 +236,9 @@ static void *sc_seq_start(struct seq_file *seq, loff_t *pos)
 	struct o2net_sock_debug *sd = seq->private;
 	struct o2net_sock_container *sc, *dummy_sc = sd->dbg_sock;
 
-	spin_lock(&o2net_debug_lock);
+	spin_lock_bh(&o2net_debug_lock);
 	sc = next_sc(dummy_sc);
-	spin_unlock(&o2net_debug_lock);
+	spin_unlock_bh(&o2net_debug_lock);
 
 	return sc;
 }
@@ -248,12 +248,12 @@ static void *sc_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	struct o2net_sock_debug *sd = seq->private;
 	struct o2net_sock_container *sc, *dummy_sc = sd->dbg_sock;
 
-	spin_lock(&o2net_debug_lock);
+	spin_lock_bh(&o2net_debug_lock);
 	sc = next_sc(dummy_sc);
 	list_del_init(&dummy_sc->sc_net_debug_item);
 	if (sc)
 		list_add(&dummy_sc->sc_net_debug_item, &sc->sc_net_debug_item);
-	spin_unlock(&o2net_debug_lock);
+	spin_unlock_bh(&o2net_debug_lock);
 
 	return sc; /* unused, just needs to be null when done */
 }
@@ -349,7 +349,7 @@ static int sc_seq_show(struct seq_file *seq, void *v)
 	struct o2net_sock_debug *sd = seq->private;
 	struct o2net_sock_container *sc, *dummy_sc = sd->dbg_sock;
 
-	spin_lock(&o2net_debug_lock);
+	spin_lock_bh(&o2net_debug_lock);
 	sc = next_sc(dummy_sc);
 
 	if (sc) {
@@ -359,7 +359,7 @@ static int sc_seq_show(struct seq_file *seq, void *v)
 			sc_show_sock_stats(seq, sc);
 	}
 
-	spin_unlock(&o2net_debug_lock);
+	spin_unlock_bh(&o2net_debug_lock);
 
 	return 0;
 }
-- 
2.17.1

