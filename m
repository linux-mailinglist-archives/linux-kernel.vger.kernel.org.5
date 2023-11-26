Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0981F7F91AC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 07:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjKZGud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 01:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZGua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 01:50:30 -0500
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A1AE5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 22:50:36 -0800 (PST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cf7ff75820so37902395ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 22:50:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700981436; x=1701586236;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/idrKmcOZ292i/teLtEPWoIY9+Yqi8viZCQk5eW5Pk=;
        b=M9NJwKt4yfMaT1eMTvLRxDjGYnqOCAeItssV6KsbGVFFKxGfVuUuaeYhEhDks9B2L+
         SMdP/pf4Z63MjJA/+2TulLVM1GJodvxddfei6orIIUbk8NLztysJJDT+gSNGQ2lRxQq7
         zzI5VxQpYbsKwPGmnpHHSom/vtDUAccXy1CPWjHeH075iU7+1PNjlE0euq8BTrCtAziG
         vBOl1OYexe1RN5KN8QibXXFZHWD/lqJ/ek8Via/U09ckAcT7xZhKj7IubZHCYYe3ju31
         NtqHItr0eOfk9hMOo1/VeQgqca0gltJrwtsQVPqbScM0QhvpZ9JAbncUIJhOj1M3+0f5
         aqVQ==
X-Gm-Message-State: AOJu0YzjeGELxWNxY53wIRNYD/blMAxC2Nm2Yq1smr53XX6PrnjisHi+
        gROvyn4v6O3btfqFH2LburKJfNimbaIwCS3QowBvHfod9PqzsPI=
X-Google-Smtp-Source: AGHT+IEyk/ISFNEPopaSJLLIP24seorBy951tavxWN2PA5hIfLGCb2/pCdsWCrEh7/agNQPIF3m7YMBG3WzKmhSG84SZW4gSOtzS
MIME-Version: 1.0
X-Received: by 2002:a17:902:d2d2:b0:1cf:9a43:d323 with SMTP id
 n18-20020a170902d2d200b001cf9a43d323mr1838939plc.11.1700981435983; Sat, 25
 Nov 2023 22:50:35 -0800 (PST)
Date:   Sat, 25 Nov 2023 22:50:35 -0800
In-Reply-To: <000000000000f2771905a46374fe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042ee27060b089aff@google.com>
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
index 4195a4bc26ca..4605314e605e 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -338,8 +338,11 @@ bool sch_direct_xmit(struct sk_buff *skb, struct Qdisc *q,
 
 	if (likely(skb)) {
 		HARD_TX_LOCK(dev, txq, smp_processor_id());
-		if (!netif_xmit_frozen_or_stopped(txq))
+		if (!netif_xmit_frozen_or_stopped(txq)) {
+			netif_tx_stop_queue(txq);
 			skb = dev_hard_start_xmit(skb, dev, txq, &ret);
+			netif_tx_start_queue(txq);
+		}
 		else
 			qdisc_maybe_clear_missed(q, txq);
 

