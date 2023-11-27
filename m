Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08587F9F43
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjK0MJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbjK0MJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:09:55 -0500
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCFBC3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:10:02 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c17cff57f9so4032642a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701087001; x=1701691801;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1P4PRUi9Xdta33xqdQzdIrLH/q/bDppjD9WobOhqYa0=;
        b=GnG22Va2y5abLWSrMOWd6zAmhW1IKa10ohcPsxE15A8mh827DiWb+06zIxpcAw0Q/e
         0kuK/ngdNIgyWWLTzQ03jpvkAQhRrQ74ATWPgG/cptJIR62SPrrGAslL3aJLlNhd2V7R
         Ne5rY3OBjLhwZRHOziznuF+DMHH5Su4yXQmVkmsSyQ5AO4/8Lmd5EtOp5MmOMJjAxhxw
         6ja9TnDHjx/6a6STn+19UvGw9/pvgZw08WxoQGu9p9r7z6NnaGh6xTTeotWd9O9698d3
         2dN01E+oeqxJCBYTwJ5LPlnBxMulmTHd8A+Ox8f+jHylIiWakvQMGY+ktCpLerDtTt0E
         iqwg==
X-Gm-Message-State: AOJu0YycyfDj5P9pgj85iLxoEFP68edCxUXdN5Xx5AdXxMg8F/WUixKx
        9Nyw9RlxRMswSPQvf14s7S3bF0X5VeBBJ16hFnUtLdBbjYshrJM=
X-Google-Smtp-Source: AGHT+IGKY2LVJDt7eef1Z2ctBXK60gaNxOtvZgwaL2MRd74GTITxloGEpiGtmt1nw+k8fmc6fnokqeBVDL8Tv2BCi7/Ejrv1HwTD
MIME-Version: 1.0
X-Received: by 2002:a63:d12:0:b0:5b8:eaa4:c6d8 with SMTP id
 c18-20020a630d12000000b005b8eaa4c6d8mr1854981pgl.1.1701087001018; Mon, 27 Nov
 2023 04:10:01 -0800 (PST)
Date:   Mon, 27 Nov 2023 04:10:00 -0800
In-Reply-To: <000000000000f2771905a46374fe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d859a060b212e83@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in sch_direct_xmit
From:   syzbot <syzbot+e18ac85757292b7baf96@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [net?] possible deadlock in sch_direct_xmit
Author: eadavis@qq.com

please test deadlock in sch_direct_xmit

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 4195a4bc26ca..9e418f94757d 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -337,13 +337,16 @@ bool sch_direct_xmit(struct sk_buff *skb, struct Qdisc *q,
 #endif
 
 	if (likely(skb)) {
-		HARD_TX_LOCK(dev, txq, smp_processor_id());
-		if (!netif_xmit_frozen_or_stopped(txq))
-			skb = dev_hard_start_xmit(skb, dev, txq, &ret);
-		else
-			qdisc_maybe_clear_missed(q, txq);
+		int cpu = smp_processor_id();
+		if (READ_ONCE(txq->xmit_lock_owner) != cpu) {
+			HARD_TX_LOCK(dev, txq, cpu);
+			if (!netif_xmit_frozen_or_stopped(txq))
+				skb = dev_hard_start_xmit(skb, dev, txq, &ret);
+			else
+				qdisc_maybe_clear_missed(q, txq);
 
-		HARD_TX_UNLOCK(dev, txq);
+			HARD_TX_UNLOCK(dev, txq);
+		}
 	} else {
 		if (root_lock)
 			spin_lock(root_lock);

