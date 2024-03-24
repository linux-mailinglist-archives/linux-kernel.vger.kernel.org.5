Return-Path: <linux-kernel+bounces-114114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A24488887F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD23F286FE4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301402021B8;
	Sun, 24 Mar 2024 23:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssppzhsP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC108131E20;
	Sun, 24 Mar 2024 23:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321420; cv=none; b=e8Xd5I2F2JQSjDeD1iB6rcGFGELuzIgdesq3TPL/SMFJfGO2EfCeMtY1Z8YJfkM4JrYDfUvN4TDfoqnArzTU/yI5Ah1bYJlkDyZRbdKVbJcAKgPK5LbuyTv+xnZQwIKBVx3qauHPCjCO1PfNgXGkhiNTf0VwMha4BW96F2VoHRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321420; c=relaxed/simple;
	bh=0VAmgdQ1t/uj+NHVK29vS+oFQU05fhWw7epz4GYuTD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZ7Mw5s0mKkW4GwaOLNOCxLn1BqiYX/99WorhD7vHB7WA4+24Ej/bR3C6+sbuZjXU1K4occklGYUgFKQJz6jN27BNC3I42ttujcYs7fyv1j59iBrX+LOVjvtqG3rtTxw/JWohsx+V6EmoRJuPwvdbV0B6WIe7BgwfxTEhUAqvLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssppzhsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F44C433F1;
	Sun, 24 Mar 2024 23:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321418;
	bh=0VAmgdQ1t/uj+NHVK29vS+oFQU05fhWw7epz4GYuTD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ssppzhsPLEVctpmNVwbNP6qpoHSoCV/mWh7TFOY2JBMdxDEcQpJc658d4R3DrWjtz
	 yszeLEn4c7kfEBofuviskJJvCBuWLeLEcTJ1ydIpF/xKBGa0OqLSA1iXSCR+ElqK4C
	 BPFpAHPVEWj6iF3jz/x1KXBu0v0m59BGDMtpnegkGh7nN8Np7MT/vvFCdfgfvWtHSx
	 YR+2oRoiV4Uxsnh9G2v/SvAuMj4KwAYW64RFIl36LYonz1ZSKJ2QQukLRc85Eg4Mec
	 yVi06jIItzWQCXtTK39BZQN7IeWw1qMdXwWpwd1xCEr+98lZDK1DW7aplN6KLR4G6q
	 tyt9R5uYYO/CQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Stanislav Fomichev <sdf@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 142/638] selftests/bpf: Add netkit to tc_redirect selftest
Date: Sun, 24 Mar 2024 18:52:59 -0400
Message-ID: <20240324230116.1348576-143-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit adfeae2d243d9e5b83d094af481d189156b11779 ]

Extend the existing tc_redirect selftest to also cover netkit devices
for exercising the bpf_redirect_peer() code paths, so that we have both
veth as well as netkit covered, all tests still pass after this change.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Stanislav Fomichev <sdf@google.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://lore.kernel.org/r/20231114004220.6495-9-daniel@iogearbox.net
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Stable-dep-of: 177f1d083a19 ("selftests/bpf: Fix the flaky tc_redirect_dtime test")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/bpf/prog_tests/tc_redirect.c    | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index 407ff4e9bc788..518f143c5b0fe 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -24,6 +24,7 @@
 
 #include "test_progs.h"
 #include "network_helpers.h"
+#include "netlink_helpers.h"
 #include "test_tc_neigh_fib.skel.h"
 #include "test_tc_neigh.skel.h"
 #include "test_tc_peer.skel.h"
@@ -112,6 +113,7 @@ static void netns_setup_namespaces_nofail(const char *verb)
 
 enum dev_mode {
 	MODE_VETH,
+	MODE_NETKIT,
 };
 
 struct netns_setup_result {
@@ -142,10 +144,51 @@ static int get_ifaddr(const char *name, char *ifaddr)
 	return 0;
 }
 
+static int create_netkit(int mode, char *prim, char *peer)
+{
+	struct rtattr *linkinfo, *data, *peer_info;
+	struct rtnl_handle rth = { .fd = -1 };
+	const char *type = "netkit";
+	struct {
+		struct nlmsghdr n;
+		struct ifinfomsg i;
+		char buf[1024];
+	} req = {};
+	int err;
+
+	err = rtnl_open(&rth, 0);
+	if (!ASSERT_OK(err, "open_rtnetlink"))
+		return err;
+
+	memset(&req, 0, sizeof(req));
+	req.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg));
+	req.n.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL;
+	req.n.nlmsg_type = RTM_NEWLINK;
+	req.i.ifi_family = AF_UNSPEC;
+
+	addattr_l(&req.n, sizeof(req), IFLA_IFNAME, prim, strlen(prim));
+	linkinfo = addattr_nest(&req.n, sizeof(req), IFLA_LINKINFO);
+	addattr_l(&req.n, sizeof(req), IFLA_INFO_KIND, type, strlen(type));
+	data = addattr_nest(&req.n, sizeof(req), IFLA_INFO_DATA);
+	addattr32(&req.n, sizeof(req), IFLA_NETKIT_MODE, mode);
+	peer_info = addattr_nest(&req.n, sizeof(req), IFLA_NETKIT_PEER_INFO);
+	req.n.nlmsg_len += sizeof(struct ifinfomsg);
+	addattr_l(&req.n, sizeof(req), IFLA_IFNAME, peer, strlen(peer));
+	addattr_nest_end(&req.n, peer_info);
+	addattr_nest_end(&req.n, data);
+	addattr_nest_end(&req.n, linkinfo);
+
+	err = rtnl_talk(&rth, &req.n, NULL);
+	ASSERT_OK(err, "talk_rtnetlink");
+	rtnl_close(&rth);
+	return err;
+}
+
 static int netns_setup_links_and_routes(struct netns_setup_result *result)
 {
 	struct nstoken *nstoken = NULL;
 	char src_fwd_addr[IFADDR_STR_LEN+1] = {};
+	int err;
 
 	if (result->dev_mode == MODE_VETH) {
 		SYS(fail, "ip link add src type veth peer name src_fwd");
@@ -153,6 +196,13 @@ static int netns_setup_links_and_routes(struct netns_setup_result *result)
 
 		SYS(fail, "ip link set dst_fwd address " MAC_DST_FWD);
 		SYS(fail, "ip link set dst address " MAC_DST);
+	} else if (result->dev_mode == MODE_NETKIT) {
+		err = create_netkit(NETKIT_L3, "src", "src_fwd");
+		if (!ASSERT_OK(err, "create_ifindex_src"))
+			goto fail;
+		err = create_netkit(NETKIT_L3, "dst", "dst_fwd");
+		if (!ASSERT_OK(err, "create_ifindex_dst"))
+			goto fail;
 	}
 
 	if (get_ifaddr("src_fwd", src_fwd_addr))
@@ -1134,7 +1184,9 @@ static void *test_tc_redirect_run_tests(void *arg)
 	netns_setup_namespaces_nofail("delete");
 
 	RUN_TEST(tc_redirect_peer, MODE_VETH);
+	RUN_TEST(tc_redirect_peer, MODE_NETKIT);
 	RUN_TEST(tc_redirect_peer_l3, MODE_VETH);
+	RUN_TEST(tc_redirect_peer_l3, MODE_NETKIT);
 	RUN_TEST(tc_redirect_neigh, MODE_VETH);
 	RUN_TEST(tc_redirect_neigh_fib, MODE_VETH);
 	RUN_TEST(tc_redirect_dtime, MODE_VETH);
-- 
2.43.0


