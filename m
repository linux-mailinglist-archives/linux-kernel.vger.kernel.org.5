Return-Path: <linux-kernel+bounces-115365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566E6889B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798801C34251
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECE81EFE57;
	Mon, 25 Mar 2024 02:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvAZFsps"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E33937145;
	Sun, 24 Mar 2024 22:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320613; cv=none; b=N8wzW/NuNpTDcjN29c+0BiRwebWdyGXw5qG8Wr0I6QMe4b3CvjhdhI9CVHh50/bJ43lXq4kAcX98g6+wQ8DWP42iMtpaUjee8yhhM5fEsVGeTd6eybI24yjj8WyJAhdhtgg1QshYWrNuasUDeerUbDx8zkEZiOhRRL21ao6Gss0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320613; c=relaxed/simple;
	bh=jcSa7AED0sYNrjMzwm3P5thW7G1RPQj5kfgFF+4N0IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lT0viAUIYPHzeanht8aD79AWOw7bZP4SiG6DScKXxLnhAq6rslBfkC3t048GNFM63YpF8otpgHuHu1FmmIc0aKZPecde+saixB81q2zI+E2RPAsnAUotKy7bOidiNiEr/gdR6qHksKUT9/zxImKZWzodZtWz7bs1vmdYf/rIcV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvAZFsps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9953C433C7;
	Sun, 24 Mar 2024 22:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320612;
	bh=jcSa7AED0sYNrjMzwm3P5thW7G1RPQj5kfgFF+4N0IY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YvAZFspsLBjKBdokl414Gkjp38mGGDJeq4rfQSXkQz8tWcpHwZOxxIs5AafUtUIYV
	 r+LP4RnDV9MP755EpiyaZ6lhBqm+2U8Hykfr9vsCatcXLun6NufG1TaKXYuuI1xvDZ
	 KrZbNH+nRQCw0cq1fHtm7Dh6mQko7H9TjNXaBAUNgHfyAFPHXkSsQ692V1NLJZpyeS
	 WD1z0BK/pL3kwOWtGk9O3sjgfylPkawIS3hgUBJImSVTI7xQc2zcYEPAuNRyTq/2sy
	 atjQFdQ/FAzWTSGzuqokTA5i6AvZ0GgjWc2I/FcmFfYaPIy78hl386vRx8kPinyZEJ
	 EkvLCnpfCRtJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manu Bretelle <chantr4@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 173/713] selftests/bpf: Disable IPv6 for lwt_redirect test
Date: Sun, 24 Mar 2024 18:38:19 -0400
Message-ID: <20240324224720.1345309-174-sashal@kernel.org>
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

From: Manu Bretelle <chantr4@gmail.com>

[ Upstream commit 2ef61296d2844c6a4211e07ab70ef2fb412b2c30 ]

After a recent change in the vmtest runner, this test started failing
sporadically.

Investigation showed that this test was subject to race condition which
got exacerbated after the vm runner change. The symptoms being that the
logic that waited for an ICMPv4 packet is naive and will break if 5 or
more non-ICMPv4 packets make it to tap0.
When ICMPv6 is enabled, the kernel will generate traffic such as ICMPv6
router solicitation...
On a system with good performance, the expected ICMPv4 packet would very
likely make it to the network interface promptly, but on a system with
poor performance, those "guarantees" do not hold true anymore.

Given that the test is IPv4 only, this change disable IPv6 in the test
netns by setting `net.ipv6.conf.all.disable_ipv6` to 1.
This essentially leaves "ping" as the sole generator of traffic in the
network namespace.
If this test was to be made IPv6 compatible, the logic in
`wait_for_packet` would need to be modified.

In more details...

At a high level, the test does:
- create a new namespace
- in `setup_redirect_target` set up lo, tap0, and link_err interfaces as
  well as add 2 routes that attaches ingress/egress sections of
  `test_lwt_redirect.bpf.o` to the xmit path.
- in `send_and_capture_test_packets` send an ICMP packet and read off
  the tap interface (using `wait_for_packet`) to check that a ICMP packet
  with the right size is read.

`wait_for_packet` will try to read `max_retry` (5) times from the tap0
fd looking for an ICMPv4 packet matching some criteria.

The problem is that when we set up the `tap0` interface, because IPv6 is
enabled by default, traffic such as Router solicitation is sent through
tap0, as in:

  # tcpdump -r /tmp/lwt_redirect.pc
  reading from file /tmp/lwt_redirect.pcap, link-type EN10MB (Ethernet)
  04:46:23.578352 IP6 :: > ff02::1:ffc0:4427: ICMP6, neighbor solicitation, who has fe80::fcba:dff:fec0:4427, length 32
  04:46:23.659522 IP6 :: > ff02::16: HBH ICMP6, multicast listener report v2, 1 group record(s), length 28
  04:46:24.389169 IP 10.0.0.1 > 20.0.0.9: ICMP echo request, id 122, seq 1, length 108
  04:46:24.618599 IP6 fe80::fcba:dff:fec0:4427 > ff02::16: HBH ICMP6, multicast listener report v2, 1 group record(s), length 28
  04:46:24.619985 IP6 fe80::fcba:dff:fec0:4427 > ff02::2: ICMP6, router solicitation, length 16
  04:46:24.767326 IP6 fe80::fcba:dff:fec0:4427 > ff02::16: HBH ICMP6, multicast listener report v2, 1 group record(s), length 28
  04:46:28.936402 IP6 fe80::fcba:dff:fec0:4427 > ff02::2: ICMP6, router solicitation, length 16

