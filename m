Return-Path: <linux-kernel+bounces-153634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14578AD0B1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B50628B12D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F00154427;
	Mon, 22 Apr 2024 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="KJ6VrDSx"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2989153BEB;
	Mon, 22 Apr 2024 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799694; cv=none; b=Fj5HgOKoNud6FN4+0PZi9r3O19Tn934OmysW+2jgCHlVVWeJTy53iMCZYHevrymbHZ3Ho3dFuJMySAEih+X5nblJQVk584PElfaxaMh83rNd3VW9htUAvcK/LuBNKebKXL2Lor5At5jBXsC9NaDLXZrbZst5Zhm0PDymRCsjIwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799694; c=relaxed/simple;
	bh=8CMLhBa/Jv+VnG6a3YiAvNFaNjvvD6CI0McXJiVGWO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HOX0Y4TZqOWPg/2HgMxMxyHouGyqzxQu8+azs+YMM00SC4cq23eG6JV8I+VQkKtoZ+aD/YlBObIyY8z7N/KSJIVvyhyRWeWTiRV50rWj9W6wPhl5Gv75SWAFSoFemCGBYP486fsyyt3lJsYCy1YzBLPWvz9BOQOz3otY0jgTQ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=KJ6VrDSx; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 867CF600AF;
	Mon, 22 Apr 2024 15:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713799690;
	bh=8CMLhBa/Jv+VnG6a3YiAvNFaNjvvD6CI0McXJiVGWO4=;
	h=From:To:Cc:Subject:Date:From;
	b=KJ6VrDSxYoqE6NXW099g5eSM9FXZzTpjCRY/6nr3x+Lln7LxkTciSsB3D3WwrKvj9
	 4I2fySynfrCOcV0uca8LtyjqIoq9VuJOgVhHr2u45VoK+JmBlJDAr+DyyUY+xnZMhm
	 rpo9IukDAo7EiVxFkWRyuHWORaYJEjl+XPilgDB+xAOJz4UgQRhvN7OhEHoe4UprHH
	 zQAQZ/h1NTy3kZ9fM/yhXZpozWCC/k0hBN6g5GF15AwPIqERhJ5mMRlYBJ+xGclzFT
	 xjuDLdw2edCxSDtFHRRPtGwbIYoxEg9zBEJIDHMaMdsYgIi0HV70MIbq8RqNIErGED
	 5e7NWshfn23tQ==
Received: by x201s (Postfix, from userid 1000)
	id 1670E208EB4; Mon, 22 Apr 2024 15:27:17 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>
Subject: [PATCH net-next] net: hns3: flower: validate control flags
Date: Mon, 22 Apr 2024 15:27:16 +0000
Message-ID: <20240422152717.175659-1-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This driver currently doesn't support any control flags.

Use flow_rule_has_control_flags() to check for control flags,
such as can be set through `tc flower ... ip_flags frag`.

In case any control flags are masked, flow_rule_has_control_flags()
sets a NL extended error message, and we return -EOPNOTSUPP.

Also propagate extack to hclge_get_cls_key_ip(), and convert it to
return error code.

Only compile-tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 .../hisilicon/hns3/hns3pf/hclge_main.c         | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 28336cf17170..85b5d2331fc9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -7222,8 +7222,9 @@ static void hclge_get_cls_key_vlan(const struct flow_rule *flow,
 	}
 }
 
-static void hclge_get_cls_key_ip(const struct flow_rule *flow,
-				 struct hclge_fd_rule *rule)
+static int hclge_get_cls_key_ip(const struct flow_rule *flow,
+				struct hclge_fd_rule *rule,
+				struct netlink_ext_ack *extack)
 {
 	u16 addr_type = 0;
 
@@ -7232,6 +7233,9 @@ static void hclge_get_cls_key_ip(const struct flow_rule *flow,
 
 		flow_rule_match_control(flow, &match);
 		addr_type = match.key->addr_type;
+
+		if (flow_rule_has_control_flags(match.mask->flags, extack))
+			return -EOPNOTSUPP;
 	}
 
 	if (addr_type == FLOW_DISSECTOR_KEY_IPV4_ADDRS) {
@@ -7260,6 +7264,8 @@ static void hclge_get_cls_key_ip(const struct flow_rule *flow,
 		rule->unused_tuple |= BIT(INNER_SRC_IP);
 		rule->unused_tuple |= BIT(INNER_DST_IP);
 	}
+
+	return 0;
 }
 
 static void hclge_get_cls_key_port(const struct flow_rule *flow,
@@ -7285,7 +7291,9 @@ static int hclge_parse_cls_flower(struct hclge_dev *hdev,
 				  struct hclge_fd_rule *rule)
 {
 	struct flow_rule *flow = flow_cls_offload_flow_rule(cls_flower);
+	struct netlink_ext_ack *extack = cls_flower->common.extack;
 	struct flow_dissector *dissector = flow->match.dissector;
+	int ret;
 
 	if (dissector->used_keys &
 	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
@@ -7303,7 +7311,11 @@ static int hclge_parse_cls_flower(struct hclge_dev *hdev,
 	hclge_get_cls_key_basic(flow, rule);
 	hclge_get_cls_key_mac(flow, rule);
 	hclge_get_cls_key_vlan(flow, rule);
-	hclge_get_cls_key_ip(flow, rule);
+
+	ret = hclge_get_cls_key_ip(flow, rule, extack);
+	if (ret)
+		return ret;
+
 	hclge_get_cls_key_port(flow, rule);
 
 	return 0;
-- 
2.43.0


