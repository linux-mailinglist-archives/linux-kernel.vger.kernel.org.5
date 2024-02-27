Return-Path: <linux-kernel+bounces-83088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0BA868E45
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3F41F22E01
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FA11386D4;
	Tue, 27 Feb 2024 11:01:56 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE121386AE;
	Tue, 27 Feb 2024 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031715; cv=none; b=pohvIqVlkRT0KO1mwPqN3XIXReULA7XDNILyx1qurFc8bVdTpHTYyo2TowLnvIIzi0sRZ3Xg+/XQUXNiquWWbqxW1cvb3CGQ7fkAHvE/WRVyNEu/koImdxxBAlKANWanA+R5fS+8/+uvd6z0iBzp1Xabx55ECGI3VJ5VgQ+fCwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031715; c=relaxed/simple;
	bh=MzzTNS9G71t2d0M0T7B+kJ7LHbvG1oqr4ucnMfdFsnU=;
	h=From:To:Subject:Date:Message-Id; b=AIwpMJF0Ls/IU+pKmb6rUNug4oj9B3lpTdmktKU0niJsUxdhL3rKXair/Mi5+wMfUXeTSkXOMPFk8aBRo7zIevOgqt5387raBPjs1ugWzRm61pB9JxXm0uZxjci8CA/aHA2XCj3qJ+cdjmzmQoSBUY/tUMpjMRD1TwOlLQhaodw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from localhost.localdomain (unknown [39.174.92.167])
	by mail-app3 (Coremail) with SMTP id cC_KCgD32TMDwd1lowWhAQ--.41758S4;
	Tue, 27 Feb 2024 19:01:25 +0800 (CST)
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
Subject: [PATCH net v1] rtnetlink: fix error logic of IFLA_BRIDGE_FLAGS writing back
Date: Tue, 27 Feb 2024 19:01:13 +0800
Message-Id: <20240227110113.573334-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cC_KCgD32TMDwd1lowWhAQ--.41758S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AFW8WFWDXr1fWFy3ZFWrKrg_yoW5JFy3pF
	WfKa47XF4DArn7ZrsrtF4DZa4avrs7GFW8ur4Ykw10yr1jqF1ruFWkKFyfuFyakFZ7AFy7
	XF12kFW5W3ZxCFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUOv38UUUUU
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
 net/core/rtnetlink.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 9c4f427f3a50..e9f16e5e3515 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -5169,10 +5169,9 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net *net = sock_net(skb->sk);
 	struct ifinfomsg *ifm;
 	struct net_device *dev;
-	struct nlattr *br_spec, *attr = NULL;
+	struct nlattr *br_spec, *attr, *br_flag = NULL;
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
+			if (nla_type(attr) == IFLA_BRIDGE_FLAGS && !br_flag) {
 				if (nla_len(attr) < sizeof(flags))
 					return -EINVAL;
 
-				have_flags = true;
+				br_flag = attr;
 				flags = nla_get_u16(attr);
 			}
 
@@ -5238,8 +5237,8 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 	}
 
-	if (have_flags)
-		memcpy(nla_data(attr), &flags, sizeof(flags));
+	if (br_flag)
+		memcpy(nla_data(br_flag), &flags, sizeof(flags));
 out:
 	return err;
 }
-- 
2.17.1


