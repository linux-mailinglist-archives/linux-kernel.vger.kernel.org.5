Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C607C7ACEAA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 05:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjIYDVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 23:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjIYDVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 23:21:10 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6661BA3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 20:21:00 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230925032057epoutp02bd7df681305cf0d704114593c49a386f~IBi6vhWhx2543425434epoutp029
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:20:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230925032057epoutp02bd7df681305cf0d704114593c49a386f~IBi6vhWhx2543425434epoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695612057;
        bh=B/ub6Usw4gRZsUbbcyLG7PBsaPuCJ/yTkPdBOWY2Hr8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=TTjxoqN8J3HjGEkj3N7L8hHp/OGkJghHiMyvTnQR6MBopCrFuZ60IAbHN+EcJ6m4C
         Oq8KRwUgHp49hfqKGSnOrszac9owoVW9iQHWfsENDoj4LwQnSZhMOhKI/s5NjXwEJo
         v9lZy3f6PgEnnvLCs6lYZrGC6uA2IV7ywlnRuqNc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230925032056epcas1p3f512410619704080a75922d7bfe6880a~IBi6XmdoE1962219622epcas1p3q;
        Mon, 25 Sep 2023 03:20:56 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.250]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Rv7S816Vzz4x9Q2; Mon, 25 Sep
        2023 03:20:56 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        79.05.18968.79CF0156; Mon, 25 Sep 2023 12:20:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20230925032055epcas1p4c11234eb7130356a7cab01a50032390c~IBi5SvqTV0874908749epcas1p4t;
        Mon, 25 Sep 2023 03:20:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230925032055epsmtrp19b36a469a450bda4057ce8a82c180e38~IBi5SHiil3002530025epsmtrp1E;
        Mon, 25 Sep 2023 03:20:55 +0000 (GMT)
X-AuditID: b6c32a4c-a9bff70000004a18-77-6510fc970650
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.18.08742.79CF0156; Mon, 25 Sep 2023 12:20:55 +0900 (KST)
Received: from VDBS1328.vd.sec.samsung.net (unknown [168.219.243.40]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230925032055epsmtip1813d94f40a90e7cd69fa2063afa908fb~IBi5IbEcy0181701817epsmtip1e;
        Mon, 25 Sep 2023 03:20:55 +0000 (GMT)
From:   "yw85.kim" <yw85.kim@samsung.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Cc:     "yw85.kim" <yw85.kim@samsung.com>
Subject: [PATCH] timers: Add warning if timer list is corrupted
Date:   Mon, 25 Sep 2023 12:00:22 +0900
Message-Id: <1695610822-3242-1-git-send-email-yw85.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsWy7bCmnu6MPwKpBsevM1n8ObGRzeLyrjls
        Fv+ubWSx2LxpKrNFx+ebbA6sHgs2lXpsWtXJ5vHu3Dl2j74tqxg9Pm+SC2CNyrbJSE1MSS1S
        SM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAdqtpFCWmFMKFApILC5W
        0rezKcovLUlVyMgvLrFVSi1IySkwK9ArTswtLs1L18tLLbEyNDAwMgUqTMjO2HtjFVvBCcGK
        5Xs2szQwXuDtYuTkkBAwkZizewtzFyMXh5DAHkaJf69+MkI4nxgl/i9sg3K+AWVmXWPqYuQA
        a3m5tBgivpdR4vKsQ0wQzi9GiVX/3jKDzGUTUJf4sPArG0hCRKCbUWLFzE5WkG5mAVWJaWsS
        QWqEBewlnqzfDFbPAhTeeWATC4jNK+AscWTLe2aI++Qkbp7rBLtPQmARu8SBB2uYIBIuEluX
        97BD2MISr45vgbKlJF72t7FDXJou8fxJOkS4QOL8zQmsELaxxLu3a5khztGUWL9LHyKsKLHz
        91xGEJtZgE/i3dceVogpvBIdbUIQppLE8VMlENUSEnsbetkgbA+JI4cegnUKCcRKtPc+ZpzA
        KDsLYf4CRsZVjFKpBcW56anJhgWGunmp5fBoSs7P3cQITlBaPjsYv6//q3eIkYmD8RCjBAez
        kgjvr2d8qUK8KYmVValF+fFFpTmpxYcYTYEhNpFZSjQ5H5gi80riDU0sDUzMjEwsjC2NzZTE
        eWM+tacICaQnlqRmp6YWpBbB9DFxcEo1MK1m0Pq96Mu1P+Kykk8kJm07V3Z/3sLfjK1JPn9d
        r2qtuT/DleP2De/m54bqWf8rd73urHD/6X0jWWBPSv8ckQr7i7yr1zhsOsfGVeWa6th37JJA
        9+r9370N5y/6eHub1PHj8nsWqzOEbKiYMT/IaP2TSS3XXDd+1/Wr8Gw/t6B3/e7TL57+k9jb
        yu6zJu6byC7uObF9lSav2D6+yNm8XOF5aVel5vPyKuPvaizd/sd2nrmrW+r6a+bpqcd2xi6Z
        Fy13+NFn/0B3Y7V/nn9umlxvtfq71LdSjbdOoDCiKLtRjO+TuVx5ntD3ldsvGC+/ybmKf6qn
        wDqBSQbLgzjP+wX57L3Jkn3J5N9RHYvW9itKLMUZiYZazEXFiQCSqQIJ2QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIJMWRmVeSWpSXmKPExsWy7bCSnO70PwKpBo+a1C3+nNjIZnF51xw2
        i3/XNrJYbN40ldmi4/NNNgdWjwWbSj02repk83h37hy7R9+WVYwenzfJBbBGcdmkpOZklqUW
        6dslcGXsvbGKreCEYMXyPZtZGhgv8HYxcnBICJhIvFxa3MXIySEksJtRYtYNSRBbQkBCovdc
        NzNEibDE4cNAJVxAJT8YJdZtW84IUsMmoC7xYeFXNpCEiEA/o8TLawtYQBqYBVQlpq1JBKkR
        FrCXeLJ+MzOIzQIU3nlgEwuIzSvgLHFky3tmiF1yEjfPdTJPYORZwMiwilEytaA4Nz232LDA
        MC+1XK84Mbe4NC9dLzk/dxMjOFS0NHcwbl/1Qe8QIxMH4yFGCQ5mJRHeX8/4UoV4UxIrq1KL
        8uOLSnNSiw8xSnOwKInzir/oTRESSE8sSc1OTS1ILYLJMnFwSjUwZTcds5XmWzztX7/WvgO7
        OY0tq5+umbF+x6KVUjMnO/o3rVod9YN3fpp+UkRaQM+DFYXhk4/In7v88M3ljW9We+metv2R
        9F88bnvg47s/jn11f9zlk7I0+V2QIhv3ibq4OxaCyucDrWV3HDuj+oHHtPhqVT9fZVGCinet
        b7/qyVaurHtHFly37l7r9jh8bljXjwk6TnoLKvn8DTj9isVyV7ye31zVwfBKiZ+HIzNq5fbG
        r18WJZ5fs19TqO/3C+/t78RT3E4HRG290S0r3Zwi8VElhUHwZaXbeS73P2kxgvcfGZ9i+l80
        mZXtro2fi9O06qdPxZf0HbCW7VT6JvI791bwx8mzDM1m5ZrcWpagxFKckWioxVxUnAgAaemE
        TYQCAAA=
X-CMS-MailID: 20230925032055epcas1p4c11234eb7130356a7cab01a50032390c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230925032055epcas1p4c11234eb7130356a7cab01a50032390c
References: <CGME20230925032055epcas1p4c11234eb7130356a7cab01a50032390c@epcas1p4.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Description]
If some drivers use timers wrong, it can cause list corruption
(LIST_POISON2) and oops.

        detach_timer(struct timer_list *timer, bool clear_pending)
          __hlist_del(entry);
            next->pprev = pprev;  // oops, next is LIST_POISON2(0x122)

