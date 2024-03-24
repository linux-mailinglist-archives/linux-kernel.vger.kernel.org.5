Return-Path: <linux-kernel+bounces-115421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F31889B76
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99EE91C3462B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8FB2092E0;
	Mon, 25 Mar 2024 02:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZ5GhHTl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C8D1D7900;
	Sun, 24 Mar 2024 22:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320600; cv=none; b=VQR5Cy8nt1/qxoIIHjYbXxXVSgfF0/4NxjTpvjV+3opyCOtPg7sUfNx3il8wbioT7QvEKVDuqNb6P0c7LF5WEHHzkpY2HEdL/zzDipFFqSxaKf72Mr9y0VJt/d4X3oRpxmJw3brD/R6pZe/zt365AuiVwkQjt6XsRN9lT81OPpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320600; c=relaxed/simple;
	bh=K757j1h2gj/8YT/wZT3TO9lwrI+Py+jNR2IhmZioBqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mypN/sHa2xltggE4rysaMkJDmbc5P148IsWrJdSI2iybP7Roty5KwGBl0uNV01+JIn7UvOUl+CbyH+cOnvIqMKA8wiriC8ldEw+MquZQ+UNXYSPjSsM9wiu1srdONqtyWW3kOvdURuEw5KjmSxgjojAJRiAuKnwIFxY7XF3aNpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZ5GhHTl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB48C433F1;
	Sun, 24 Mar 2024 22:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320599;
	bh=K757j1h2gj/8YT/wZT3TO9lwrI+Py+jNR2IhmZioBqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MZ5GhHTlKNflZ6Uau2xiXLIjngMRH5FR52jLhnK8eB18XszB1KzTChAObXXuIZRSg
	 PNnov9rVkcIYFw7etvShD0b4mXvTA5NyTNdtzf+vFLhSEKLmv1Z3PL8QsG6X+UEH1S
	 TwqLz9xD/jDeyUmClWI6HCR6AZfV918K87WqNMb1GEGuiTt48IV1/LZIGWyRHck8Tj
	 X84Z5NqSwadOVQ1aaoGeD+ipXkT7+KXoYgex0oiH2ZeIxo9fE2fPZKqrnKnZ/hZycu
	 1pgBi+rt0nmuDzm94Tdg2xO/7vF8D9W8DQ6L46PA6zr2xnFXIiWVJy6A+PVo/r/vYC
	 4JVrnS6zngwiA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 160/713] selftests/bpf: Wait for the netstamp_needed_key static key to be turned on
Date: Sun, 24 Mar 2024 18:38:06 -0400
Message-ID: <20240324224720.1345309-161-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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

[ Upstream commit ce6f6cffaeaa0a3bcdafcae7fe03c68c3afae631 ]

After the previous patch that speeded up the test (by avoiding neigh
discovery in IPv6), the BPF CI occasionally hits this error:

rcv tstamp unexpected pkt rcv tstamp: actual 0 == expected 0

The test complains about the cmsg returned from the recvmsg() does not
have the rcv timestamp. Setting skb->tstamp or not is
controlled by a kernel static key "netstamp_needed_key". The static
key is enabled whenever this is at least one sk with the SOCK_TIMESTAMP
set.

The test_redirect_dtime does use setsockopt() to turn on
the SOCK_TIMESTAMP for the reading sk. In the kernel
net_enable_timestamp() has a delay to enable the "netstamp_needed_key"
when CONFIG_JUMP_LABEL is set. This potential delay is the likely reason
for packet missing rcv timestamp occasionally.

This patch is to create udp sockets with SOCK_TIMESTAMP set.
It sends and receives some packets until the received packet
has a rcv timestamp. It currently retries at most 5 times with 1s
in between. This should be enough to wait for the "netstamp_needed_key".
It then holds on to the socket and only closes it at the end of the test.
This guarantees that the test has the "netstamp_needed_key" key turned
on from the beginning.

To simplify the udp sockets setup, they are sending/receiving packets
in the same netns (ns_dst is used) and communicate over the "lo" dev.
Hence, the patch enables the "lo" dev in the ns_dst.

Fixes: c803475fd8dd ("bpf: selftests: test skb->tstamp in redirect_neigh")
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20240120060518.3604920-2-martin.lau@linux.dev
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/bpf/prog_tests/tc_redirect.c    | 79 ++++++++++++++++++-
 1 file changed, 75 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index 610887157fd85..dbe06aeaa2b27 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -291,6 +291,7 @@ static int netns_setup_links_and_routes(struct netns_setup_result *result)
 	SYS(fail, "ip addr add " IP4_DST "/32 dev dst");
 	SYS(fail, "ip addr add " IP6_DST "/128 dev dst nodad");
 	SYS(fail, "ip link set dev dst up");
+	SYS(fail, "ip link set dev lo up");
 
 	SYS(fail, "ip route add " IP4_SRC "/32 dev dst scope global");
 	SYS(fail, "ip route add " IP4_NET "/16 dev dst scope global");
@@ -468,7 +469,7 @@ static int set_forwarding(bool enable)
 	return 0;
 }
 
