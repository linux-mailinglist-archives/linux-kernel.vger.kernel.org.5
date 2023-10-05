Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93ABD7BA573
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242090AbjJEQQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241188AbjJEQNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:13:47 -0400
X-Greylist: delayed 4506 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 Oct 2023 08:38:25 PDT
Received: from m15.mail.126.com (m15.mail.126.com [45.254.50.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6AD0F27B1C;
        Thu,  5 Oct 2023 08:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=LfDP8Q3SbfxhvYe2p+
        Jc+kb6Bw/OvEf2Np0A9Pqlpqc=; b=dgrd4JPXyQ6ZcExPM/hkFnTtmxUL3A3ORB
        TZtgNUJyUf32zlFMQ+xgijCtSL/Ln8596DnwVQhRzEG+J2HyAbOcvvTL3U3+Hqct
        zYiDRcrXGG4gIGyf3LkycViSLAiVrWSX17CgKF7yBRR/cPoimddzy7arBfrrUVaj
        dREcK0vq4=
Received: from localhost.localdomain (unknown [111.48.58.12])
        by zwqz-smtp-mta-g1-1 (Coremail) with SMTP id _____wD3HxwAox5lI+7GBA--.31668S2;
        Thu, 05 Oct 2023 19:50:25 +0800 (CST)
From:   xiaolinkui <xiaolinkui@126.com>
To:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, justinstitt@google.com, kuniyu@amazon.com
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH] netfilter: ipset: wait for xt_recseq on all cpus
Date:   Thu,  5 Oct 2023 19:50:22 +0800
Message-Id: <20231005115022.12902-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wD3HxwAox5lI+7GBA--.31668S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF48Ww45Gr1Utw13Wr4DJwb_yoWrXw1xpF
        W5Wr13Kr48ZFnrAr1DAr10yry5twnxAa1UtF4fGw1fWF17Gw1UWF18tFW7KF17Xr9Yqr13
        tw1Dt340qr1UWaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzJP_UUUUU=
X-Originating-IP: [111.48.58.12]
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/1tbibQYA1lpEFCD44QAAsO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linkui Xiao <xiaolinkui@kylinos.cn>

Before destroying the ipset, take a check on sequence to ensure that the
ip_set_test operation of this ipset has been completed.

The code of set_match_v4 is protected by addend=xt_write_recseq_begin() and
xt_write_recseq_end(addend). So we can ensure that the test operation is
completed by reading seqcount.

Otherwise, there will be a low probability of use-after-free problems
occurring:

 PC: ffff0000033c0168  [hash_net4_kadt+56]
 LR: ffff000002b811bc  [ip_set_test+188]
 SP: ffff8003fff3f8d0  PSTATE: 60400005
X29: ffff8003fff3f8d0  X28: ffff8003ab915c4e  X27: ffff8003b0c7a000
X26: ffff8003b9780040  X25: ffff000000c70600  X24: ffff8003ac2c0200
X23: ffff000002f70fcc  X22: 0000000000000002  X21: ffff8003ac2c0200
X20: ffff8003be8e2800  X19: ffff8003fff3f9c8  X18: 0000000000000000
X17: 0000000000000000  X16: 0000000000000000  X15: 0000000000000000
X14: 970000002d494600  X13: 0000000000000000  X12: c5d405f139e6e418
X11: ffff000000c70600  X10: ffff8003b0c7a000   X9: 0000000000000001
 X8: 0000000000000000   X7: 000000000000005f   X6: 0000000000000000
 X5: ffff0000033c0130   X4: ffff8003fff3f9c8   X3: 0000000000000002
 X2: ffff0000033d01d8   X1: 00000000ffffffff   X0: 0000000000000000
[ffff8003fff3f8d0] hash_net4_kadt at ffff0000033c0164 [ip_set_hash_net]
[ffff8003fff3f940] ip_set_test at ffff000002b811b8 [ip_set]
[ffff8003fff3f990] set_match_v4 at ffff000002f70fc8 [xt_set]
[ffff8003fff3fa20] ipt_do_table at ffff000000c504e0 [ip_tables]
[ffff8003fff3fb60] iptable_filter_hook at ffff00000266006c [iptable_filter]
[ffff8003fff3fb80] nf_hook_slow at ffff000008ac7a84
[ffff8003fff3fbc0] ip_local_deliver at ffff000008ad5d88
[ffff8003fff3fc10] ip_rcv_finish at ffff000008ad59b4
[ffff8003fff3fc40] ip_rcv at ffff000008ad5dec
[ffff8003fff3fca0] __netif_receive_skb_one_core at ffff000008a6c344
[ffff8003fff3fce0] __netif_receive_skb at ffff000008a6c3ac
[ffff8003fff3fd00] netif_receive_skb_internal at ffff000008a6c440
[ffff8003fff3fd30] napi_gro_receive at ffff000008a6d3ec
[ffff8003fff3fd60] receive_buf at ffff000001c934d8 [virtio_net]
[ffff8003fff3fe20] virtnet_poll at ffff000001c953e8 [virtio_net]
[ffff8003fff3fec0] net_rx_action at ffff000008a6c9ec
[ffff8003fff3ff60] __softirqentry_text_start at ffff0000080819f0
[ffff8003fff3fff0] irq_exit at ffff0000080f1228
[ffff8003fff40010] __handle_domain_irq at ffff000008162a10

Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 net/netfilter/ipset/ip_set_core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 46f4f47e29e4..53561176162f 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -1187,6 +1187,24 @@ ip_set_destroy_set(struct ip_set *set)
 	kfree(set);
 }
 
+static void wait_xt_recseq(void)
+{
+	unsigned int cpu;
+
+	/* wait for even xt_recseq on all cpus */
+	for_each_possible_cpu(cpu) {
+		seqcount_t *s = &per_cpu(xt_recseq, cpu);
+		u32 seq = raw_read_seqcount(s);
+
+		if (seq & 1) {
+			do {
+				cond_resched();
+				cpu_relax();
+			} while (seq == raw_read_seqcount(s));
+		}
+	}
+}
+
 static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
 			  const struct nlattr * const attr[])
 {
@@ -1225,6 +1243,7 @@ static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
 		for (i = 0; i < inst->ip_set_max; i++) {
 			s = ip_set(inst, i);
 			if (s) {
+				wait_xt_recseq();
 				ip_set(inst, i) = NULL;
 				ip_set_destroy_set(s);
 			}
@@ -1243,6 +1262,7 @@ static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
 			ret = -IPSET_ERR_BUSY;
 			goto out;
 		}
+		wait_xt_recseq();
 		ip_set(inst, i) = NULL;
 		read_unlock_bh(&ip_set_ref_lock);
 
-- 
2.17.1

