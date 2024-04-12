Return-Path: <linux-kernel+bounces-142622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EA38A2DF2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4151F219B6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FD756443;
	Fri, 12 Apr 2024 12:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="RKcgOz/o"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7207255C3E;
	Fri, 12 Apr 2024 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712923435; cv=none; b=CfSSl7M36idH1S4eotcapQGfHvXNxiMRPdk74w5ANcgZ7mP2Kesmer6FGooJVHuAgubGcuooYCgttbL+emk0YUI0ri++ziaGFEzcRbX82xR4aiB2pPSARbaMGwNt2hKNsFJrKz7ll9MZZOg6CNL1grahG+gG3ce0IH4WvuAaNZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712923435; c=relaxed/simple;
	bh=lRzbJyihvGMzcZ0Sl/0gTZzX9Tm+cwJBSQJ/1svgYAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IHVL0VUysLmoLIvTRqJkxtNR974j/XDHRk4/u4aoU5hKiFOxJcRq9rqvq7o9vi8oGe15tAnkGWWu16/taV+qQ2K5xmZwvVBOjbb2OjMoSs+Z3IuDy0Yn0QXUesvyBqSbPZBj+lkYSUOJ59xCJdX5yw2nSTBpOfOZ0cv+fzQ+Tyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=RKcgOz/o; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 96A29600A2;
	Fri, 12 Apr 2024 12:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712923426;
	bh=lRzbJyihvGMzcZ0Sl/0gTZzX9Tm+cwJBSQJ/1svgYAA=;
	h=From:To:Cc:Subject:Date:From;
	b=RKcgOz/o7Pi81fh269tcV3qy43eZIsCoC+qnKr8OTyFI75BrR91myAJgyEd5kRy3t
	 m1Bmo7zHOTeJ1VBs1zpietrTUgDWBiJe7bjTqCVS8KG8azmLC2QWFIWZiRI5Uphmuv
	 nw/0tmiADlMrFbkiGOkgqu5sYSeg4tgaqT9bsYpu5cyfkWkrwGlmUwh4chaTg+272T
	 bUW6Ohnsp7bf07o62TfdALLZw7mV3zQepgPKikqNO4lHKggzwvI3H9RitYdK5wEclG
	 MieTn9pH1bi/kZHcpUY+Uk2u/f2SGrrETioqCfToLUMrkZ6BiT3pgsTse0gv63FEBn
	 CM90/ZD893sRw==
Received: by x201s (Postfix, from userid 1000)
	id 7A15C2010E6; Fri, 12 Apr 2024 12:03:02 +0000 (UTC)
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
	hariprasad <hkelam@marvell.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net v2] octeontx2-pf: fix FLOW_DIS_IS_FRAGMENT implementation
Date: Fri, 12 Apr 2024 12:02:56 +0000
Message-ID: <20240412120258.233970-1-ast@fiberby.net>
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
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---

Changelog:

v2:
- Added Reviewed-by from Jacob Keller.

v1: https://lore.kernel.org/all/20240410134303.21560-1-ast@fiberby.net/

 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 87bdb93cb066..f4655a8c0705 100644
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