-static void rcv_tstamp(int fd, const char *expected, size_t s)
+static int __rcv_tstamp(int fd, const char *expected, size_t s, __u64 *tstamp)
 {
 	struct __kernel_timespec pkt_ts = {};
 	char ctl[CMSG_SPACE(sizeof(pkt_ts))];
@@ -489,7 +490,7 @@ static void rcv_tstamp(int fd, const char *expected, size_t s)
 
 	ret = recvmsg(fd, &msg, 0);
 	if (!ASSERT_EQ(ret, s, "recvmsg"))
-		return;
+		return -1;
 	ASSERT_STRNEQ(data, expected, s, "expected rcv data");
 
 	cmsg = CMSG_FIRSTHDR(&msg);
@@ -498,6 +499,12 @@ static void rcv_tstamp(int fd, const char *expected, size_t s)
 		memcpy(&pkt_ts, CMSG_DATA(cmsg), sizeof(pkt_ts));
 
 	pkt_ns = pkt_ts.tv_sec * NSEC_PER_SEC + pkt_ts.tv_nsec;
+	if (tstamp) {
+		/* caller will check the tstamp itself */
+		*tstamp = pkt_ns;
+		return 0;
+	}
+
 	ASSERT_NEQ(pkt_ns, 0, "pkt rcv tstamp");
 
 	ret = clock_gettime(CLOCK_REALTIME, &now_ts);
@@ -507,6 +514,60 @@ static void rcv_tstamp(int fd, const char *expected, size_t s)
 	if (ASSERT_GE(now_ns, pkt_ns, "check rcv tstamp"))
 		ASSERT_LT(now_ns - pkt_ns, 5 * NSEC_PER_SEC,
 			  "check rcv tstamp");
+	return 0;
+}
+
+static void rcv_tstamp(int fd, const char *expected, size_t s)
+{
+	__rcv_tstamp(fd, expected, s, NULL);
+}
+
+static int wait_netstamp_needed_key(void)
+{
+	int opt = 1, srv_fd = -1, cli_fd = -1, nretries = 0, err, n;
+	char buf[] = "testing testing";
+	struct nstoken *nstoken;
+	__u64 tstamp = 0;
+
+	nstoken = open_netns(NS_DST);
+	if (!nstoken)
+		return -1;
+
+	srv_fd = start_server(AF_INET6, SOCK_DGRAM, "::1", 0, 0);
+	if (!ASSERT_GE(srv_fd, 0, "start_server"))
+		goto done;
+
+	err = setsockopt(srv_fd, SOL_SOCKET, SO_TIMESTAMPNS_NEW,
+			 &opt, sizeof(opt));
+	if (!ASSERT_OK(err, "setsockopt(SO_TIMESTAMPNS_NEW)"))
+		goto done;
+
+	cli_fd = connect_to_fd(srv_fd, TIMEOUT_MILLIS);
+	if (!ASSERT_GE(cli_fd, 0, "connect_to_fd"))
+		goto done;
+
+again:
+	n = write(cli_fd, buf, sizeof(buf));
+	if (!ASSERT_EQ(n, sizeof(buf), "send to server"))
+		goto done;
+	err = __rcv_tstamp(srv_fd, buf, sizeof(buf), &tstamp);
+	if (!ASSERT_OK(err, "__rcv_tstamp"))
+		goto done;
+	if (!tstamp && nretries++ < 5) {
+		sleep(1);
+		printf("netstamp_needed_key retry#%d\n", nretries);
+		goto again;
+	}
+
+done:
+	if (!tstamp && srv_fd != -1) {
+		close(srv_fd);
+		srv_fd = -1;
+	}
+	if (cli_fd != -1)
+		close(cli_fd);
+	close_netns(nstoken);
+	return srv_fd;
 }
 
 static void snd_tstamp(int fd, char *b, size_t s)
@@ -843,11 +904,20 @@ static void test_tc_redirect_dtime(struct netns_setup_result *setup_result)
 {
 	struct test_tc_dtime *skel;
 	struct nstoken *nstoken;
-	int err;
+	int hold_tstamp_fd, err;
+
+	/* Hold a sk with the SOCK_TIMESTAMP set to ensure there
+	 * is no delay in the kernel net_enable_timestamp().
+	 * This ensures the following tests must have
+	 * non zero rcv tstamp in the recvmsg().
+	 */
+	hold_tstamp_fd = wait_netstamp_needed_key();
+	if (!ASSERT_GE(hold_tstamp_fd, 0, "wait_netstamp_needed_key"))
+		return;
 
 	skel = test_tc_dtime__open();
 	if (!ASSERT_OK_PTR(skel, "test_tc_dtime__open"))
-		return;
+		goto done;
 
 	skel->rodata->IFINDEX_SRC = setup_result->ifindex_src_fwd;
 	skel->rodata->IFINDEX_DST = setup_result->ifindex_dst_fwd;
@@ -892,6 +962,7 @@ static void test_tc_redirect_dtime(struct netns_setup_result *setup_result)
 
 done:
 	test_tc_dtime__destroy(skel);
+	close(hold_tstamp_fd);
 }
 
 static void test_tc_redirect_neigh_fib(struct netns_setup_result *setup_result)
-- 
2.43.0


