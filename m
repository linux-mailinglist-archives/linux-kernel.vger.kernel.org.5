Return-Path: <linux-kernel+bounces-101834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28B687ABFF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42651C20B51
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412B36EB53;
	Wed, 13 Mar 2024 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeHYCmNp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD126E616;
	Wed, 13 Mar 2024 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347869; cv=none; b=gviXFjn1Cj3bHUVtADjukpv1X/OX5EPHkUb3p1eOaeVr7/ljsdxYDFEpF0XD7xIiFL4SHY4zpJKIufxJKLhx3QZ2eMUyZj4nYbUQ2Eb65SOXtN/CpLmPkEAve5Qwma6C+LYvS2rMnvQcRr0lpLYRwWHEe1eEm33Te98adml39Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347869; c=relaxed/simple;
	bh=c9gRSY8NjpefR/RFvaa/fyBhrpNVDBwJnFGznfuiZ9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nj7HSPXG/sx8NG1emNNPUbM0jnKfm20vpY9zqhIGa4TJtHUXBAptbBhHgQcf1AHS/uU5PkTbChJ/3Q9KOyJVLmzqAFaIKigUEPm4tjJz8BZ4DDajGiPtIsmLUA4ZcjVIiQoh1NdlCIWUZ60yzCv8PPX9KUzKczfZ/uVWQt3N1GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeHYCmNp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86EA2C433B1;
	Wed, 13 Mar 2024 16:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347869;
	bh=c9gRSY8NjpefR/RFvaa/fyBhrpNVDBwJnFGznfuiZ9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WeHYCmNpfx5B6VNudGE8X/xHbVSBDhs3riujY0ig1o636maYWF5D6f/RTb/aFE01d
	 AEkenD+MLWPyxAdrN6b7dUWVK9yolQwmfJpxpPHQSs33gBxVETD9QZ6OcbcDGizWA4
	 QP7n+ItLQDsChE8dtrQLFfLjRMhmotAFfpLBxABQQ6Nx4NljAmVxMw1jZJjkFRlnUn
	 2Ric0+JFSivRRN7cJSdyasnUcf2V7PjS7sbKObVp7iSHH2vVtuEveyGgSnkx3y6eSY
	 0DnTff0vky5ck5bAZkYhRq8qEZI+mPjc+0F8H98rj0FPejOExEx5ik6x4s0EYUHMka
	 G8J4VPBr54O9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 31/60] selftests/bpf: Fix up xdp bonding test wrt feature flags
Date: Wed, 13 Mar 2024 12:36:38 -0400
Message-ID: <20240313163707.615000-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
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


