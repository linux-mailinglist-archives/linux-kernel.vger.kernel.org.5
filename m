Return-Path: <linux-kernel+bounces-114057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDA5888825
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAF7128A0FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A0914C5A4;
	Sun, 24 Mar 2024 23:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvZ4u0c5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8257D130AC0;
	Sun, 24 Mar 2024 23:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321338; cv=none; b=m2i/D4HuN5S1yEB3tpoz4yqq1oD2s4erZbcZDEO1bm53qcxh1S4p8UMVW3acOP0VCmj2ppSZO+vF47rndl20rah1tyq2vN1VXHsjncDebZ3cYDizbRCKv2+aao8gZA1DL/gi/Z2pCdxxaYsc4a8VM48fpDaXsvSlMdWXAsd5nPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321338; c=relaxed/simple;
	bh=5CPxsw81z44H+28IB3BVZsy+NDRz7gWFJc1ZSn5OheM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzCDOC+DSq2aUfecQVOeLy060awTytsNjYdvJ0ILvz6TlU7X3ld9pPczT3MBNl1XZEyFZqOonii60E3S+lcmYaB81WgPAKnf7Hmb3Tdwd7nlWvExaF7sGHc8a5avQ1T4RwLl3L8+X7ikur25cIjn8NuQ554aLePZHzedYw84svE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvZ4u0c5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D53C43390;
	Sun, 24 Mar 2024 23:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321337;
	bh=5CPxsw81z44H+28IB3BVZsy+NDRz7gWFJc1ZSn5OheM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jvZ4u0c5a7jDdsHJrTPR54bpTjmnNIdspeo9W7BiF8rfSIpN7y+Yu4M2WA3vr8rbL
	 de2UKwhWTY5FZ6lREdOzYwNJwwFD4l2dNKAbkc+BpsZxYAbl+GZ0LsRQ0/q1fjwfBK
	 c3Dd1+WPTngpphNfFxKvy2YL1NYVKVZiwgFWZIJP2PuEjUgsAcOT/u8RRXIVm3vH2g
	 z1HnOp6M0CvKnAJ+zPVomqGRJYdUF8pQ+9pDAunyPBNOuQy0gsGjDzXIf5F2qjCHJ2
	 T6P0MrEbCE1e2v2io7NuRRpG9nvQZPKWrUk37qIniBQEFnXHxM1OiAyO9kX/we2JMi
	 if+buaBOE+MRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mike Yu <yumike@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 061/638] xfrm: fix xfrm child route lookup for packet offload
Date: Sun, 24 Mar 2024 18:51:38 -0400
Message-ID: <20240324230116.1348576-62-sashal@kernel.org>
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

From: Mike Yu <yumike@google.com>

[ Upstream commit d4872d70fc6feabfc8e897edad993a81096ade9f ]

In current code, xfrm_bundle_create() always uses the matched
SA's family type to look up a xfrm child route for the skb.
The route returned by xfrm_dst_lookup() will eventually be
used in xfrm_output_resume() (skb_dst(skb)->ops->local_out()).

If packet offload is used, the above behavior can lead to
calling ip_local_out() for an IPv6 packet or calling
ip6_local_out() for an IPv4 packet, which is likely to fail.

This change fixes the behavior by checking if the matched SA
has packet offload enabled. If not, keep the same behavior;
if yes, use the matched SP's family type for the lookup.

Test: verified IPv6-in-IPv4 packets on Android device with
      IPsec packet offload enabled
Signed-off-by: Mike Yu <yumike@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_policy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index d24b4d4f620ea..97d69ec54ff9c 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2679,7 +2679,9 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 			if (xfrm[i]->props.smark.v || xfrm[i]->props.smark.m)
 				mark = xfrm_smark_get(fl->flowi_mark, xfrm[i]);
 
-			family = xfrm[i]->props.family;
+			if (xfrm[i]->xso.type != XFRM_DEV_OFFLOAD_PACKET)
+				family = xfrm[i]->props.family;
+
 			oif = fl->flowi_oif ? : fl->flowi_l3mdev;
 			dst = xfrm_dst_lookup(xfrm[i], tos, oif,
 					      &saddr, &daddr, family, mark);
-- 
2.43.0


