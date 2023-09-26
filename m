Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05DD7AF2C6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbjIZS1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235488AbjIZS1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:27:13 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDFF1A8;
        Tue, 26 Sep 2023 11:27:06 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-692a885f129so6004760b3a.0;
        Tue, 26 Sep 2023 11:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695752825; x=1696357625; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFyC5gsYXKnW8lTttjRH9vTXhArvr4/9vr68HemFOfM=;
        b=nGGnB+kktXzsxjEizSELx5hW1CP1nsAckXWTsvhopZy6VRPBJfTPv375BfefMUmXcO
         BvwlAr8DQII5/undLh59Uma5/kyimwbgygQzJrYQgB4YtLUBTFYsG8eVSM2+s1rvGSM5
         jGJrWBEBDQtPyM+hzZFSnSOKHcOTjfSd7owj59nOo5/s27mazNhY2sIZ+KUwAlcQkW+Z
         EIH0DLQQxODRaztbkltwuE5VEJEvl9Nqs+5dknqFYvnc7zSub4yHpaKGx0IMRmJT7d4F
         UtRcGxzmI9rAiszpcwVJNqZU+/vPhCnhGG4w5QclH7K0axzep9OMm53sE2BHy3r+oedW
         bwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695752825; x=1696357625;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFyC5gsYXKnW8lTttjRH9vTXhArvr4/9vr68HemFOfM=;
        b=PYgWShx8mTSFx6m+c5HGBM4qdScIAUeZ+CQAAOEjjzSuvMIF40fyyUf2mrX7ojESAF
         X4dxEhGsthb3vLVBdXVNmQBL23cKjsHmeQcNKymK1D4aNuZp5tyoxruPzXD8R1g3/NBs
         WRLbTmgdBvVfSi9/yRfV17kb0W9XtcODryGkMb0MLMrp0+sMvPU35oPi7qM+Xde7J/C5
         FYTNOCNlMnn4TDg2iKJkjVpc51IlYhEuH5a21ZMHYK5LwU3b6RK3yzYO1dmKb+BtKJLy
         paAaI+dIBpIzj2BsJX8UbtF6qGISajFbkD+UsTz0KawjiQmZmEVbSCtnKGK7ijje0GjQ
         8IEw==
X-Gm-Message-State: AOJu0Ywzbo1eFPrSgq9Ofm75vdDOQ6Lyxkzfo11oJHXNXQkh/cxtT6Ja
        Y2T8rX0mwgRqSwTGf8QT0Dw=
X-Google-Smtp-Source: AGHT+IFXnQo18kLqTvR/7aR00M8EkW5CBKsckoF2q/087HYWXhl/5voISNcSGrfOXxPyIbIQmWURSw==
X-Received: by 2002:a05:6a00:a1b:b0:690:d4f5:c664 with SMTP id p27-20020a056a000a1b00b00690d4f5c664mr9057118pfh.11.1695752825419;
        Tue, 26 Sep 2023 11:27:05 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id p3-20020aa78603000000b0068b1149ea4dsm10332914pfn.69.2023.09.26.11.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 11:27:04 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] net/sched: use spin_lock_bh() on &gact->tcf_lock
Date:   Tue, 26 Sep 2023 18:26:25 +0000
Message-Id: <20230926182625.72475-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I find tcf_gate_act() acquires &gact->tcf_lock without disable
bh explicitly, as gact->tcf_lock is acquired inside timer under
softirq context, if tcf_gate_act() is not called with bh disable
by default or under softirq context(which I am not sure as I cannot
find corresponding documentation), then it could be the following 
deadlocks.

tcf_gate_act()
--> spin_loc(&gact->tcf_lock)
<interrupt>
   --> gate_timer_func()
   --> spin_lock(&gact->tcf_lock)

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 net/sched/act_gate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index c9a811f4c7ee..b82daf7401a5 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -124,25 +124,25 @@ TC_INDIRECT_SCOPE int tcf_gate_act(struct sk_buff *skb,
 	tcf_lastuse_update(&gact->tcf_tm);
 	tcf_action_update_bstats(&gact->common, skb);
 
-	spin_lock(&gact->tcf_lock);
+	spin_lock_bh(&gact->tcf_lock);
 	if (unlikely(gact->current_gate_status & GATE_ACT_PENDING)) {
-		spin_unlock(&gact->tcf_lock);
+		spin_unlock_bh(&gact->tcf_lock);
 		return action;
 	}
 
 	if (!(gact->current_gate_status & GATE_ACT_GATE_OPEN)) {
-		spin_unlock(&gact->tcf_lock);
+		spin_unlock_bh(&gact->tcf_lock);
 		goto drop;
 	}
 
 	if (gact->current_max_octets >= 0) {
 		gact->current_entry_octets += qdisc_pkt_len(skb);
 		if (gact->current_entry_octets > gact->current_max_octets) {
-			spin_unlock(&gact->tcf_lock);
+			spin_unlock_bh(&gact->tcf_lock);
 			goto overlimit;
 		}
 	}
-	spin_unlock(&gact->tcf_lock);
+	spin_unlock_bh(&gact->tcf_lock);
 
 	return action;
 
-- 
2.17.1

