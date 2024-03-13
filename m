Return-Path: <linux-kernel+bounces-101981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475CA87AD4E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CED3BB25375
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648511474AE;
	Wed, 13 Mar 2024 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZF6Ude33"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DD8146E9C;
	Wed, 13 Mar 2024 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348191; cv=none; b=EFsWVYTLXWpgRvKJ8VrMLUB2AnE3qriNC16x9YR0VxWF4EKXP2cEcz1wH4nlno7XELYsmzLNwkgS05+cPJZqVUG7ovwhM1u83WcNXiEHDoDgySOjz29XHOchKRvN7SUN432RPmpaIWcnhFT0azFAzdG6+NdLWs4EJ9nCusrOFGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348191; c=relaxed/simple;
	bh=ognCZaFS6GdMBlOCUFY4jl2BZglCYU4E6QLhPCdkh8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5p6E7Fw5L+gyTmAz0Bwdm3wVmzTBApXqVoGBHCxtK5VSeqkFL8jh3w+sD00zK32O4kJwx8Li3HUo4yboL+EKowl1nB2mVgMo/S7YpWsEH2NBkvijCGADDdKHtql3HibUZEH5eNGhFe6+3uCcmhK6J2Qmy3rMFE3yQJDkT1FiSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZF6Ude33; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF63C43609;
	Wed, 13 Mar 2024 16:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348191;
	bh=ognCZaFS6GdMBlOCUFY4jl2BZglCYU4E6QLhPCdkh8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZF6Ude339PnGDq7O0XpMkn2SIXW9yth6sOYrNZW/84AHiomvuJS40t2cxI9S/gsCA
	 88lobIs4+6io/m3uChaXuoaeJO3Xxee54GNiBmNIJ+GRgkq0GZF9srFJwuvM6+KPrO
	 Y4MpjIL+zmMfhBI5H54fo4JJgc32tqMQb1RoOxQusCZHNi9L+lUUgZQLFRN/xaIAZ5
	 U4+u7yBbwt7guc041KqmeiEfaulUkjNPpQ0oIWdy57NAdC7SDREBAG3ubgA/gvImdq
	 t4d1UjJy1I5VWGYiRqGakd6mzKFEdhG7465Un3gL6hOl+3b9xOAkNW8nV8WrzRfENH
	 cBQaTn/IHooVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hui Zhou <hui.zhou@corigine.com>,
	Louis Peens <louis.peens@corigine.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 41/76] nfp: flower: add hardware offload check for post ct entry
Date: Wed, 13 Mar 2024 12:41:48 -0400
Message-ID: <20240313164223.615640-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
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
index 0a5592b12e2d1..03a2dbcfbe566 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
@@ -1471,10 +1471,30 @@ int nfp_fl_ct_handle_post_ct(struct nfp_flower_priv *priv,
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


