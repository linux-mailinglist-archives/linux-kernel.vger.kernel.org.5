Return-Path: <linux-kernel+bounces-148633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE238A8556
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AE8D1F25230
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635891411E8;
	Wed, 17 Apr 2024 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="MyxQToss"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609DC14039D;
	Wed, 17 Apr 2024 13:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361967; cv=none; b=R1uQVmM4VxNgctfDU5sAe0zD8jz1pwx1nJZg8rlbFCXYVNVCkAyomao/nzH2DoKvT9rtQiHhDq51D/+UwFtA2zm4wLAg0+Bm1VwqNz64wHwvr+NRuJkraWuNICKKDSUCmqaoe6TFbTMPfpdBnh+n5cQArZumLbBQ4ZpRDhxWzDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361967; c=relaxed/simple;
	bh=dvs8rmkpjRbTlCQkdBXUSnIfhTY7ofWCgT1rCrbizXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mDW7MN60CetZVDl5AgRJ6gq6kkyTSXCTqij7X6cQJG9CjOpM/qLAkTEJFT2FWDr33bKHPpmWNyQWstuJjn0bIZM0wXVHkZp93GWzISYiNnXJRBzqzAYYM3qBeKDhGWBBBtvS0WP+kW0D6ZGn4VzqSVo+UH8Zg9o+nOAM+iJgCD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=MyxQToss; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id DCAFA600A7;
	Wed, 17 Apr 2024 13:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713361963;
	bh=dvs8rmkpjRbTlCQkdBXUSnIfhTY7ofWCgT1rCrbizXU=;
	h=From:To:Cc:Subject:Date:From;
	b=MyxQTossvwiZE6WUOuoKK5bTFXhKpKpktRXUUPeOLoblR/6RPr8n/UFQBZUgkuorZ
	 sh8wBhW9kAt+tQdz2YVOCiQjKnEYncE1SMzmvl1UOxwOBrKj8sKBi3AUqDbnAF0/2r
	 Gko18E0QzVPb4XKQ7CLJ9JHO+6sx2NnADzg2gjw3202Q4unjlv4BwmLGL9oz/qq9X9
	 NNGfiaC2MrZC7vS6Lr+Wj2mbcXvcDL6Ms5IsHoKoxJkFm5iRxYWga6hrtPMeHF9mx0
	 8rN6dZRDi2ach9xAjFsPSL5GdcmCKR4RGj6A1YpOGB5akL3+B+Npf5sdmHyXGE1xEY
	 ypmuBQKAfdosw==
Received: by x201s (Postfix, from userid 1000)
	id 816AA203AC4; Wed, 17 Apr 2024 13:51:15 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: [PATCH net-next] net/mlx5e: flower: check for unsupported control flags
Date: Wed, 17 Apr 2024 13:51:09 +0000
Message-ID: <20240417135110.99900-1-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use flow_rule_is_supp_control_flags() to reject filters with
unsupported control flags.

In case any unsupported control flags are masked,
flow_rule_is_supp_control_flags() sets a NL extended
error message, and we return -EOPNOTSUPP.

Only compile-tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index aeb32cb27182..5019280cfcdd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -2819,6 +2819,11 @@ static int __parse_cls_flower(struct mlx5e_priv *priv,
 			else
 				*match_level = MLX5_MATCH_L3;
 		}
+
+		if (!flow_rule_is_supp_control_flags(FLOW_DIS_IS_FRAGMENT |
+						     FLOW_DIS_FIRST_FRAG,
+						     match.mask->flags, extack))
+			return -EOPNOTSUPP;
 	}
 
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC)) {
-- 
2.43.0