If `wait_for_packet` sees 5 non-ICMPv4 packets, it will return 0, which is what we see in:

  2024-01-31T03:51:25.0336992Z test_lwt_redirect_run:PASS:netns_create 0 nsec
  2024-01-31T03:51:25.0341309Z open_netns:PASS:malloc token 0 nsec
  2024-01-31T03:51:25.0344844Z open_netns:PASS:open /proc/self/ns/net 0 nsec
  2024-01-31T03:51:25.0350071Z open_netns:PASS:open netns fd 0 nsec
  2024-01-31T03:51:25.0353516Z open_netns:PASS:setns 0 nsec
  2024-01-31T03:51:25.0356560Z test_lwt_redirect_run:PASS:setns 0 nsec
  2024-01-31T03:51:25.0360140Z open_tuntap:PASS:open(/dev/net/tun) 0 nsec
  2024-01-31T03:51:25.0363822Z open_tuntap:PASS:ioctl(TUNSETIFF) 0 nsec
  2024-01-31T03:51:25.0367402Z open_tuntap:PASS:fcntl(O_NONBLOCK) 0 nsec
  2024-01-31T03:51:25.0371167Z setup_redirect_target:PASS:open_tuntap 0 nsec
  2024-01-31T03:51:25.0375180Z setup_redirect_target:PASS:if_nametoindex 0 nsec
  2024-01-31T03:51:25.0379929Z setup_redirect_target:PASS:ip link add link_err type dummy 0 nsec
  2024-01-31T03:51:25.0384874Z setup_redirect_target:PASS:ip link set lo up 0 nsec
  2024-01-31T03:51:25.0389678Z setup_redirect_target:PASS:ip addr add dev lo 10.0.0.1/32 0 nsec
  2024-01-31T03:51:25.0394814Z setup_redirect_target:PASS:ip link set link_err up 0 nsec
  2024-01-31T03:51:25.0399874Z setup_redirect_target:PASS:ip link set tap0 up 0 nsec
  2024-01-31T03:51:25.0407731Z setup_redirect_target:PASS:ip route add 10.0.0.0/24 dev link_err encap bpf xmit obj test_lwt_redirect.bpf.o sec redir_ingress 0 nsec
  2024-01-31T03:51:25.0419105Z setup_redirect_target:PASS:ip route add 20.0.0.0/24 dev link_err encap bpf xmit obj test_lwt_redirect.bpf.o sec redir_egress 0 nsec
  2024-01-31T03:51:25.0427209Z test_lwt_redirect_normal:PASS:setup_redirect_target 0 nsec
  2024-01-31T03:51:25.0431424Z ping_dev:PASS:if_nametoindex 0 nsec
  2024-01-31T03:51:25.0437222Z send_and_capture_test_packets:FAIL:wait_for_epacket unexpected wait_for_epacket: actual 0 != expected 1
  2024-01-31T03:51:25.0448298Z (/tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c:175: errno: Success) test_lwt_redirect_normal egress test fails
  2024-01-31T03:51:25.0457124Z close_netns:PASS:setns 0 nsec

When running in a VM which potential resource contrains, the odds that calling
`ping` is not scheduled very soon after bringing `tap0` up increases,
and with this the chances to get our ICMP packet pushed to position 6+
in the network trace.

To confirm this indeed solves the issue, I ran the test 100 times in a
row with:

  errors=0
  successes=0
  for i in `seq 1 100`
  do
    ./test_progs -t lwt_redirect/lwt_redirect_normal
    if [ $? -eq 0 ]; then
      successes=$((successes+1))
    else
      errors=$((errors+1))
    fi
  done
  echo "successes: $successes/errors: $errors"

While this test would at least fail a couple of time every 10 runs, here
it ran 100 times with no error.

Fixes: 43a7c3ef8a15 ("selftests/bpf: Add lwt_xmit tests for BPF_REDIRECT")
Signed-off-by: Manu Bretelle <chantr4@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20240131053212.2247527-1-chantr4@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/lwt_redirect.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c b/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
index 59b38569f310b..2bc932a18c17e 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
@@ -203,6 +203,7 @@ static int setup_redirect_target(const char *target_dev, bool need_mac)
 	if (!ASSERT_GE(target_index, 0, "if_nametoindex"))
 		goto fail;
 
+	SYS(fail, "sysctl -w net.ipv6.conf.all.disable_ipv6=1");
 	SYS(fail, "ip link add link_err type dummy");
 	SYS(fail, "ip link set lo up");
 	SYS(fail, "ip addr add dev lo " LOCAL_SRC "/32");
-- 
2.43.0


