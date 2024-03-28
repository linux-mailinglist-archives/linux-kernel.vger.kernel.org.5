Return-Path: <linux-kernel+bounces-114113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BAC88887C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A3A1C27877
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFF620219A;
	Sun, 24 Mar 2024 23:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxRjZWO3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F6B1E7E18;
	Sun, 24 Mar 2024 23:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321418; cv=none; b=pRrzTEF2M29/IpBESJGTneBWJEPY6dicLnryVRY9XqnPtm5dXA6P0q57ty6SYx/rebgPtHGRgwgPkr6ji203ddKCBT7nr4A4IMBFlvEak/xmHMwdXZdaii7QkOaJgeDmBrXJMKH3mVeZWborGyvu1SxK1v0QDwc3TQo4SPsrC0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321418; c=relaxed/simple;
	bh=cOneneQTxDJq0wolhyn4GCWoWHESQBbE/3GBVzu4Z+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBtJLpPXi+nom9ObZy1swTKXp1yS+87H7oBgX/I1lrUQ9JJbEW8C7H7Mkuu2CzJ12neQHMXTXsVZph5HG8PBjvtEQ3dfASkwGYeDUrQD1cvpNPjTX/fMVkLKmwcATPTziIvETRqiXqoE86MGgFO/mIZNamrzJc/soVh0zGK3mi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxRjZWO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39E6C43394;
	Sun, 24 Mar 2024 23:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321417;
	bh=cOneneQTxDJq0wolhyn4GCWoWHESQBbE/3GBVzu4Z+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CxRjZWO3FOCZXNPgYmzEhwjYt6fOx8JKtoCfOhd5UBQIURyZlMrbBZCYREIDNJZDy
	 JApMENJgeqcJxFeUp9Dj3wWl5tYWMpBJ87896KPz0Xqqemrb08KnSDOC1nMI7WN693
	 IusckId9K3GvbIQsPRM1bb9xaQhjzvMZBe3dCMwy2drVTZxP8sXTZyuZj0jQIXw7jK
	 Xoeevl4uVySvGOba7OZGSto7hwVxZFVU7Z06RDX94O+/GBOm52DiGJKkE9zY0wf8/a
	 9vTOohjpHCYUMsxRb3IDtne7Dd218/tQaGf9kmkbsnlCLkoauc0jag1ER/KXqGlmoT
	 zz/S3m8JcmSZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Stanislav Fomichev <sdf@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 141/638] selftests/bpf: De-veth-ize the tc_redirect test case
Date: Sun, 24 Mar 2024 18:52:58 -0400
Message-ID: <20240324230116.1348576-142-sashal@kernel.org>
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

[ Upstream commit eee82da79f036bb49ff80d3088b9530e3c2e57eb ]

No functional changes to the test case, but just renaming various functions,
variables, etc, to remove veth part of their name for making it more generic
and reusable later on (e.g. for netkit).

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Stanislav Fomichev <sdf@google.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://lore.kernel.org/r/20231114004220.6495-8-daniel@iogearbox.net
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Stable-dep-of: 177f1d083a19 ("selftests/bpf: Fix the flaky tc_redirect_dtime test")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/bpf/prog_tests/tc_redirect.c    | 263 +++++++++---------
 1 file changed, 137 insertions(+), 126 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index 6ee22c3b251ad..407ff4e9bc788 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -110,11 +110,16 @@ static void netns_setup_namespaces_nofail(const char *verb)
 	}
 }
 
+enum dev_mode {
+	MODE_VETH,
+};
+
 struct netns_setup_result {
-	int ifindex_veth_src;
-	int ifindex_veth_src_fwd;
-	int ifindex_veth_dst;
-	int ifindex_veth_dst_fwd;
+	enum dev_mode dev_mode;
+	int ifindex_src;
+	int ifindex_src_fwd;
+	int ifindex_dst;
+	int ifindex_dst_fwd;
 };
 
 static int get_ifaddr(const char *name, char *ifaddr)