However, it is difficult to find the cause through backtrace.

        [1-11.7841] Unable to handle kernel NULL pointer dereference at
          virtual address 00000126
        [1-11.7841] pgd = 0ac52d81
        [1-11.7841] [00000126] *pgd=00000000
        Die cpu info :
        [1-11.7841] Internal error: Oops: 805 [#1] PREEMPT SMP ARM
        [1-11.7842] PC is at run_timer_softirq+0x1f0/0x684
        [1-11.7842] LR is at __warn+0xb4/0xf8
        ...
        [1-11.7842] Backtrace:
        [1-11.7842] [<c00bd464>] (run_timer_softirq)
        [1-11.7842] [<c000a438>] (__do_softirq+0x1ac/0x50c)
        [1-11.7842] [<c00362d4>] (run_ksoftirqd+0x84/0x98)
        [1-11.7842] [<c005a564>] (smpboot_thread_fn+0x140/0x2c0)
        [1-11.7843] [<c00560c0>] (kthread+0x1cc/0x1d0)

Adding this warning will give us more detailed information.
In this case the hdmi_switch driver was the cause.

A problem occurred because multiple schedule delayed works
were created using same dw(struct delayed_work dw) structure.

        [1-11.7835] WARNING: CPU: 1 PID: 17 at kernel/time/timer.c:830
          run_timer_softirq+0x50c/0x684
        [1-11.7836] timer: list corruption, entry->next is LIST_POISON2,
          entry:dw+0x10/0xfffe1a3c [hdmi_switch],
          fn:delayed_work_timer_fn+0x0/0x28

Signed-off-by: yw85.kim <yw85.kim@samsung.com>
---
 kernel/time/timer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 63a8ce7..e1e3340 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -877,6 +877,10 @@ static inline void detach_timer(struct timer_list *timer, bool clear_pending)
 
 	debug_deactivate(timer);
 
+	if (unlikely(entry->next == LIST_POISON2))
+		WARN_ONCE(1, "timer: list corruption, next is LIST_POISON2, entry:%pS, fn:%pS\n",
+			entry, timer->function);
+
 	__hlist_del(entry);
 	if (clear_pending)
 		entry->pprev = NULL;
-- 
2.7.4

