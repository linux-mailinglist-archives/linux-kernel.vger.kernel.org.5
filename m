Return-Path: <linux-kernel+bounces-101903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B4887AC96
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F4528A910
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75508175B;
	Wed, 13 Mar 2024 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWj4ZOOX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89D68173C;
	Wed, 13 Mar 2024 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348041; cv=none; b=LqZAWyfm21OvAszuL7Pv+WEJsl77rzwFbVf4SHiExQcDor8P+r7H3VaMbaRi0Dz7/YfIhZ72C9eu03eIAk/okNSKZ2Af3RjHeZaZWls9Vifuo+JDU32mR1DHt079/weRte5aCjSnXAhmFEGX7JpdN0UK8f7W4r656cAq/m075/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348041; c=relaxed/simple;
	bh=fUxyNfgxB2Vx9wcxWhFz5duoo3Et+DeB9Wd4NPZCsHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EH2sQCx7duS1M3vecR45JEymC0zvjrAXbDULrfIH6JQB9eOLdoKGp5tDtFKiLqvz4F/fbhKXvBuC4SUk8lO1GlWBUs+1OAgR2mVBXvWWjG8Msut7mthkQAfl3erjiLJ4CBGPFpHYrUm8KcskjqWQs3fmeqh0FT0ISWoUKPcS3Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWj4ZOOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D902DC433C7;
	Wed, 13 Mar 2024 16:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348040;
	bh=fUxyNfgxB2Vx9wcxWhFz5duoo3Et+DeB9Wd4NPZCsHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DWj4ZOOX4MECBgkLLAJQE824RJBvEIo3a0x4hsmshiiKbdzKnanVQecpCXIRW7bn8
	 d3JunKT9eG/St81uD8n7ML9aDZRNRnPW3nxnoSHjEEzzVaLhJsTiIGSmiYEqx1ZFN8
	 ADgzkhkBDTRxG5QH2w9wtrZ3oX37SKPVx3B47ah59TtpfjRYyS3+qgcrmxxkbumL92
	 HdMXanAe3OsPI2rSlpj3CHDJbHtZ+FNR3t/ohA0PhCO+h6+DC9x6+hwhfkjRZV4PjF
	 7IG5WGBdMPV4inedwlOeSYuZetcIN3pmbAEeY0v6CpzacF1MRBAlX6lGGaHe3zi//h
	 UbC5d2g5xx/3A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wentao Jia <wentao.jia@corigine.com>,
	Simon Horman <simon.horman@corigine.com>,
	Louis Peens <louis.peens@corigine.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 35/71] nfp: flower: add goto_chain_index for ct entry
Date: Wed, 13 Mar 2024 12:39:21 -0400
Message-ID: <20240313163957.615276-36-sashal@kernel.org>
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

From: Wentao Jia <wentao.jia@corigine.com>

[ Upstream commit 3e44d19934b92398785b3ffc2353b9eba264140e ]

The chain_index has different means in pre ct entry and post ct entry.
In pre ct entry, it means chain index, but in post ct entry, it means
goto chain index, it is confused.

chain_index and goto_chain_index may be present in one flow rule, It
cannot be distinguished by one field chain_index, both chain_index
and goto_chain_index are required in the follow-up patch to support
multiple ct zones

Another field goto_chain_index is added to record the goto chain index.
If no goto action in post ct entry, goto_chain_index is 0.

Signed-off-by: Wentao Jia <wentao.jia@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: cefa98e806fd ("nfp: flower: add hardware offload check for post ct entry")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/netronome/nfp/flower/conntrack.c | 8 ++++++--
 drivers/net/ethernet/netronome/nfp/flower/conntrack.h | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
index 7af03b45555dd..da7a47416a208 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
@@ -1243,7 +1243,7 @@ static int nfp_ct_do_tc_merge(struct nfp_fl_ct_zone_entry *zt,
 	/* Checks that the chain_index of the filter matches the
 	 * chain_index of the GOTO action.
 	 */
-	if (post_ct_entry->chain_index != pre_ct_entry->chain_index)
+	if (post_ct_entry->chain_index != pre_ct_entry->goto_chain_index)
 		return -EINVAL;
 
 	err = nfp_ct_merge_check(pre_ct_entry, post_ct_entry);
@@ -1776,7 +1776,8 @@ int nfp_fl_ct_handle_pre_ct(struct nfp_flower_priv *priv,
 	if (IS_ERR(ct_entry))
 		return PTR_ERR(ct_entry);
 	ct_entry->type = CT_TYPE_PRE_CT;
-	ct_entry->chain_index = ct_goto->chain_index;
+	ct_entry->chain_index = flow->common.chain_index;
+	ct_entry->goto_chain_index = ct_goto->chain_index;
 	list_add(&ct_entry->list_node, &zt->pre_ct_list);
 	zt->pre_ct_count++;
 
@@ -1799,6 +1800,7 @@ int nfp_fl_ct_handle_post_ct(struct nfp_flower_priv *priv,
 	struct nfp_fl_ct_zone_entry *zt;
 	bool wildcarded = false;
 	struct flow_match_ct ct;
+	struct flow_action_entry *ct_goto;
 
 	flow_rule_match_ct(rule, &ct);
 	if (!ct.mask->ct_zone) {
@@ -1823,6 +1825,8 @@ int nfp_fl_ct_handle_post_ct(struct nfp_flower_priv *priv,
 
 	ct_entry->type = CT_TYPE_POST_CT;
 	ct_entry->chain_index = flow->common.chain_index;
+	ct_goto = get_flow_act(flow->rule, FLOW_ACTION_GOTO);
+	ct_entry->goto_chain_index = ct_goto ? ct_goto->chain_index : 0;
 	list_add(&ct_entry->list_node, &zt->post_ct_list);
 	zt->post_ct_count++;
 
diff --git a/drivers/net/ethernet/netronome/nfp/flower/conntrack.h b/drivers/net/ethernet/netronome/nfp/flower/conntrack.h
index 762c0b36e269b..9440ab776ecea 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/conntrack.h
+++ b/drivers/net/ethernet/netronome/nfp/flower/conntrack.h
@@ -112,6 +112,7 @@ enum nfp_nfp_layer_name {
  * @cookie:	Flow cookie, same as original TC flow, used as key
  * @list_node:	Used by the list
  * @chain_index:	Chain index of the original flow
+ * @goto_chain_index:	goto chain index of the flow
  * @netdev:	netdev structure.
  * @type:	Type of pre-entry from enum ct_entry_type
  * @zt:		Reference to the zone table this belongs to
@@ -125,6 +126,7 @@ struct nfp_fl_ct_flow_entry {
 	unsigned long cookie;
 	struct list_head list_node;
 	u32 chain_index;
+	u32 goto_chain_index;
 	enum ct_entry_type type;
 	struct net_device *netdev;
 	struct nfp_fl_ct_zone_entry *zt;
-- 
2.43.0


