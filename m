Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEB580447D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376291AbjLECKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjLECKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:10:06 -0500
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746FD10F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:10:12 -0800 (PST)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b8b5221627so4115814b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 18:10:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701742212; x=1702347012;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FgfZZfyJWSdHuyV8ubdtxl0EppomZgVAi2DJM2XdXok=;
        b=p66OPi7qMpztYCEC5p/Yk4xT4qMN+BtHr3+Uj7TrZHaHzEVRQYTQb4A3mD3Tf9UZhE
         wBOQkqTzbux33WH3fTr/RrZ0kbRddkDWP/nunpKAoP4/vFiK4U+iH8on89rYtzaBvIfk
         apkR7YSvjkdaGYReiHKEJVKX68c3yqVk5BIDzPeq9his4LVhvbq7jbKpubEdsgnaC6e/
         OzOvxOxs3jWJJZBTh/3wzmtSvgeyLuQXZq6uzcDtWcddbUmglJ5MwcI6p3m3+Gh4dwJm
         apM1rFkp32UbiyVmc+WnVNG7vdtcvLNogu5YkHRbGinJqykM2MKrknmHlvrj1dngNIL8
         OWHg==
X-Gm-Message-State: AOJu0YxaVMxp/YOfVdPZhdqX0Oq6zhqUmN0Dfpijl6RXKcFi9pSssTEZ
        Zky1BtTIzGKp3WRzhwwJFWBZ24eoylmdXtui8j0uooFVo0+UbhQ=
X-Google-Smtp-Source: AGHT+IFD4CJ6gTupwO+FpOS005LHtbPxayj/yX5KKnejFxx0cicx+ANIfuql7kEFS4rB1cjUu80QmkRruG32XQuHlflo90hcB/Oy
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2090:b0:3a7:5f99:9fe1 with SMTP id
 s16-20020a056808209000b003a75f999fe1mr3221758oiw.2.1701742211858; Mon, 04 Dec
 2023 18:10:11 -0800 (PST)
Date:   Mon, 04 Dec 2023 18:10:11 -0800
In-Reply-To: <00000000000077c77f060b603f2d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000986fc060bb9bc3b@google.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in sys_socket
From:   syzbot <syzbot+de8e83db70e8beedd556@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [net?] INFO: rcu detected stall in sys_socket
Author: eadavis@qq.com

please test rcu detected stall in sys_socket

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 18d46e76d7c2

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 31a8252bd09c..4bc377120ea0 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -843,6 +843,7 @@ static struct sk_buff *taprio_dequeue(struct Qdisc *sch)
 
 	rcu_read_lock();
 	entry = rcu_dereference(q->current_entry);
+	rcu_read_unlock();
 	/* if there's no entry, it means that the schedule didn't
 	 * start yet, so force all gates to be open, this is in
 	 * accordance to IEEE 802.1Qbv-2015 Section 8.6.9.4.5
@@ -869,8 +870,6 @@ static struct sk_buff *taprio_dequeue(struct Qdisc *sch)
 	}
 
 done:
-	rcu_read_unlock();
-
 	return skb;
 }
 

