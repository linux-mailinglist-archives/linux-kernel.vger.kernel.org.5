Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BA57DE66D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 20:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345602AbjKATcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 15:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345574AbjKATcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 15:32:12 -0400
Received: from mx4.spacex.com (mx4.spacex.com [192.31.242.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7420D12E;
        Wed,  1 Nov 2023 12:32:05 -0700 (PDT)
Received: from pps.filterd (mx4.spacex.com [127.0.0.1])
        by mx4.spacex.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1HtMNJ006209;
        Wed, 1 Nov 2023 12:19:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spacex.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=dkim; bh=K8t1h29qoJgDaDFX2qbEYAZ6YVO/kL5T9Bzxga1eoBs=;
 b=TlL1FXFpL6WnAuKsQ30zvjSeaF1TjQpHJctJoWVXvXjIgBc4U+yvBvqt034H5tzsFrsn
 p+1WYuHyXnuK7mcO1TVPXzf+BtHvhJIEDJKhVilX7Ozj+8j7NXk1tmxwkKNNGAruoC9W
 yyoPkELLpUHKYneL3OGZdsMv75+Cn5pABUWiiRIefFMA1+OTWQ0HpilzyDNc5voYsyMQ
 qGK8WwjZ4/7Cn9QsdoBMprpzRjYAt2RnXB75nfgE3rbqqc7CceOxfWs/THOygwR49o+1
 WsX/iR5OgI/z7M+xEssfCaSESpH4g6JLDFtFmPo2xW+WR+rt6YS25bk62Bfmb3Wvc8Os Xw== 
Received: from smtp.spacex.corp ([10.34.3.234])
        by mx4.spacex.com (PPS) with ESMTPS id 3u0yqn5peb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 01 Nov 2023 12:19:16 -0700
Received: from apakhunov-z4.spacex.corp (10.1.32.161) by
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 12:19:16 -0700
From:   <alexey.pakhunov@spacex.com>
To:     <siva.kallam@broadcom.com>
CC:     <vincent.wong2@spacex.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <prashant@broadcom.com>,
        <mchan@broadcom.com>, Alex Pakhunov <alexey.pakhunov@spacex.com>
Subject: [PATCH 0/2] tg3: Fix the TX ring stall
Date:   Wed, 1 Nov 2023 12:18:56 -0700
Message-ID: <20231101191858.2611154-1-alexey.pakhunov@spacex.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ht-dc-ex-d3-n1.spacex.corp (10.34.3.236) To
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234)
X-Proofpoint-ORIG-GUID: t3s4_VIsBNvb9nflAae7tjUajF2xu0Vs
X-Proofpoint-GUID: t3s4_VIsBNvb9nflAae7tjUajF2xu0Vs
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 clxscore=1011 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010142
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Pakhunov <alexey.pakhunov@spacex.com>

This patch fixes the problem with tg3 driver we encountered on several
machines having Broadcom 5719 NIC. The problem showed up as a 10-20 seconds
interruption in network traffic and these dmegs message followed by the NIC
registers dump:

=== dmesg ===
NETDEV WATCHDOG: eth0 (tg3): transmit queue 0 timed out
...
RIP: 0010:dev_watchdog+0x21e/0x230
...
tg3 0000:02:00.2 eth0: transmit timed out, resetting
=== ===

The issue was observed with "4.15.0-52-lowlatency #56~16.04.1-Ubuntu" and
"4.15.0-161-lowlatency #169~16.04.1-Ubuntu" kernels.

Based on the state of the TX queue at the time of the reset and analysis of
dev_watchdog() it appeared that the NIC has not been notified about packets
accumulated in the TX ring for TG3_TX_TIMEOUT seconds and was reset:

=== dmesg ===
tg3 0000:02:00.2 eth0: 0: Host status block [00000001:000000a0:(0000:06d8:0000):(0000:01a0)]
tg3 0000:02:00.2 eth0: 0: NAPI info [000000a0:000000a0:(0188:01a0:01ff):0000:(06f2:0000:0000:0000)]
=== ===

tnapi->hw_status->idx[0].tx_consumer is the same as tnapi->tx_cons (0x1a0)
meaning that the driver has processed all TX descriptions released by
the NIC. tnapi->tx_prod (0x188) is ahead of 0x1a0 meaning that there are
more descriptors in the TX ring ready to be sent but the NIC does not know
about that yet.

Further analysis showed that tg3_start_xmit() can stop the TX queue and
not tell the NIC about already enqueued packets. The specific sequence
is:

1. tg3_start_xmit() is called at least once and queues packet(s) without
   updating tnapi->prodmbox (netdev_xmit_more() returns true)
2. tg3_start_xmit() is called with an SKB which causes tg3_tso_bug() to be
   called.
3. tg3_tso_bug() determines that the SKB is too large [L7860], ...

        if (unlikely(tg3_tx_avail(tnapi) <= frag_cnt_est)) {

   ... stops the queue [L7861], and returns NETDEV_TX_BUSY [L7870]:

        netif_tx_stop_queue(txq);
        ...
        if (tg3_tx_avail(tnapi) <= frag_cnt_est)
                return NETDEV_TX_BUSY;

4. Since all tg3_tso_bug() call sites directly return, the code updating
   tnapi->prodmbox [L8138] is skipped.

5. The queue is stuck now. tg3_start_xmit() is not called while the queue
   is stopped. The NIC is not processing new packets because
   tnapi->prodmbox wasn't updated. tg3_tx() is not called by
   tg3_poll_work() because the all TX descriptions that could be freed has
   been freed [L7159]:

        /* run TX completion thread */
        if (tnapi->hw_status->idx[0].tx_consumer != tnapi->tx_cons) {
                tg3_tx(tnapi);

6. Eventually, dev_watchdog() fires resetting the queue.

As far as I can tell this sequence is still possible in HEAD of master.

I could not reproduce this stall by generating traffic to match conditions
required for tg3_tso_bug() to be called. Based on the driver's code
the SKB must be a TSO or GSO skb; it should contain a VLAN tag or extra TCP
header options; and it should be queued at exactly the right time.
I believe that the last part is what makes reproducing it harder.

However I was able to reproduce the stall by mimicing the behavior of
tg3_tso_bug() in tg3_start_xmit(). I added the following lines to
tg3_start_xmit() before "would_hit_hwbug = 0;" [L8046]:

        if (...) {
                netif_tx_stop_queue(txq);
                return NETDEV_TX_BUSY;
        }

        would_hit_hwbug = 0;

The condition is not super relevant. It was used to control when the stall
is induced, so that the network is not completely broken dueing testing.
This approach reproduced the issue rather reliably.

The proposed fix makes sure that the tnapi->prodmbox update happens
regardless of the reason tg3_start_xmit() returned. It essentially moves
the code updating tnapi->prodmbox from tg3_start_xmit() (which is renamed
to __tg3_start_xmit()) to a new wrapper. This makes sure all retun paths
are covered.

I tested this fix with the code inducing the TX stall from above. The fix
eliminated stalls completely.

Note that initially, instead of adding a new wrapper function, I tried
adjusting all code paths exiting tg3_start_xmit() so that they go through
the branch updating tnapi->prodmbox. This approach seemed more fragile
than adding a wrapper.

Alex Pakhunov (2):
  tg3: Increment tx_dropped in tg3_tso_bug()
  tg3: Fix the TX ring stall

 drivers/net/ethernet/broadcom/tg3.c | 50 ++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 12 deletions(-)


base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
-- 
2.39.3

