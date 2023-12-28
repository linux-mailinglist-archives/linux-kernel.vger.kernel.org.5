Return-Path: <linux-kernel+bounces-12472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2487481F545
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96291F22603
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9884401;
	Thu, 28 Dec 2023 07:03:26 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from zg8tmty3ljk5ljewns4xndka.icoremail.net (zg8tmty3ljk5ljewns4xndka.icoremail.net [167.99.105.149])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FC13C0B;
	Thu, 28 Dec 2023 07:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from localhost.localdomain (unknown [39.174.92.167])
	by mail-app3 (Coremail) with SMTP id cC_KCgBn3YynHY1lqyGVAQ--.7281S4;
	Thu, 28 Dec 2023 15:03:04 +0800 (CST)
From: Lin Ma <linma@zju.edu.cn>
To: jk@codeconstruct.com.au,
	matt@codeconstruct.com.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lin Ma <linma@zju.edu.cn>
Subject: [PATCH net-next v1] net: mctp: use deprecated parser in mctp_set_link_af
Date: Thu, 28 Dec 2023 15:02:58 +0800
Message-Id: <20231228070258.3052422-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cC_KCgBn3YynHY1lqyGVAQ--.7281S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KF15Cr4kWw47JF13AF48Xrb_yoW8AFW5pa
	4vqFyUKrsrGryIgayvgF4vga43uw4DCw45GrySg3savFn8XrZ3tFyxKrWa9r43Ca1UAFZx
	AryUK3Wjqw1DJFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUym14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In mctp set_link_af implementation `mctp_set_link_af`, it uses strict
parser nla_parse_nested to parse the nested attribute. This is fine in
most cases but not here, as the rtnetlink uses *bad magic* in setlink
code, see code snippet in function `do_setlink`.

  nla_for_each_nested(af, tb[IFLA_AF_SPEC], rem) {
    const struct rtnl_af_ops *af_ops;
    BUG_ON(!(af_ops = rtnl_af_lookup(nla_type(af)))); <= (1)
    err = af_ops->set_link_af(dev, af, extack);       <= (2)

That is, in line (1), the attribute type of af will used to look up the
af_ops, and for MCTP case will use AF_MCTP here to get mctp_af_ops.
Therefore, the attribute with type AF_MCTP will never survive in the
check within the nla_parse_nested.

  if (!(nla->nla_type & NLA_F_NESTED)) {  <= nla_type is AF_MCTP
    NL_SET_ERR_MSG_ATTR(extack, nla, "NLA_F_NESTED is missing");
    return -EINVAL;  <= always invalid
  }

For other set_link_af users IPV4 and IPV6 both make a trick here by
using nla_parse_nested_deprecated, which will check the NLA_F_NESTED
then able to use this type field as family value. This patch simply port
the MCTP code also to deprecated parser to make it work.

Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
 net/mctp/device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mctp/device.c b/net/mctp/device.c
index acb97b257428..226c8e3ed85f 100644
--- a/net/mctp/device.c
+++ b/net/mctp/device.c
@@ -400,8 +400,8 @@ static int mctp_set_link_af(struct net_device *dev, const struct nlattr *attr,
 	struct mctp_dev *mdev;
 	int rc;
 
-	rc = nla_parse_nested(tb, IFLA_MCTP_MAX, attr, ifla_af_mctp_policy,
-			      NULL);
+	rc = nla_parse_nested_deprecated(tb, IFLA_MCTP_MAX, attr, ifla_af_mctp_policy,
+					 NULL);
 	if (rc)
 		return rc;
 
-- 
2.17.1


