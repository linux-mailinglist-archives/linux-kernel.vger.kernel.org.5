Return-Path: <linux-kernel+bounces-138667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6444F89F9C7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B45A4B225DB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD572177994;
	Wed, 10 Apr 2024 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="NPrA4equ"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624FB15EFAD;
	Wed, 10 Apr 2024 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756617; cv=none; b=KouNOimLM8IlEy9itFzFKq/+mBHaAJjtlE0Z0XS/s0uz/urONw79gwrv2lBx0OSp1dhCugEDwdpCB8ksk6yRd6l08xwg7lLzejYxnfBFmGL1qXW6LlgXeM+EYR1tKqh2Zfppp8Y17bMxSXEWid/s3W8uniFecZTmWpaH9KtxIic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756617; c=relaxed/simple;
	bh=XiPRziEWRhIzlEfs7eO5aDDMDS4PjF7n1KvdNGZEerQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gHvqR3PRqMuFVH5coyMnr+Jd3/Y0+zBA9b9sVR3I3NBYiCJnh8Fq14++vAJiezvLhjkg1REhMCpyG22IVOhc6xZ0AP4aHdwvQOzLas70vJfV3eUF2YkISn1EEnrsMdSUNkxqLen0XP0Xa8ZXXw0wuuabESrV3LX28svJ0ZrVK9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=NPrA4equ; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 89CD3600A2;
	Wed, 10 Apr 2024 13:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712756610;
	bh=XiPRziEWRhIzlEfs7eO5aDDMDS4PjF7n1KvdNGZEerQ=;
	h=From:To:Cc:Subject:Date:From;
	b=NPrA4equ/TMpR0q6+Yituygvav46aTdDa8B2kaKZjNOVKTtNVH/dVGDuT2u3rDTD3
	 djiLop+Vu9z9nCp+t381RUOL/BC0iIHDfG4SvMl1S4XURG1RuwSTpaKGJunRGbKCEX
	 dHJ9AD/n0aH3ESMcAIOpCzov23dYW+p6mTmqfd5jr1VgwOUGKRy/OnGJPr3np3CE1z
	 0ZBykyAPQAGJtTEVluccEHnSHZeYZRoQSkpP+L/kKkkEL66TuqjMMFQFyFAYsfjDAp
	 NCrFw+cIQUmkhyKQVOHCBZ6aSKLv6bpNzl1NsqgN8ciZIEr+h8zw3bmWfm8CBN0HLQ
	 6hSUCSOr5kf9w==
Received: by x201s (Postfix, from userid 1000)
	id C1DB02010E6; Wed, 10 Apr 2024 13:43:04 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org,
	Suman Ghosh <sumang@marvell.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>
Subject: [PATCH net] octeontx2-pf: fix FLOW_DIS_IS_FRAGMENT implementation
Date: Wed, 10 Apr 2024 13:43:01 +0000
Message-ID: <20240410134303.21560-1-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Upon reviewing the flower control flags handling in
this driver, I notice that the key wasn't being used,
only the mask.

Ie. `tc flower ... ip_flags nofrag` was hardware
offloaded as `... ip_flags frag`.

Only compile tested, no access to HW.

Fixes: c672e3727989 ("octeontx2-pf: Add support to filter packet based on IP fragment")
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---

This is a best guess on a fix, I don't know if it will work,
but hopefully someone at Marvell can test it.

The more certain alternative would be to set an error msg.
and return -EOPNOTSUPP, when `tc flower ip_flags nofrag`
is used.

 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 87bdb93cb066e..f4655a8c0705d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -688,22 +688,25 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 	}
 
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CONTROL)) {
 		struct flow_match_control match;
+		u32 val;
 
 		flow_rule_match_control(rule, &match);
 		if (match.mask->flags & FLOW_DIS_FIRST_FRAG) {
 			NL_SET_ERR_MSG_MOD(extack, "HW doesn't support frag first/later");
 			return -EOPNOTSUPP;
 		}
 
 		if (match.mask->flags & FLOW_DIS_IS_FRAGMENT) {
+			val = match.key->flags & FLOW_DIS_IS_FRAGMENT;
 			if (ntohs(flow_spec->etype) == ETH_P_IP) {
-				flow_spec->ip_flag = IPV4_FLAG_MORE;
+				flow_spec->ip_flag = val ? IPV4_FLAG_MORE : 0;
 				flow_mask->ip_flag = IPV4_FLAG_MORE;
 				req->features |= BIT_ULL(NPC_IPFRAG_IPV4);
 			} else if (ntohs(flow_spec->etype) == ETH_P_IPV6) {
-				flow_spec->next_header = IPPROTO_FRAGMENT;
+				flow_spec->next_header = val ?
+							 IPPROTO_FRAGMENT : 0;
 				flow_mask->next_header = 0xff;
 				req->features |= BIT_ULL(NPC_IPFRAG_IPV6);
 			} else {
 				NL_SET_ERR_MSG_MOD(extack, "flow-type should be either IPv4 and IPv6");
-- 
2.43.0


