Return-Path: <linux-kernel+bounces-12466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F8381F527
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EC74283EA5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 06:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70FE3D8E;
	Thu, 28 Dec 2023 06:44:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7962909;
	Thu, 28 Dec 2023 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from localhost.localdomain (unknown [125.119.253.75])
	by mail-app3 (Coremail) with SMTP id cC_KCgAXjo0vGY1ljQGVAQ--.6801S4;
	Thu, 28 Dec 2023 14:44:00 +0800 (CST)
From: Lin Ma <linma@zju.edu.cn>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lin Ma <linma@zju.edu.cn>
Subject: [PATCH net-next v2] net/sched: cls_api: complement tcf_tfilter_dump_policy
Date: Thu, 28 Dec 2023 14:43:58 +0800
Message-Id: <20231228064358.3042747-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cC_KCgAXjo0vGY1ljQGVAQ--.6801S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CFW7Aw1fAr43CFyfXw4DCFg_yoW8GrykpF
	ZrW348Cr1DXry8Jws7G3Z7uF1agrZxZw47GrWvk34xZ3sxJrn3GFWftFWak3W2kF48Arsr
	tF15t3yUua1q9F7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
	DUUUUU=
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In function `tc_dump_tfilter`, the attributes array is parsed via
tcf_tfilter_dump_policy which only describes TCA_DUMP_FLAGS. However,
the NLA TCA_CHAIN is also accessed with `nla_get_u32`.

The access to TCA_CHAIN is introduced in commit 5bc1701881e3 ("net:
sched: introduce multichain support for filters") and no nla_policy is
provided for parsing at that point. Later on, tcf_tfilter_dump_policy is
introduced in commit f8ab1807a9c9 ("net: sched: introduce terse dump
flag") while still ignoring the fact that TCA_CHAIN needs a check. This
patch does that by complementing the policy to allow the access
discussed here can be safe as other cases just choose rtm_tca_policy as
the parsing policy.

Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
V1 -> V2: send to net-next as told by Jamal <jhs@mojatatu.com>

 net/sched/cls_api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 1976bd163986..2b5b8eca2ee3 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2732,6 +2732,7 @@ static bool tcf_chain_dump(struct tcf_chain *chain, struct Qdisc *q, u32 parent,
 }
 
 static const struct nla_policy tcf_tfilter_dump_policy[TCA_MAX + 1] = {
+	[TCA_CHAIN]      = { .type = NLA_U32 },
 	[TCA_DUMP_FLAGS] = NLA_POLICY_BITFIELD32(TCA_DUMP_FLAGS_TERSE),
 };
 
-- 
2.17.1


