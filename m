Return-Path: <linux-kernel+bounces-83202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64484869029
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88EB51C21B64
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F45143C7B;
	Tue, 27 Feb 2024 12:12:04 +0000 (UTC)
Received: from zg8tmtu5ljg5lje1ms4xmtka.icoremail.net (zg8tmtu5ljg5lje1ms4xmtka.icoremail.net [159.89.151.119])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F911420C4;
	Tue, 27 Feb 2024 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.89.151.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035924; cv=none; b=cD2Vt1M3OBeCIMo9gtqPeHZdELYwRavsVG+HD1vwW/LhK4sILgyiWaA1Of2mk9lI5+cu1FzYZ7oaLXzddu4jwN3BWj2T4PcbyAmv76tgqAF5a/S/0cCoBWJep3B9QffoN6/E2TsOazIcdyt3fGBG17zP9m3qnCXY4ea3ivesvus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035924; c=relaxed/simple;
	bh=PRbPf7BCbHwK2buRz5uodWE7f30oFbcZYo5Q4brrAI0=;
	h=From:To:Subject:Date:Message-Id; b=iAC/sgcYIPoNB4azTdQN6Sfbo8vSrb9jFCUqiYs+n9ysRj7V6+gLp6vK14PJoFMHcuoa9nkhtyx2xz4gQ0BcR1HcnxXvsFo7c8jg3yQK+H2Bb1fQRv50kMDfWdLQ7/+gOiWhj6wnUiSmbJ6edCL/2aT0Q8MFuqCObO7ZzREZ8l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=159.89.151.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from localhost.localdomain (unknown [125.120.153.166])
	by mail-app2 (Coremail) with SMTP id by_KCgCXTa550d1lORdMAg--.22855S4;
	Tue, 27 Feb 2024 20:11:38 +0800 (CST)
From: Lin Ma <linma@zju.edu.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	idosch@nvidia.com,
	razor@blackwall.org,
	jiri@resnulli.us,
	lucien.xin@gmail.com,
	linma@zju.edu.cn,
	edwin.peer@broadcom.com,
	amcohen@nvidia.com,
	pctammela@mojatatu.com,
	liuhangbin@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] rtnetlink: fix error logic of IFLA_BRIDGE_FLAGS writing back
Date: Tue, 27 Feb 2024 20:11:28 +0800
Message-Id: <20240227121128.608110-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:by_KCgCXTa550d1lORdMAg--.22855S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGr4ftw47Cw4fWr4xuFyDWrg_yoW5Gw18pF
	4rKa42qF4kJrn7Zr47JF4UZayavrs7GFW8Cr4Yyw10yr1aqF1ruFZ7KFy3uFyayFZrAr17
	XF1qyFW5XanxCFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUQID7UUUUU=
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In the commit d73ef2d69c0d ("rtnetlink: let rtnl_bridge_setlink checks
IFLA_BRIDGE_MODE length"), an adjustment was made to the old loop logic
in the function `rtnl_bridge_setlink` to enable the loop to also check
the length of the IFLA_BRIDGE_MODE attribute. However, this adjustment
removed the `break` statement and led to an error logic of the flags
writing back at the end of this function.

if (have_flags)
    memcpy(nla_data(attr), &flags, sizeof(flags));
    // attr should point to IFLA_BRIDGE_FLAGS NLA !!!

Before the mentioned commit, the `attr` is granted to be IFLA_BRIDGE_FLAGS.
However, this is not necessarily true fow now as the updated loop will let
the attr point to the last NLA, even an invalid NLA which could cause
overflow writes.

This patch introduces a new variable `br_flag` to save the NLA pointer
that points to IFLA_BRIDGE_FLAGS and uses it to resolve the mentioned
error logic.

Fixes: d73ef2d69c0d ("rtnetlink: let rtnl_bridge_setlink checks IFLA_BRIDGE_MODE length")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
v1 -> v2: rename the br_flag to br_flags_attr which offers better
          description suggested by Nikolay.

 net/core/rtnetlink.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 9c4f427f3a50..ae86f751efc3 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -5169,10 +5169,9 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net *net = sock_net(skb->sk);
 	struct ifinfomsg *ifm;
 	struct net_device *dev;
-	struct nlattr *br_spec, *attr = NULL;
+	struct nlattr *br_spec, *attr, *br_flags_attr = NULL;
 	int rem, err = -EOPNOTSUPP;
 	u16 flags = 0;
-	bool have_flags = false;
 
 	if (nlmsg_len(nlh) < sizeof(*ifm))
 		return -EINVAL;
@@ -5190,11 +5189,11 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
 	if (br_spec) {
 		nla_for_each_nested(attr, br_spec, rem) {
-			if (nla_type(attr) == IFLA_BRIDGE_FLAGS && !have_flags) {
+			if (nla_type(attr) == IFLA_BRIDGE_FLAGS && !br_flags_attr) {
 				if (nla_len(attr) < sizeof(flags))
 					return -EINVAL;
 
-				have_flags = true;
+				br_flags_attr = attr;
 				flags = nla_get_u16(attr);
 			}
 
@@ -5238,8 +5237,8 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 	}
 
-	if (have_flags)
-		memcpy(nla_data(attr), &flags, sizeof(flags));
+	if (br_flags_attr)
+		memcpy(nla_data(br_flags_attr), &flags, sizeof(flags));
 out:
 	return err;
 }
-- 
2.17.1


