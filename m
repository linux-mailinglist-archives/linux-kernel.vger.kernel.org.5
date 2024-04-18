Return-Path: <linux-kernel+bounces-150472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 894F78A9FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FFB41F23950
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467CF16F916;
	Thu, 18 Apr 2024 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Rly0IjLw"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F368879EA;
	Thu, 18 Apr 2024 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457130; cv=none; b=daPeZmt/R6WIfkyBzXn2IQxz+kzvKxJc6+/ea5dxdVWMt8m/kXwmdz3GFXupMqzmOXqHVOPy3dYA5Go++ZVTcU122ikZV/ALzmrgx+4aEtc4yjAg7IKvNH2Hbuv3KpxtPpS/Zo+u8OaM4MbE+RHMO+R5ESZcY4Mr4B4MfMJ3gw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457130; c=relaxed/simple;
	bh=zMJB6MjfEiqsXe9D7KG5qHReQgyAiQ2kyC/RVG+ge1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MNifU6Zh38jvlp7jJonypTM0CH862K8ptHsC8swG4Y5eZiQsop9fBTtqtbHqoI7R6j48YctzLgX/BnUht78Ci2QbWMTL4RXdfzswumKLvmi1SezzFKrcayFbaC51+dx35H0y9MxZwzbC0k9K9fgxdFIqNAvK5nbMQ460jP4F+Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Rly0IjLw; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id C2645600A7;
	Thu, 18 Apr 2024 16:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713457119;
	bh=zMJB6MjfEiqsXe9D7KG5qHReQgyAiQ2kyC/RVG+ge1U=;
	h=From:To:Cc:Subject:Date:From;
	b=Rly0IjLwkwalnkhIni7FJ5Pp/DqFl/iMetAeWPzcg6fWByQxSFJz10jCMSHN2qvQ+
	 +2+eyjeb42C144sCcQ3yvESwMs33BZI9c/I0haDuqmogtE/NDzVKCOcQmkqX0LyLzz
	 kb8wRDx2B6WOfmMXxzwnYNrWnpq91Mb2Mv2ZTZtga6l/h/ZmW3T40flQI1ULZpWoST
	 XsWGJs4beYeky2MHw8ZYhNoPY904bxJybzX0+2wZZX8eGhkv/+rZJGyTQAKAZgF3rT
	 ZPncp83z834USiyzhC6GIDl5ETSdCNknmFKTgCKwF1bXgUYxlMhaNz61M13Dk9ffVN
	 Sj+33rquFOfjQ==
Received: by x201s (Postfix, from userid 1000)
	id 70B5E20EF3B; Thu, 18 Apr 2024 16:18:03 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH net-next] dpaa2-switch: flower: validate control flags
Date: Thu, 18 Apr 2024 16:18:01 +0000
Message-ID: <20240418161802.189247-1-ast@fiberby.net>
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

Use flow_rule_match_has_control_flags() to check for control flags,
such as can be set through `tc flower ... ip_flags frag`.

In case any control flags are masked, flow_rule_match_has_control_flags()
sets a NL extended error message, and we return -EOPNOTSUPP.

Only compile-tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c
index b6a534a3e0b1..701a87370737 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c
@@ -33,6 +33,9 @@ static int dpaa2_switch_flower_parse_key(struct flow_cls_offload *cls,
 	acl_h = &acl_key->match;
 	acl_m = &acl_key->mask;
 
+	if (flow_rule_match_has_control_flags(rule, extack))
+		return -EOPNOTSUPP;
+
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC)) {
 		struct flow_match_basic match;
 
@@ -548,6 +551,9 @@ static int dpaa2_switch_flower_parse_mirror_key(struct flow_cls_offload *cls,
 		return -EOPNOTSUPP;
 	}
 
+	if (flow_rule_match_has_control_flags(rule, extack))
+		return -EOPNOTSUPP;
+
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_VLAN)) {
 		struct flow_match_vlan match;
 
-- 
2.43.0


