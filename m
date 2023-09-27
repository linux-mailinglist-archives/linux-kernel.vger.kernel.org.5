Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291967B054C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 15:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjI0NX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 09:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjI0NX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:23:56 -0400
X-Greylist: delayed 970 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Sep 2023 06:23:53 PDT
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADD69121;
        Wed, 27 Sep 2023 06:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=eroLtTf+BRzP2Naauk
        ntQodBaf4coGESmD1OCvBAhWY=; b=oDGFUhaaaMCz/jky6wbT2eMo/g62leUXPE
        MTQrm8XbYMv5ib+TZcdolzMnUVkcDbI6NEro4qEOsdowHZD5T1DgOLGooQiqhf/4
        +lluM9NDx4sZ9DmO8R2FQDobRyhmBZDbUefc/mXjIPebZNOQLdZYf33Q2rt6eGqD
        0QY6mJezE=
Received: from localhost.localdomain (unknown [111.48.58.12])
        by zwqz-smtp-mta-g4-1 (Coremail) with SMTP id _____wB3v7c7KBRlwUE_Aw--.42176S2;
        Wed, 27 Sep 2023 21:03:56 +0800 (CST)
From:   xiaolinkui <xiaolinkui@126.com>
To:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, justinstitt@google.com, kuniyu@amazon.com
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH] netfilter: ipset: add ip_set lock to ip_set_test
Date:   Wed, 27 Sep 2023 21:03:09 +0800
Message-Id: <20230927130309.30891-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wB3v7c7KBRlwUE_Aw--.42176S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFWxGF47Xr17Kr4fuF1kuFg_yoW5Xr4rpF
        WF9Fn8J34Dur1DZw48KF4xJ3Wj93ZIqr1UWrnY9ry7CF1kGrnrJF4jyryYvr47trZ5ury3
        Ja4j9w4jvrn0gw7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-AwsUUUUU=
X-Originating-IP: [111.48.58.12]
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/1tbiigj31lpEFGL1ugAAsE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linkui Xiao <xiaolinkui@kylinos.cn>

If the ip_set is not locked during ip_set_test, the following situations
may occur:

	CPU0				CPU1
	ip_rcv->
	ip_rcv_finish->
	ip_local_deliver->
	nf_hook_slow->
	iptable_filter_hook->
	ipt_do_table->
	set_match_v4->
	ip_set_test->			list_set_destroy->
	hash_net4_kadt->		set->data = NULL
	h = set->data
	.cidr = INIT_CIDR(h->nets[0].cidr[0], HOST_MASK)

The set->data is empty, continuing to access set->data will result in a
kernel NULL pointer. The call trace is as follows:

[2350616.024418] Call trace:
[2350616.024670]  hash_net4_kadt+0x38/0x148 [ip_set_hash_net]
[2350616.025147]  ip_set_test+0xbc/0x230 [ip_set]
[2350616.025549]  set_match_v4+0xac/0xd0 [xt_set]
[2350616.025951]  ipt_do_table+0x32c/0x678 [ip_tables]
[2350616.026391]  iptable_filter_hook+0x30/0x40 [iptable_filter]
[2350616.026905]  nf_hook_slow+0x50/0x100
[2350616.027256]  ip_local_deliver+0xd4/0xe8
[2350616.027616]  ip_rcv_finish+0x90/0xb0
[2350616.027961]  ip_rcv+0x50/0xb0
[2350616.028261]  __netif_receive_skb_one_core+0x58/0x68
[2350616.028716]  __netif_receive_skb+0x28/0x80
[2350616.029098]  netif_receive_skb_internal+0x3c/0xa8
[2350616.029533]  napi_gro_receive+0xf8/0x170
[2350616.029898]  receive_buf+0xec/0xa08 [virtio_net]
[2350616.030323]  virtnet_poll+0x144/0x310 [virtio_net]
[2350616.030761]  net_rx_action+0x158/0x3a0
[2350616.031124]  __do_softirq+0x11c/0x33c
[2350616.031470]  irq_exit+0x11c/0x128
[2350616.031793]  __handle_domain_irq+0x6c/0xc0
[2350616.032172]  gic_handle_irq+0x6c/0x170
[2350616.032528]  el1_irq+0xb8/0x140
[2350616.032835]  arch_cpu_idle+0x38/0x1c0
[2350616.033183]  default_idle_call+0x24/0x58
[2350616.033549]  do_idle+0x1a4/0x268
[2350616.033859]  cpu_startup_entry+0x28/0x78
[2350616.034234]  secondary_start_kernel+0x17c/0x1c8

Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 net/netfilter/ipset/ip_set_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 35d2f9c9ada0..46f4f47e29e4 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -747,7 +747,9 @@ ip_set_test(ip_set_id_t index, const struct sk_buff *skb,
 	    !(opt->family == set->family || set->family == NFPROTO_UNSPEC))
 		return 0;
 
+	ip_set_lock(set);
 	ret = set->variant->kadt(set, skb, par, IPSET_TEST, opt);
+	ip_set_unlock(set);
 
 	if (ret == -EAGAIN) {
 		/* Type requests element to be completed */
-- 
2.17.1

