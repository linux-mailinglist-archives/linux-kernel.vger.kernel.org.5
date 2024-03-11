Return-Path: <linux-kernel+bounces-99384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4690E8787A0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017C1286FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A459759B4D;
	Mon, 11 Mar 2024 18:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cr3TvSrY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D042159B41;
	Mon, 11 Mar 2024 18:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182228; cv=none; b=vGqxrXwMXR/Focw7tXHFJ8uC0ODp4b8VqabUt5ToptiJRxZUrcKui4+7cby+U+LmWJVvtAl5+UNsKgFOJkxizKacHa330JGalJr1mSdaPxYiaiQSSaALtnLfrySZ/p7NKBfJdx/Uh81y1q4moaebRymjTT0j2PFiUZsOoyFuTso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182228; c=relaxed/simple;
	bh=KLNv6IZ5yEeP9+TzZ7XNfvS9hm4MRpt6kWqrQ9+/B+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bREuUpHWwXyGqFHuYeI1vipLUcwaKwsDdTp+wnMI3P3LewpTtlzY1aLHnrCCbKacNTofIpduS+lFYE9FgW9BGs6G2azAp9OpmnVQK8gy7MhFvzn2t2fUb94JGwIRDmWLyDed7+hJa1hvGxiIKCVrbCVDXgoPE4smikQ43Ie2Fk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cr3TvSrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4063C43390;
	Mon, 11 Mar 2024 18:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182228;
	bh=KLNv6IZ5yEeP9+TzZ7XNfvS9hm4MRpt6kWqrQ9+/B+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cr3TvSrY+aQkDeabwVvMaB2Svs1Fsf2GpQiO9LtYIeS84IimCcI195o8ZsF/xUvNs
	 9uN4zDbhaJbMSUVazDsvmraAtqXc1QYjvAqu6dXWhJ5pY2A8mIxbAnV+T9qGexpVjQ
	 By4Gkeq8dWy0T1Wq4i/D24bVQo9w7JcETnshNLu4GNJrANvBPVL3C+ExVjXUlegHzb
	 uyr+ujIdhPwlIbeRn794IhDzjfIw3mSwJZim/47B+YtjJFE5XQzg/wWiKVM2N/wkb4
	 k6/dr83KSoFtVAddUYLIwamL/Qk1oZj+IG6Jt6anIfM1RdiFUjzhPAbA3zpfN8BrDG
	 HpgAZiWqGBEYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mike Yu <yumike@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 10/14] xfrm: set skb control buffer based on packet offload as well
Date: Mon, 11 Mar 2024 14:36:13 -0400
Message-ID: <20240311183618.327694-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183618.327694-1-sashal@kernel.org>
References: <20240311183618.327694-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
Content-Transfer-Encoding: 8bit

From: Mike Yu <yumike@google.com>

[ Upstream commit 8688ab2170a5be0bc922195f7091c38b506bab2e ]

In packet offload, packets are not encrypted in XFRM stack, so
the next network layer which the packets will be forwarded to
should depend on where the packet came from (either xfrm4_output
or xfrm6_output) rather than the matched SA's family type.

Test: verified IPv6-in-IPv4 packets on Android device with
      IPsec packet offload enabled
Signed-off-by: Mike Yu <yumike@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_output.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index 662c83beb345e..e5722c95b8bb3 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -704,9 +704,13 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 {
 	struct net *net = dev_net(skb_dst(skb)->dev);
 	struct xfrm_state *x = skb_dst(skb)->xfrm;
+	int family;
 	int err;
 
-	switch (x->outer_mode.family) {
+	family = (x->xso.type != XFRM_DEV_OFFLOAD_PACKET) ? x->outer_mode.family
+		: skb_dst(skb)->ops->family;
+
+	switch (family) {
 	case AF_INET:
 		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 		IPCB(skb)->flags |= IPSKB_XFRM_TRANSFORMED;
-- 
2.43.0