@@ -140,55 +145,59 @@ static int get_ifaddr(const char *name, char *ifaddr)
 static int netns_setup_links_and_routes(struct netns_setup_result *result)
 {
 	struct nstoken *nstoken = NULL;
-	char veth_src_fwd_addr[IFADDR_STR_LEN+1] = {};
+	char src_fwd_addr[IFADDR_STR_LEN+1] = {};
 
-	SYS(fail, "ip link add veth_src type veth peer name veth_src_fwd");
-	SYS(fail, "ip link add veth_dst type veth peer name veth_dst_fwd");
+	if (result->dev_mode == MODE_VETH) {
+		SYS(fail, "ip link add src type veth peer name src_fwd");
+		SYS(fail, "ip link add dst type veth peer name dst_fwd");
 
-	SYS(fail, "ip link set veth_dst_fwd address " MAC_DST_FWD);
-	SYS(fail, "ip link set veth_dst address " MAC_DST);
+		SYS(fail, "ip link set dst_fwd address " MAC_DST_FWD);
+		SYS(fail, "ip link set dst address " MAC_DST);
+	}
 
-	if (get_ifaddr("veth_src_fwd", veth_src_fwd_addr))
+	if (get_ifaddr("src_fwd", src_fwd_addr))
 		goto fail;
 
-	result->ifindex_veth_src = if_nametoindex("veth_src");
-	if (!ASSERT_GT(result->ifindex_veth_src, 0, "ifindex_veth_src"))
+	result->ifindex_src = if_nametoindex("src");
+	if (!ASSERT_GT(result->ifindex_src, 0, "ifindex_src"))
 		goto fail;
 
-	result->ifindex_veth_src_fwd = if_nametoindex("veth_src_fwd");
-	if (!ASSERT_GT(result->ifindex_veth_src_fwd, 0, "ifindex_veth_src_fwd"))
+	result->ifindex_src_fwd = if_nametoindex("src_fwd");
+	if (!ASSERT_GT(result->ifindex_src_fwd, 0, "ifindex_src_fwd"))
 		goto fail;
 
-	result->ifindex_veth_dst = if_nametoindex("veth_dst");
-	if (!ASSERT_GT(result->ifindex_veth_dst, 0, "ifindex_veth_dst"))
+	result->ifindex_dst = if_nametoindex("dst");
+	if (!ASSERT_GT(result->ifindex_dst, 0, "ifindex_dst"))
 		goto fail;
 
-	result->ifindex_veth_dst_fwd = if_nametoindex("veth_dst_fwd");
-	if (!ASSERT_GT(result->ifindex_veth_dst_fwd, 0, "ifindex_veth_dst_fwd"))
+	result->ifindex_dst_fwd = if_nametoindex("dst_fwd");
+	if (!ASSERT_GT(result->ifindex_dst_fwd, 0, "ifindex_dst_fwd"))
 		goto fail;
 
-	SYS(fail, "ip link set veth_src netns " NS_SRC);
-	SYS(fail, "ip link set veth_src_fwd netns " NS_FWD);
-	SYS(fail, "ip link set veth_dst_fwd netns " NS_FWD);
-	SYS(fail, "ip link set veth_dst netns " NS_DST);
+	SYS(fail, "ip link set src netns " NS_SRC);
+	SYS(fail, "ip link set src_fwd netns " NS_FWD);
+	SYS(fail, "ip link set dst_fwd netns " NS_FWD);
+	SYS(fail, "ip link set dst netns " NS_DST);
 
 	/** setup in 'src' namespace */
 	nstoken = open_netns(NS_SRC);
 	if (!ASSERT_OK_PTR(nstoken, "setns src"))
 		goto fail;
 
-	SYS(fail, "ip addr add " IP4_SRC "/32 dev veth_src");
-	SYS(fail, "ip addr add " IP6_SRC "/128 dev veth_src nodad");
-	SYS(fail, "ip link set dev veth_src up");
+	SYS(fail, "ip addr add " IP4_SRC "/32 dev src");
+	SYS(fail, "ip addr add " IP6_SRC "/128 dev src nodad");
+	SYS(fail, "ip link set dev src up");
 
-	SYS(fail, "ip route add " IP4_DST "/32 dev veth_src scope global");
-	SYS(fail, "ip route add " IP4_NET "/16 dev veth_src scope global");
-	SYS(fail, "ip route add " IP6_DST "/128 dev veth_src scope global");
+	SYS(fail, "ip route add " IP4_DST "/32 dev src scope global");
+	SYS(fail, "ip route add " IP4_NET "/16 dev src scope global");
+	SYS(fail, "ip route add " IP6_DST "/128 dev src scope global");
 
-	SYS(fail, "ip neigh add " IP4_DST " dev veth_src lladdr %s",
-	    veth_src_fwd_addr);
-	SYS(fail, "ip neigh add " IP6_DST " dev veth_src lladdr %s",
-	    veth_src_fwd_addr);
+	if (result->dev_mode == MODE_VETH) {
+		SYS(fail, "ip neigh add " IP4_DST " dev src lladdr %s",
+		    src_fwd_addr);
+		SYS(fail, "ip neigh add " IP6_DST " dev src lladdr %s",
+		    src_fwd_addr);
+	}
 
 	close_netns(nstoken);
 
@@ -201,15 +210,15 @@ static int netns_setup_links_and_routes(struct netns_setup_result *result)
 	 * needs v4 one in order to start ARP probing. IP4_NET route is added
 	 * to the endpoints so that the ARP processing will reply.
 	 */
-	SYS(fail, "ip addr add " IP4_SLL "/32 dev veth_src_fwd");
-	SYS(fail, "ip addr add " IP4_DLL "/32 dev veth_dst_fwd");
-	SYS(fail, "ip link set dev veth_src_fwd up");
-	SYS(fail, "ip link set dev veth_dst_fwd up");
+	SYS(fail, "ip addr add " IP4_SLL "/32 dev src_fwd");
+	SYS(fail, "ip addr add " IP4_DLL "/32 dev dst_fwd");
+	SYS(fail, "ip link set dev src_fwd up");
+	SYS(fail, "ip link set dev dst_fwd up");
 
-	SYS(fail, "ip route add " IP4_SRC "/32 dev veth_src_fwd scope global");
-	SYS(fail, "ip route add " IP6_SRC "/128 dev veth_src_fwd scope global");
-	SYS(fail, "ip route add " IP4_DST "/32 dev veth_dst_fwd scope global");
-	SYS(fail, "ip route add " IP6_DST "/128 dev veth_dst_fwd scope global");
+	SYS(fail, "ip route add " IP4_SRC "/32 dev src_fwd scope global");
+	SYS(fail, "ip route add " IP6_SRC "/128 dev src_fwd scope global");
+	SYS(fail, "ip route add " IP4_DST "/32 dev dst_fwd scope global");
+	SYS(fail, "ip route add " IP6_DST "/128 dev dst_fwd scope global");
 
 	close_netns(nstoken);
 
@@ -218,16 +227,18 @@ static int netns_setup_links_and_routes(struct netns_setup_result *result)
 	if (!ASSERT_OK_PTR(nstoken, "setns dst"))
 		goto fail;
 
-	SYS(fail, "ip addr add " IP4_DST "/32 dev veth_dst");
-	SYS(fail, "ip addr add " IP6_DST "/128 dev veth_dst nodad");
-	SYS(fail, "ip link set dev veth_dst up");
+	SYS(fail, "ip addr add " IP4_DST "/32 dev dst");
+	SYS(fail, "ip addr add " IP6_DST "/128 dev dst nodad");
+	SYS(fail, "ip link set dev dst up");
 
-	SYS(fail, "ip route add " IP4_SRC "/32 dev veth_dst scope global");
-	SYS(fail, "ip route add " IP4_NET "/16 dev veth_dst scope global");
-	SYS(fail, "ip route add " IP6_SRC "/128 dev veth_dst scope global");
+	SYS(fail, "ip route add " IP4_SRC "/32 dev dst scope global");
+	SYS(fail, "ip route add " IP4_NET "/16 dev dst scope global");
+	SYS(fail, "ip route add " IP6_SRC "/128 dev dst scope global");
 
-	SYS(fail, "ip neigh add " IP4_SRC " dev veth_dst lladdr " MAC_DST_FWD);
-	SYS(fail, "ip neigh add " IP6_SRC " dev veth_dst lladdr " MAC_DST_FWD);
+	if (result->dev_mode == MODE_VETH) {
+		SYS(fail, "ip neigh add " IP4_SRC " dev dst lladdr " MAC_DST_FWD);
+		SYS(fail, "ip neigh add " IP6_SRC " dev dst lladdr " MAC_DST_FWD);
+	}
 
 	close_netns(nstoken);
 
@@ -293,23 +304,23 @@ static int netns_load_bpf(const struct bpf_program *src_prog,
 			  const struct bpf_program *chk_prog,
 			  const struct netns_setup_result *setup_result)
 {
-	LIBBPF_OPTS(bpf_tc_hook, qdisc_veth_src_fwd);
-	LIBBPF_OPTS(bpf_tc_hook, qdisc_veth_dst_fwd);
+	LIBBPF_OPTS(bpf_tc_hook, qdisc_src_fwd);
+	LIBBPF_OPTS(bpf_tc_hook, qdisc_dst_fwd);
 	int err;
 
-	/* tc qdisc add dev veth_src_fwd clsact */
-	QDISC_CLSACT_CREATE(&qdisc_veth_src_fwd, setup_result->ifindex_veth_src_fwd);
-	/* tc filter add dev veth_src_fwd ingress bpf da src_prog */
-	XGRESS_FILTER_ADD(&qdisc_veth_src_fwd, BPF_TC_INGRESS, src_prog, 0);
-	/* tc filter add dev veth_src_fwd egress bpf da chk_prog */
-	XGRESS_FILTER_ADD(&qdisc_veth_src_fwd, BPF_TC_EGRESS, chk_prog, 0);
+	/* tc qdisc add dev src_fwd clsact */
+	QDISC_CLSACT_CREATE(&qdisc_src_fwd, setup_result->ifindex_src_fwd);
+	/* tc filter add dev src_fwd ingress bpf da src_prog */
+	XGRESS_FILTER_ADD(&qdisc_src_fwd, BPF_TC_INGRESS, src_prog, 0);
+	/* tc filter add dev src_fwd egress bpf da chk_prog */
+	XGRESS_FILTER_ADD(&qdisc_src_fwd, BPF_TC_EGRESS, chk_prog, 0);
 
-	/* tc qdisc add dev veth_dst_fwd clsact */
-	QDISC_CLSACT_CREATE(&qdisc_veth_dst_fwd, setup_result->ifindex_veth_dst_fwd);
-	/* tc filter add dev veth_dst_fwd ingress bpf da dst_prog */
-	XGRESS_FILTER_ADD(&qdisc_veth_dst_fwd, BPF_TC_INGRESS, dst_prog, 0);
-	/* tc filter add dev veth_dst_fwd egress bpf da chk_prog */
-	XGRESS_FILTER_ADD(&qdisc_veth_dst_fwd, BPF_TC_EGRESS, chk_prog, 0);
+	/* tc qdisc add dev dst_fwd clsact */
+	QDISC_CLSACT_CREATE(&qdisc_dst_fwd, setup_result->ifindex_dst_fwd);
+	/* tc filter add dev dst_fwd ingress bpf da dst_prog */
+	XGRESS_FILTER_ADD(&qdisc_dst_fwd, BPF_TC_INGRESS, dst_prog, 0);
+	/* tc filter add dev dst_fwd egress bpf da chk_prog */
+	XGRESS_FILTER_ADD(&qdisc_dst_fwd, BPF_TC_EGRESS, chk_prog, 0);
 
 	return 0;
 fail:
@@ -539,10 +550,10 @@ static void test_inet_dtime(int family, int type, const char *addr, __u16 port)
 static int netns_load_dtime_bpf(struct test_tc_dtime *skel,
 				const struct netns_setup_result *setup_result)
 {
-	LIBBPF_OPTS(bpf_tc_hook, qdisc_veth_src_fwd);
-	LIBBPF_OPTS(bpf_tc_hook, qdisc_veth_dst_fwd);
-	LIBBPF_OPTS(bpf_tc_hook, qdisc_veth_src);
-	LIBBPF_OPTS(bpf_tc_hook, qdisc_veth_dst);
+	LIBBPF_OPTS(bpf_tc_hook, qdisc_src_fwd);
+	LIBBPF_OPTS(bpf_tc_hook, qdisc_dst_fwd);
+	LIBBPF_OPTS(bpf_tc_hook, qdisc_src);
+	LIBBPF_OPTS(bpf_tc_hook, qdisc_dst);
 	struct nstoken *nstoken;
 	int err;
 
@@ -550,58 +561,58 @@ static int netns_load_dtime_bpf(struct test_tc_dtime *skel,
 	nstoken = open_netns(NS_SRC);
 	if (!ASSERT_OK_PTR(nstoken, "setns " NS_SRC))
 		return -1;
-	/* tc qdisc add dev veth_src clsact */
-	QDISC_CLSACT_CREATE(&qdisc_veth_src, setup_result->ifindex_veth_src);
-	/* tc filter add dev veth_src ingress bpf da ingress_host */
-	XGRESS_FILTER_ADD(&qdisc_veth_src, BPF_TC_INGRESS, skel->progs.ingress_host, 0);
-	/* tc filter add dev veth_src egress bpf da egress_host */
-	XGRESS_FILTER_ADD(&qdisc_veth_src, BPF_TC_EGRESS, skel->progs.egress_host, 0);
+	/* tc qdisc add dev src clsact */
+	QDISC_CLSACT_CREATE(&qdisc_src, setup_result->ifindex_src);
+	/* tc filter add dev src ingress bpf da ingress_host */
+	XGRESS_FILTER_ADD(&qdisc_src, BPF_TC_INGRESS, skel->progs.ingress_host, 0);
+	/* tc filter add dev src egress bpf da egress_host */
+	XGRESS_FILTER_ADD(&qdisc_src, BPF_TC_EGRESS, skel->progs.egress_host, 0);
 	close_netns(nstoken);
 
 	/* setup ns_dst tc progs */
 	nstoken = open_netns(NS_DST);
 	if (!ASSERT_OK_PTR(nstoken, "setns " NS_DST))
 		return -1;
-	/* tc qdisc add dev veth_dst clsact */
-	QDISC_CLSACT_CREATE(&qdisc_veth_dst, setup_result->ifindex_veth_dst);
-	/* tc filter add dev veth_dst ingress bpf da ingress_host */
-	XGRESS_FILTER_ADD(&qdisc_veth_dst, BPF_TC_INGRESS, skel->progs.ingress_host, 0);
-	/* tc filter add dev veth_dst egress bpf da egress_host */
-	XGRESS_FILTER_ADD(&qdisc_veth_dst, BPF_TC_EGRESS, skel->progs.egress_host, 0);
+	/* tc qdisc add dev dst clsact */
+	QDISC_CLSACT_CREATE(&qdisc_dst, setup_result->ifindex_dst);
+	/* tc filter add dev dst ingress bpf da ingress_host */
+	XGRESS_FILTER_ADD(&qdisc_dst, BPF_TC_INGRESS, skel->progs.ingress_host, 0);
+	/* tc filter add dev dst egress bpf da egress_host */
+	XGRESS_FILTER_ADD(&qdisc_dst, BPF_TC_EGRESS, skel->progs.egress_host, 0);
 	close_netns(nstoken);
 
 	/* setup ns_fwd tc progs */
 	nstoken = open_netns(NS_FWD);
 	if (!ASSERT_OK_PTR(nstoken, "setns " NS_FWD))
 		return -1;
-	/* tc qdisc add dev veth_dst_fwd clsact */
-	QDISC_CLSACT_CREATE(&qdisc_veth_dst_fwd, setup_result->ifindex_veth_dst_fwd);
-	/* tc filter add dev veth_dst_fwd ingress prio 100 bpf da ingress_fwdns_prio100 */
-	XGRESS_FILTER_ADD(&qdisc_veth_dst_fwd, BPF_TC_INGRESS,
+	/* tc qdisc add dev dst_fwd clsact */
+	QDISC_CLSACT_CREATE(&qdisc_dst_fwd, setup_result->ifindex_dst_fwd);
+	/* tc filter add dev dst_fwd ingress prio 100 bpf da ingress_fwdns_prio100 */
+	XGRESS_FILTER_ADD(&qdisc_dst_fwd, BPF_TC_INGRESS,
 			  skel->progs.ingress_fwdns_prio100, 100);
-	/* tc filter add dev veth_dst_fwd ingress prio 101 bpf da ingress_fwdns_prio101 */
-	XGRESS_FILTER_ADD(&qdisc_veth_dst_fwd, BPF_TC_INGRESS,
+	/* tc filter add dev dst_fwd ingress prio 101 bpf da ingress_fwdns_prio101 */
+	XGRESS_FILTER_ADD(&qdisc_dst_fwd, BPF_TC_INGRESS,
 			  skel->progs.ingress_fwdns_prio101, 101);
-	/* tc filter add dev veth_dst_fwd egress prio 100 bpf da egress_fwdns_prio100 */
-	XGRESS_FILTER_ADD(&qdisc_veth_dst_fwd, BPF_TC_EGRESS,
+	/* tc filter add dev dst_fwd egress prio 100 bpf da egress_fwdns_prio100 */
+	XGRESS_FILTER_ADD(&qdisc_dst_fwd, BPF_TC_EGRESS,
 			  skel->progs.egress_fwdns_prio100, 100);
-	/* tc filter add dev veth_dst_fwd egress prio 101 bpf da egress_fwdns_prio101 */
-	XGRESS_FILTER_ADD(&qdisc_veth_dst_fwd, BPF_TC_EGRESS,
+	/* tc filter add dev dst_fwd egress prio 101 bpf da egress_fwdns_prio101 */
+	XGRESS_FILTER_ADD(&qdisc_dst_fwd, BPF_TC_EGRESS,
 			  skel->progs.egress_fwdns_prio101, 101);
 
-	/* tc qdisc add dev veth_src_fwd clsact */
-	QDISC_CLSACT_CREATE(&qdisc_veth_src_fwd, setup_result->ifindex_veth_src_fwd);
-	/* tc filter add dev veth_src_fwd ingress prio 100 bpf da ingress_fwdns_prio100 */
-	XGRESS_FILTER_ADD(&qdisc_veth_src_fwd, BPF_TC_INGRESS,
+	/* tc qdisc add dev src_fwd clsact */
+	QDISC_CLSACT_CREATE(&qdisc_src_fwd, setup_result->ifindex_src_fwd);
+	/* tc filter add dev src_fwd ingress prio 100 bpf da ingress_fwdns_prio100 */
+	XGRESS_FILTER_ADD(&qdisc_src_fwd, BPF_TC_INGRESS,
 			  skel->progs.ingress_fwdns_prio100, 100);
-	/* tc filter add dev veth_src_fwd ingress prio 101 bpf da ingress_fwdns_prio101 */
-	XGRESS_FILTER_ADD(&qdisc_veth_src_fwd, BPF_TC_INGRESS,
+	/* tc filter add dev src_fwd ingress prio 101 bpf da ingress_fwdns_prio101 */
+	XGRESS_FILTER_ADD(&qdisc_src_fwd, BPF_TC_INGRESS,
 			  skel->progs.ingress_fwdns_prio101, 101);
-	/* tc filter add dev veth_src_fwd egress prio 100 bpf da egress_fwdns_prio100 */
-	XGRESS_FILTER_ADD(&qdisc_veth_src_fwd, BPF_TC_EGRESS,
+	/* tc filter add dev src_fwd egress prio 100 bpf da egress_fwdns_prio100 */
+	XGRESS_FILTER_ADD(&qdisc_src_fwd, BPF_TC_EGRESS,
 			  skel->progs.egress_fwdns_prio100, 100);
-	/* tc filter add dev veth_src_fwd egress prio 101 bpf da egress_fwdns_prio101 */
-	XGRESS_FILTER_ADD(&qdisc_veth_src_fwd, BPF_TC_EGRESS,
+	/* tc filter add dev src_fwd egress prio 101 bpf da egress_fwdns_prio101 */
+	XGRESS_FILTER_ADD(&qdisc_src_fwd, BPF_TC_EGRESS,
 			  skel->progs.egress_fwdns_prio101, 101);
 	close_netns(nstoken);
 	return 0;
@@ -777,8 +788,8 @@ static void test_tc_redirect_dtime(struct netns_setup_result *setup_result)
 	if (!ASSERT_OK_PTR(skel, "test_tc_dtime__open"))
 		return;
 
-	skel->rodata->IFINDEX_SRC = setup_result->ifindex_veth_src_fwd;
-	skel->rodata->IFINDEX_DST = setup_result->ifindex_veth_dst_fwd;
+	skel->rodata->IFINDEX_SRC = setup_result->ifindex_src_fwd;
+	skel->rodata->IFINDEX_DST = setup_result->ifindex_dst_fwd;
 
 	err = test_tc_dtime__load(skel);
 	if (!ASSERT_OK(err, "test_tc_dtime__load"))
@@ -868,8 +879,8 @@ static void test_tc_redirect_neigh(struct netns_setup_result *setup_result)
 	if (!ASSERT_OK_PTR(skel, "test_tc_neigh__open"))
 		goto done;
 
-	skel->rodata->IFINDEX_SRC = setup_result->ifindex_veth_src_fwd;
-	skel->rodata->IFINDEX_DST = setup_result->ifindex_veth_dst_fwd;
+	skel->rodata->IFINDEX_SRC = setup_result->ifindex_src_fwd;
+	skel->rodata->IFINDEX_DST = setup_result->ifindex_dst_fwd;
 
 	err = test_tc_neigh__load(skel);
 	if (!ASSERT_OK(err, "test_tc_neigh__load"))
@@ -904,8 +915,8 @@ static void test_tc_redirect_peer(struct netns_setup_result *setup_result)
 	if (!ASSERT_OK_PTR(skel, "test_tc_peer__open"))
 		goto done;
 
-	skel->rodata->IFINDEX_SRC = setup_result->ifindex_veth_src_fwd;
-	skel->rodata->IFINDEX_DST = setup_result->ifindex_veth_dst_fwd;
+	skel->rodata->IFINDEX_SRC = setup_result->ifindex_src_fwd;
+	skel->rodata->IFINDEX_DST = setup_result->ifindex_dst_fwd;
 
 	err = test_tc_peer__load(skel);
 	if (!ASSERT_OK(err, "test_tc_peer__load"))
@@ -996,7 +1007,7 @@ static int tun_relay_loop(int src_fd, int target_fd)
 static void test_tc_redirect_peer_l3(struct netns_setup_result *setup_result)
 {
 	LIBBPF_OPTS(bpf_tc_hook, qdisc_tun_fwd);
-	LIBBPF_OPTS(bpf_tc_hook, qdisc_veth_dst_fwd);
+	LIBBPF_OPTS(bpf_tc_hook, qdisc_dst_fwd);
 	struct test_tc_peer *skel = NULL;
 	struct nstoken *nstoken = NULL;
 	int err;
@@ -1045,7 +1056,7 @@ static void test_tc_redirect_peer_l3(struct netns_setup_result *setup_result)
 		goto fail;
 
 	skel->rodata->IFINDEX_SRC = ifindex;
-	skel->rodata->IFINDEX_DST = setup_result->ifindex_veth_dst_fwd;
+	skel->rodata->IFINDEX_DST = setup_result->ifindex_dst_fwd;
 
 	err = test_tc_peer__load(skel);
 	if (!ASSERT_OK(err, "test_tc_peer__load"))
@@ -1053,19 +1064,19 @@ static void test_tc_redirect_peer_l3(struct netns_setup_result *setup_result)
 
 	/* Load "tc_src_l3" to the tun_fwd interface to redirect packets
 	 * towards dst, and "tc_dst" to redirect packets
-	 * and "tc_chk" on veth_dst_fwd to drop non-redirected packets.
+	 * and "tc_chk" on dst_fwd to drop non-redirected packets.
 	 */
 	/* tc qdisc add dev tun_fwd clsact */
 	QDISC_CLSACT_CREATE(&qdisc_tun_fwd, ifindex);
 	/* tc filter add dev tun_fwd ingress bpf da tc_src_l3 */
 	XGRESS_FILTER_ADD(&qdisc_tun_fwd, BPF_TC_INGRESS, skel->progs.tc_src_l3, 0);
 
-	/* tc qdisc add dev veth_dst_fwd clsact */
-	QDISC_CLSACT_CREATE(&qdisc_veth_dst_fwd, setup_result->ifindex_veth_dst_fwd);
-	/* tc filter add dev veth_dst_fwd ingress bpf da tc_dst_l3 */
-	XGRESS_FILTER_ADD(&qdisc_veth_dst_fwd, BPF_TC_INGRESS, skel->progs.tc_dst_l3, 0);
-	/* tc filter add dev veth_dst_fwd egress bpf da tc_chk */
-	XGRESS_FILTER_ADD(&qdisc_veth_dst_fwd, BPF_TC_EGRESS, skel->progs.tc_chk, 0);
+	/* tc qdisc add dev dst_fwd clsact */
+	QDISC_CLSACT_CREATE(&qdisc_dst_fwd, setup_result->ifindex_dst_fwd);
+	/* tc filter add dev dst_fwd ingress bpf da tc_dst_l3 */
+	XGRESS_FILTER_ADD(&qdisc_dst_fwd, BPF_TC_INGRESS, skel->progs.tc_dst_l3, 0);
+	/* tc filter add dev dst_fwd egress bpf da tc_chk */
+	XGRESS_FILTER_ADD(&qdisc_dst_fwd, BPF_TC_EGRESS, skel->progs.tc_chk, 0);
 
 	/* Setup route and neigh tables */
 	SYS(fail, "ip -netns " NS_SRC " addr add dev tun_src " IP4_TUN_SRC "/24");
@@ -1074,17 +1085,17 @@ static void test_tc_redirect_peer_l3(struct netns_setup_result *setup_result)
 	SYS(fail, "ip -netns " NS_SRC " addr add dev tun_src " IP6_TUN_SRC "/64 nodad");
 	SYS(fail, "ip -netns " NS_FWD " addr add dev tun_fwd " IP6_TUN_FWD "/64 nodad");
 
-	SYS(fail, "ip -netns " NS_SRC " route del " IP4_DST "/32 dev veth_src scope global");
+	SYS(fail, "ip -netns " NS_SRC " route del " IP4_DST "/32 dev src scope global");
 	SYS(fail, "ip -netns " NS_SRC " route add " IP4_DST "/32 via " IP4_TUN_FWD
 	    " dev tun_src scope global");
-	SYS(fail, "ip -netns " NS_DST " route add " IP4_TUN_SRC "/32 dev veth_dst scope global");
-	SYS(fail, "ip -netns " NS_SRC " route del " IP6_DST "/128 dev veth_src scope global");
+	SYS(fail, "ip -netns " NS_DST " route add " IP4_TUN_SRC "/32 dev dst scope global");
+	SYS(fail, "ip -netns " NS_SRC " route del " IP6_DST "/128 dev src scope global");
 	SYS(fail, "ip -netns " NS_SRC " route add " IP6_DST "/128 via " IP6_TUN_FWD
 	    " dev tun_src scope global");
-	SYS(fail, "ip -netns " NS_DST " route add " IP6_TUN_SRC "/128 dev veth_dst scope global");
+	SYS(fail, "ip -netns " NS_DST " route add " IP6_TUN_SRC "/128 dev dst scope global");
 
-	SYS(fail, "ip -netns " NS_DST " neigh add " IP4_TUN_SRC " dev veth_dst lladdr " MAC_DST_FWD);
-	SYS(fail, "ip -netns " NS_DST " neigh add " IP6_TUN_SRC " dev veth_dst lladdr " MAC_DST_FWD);
+	SYS(fail, "ip -netns " NS_DST " neigh add " IP4_TUN_SRC " dev dst lladdr " MAC_DST_FWD);
+	SYS(fail, "ip -netns " NS_DST " neigh add " IP6_TUN_SRC " dev dst lladdr " MAC_DST_FWD);
 
 	if (!ASSERT_OK(set_forwarding(false), "disable forwarding"))
 		goto fail;
@@ -1106,9 +1117,9 @@ static void test_tc_redirect_peer_l3(struct netns_setup_result *setup_result)
 		close_netns(nstoken);
 }
 
-#define RUN_TEST(name)                                                                      \
+#define RUN_TEST(name, mode)                                                                \
 	({                                                                                  \
-		struct netns_setup_result setup_result;                                     \
+		struct netns_setup_result setup_result = { .dev_mode = mode, };             \
 		if (test__start_subtest(#name))                                             \
 			if (ASSERT_OK(netns_setup_namespaces("add"), "setup namespaces")) { \
 				if (ASSERT_OK(netns_setup_links_and_routes(&setup_result),  \
@@ -1122,11 +1133,11 @@ static void *test_tc_redirect_run_tests(void *arg)
 {
 	netns_setup_namespaces_nofail("delete");
 
-	RUN_TEST(tc_redirect_peer);
-	RUN_TEST(tc_redirect_peer_l3);
-	RUN_TEST(tc_redirect_neigh);
-	RUN_TEST(tc_redirect_neigh_fib);
-	RUN_TEST(tc_redirect_dtime);
+	RUN_TEST(tc_redirect_peer, MODE_VETH);
+	RUN_TEST(tc_redirect_peer_l3, MODE_VETH);
+	RUN_TEST(tc_redirect_neigh, MODE_VETH);
+	RUN_TEST(tc_redirect_neigh_fib, MODE_VETH);
+	RUN_TEST(tc_redirect_dtime, MODE_VETH);
 	return NULL;
 }
 
-- 
2.43.0


