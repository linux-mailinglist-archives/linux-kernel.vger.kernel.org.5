Return-Path: <linux-kernel+bounces-150473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116648A9FE6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8CD28488A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3030F171093;
	Thu, 18 Apr 2024 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="CY24/O8X"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D095156F54;
	Thu, 18 Apr 2024 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457132; cv=none; b=myExeNYPNOQMn0kKa/ev7ukuWhhfMQmY7lmTzbg9hirREH2h+ENmF/m4zfxpZNiWlQFSZLAb70JujDNLbPpxQe5qEFrcl3Ji3ppKSw6Xb+yIl5OZbpF9zZxxIe/j/baKtgY0bCQjOxwJUOGzblwiKkKt24ek8o1TpVQGtktyqXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457132; c=relaxed/simple;
	bh=poIxThn5SO+bZMSKWV/zQXecY4gPv1jAHmJyjQa0Jis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bl27/ARZ5uk3av4uikvnVMnvgnyea41zd1V1zIvFvGefpqV3N5Dd0k4Mm/FbW2x4f7D8aNqQDB5ZCNkjUx6VmvYBH5LWnZEXUPCgm0KF+o1uBSC/xu1NPXJh+vl4h/awi2ryh5LkDYvJtByd1m7+JUnlJNqYmJW3ikdU4Zyzr7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=CY24/O8X; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 4C768600A9;
	Thu, 18 Apr 2024 16:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713457121;
	bh=poIxThn5SO+bZMSKWV/zQXecY4gPv1jAHmJyjQa0Jis=;
	h=From:To:Cc:Subject:Date:From;
	b=CY24/O8XUMd0XS1um4Tx5ptgj+TSOqvKJUsGp+n5L4BpsqeGkTlk06oKFS8pXEGKW
	 AuxCfrodZBwrB4Jau8doBtq/qD1RXexbhCMl6u191osXhT5dvm/n6RRf8WZSsjdW1P
	 N0ZaVU0hH9hNUvncwJoKmX39ziwt3bGWRDmGA2YOJjjvPqPM42nthJXP8uWSc4XSc3
	 NHHh1n0psPeXwwKYUtQ9q5AEbEzV6RzApJI9z2t4aQNMpKYE/VlpHxqOZT9KjqK0vU
	 SuFiQnrdcFKUkXNMcFAVDODVb6c8r/hoB4r8fQbdActJVEa5/sGBfJzkFdZX/PUww5
	 HgOzIPva7kbMA==
Received: by x201s (Postfix, from userid 1000)
	id 58CEE2061E5; Thu, 18 Apr 2024 16:17:53 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Raju Rangoju <rajur@chelsio.com>
Subject: [PATCH net-next] cxgb4: flower: validate control flags
Date: Thu, 18 Apr 2024 16:17:49 +0000
Message-ID: <20240418161751.189226-1-ast@fiberby.net>
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

Only compile tested, no hardware available.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
index 3a6987cafe59..69d045d769c4 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
@@ -327,6 +327,9 @@ static int cxgb4_validate_flow_match(struct netlink_ext_ack *extack,
 		return -EOPNOTSUPP;
 	}
 
+	if (flow_rule_match_has_control_flags(rule, extack))
+		return -EOPNOTSUPP;
+
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC)) {
 		struct flow_match_basic match;
 
-- 
2.43.0


