Return-Path: <linux-kernel+bounces-112976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A104888034
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9D61F216E8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990B912BE82;
	Sun, 24 Mar 2024 22:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0hR7w1x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D456E43AA4;
	Sun, 24 Mar 2024 22:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319788; cv=none; b=mZlCGmI7iUePdHa4Qfbyy4ytE6Dk9h2mDZXHfTsaQdC9ESQHYLMQ2CBj5wrNrc2KmKHILRgLgdD6NIVpjwZYBVikQsHAvDFzX2pIp2ok55mQlckqX9j7ugwqwIkImbvWwSKdp595YXse+cftPmRhNU6o/36huqM6npHB0fawYGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319788; c=relaxed/simple;
	bh=qFpUQqMP2OvlrWkLC22tIXBrzZPa6exUEWIiFlsA8jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=paGlhMej9XBIPrLfWP2NI/8T5LvB7BeDzVn+qJpHBKwRpLarwgjvd07EkKIdDUYe69A24hNwOsNBqotJdN7UKYFahK+GPL+q402WbdVrzuiEB1wGDlMErM2g/hLIfGkFAGL+TkgRmO9855kIBg/2f3Y2eb0YpnWSI8IUgcwKZTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0hR7w1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1853CC43394;
	Sun, 24 Mar 2024 22:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319788;
	bh=qFpUQqMP2OvlrWkLC22tIXBrzZPa6exUEWIiFlsA8jY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L0hR7w1xMZYXeP/rv6NcULpLQ+Q74m6/eMcNl11WAH5d3AbNuK1W00Dfs1vwoahQ9
	 amV7GUSUynAYyFMjvwtqWW2ur4C9pADpE8xfte0gK5o8k91Lughx3f9MlxHHUWG3yP
	 3llsrW2UQkDvZg3SDTjY6/GRq0A2iEBi9sNqI9kfmn53xYIP1Rmrb9gynrf8XeMrcs
	 szPZ3QSuaRuyM4d7354d/mvcbKbzLY12qvsxCKaBXizd9Tk+5k+Dh044T18hV7pY0y
	 fifgZ3xgRDPeOeTPtYb/osCsg08aU3Dvfuz3M09cPrub738YyJ4D+HsU9Tuyuqcjus
	 ifwjWiIOORCyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 089/715] selftests/bpf: Fix the flaky tc_redirect_dtime test
Date: Sun, 24 Mar 2024 18:24:28 -0400
Message-ID: <20240324223455.1342824-90-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Martin KaFai Lau <martin.lau@kernel.org>

[ Upstream commit 177f1d083a19af58f4b1206d299ed73689249fd8 ]

BPF CI has been reporting the tc_redirect_dtime test failing
from time to time:

test_inet_dtime:PASS:setns src 0 nsec
(network_helpers.c:253: errno: No route to host) Failed to connect to server
close_netns:PASS:setns 0 nsec
test_inet_dtime:FAIL:connect_to_fd unexpected connect_to_fd: actual -1 < expected 0
test_tcp_clear_dtime:PASS:tcp ip6 clear dtime ingress_fwdns_p100 0 nsec

The connect_to_fd failure (EHOSTUNREACH) is from the
test_tcp_clear_dtime() test and it is the very first IPv6 traffic
after setting up all the links, addresses, and routes.

The symptom is this first connect() is always slow. In my setup, it
could take ~3s.

After some tracing and tcpdump, the slowness is mostly spent in
the neighbor solicitation in the "ns_fwd" namespace while
the "ns_src" and "ns_dst" are fine.

I forced the kernel to drop the neighbor solicitation messages.
I can then reproduce EHOSTUNREACH. What actually happen could be:
- the neighbor advertisement came back a little slow.
- the "ns_fwd" namespace concluded a neighbor discovery failure
  and triggered the ndisc_error_report() => ip6_link_failure() =>
  icmpv6_send(skb, ICMPV6_DEST_UNREACH, ICMPV6_ADDR_UNREACH, 0)
- the client's connect() reports EHOSTUNREACH after receiving
  the ICMPV6_DEST_UNREACH message.

The neigh table of both "ns_src" and "ns_dst" namespace has already
been manually populated but not the "ns_fwd" namespace. This patch
fixes it by manually populating the neigh table also in the "ns_fwd"
namespace.

Although the namespace configuration part had been existed before
the tc_redirect_dtime test, still Fixes-tagging the patch when
the tc_redirect_dtime test was added since it is the only test
hitting it so far.

Fixes: c803475fd8dd ("bpf: selftests: test skb->tstamp in redirect_neigh")
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20240120060518.3604920-1-martin.lau@linux.dev
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/tc_redirect.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index 518f143c5b0fe..610887157fd85 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -188,6 +188,7 @@ static int netns_setup_links_and_routes(struct netns_setup_result *result)
 {
 	struct nstoken *nstoken = NULL;
 	char src_fwd_addr[IFADDR_STR_LEN+1] = {};
+	char src_addr[IFADDR_STR_LEN + 1] = {};
 	int err;
 
 	if (result->dev_mode == MODE_VETH) {
@@ -208,6 +209,9 @@ static int netns_setup_links_and_routes(struct netns_setup_result *result)
 	if (get_ifaddr("src_fwd", src_fwd_addr))
 		goto fail;
 
+	if (get_ifaddr("src", src_addr))
+		goto fail;
+
 	result->ifindex_src = if_nametoindex("src");
 	if (!ASSERT_GT(result->ifindex_src, 0, "ifindex_src"))
 		goto fail;
@@ -270,6 +274,13 @@ static int netns_setup_links_and_routes(struct netns_setup_result *result)
 	SYS(fail, "ip route add " IP4_DST "/32 dev dst_fwd scope global");
 	SYS(fail, "ip route add " IP6_DST "/128 dev dst_fwd scope global");
 
+	if (result->dev_mode == MODE_VETH) {
+		SYS(fail, "ip neigh add " IP4_SRC " dev src_fwd lladdr %s", src_addr);
+		SYS(fail, "ip neigh add " IP6_SRC " dev src_fwd lladdr %s", src_addr);
+		SYS(fail, "ip neigh add " IP4_DST " dev dst_fwd lladdr %s", MAC_DST);
+		SYS(fail, "ip neigh add " IP6_DST " dev dst_fwd lladdr %s", MAC_DST);
+	}
+
 	close_netns(nstoken);
 
 	/** setup in 'dst' namespace */
-- 
2.43.0


