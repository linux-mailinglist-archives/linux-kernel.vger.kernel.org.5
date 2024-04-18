Return-Path: <linux-kernel+bounces-150474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB098A9FE9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E2B11F234BB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2CA16F917;
	Thu, 18 Apr 2024 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="g3GKpEMc"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B674161B6A;
	Thu, 18 Apr 2024 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457161; cv=none; b=rXqRvAZLoH1aXnuKZ54B76E21Yu6kVJHbF8Rzd7qz9swpBqzgcugCLhkXwRbxsdDOZVM3VMqRhshpIf/9LPHmg6a4WXwuXdlB9qgHkWSIIjIdOnNVsiOgVk9mq8O3iApzfe3vC7iQJXWidG9SAVuv7Yxr8Y5gW5XouDBrsYgT4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457161; c=relaxed/simple;
	bh=dI6Cqzw1iKtIkYphmVcf4PPF7ZmfJQ37K3PfXaknTEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=slcxazKIB8ePcAsQ4Fmmonb1UmfwijHY0qPgb+iT70eG1FV0idmKk1QS7YR+6cnElhs3q5Hrv2mVwUSfAy3L3GP09u6KES16bNyOZh7b7nPn6B80p61yFSzy1/G0hYsQKnKdhbUhYiaYQaKaVAkSfDjtdH9qZb9bTe1kjbP9U1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=g3GKpEMc; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 73B53600A5;
	Thu, 18 Apr 2024 16:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713457156;
	bh=dI6Cqzw1iKtIkYphmVcf4PPF7ZmfJQ37K3PfXaknTEw=;
	h=From:To:Cc:Subject:Date:From;
	b=g3GKpEMcJ4JZdrNGGO8E+o2xBduPlDkBTG904wvBPPgua1rSNNW+scR/mHXOoTSKe
	 a59sXLHLUjHNKv5h9iF5O7acFSKbe+iiSB2k1kCCbvxl4OfsXSV6Hq2iHForPY0N5o
	 q9nBSms94UZM4kIeQNhim9kae7zQ/nKPa0KvRY2nNQU6dDcl8etcPb/adR5m1/ANU7
	 1+TGbjWZIdHnvp9Vchn8X1L3VZQP/N211ko43qrccFhcZEaQSarLLBVcgxbJ8ulOVu
	 cGeCcFOOL3zk00L30yLBhapKZzR8BXgGdJ+xBmi8tgnUfXRgrzi9bKVeN3fLl4E8CU
	 1VlMdY6mljtDw==
Received: by x201s (Postfix, from userid 1000)
	id 85E9720EF3E; Thu, 18 Apr 2024 16:18:22 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next] net: ethernet: mtk_eth_soc: flower: validate control flags
Date: Thu, 18 Apr 2024 16:18:15 +0000
Message-ID: <20240418161821.189263-1-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This driver currently doesn't support any control flags.

Use flow_rule_has_control_flags() to check for control flags,
such as can be set through `tc flower ... ip_flags frag`.

In case any control flags are masked, flow_rule_has_control_flags()
sets a NL extended error message, and we return -EOPNOTSUPP.

Only compile-tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/mediatek/mtk_ppe_offload.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
index fbb5e9d5af13..aa262e6f4b85 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
@@ -273,6 +273,10 @@ mtk_flow_offload_replace(struct mtk_eth *eth, struct flow_cls_offload *f,
 
 		flow_rule_match_control(rule, &match);
 		addr_type = match.key->addr_type;
+
+		if (flow_rule_has_control_flags(match.mask->flags,
+						f->common.extack))
+			return -EOPNOTSUPP;
 	} else {
 		return -EOPNOTSUPP;
 	}
-- 
2.43.0


