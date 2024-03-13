Return-Path: <linux-kernel+bounces-101904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8807B87AC98
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42AEF28AB84
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85F381ABB;
	Wed, 13 Mar 2024 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3TSoDMN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AEC8175F;
	Wed, 13 Mar 2024 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348042; cv=none; b=sDLnGMk3spjevSY9PpHmT2DSI6A70g8UQ8aEBpNo/HSiiBgGg8FhRUA/llarPmMVpg7yU5oMf+41s2QHI91EnYOfhW8/DASmyHRZqFgI0MdW22VrMB8MsaTpRtnIbrJ0mv1VaHIOqlLiNwcjfuXAL4LveF2YKw9kiidfMX9HHPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348042; c=relaxed/simple;
	bh=MgFQRhG/OOHV6pUt9GRHyVpyPsEKWtkQOkVBE1rThM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFjOfHbL3WIkwfMmkntLZzHiZo2U5EkLPkFxNjYPaYUl7UTsM3x9PEast8v/9XPMO1b8NGMky3CtOFA1WDKxDJjgD2hF3Ai7FAIxGKeOGmHArCvF2hyB7zQdTMeXXcNDMOpmNpQrh7GzEOfqblfdhlsy3/gLsEr3d/1RtfH+/DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3TSoDMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA57C43390;
	Wed, 13 Mar 2024 16:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348041;
	bh=MgFQRhG/OOHV6pUt9GRHyVpyPsEKWtkQOkVBE1rThM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u3TSoDMNOPGS8nfNmUbQqzDwLNvgDlB0J2tnGHkAt3BnMqILCVpk+XcK12qXTQnl5
	 JtvFADSKlFMWCsenaEhAXv+2yIJnDb/zQGgF3LFi+wIeLto1Fe/2L4paM4uILEV3E/
	 hjL9l2nCwbNFOoJQUPYIc/MYtttcHgqtaWPgyNnJPdJPa9O4w8Fobro/I9EIV4QdR5
	 zUk9EliLlhpNUpd17TCZyciYwnKLLnofGpfhpRkLG9LBmJGR/lE2wlbGe57MoNq8Wp
	 AvF4mXEM6xOPDclVq+ONUBToL1Jf853UfGDlvJtrsd0n6w41fIVoy97QFenhC4h+ks
	 5FPnGV8r2+WbA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hui Zhou <hui.zhou@corigine.com>,
	Louis Peens <louis.peens@corigine.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 36/71] nfp: flower: add hardware offload check for post ct entry
Date: Wed, 13 Mar 2024 12:39:22 -0400
Message-ID: <20240313163957.615276-37-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Hui Zhou <hui.zhou@corigine.com>

[ Upstream commit cefa98e806fd4e2a5e2047457a11ae5f17b8f621 ]

The nfp offload flow pay will not allocate a mask id when the out port
is openvswitch internal port. This is because these flows are used to
configure the pre_tun table and are never actually send to the firmware
as an add-flow message. When a tc rule which action contains ct and
the post ct entry's out port is openvswitch internal port, the merge
offload flow pay with the wrong mask id of 0 will be send to the
firmware. Actually, the nfp can not support hardware offload for this
situation, so return EOPNOTSUPP.

Fixes: bd0fe7f96a3c ("nfp: flower-ct: add zone table entry when handling pre/post_ct flows")
CC: stable@vger.kernel.org # 5.14+
Signed-off-by: Hui Zhou <hui.zhou@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
Link: https://lore.kernel.org/r/20240124151909.31603-2-louis.peens@corigine.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/netronome/nfp/flower/conntrack.c | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
index da7a47416a208..497766ecdd91d 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
@@ -1797,10 +1797,30 @@ int nfp_fl_ct_handle_post_ct(struct nfp_flower_priv *priv,
 {
 	struct flow_rule *rule = flow_cls_offload_flow_rule(flow);
 	struct nfp_fl_ct_flow_entry *ct_entry;
+	struct flow_action_entry *ct_goto;
 	struct nfp_fl_ct_zone_entry *zt;
+	struct flow_action_entry *act;
 	bool wildcarded = false;
 	struct flow_match_ct ct;
-	struct flow_action_entry *ct_goto;
+	int i;
+
+	flow_action_for_each(i, act, &rule->action) {
+		switch (act->id) {
+		case FLOW_ACTION_REDIRECT:
+		case FLOW_ACTION_REDIRECT_INGRESS:
+		case FLOW_ACTION_MIRRED:
+		case FLOW_ACTION_MIRRED_INGRESS:
+			if (act->dev->rtnl_link_ops &&
+			    !strcmp(act->dev->rtnl_link_ops->kind, "openvswitch")) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "unsupported offload: out port is openvswitch internal port");
+				return -EOPNOTSUPP;
+			}
+			break;
+		default:
+			break;
+		}
+	}
 
 	flow_rule_match_ct(rule, &ct);
 	if (!ct.mask->ct_zone) {
-- 
2.43.0


