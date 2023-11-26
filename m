Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A768B7F9204
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 10:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjKZJqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 04:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZJqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 04:46:46 -0500
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0BE85
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 01:46:49 -0800 (PST)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6cd8b5b2d04so143842b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 01:46:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700992007; x=1701596807;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S2jxZKeNVhy8r3m++ysP7foF2GDOTArTqfIO8UDHyTk=;
        b=wZ/Hi0+B6GZ/0gpiRSnZGkBDfWH/pZBX4l6bUg8NJ8sNs5tITjI3yiRK9+CCIEGe47
         iXcb9e20jb51BSjK5JX0nIwI9pSgKFJPbWoawXFYiGLuoYJD6879oM0QHxAR97jU8S7f
         yaYN8iGtbhqwevgQMplKRspF2TOM7xyag+tQwDK/BUzp4/MSon3wjgx/N0fyQFdkenYg
         En8DyoyJa7uYuna8nW1XqE/SVAtiSibaJlgCEEXXKFyv4ihJKffxdQj+4W8ekhqKxZtC
         s8YBnkMJoPc/BLPnX7O7bNXezZ0q5tidtiyXS9IDJ6h7tgUtlc4/4LsNHRaSvCdQLXbX
         9GfA==
X-Gm-Message-State: AOJu0YwYMaH3iBD48sEJ7xWthgZa44QjsBR7IlC6WQuOOBhMnJuDr/oe
        4G0hsJTZR6BQn73ATKwpHP06HuZkZ3A/E2Gg+YgWAkp3HNG0zkE=
X-Google-Smtp-Source: AGHT+IFpFby8ZUy2E0VADv2tVM+v1t0uH1r1Z63IQL67unRfv5jl29xbfkYkJJiDWY5mWpz0RS02CfPHpjhjF+GaUaCmmV9PJ+Og
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:3a03:b0:6cd:810:3875 with SMTP id
 fj3-20020a056a003a0300b006cd08103875mr729811pfb.5.1700992007000; Sun, 26 Nov
 2023 01:46:47 -0800 (PST)
Date:   Sun, 26 Nov 2023 01:46:46 -0800
In-Reply-To: <000000000000f2771905a46374fe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000057dbf4060b0b10b6@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in sch_direct_xmit
From:   syzbot <syzbot+e18ac85757292b7baf96@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
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
index 4195a4bc26ca..d9d39887a550 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -337,13 +337,16 @@ bool sch_direct_xmit(struct sk_buff *skb, struct Qdisc *q,
 #endif
 
 	if (likely(skb)) {
-		HARD_TX_LOCK(dev, txq, smp_processor_id());
-		if (!netif_xmit_frozen_or_stopped(txq))
+		if (!netif_xmit_frozen_or_stopped(txq)) {
+			HARD_TX_LOCK(dev, txq, smp_processor_id());
+			netif_tx_stop_queue(txq);
 			skb = dev_hard_start_xmit(skb, dev, txq, &ret);
+			netif_tx_start_queue(txq);
+			HARD_TX_UNLOCK(dev, txq);
+		}
 		else
 			qdisc_maybe_clear_missed(q, txq);
 
-		HARD_TX_UNLOCK(dev, txq);
 	} else {
 		if (root_lock)
 			spin_lock(root_lock);

