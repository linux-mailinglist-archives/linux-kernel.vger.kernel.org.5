Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7417734C1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 01:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjHGXPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 19:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjHGXPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 19:15:19 -0400
X-Greylist: delayed 909 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Aug 2023 16:15:12 PDT
Received: from sender3-of-o57.zoho.com (sender3-of-o57.zoho.com [136.143.184.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B7FC6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 16:15:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1691449198; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=BxkmrughG4HGEdlwMRbhsAqQRhcArSbKxpp7gkbMM82uZKQhWcZ+hJiIO6cuyq0hrQRF+Mj13t+PuK8sw4bQIXzf9OPLU3sRVrzgkWeXh+sdI2ZOUGyhaCYbGhg1IczGp7fEtidWccDKYOKJ2TrGAGqsA9B35u+sSRTZLm2DVv4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1691449198; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=4JrgPyYqUhzXTQlnR/KevK6axBY/gDbp/sriinezoRo=; 
        b=DFNhs9s++Hm9DyOjAEaRegKitwX0lbUCjEStvHZkAosUgSecF40B84KD7rTME8YrBd6ciexddD/gJR2TXJqAt0EmrfUKitXnsk8gF5o/SjegN7RDTg/bfLKRI0UpnlbTU4cermcKED6kE/rgoHcmGYOW4xkj3FxjpKz64fWViQE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=mitchellaugustin.com;
        spf=pass  smtp.mailfrom=mitchell@mitchellaugustin.com;
        dmarc=pass header.from=<mitchell@mitchellaugustin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1691449198;
        s=zoho; d=mitchellaugustin.com; i=mitchell@mitchellaugustin.com;
        h=Message-ID:Date:Date:MIME-Version:From:From:Subject:Subject:To:To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
        bh=4JrgPyYqUhzXTQlnR/KevK6axBY/gDbp/sriinezoRo=;
        b=U8cblnQCoNk66GUz8/m0FT/HYz/2IGnE8MRnMHqKoJo2Q7y0S2cYZKbw3rT8B3mx
        tzI0dys1hmUEc/Rs6VBGJYPgdftKdK2AD5UlsUOIAr7A1SPnEZwPNoFDAbtzq0ZUHKO
        1CploetvDVc3AccijK4UwEXaydthadnYkTdnd8LI=
Received: from [192.168.10.116] (xpress10810.htc.net [216.114.108.10]) by mx.zohomail.com
        with SMTPS id 1691449196115871.0223143507202; Mon, 7 Aug 2023 15:59:56 -0700 (PDT)
Message-ID: <511c74b6-7d60-b60b-3f45-577c627fcf89@mitchellaugustin.com>
Date:   Mon, 7 Aug 2023 17:59:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
From:   Mitchell Augustin <mitchell@mitchellaugustin.com>
Subject: [PATCH 4.19.289] net/sched: sch_qfq: account for stab overhead in
 qfq_enqueue
To:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 From cb3f87086b7d412df344f120ecd324412103c903 Mon Aug 7 17:57:04 2023
From: Mitchell Augustin <mitchell@mitchellaugustin.com>
Date: Mon, 7 Aug 2023 17:57:04 -0500
Subject: [PATCH 4.19.289] net/sched: sch_qfq: account for stab overhead 
in qfq_enqueue

[ Upstream commit 3e337087c3b5805fe0b8a46ba622a962880b5d64 ]

I'm backporting the following patch from the mainline 6.5-rc4 branch 
(the above commit) to the 4.19.289 tree.

Lion says:
-------
In the QFQ scheduler a similar issue to CVE-2023-31436
persists.

Consider the following code in net/sched/sch_qfq.c:

static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
                 struct sk_buff **to_free)
{
      unsigned int len = qdisc_pkt_len(skb), gso_segs;

     // ...

      if (unlikely(cl->agg->lmax < len)) {
          pr_debug("qfq: increasing maxpkt from %u to %u for class %u",
               cl->agg->lmax, len, cl->common.classid);
          err = qfq_change_agg(sch, cl, cl->agg->class_weight, len);
          if (err) {
              cl->qstats.drops++;
              return qdisc_drop(skb, sch, to_free);
          }

     // ...

      }

Similarly to CVE-2023-31436, "lmax" is increased without any bounds
checks according to the packet length "len". Usually this would not
impose a problem because packet sizes are naturally limited.

This is however not the actual packet length, rather the
"qdisc_pkt_len(skb)" which might apply size transformations according to
"struct qdisc_size_table" as created by "qdisc_get_stab()" in
net/sched/sch_api.c if the TCA_STAB option was set when modifying the 
qdisc.

A user may choose virtually any size using such a table.

As a result the same issue as in CVE-2023-31436 can occur, allowing heap
out-of-bounds read / writes in the kmalloc-8192 cache.
-------

We can create the issue with the following commands:

tc qdisc add dev $DEV root handle 1: stab mtu 2048 tsize 512 mpu 0 \
overhead 999999999 linklayer ethernet qfq
tc class add dev $DEV parent 1: classid 1:1 htb rate 6mbit burst 15k
tc filter add dev $DEV parent 1: matchall classid 1:1
ping -I $DEV 1.1.1.2

This is caused by incorrectly assuming that qdisc_pkt_len() returns a
length within the QFQ_MIN_LMAX < len < QFQ_MAX_LMAX.
---
  net/sched/sch_qfq.c | 8 +++++++-
  1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index c2a68f6e427e..81ebe7741463 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -116,6 +116,7 @@

  #define QFQ_MTU_SHIFT        16    /* to support TSO/GSO */
  #define QFQ_MIN_LMAX        512    /* see qfq_slot_insert */
+#define QFQ_MAX_LMAX        (1UL << QFQ_MTU_SHIFT)

  #define QFQ_MAX_AGG_CLASSES    8 /* max num classes per aggregate 
allowed */

@@ -387,8 +388,13 @@ static int qfq_change_agg(struct Qdisc *sch, struct 
qfq_class *cl, u32 weight,
                 u32 lmax)
  {
      struct qfq_sched *q = qdisc_priv(sch);
-    struct qfq_aggregate *new_agg = qfq_find_agg(q, lmax, weight);
+    struct qfq_aggregate *new_agg;

+    /* 'lmax' can range from [QFQ_MIN_LMAX, pktlen + stab overhead] */
+    if (lmax > QFQ_MAX_LMAX)
+        return -EINVAL;
+
+    new_agg = qfq_find_agg(q, lmax, weight);
      if (new_agg == NULL) { /* create new aggregate */
          new_agg = kzalloc(sizeof(*new_agg), GFP_ATOMIC);
          if (new_agg == NULL)
-- 
2.34.1

