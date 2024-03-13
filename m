Return-Path: <linux-kernel+bounces-101775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0556A87AB77
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02AB6B21301
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E8861694;
	Wed, 13 Mar 2024 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jwd+/bf4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464EF61676;
	Wed, 13 Mar 2024 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347603; cv=none; b=thvi5w0UhJplFtAwYmhWjJbuaGQQKUyReY/m/j9JjcRTcaA+0jbrlaPV7RsRG7OLE06/TghU/N4NvgTe/p639ywafUlHSVLsuieO+pXI/M6tfQlpkJuxMOrOJHETX/5PDidPH73BqHROgcCTcXh11NywOfxfHyauxUHAiQTO3c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347603; c=relaxed/simple;
	bh=c9gRSY8NjpefR/RFvaa/fyBhrpNVDBwJnFGznfuiZ9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mz3whTZUh33JjkWAa3iGTZ3bBELccWza2Anvzcb31JMP4y0UWUtJuj0GPlEq962sEi3yDvvpKRX9ucLdHy+A/AmUHn4SmNDa0RSmAJp9SOEyGmW5GmFuHaHyV9NWOC/j9Vnn3OaoAkQAZwZiQIGFHsrBwRCtuHOXm9RlVfXQF0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jwd+/bf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F3CC433B2;
	Wed, 13 Mar 2024 16:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347603;
	bh=c9gRSY8NjpefR/RFvaa/fyBhrpNVDBwJnFGznfuiZ9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jwd+/bf4jfHHtGurKMsGZ4q4Bzk5OSt+VZt9OHvSMFPaG63dzbsrUersntBA9KiU4
	 o0MJwp7+2F/bck5IHw4FwcPmSbeSujINxXe0DfAYqV+E6X7DbZi3qOj6cnuEg41CoX
	 E+riH2WMhTl8LBr7kKEbr+cD3il9CTGlHLroO0PbmrE8aofWPqRwkCliUo9/S63FVK
	 oqoh2nGtEbJ66P82jgpZ+Labi2HM4G00bImdc7RsyZf3wR8VV3Mxdq30nqP6kiWvx+
	 fGcvhAQGaGBhFsQrBQ7v6o3aJxz+zGClo70wP3asGMm5eQYowTPGy2c2T31JNWaKQ/
	 aZSjMjhLFF4Og==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 36/61] selftests/bpf: Fix up xdp bonding test wrt feature flags
Date: Wed, 13 Mar 2024 12:32:11 -0400
Message-ID: <20240313163236.613880-37-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 0bfc0336e1348883fdab4689f0c8c56458f36dd8 ]

Adjust the XDP feature flags for the bond device when no bond slave
devices are attached. After 9b0ed890ac2a ("bonding: do not report
NETDEV_XDP_ACT_XSK_ZEROCOPY"), the empty bond device must report 0
as flags instead of NETDEV_XDP_ACT_MASK.

  # ./vmtest.sh -- ./test_progs -t xdp_bond
  [...]
  [    3.983311] bond1 (unregistering): (slave veth1_1): Releasing backup interface
  [    3.995434] bond1 (unregistering): Released all slaves
  [    4.022311] bond2: (slave veth2_1): Releasing backup interface
  #507/1   xdp_bonding/xdp_bonding_attach:OK
  #507/2   xdp_bonding/xdp_bonding_nested:OK
  #507/3   xdp_bonding/xdp_bonding_features:OK
  #507/4   xdp_bonding/xdp_bonding_roundrobin:OK
  #507/5   xdp_bonding/xdp_bonding_activebackup:OK
  #507/6   xdp_bonding/xdp_bonding_xor_layer2:OK
  #507/7   xdp_bonding/xdp_bonding_xor_layer23:OK
  #507/8   xdp_bonding/xdp_bonding_xor_layer34:OK
  #507/9   xdp_bonding/xdp_bonding_redirect_multi:OK
  #507     xdp_bonding:OK
  Summary: 1/9 PASSED, 0 SKIPPED, 0 FAILED
  [    4.185255] bond2 (unregistering): Released all slaves
  [...]

Fixes: 9b0ed890ac2a ("bonding: do not report NETDEV_XDP_ACT_XSK_ZEROCOPY")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Message-ID: <20240305090829.17131-2-daniel@iogearbox.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/xdp_bonding.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
index c3b45745cbccd..6d8b54124cb35 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
@@ -511,7 +511,7 @@ static void test_xdp_bonding_features(struct skeletons *skeletons)
 	if (!ASSERT_OK(err, "bond bpf_xdp_query"))
 		goto out;
 
-	if (!ASSERT_EQ(query_opts.feature_flags, NETDEV_XDP_ACT_MASK,
+	if (!ASSERT_EQ(query_opts.feature_flags, 0,
 		       "bond query_opts.feature_flags"))
 		goto out;
 
@@ -601,7 +601,7 @@ static void test_xdp_bonding_features(struct skeletons *skeletons)
 	if (!ASSERT_OK(err, "bond bpf_xdp_query"))
 		goto out;
 
-	ASSERT_EQ(query_opts.feature_flags, NETDEV_XDP_ACT_MASK,
+	ASSERT_EQ(query_opts.feature_flags, 0,
 		  "bond query_opts.feature_flags");
 out:
 	bpf_link__destroy(link);
-- 
2.43.0


