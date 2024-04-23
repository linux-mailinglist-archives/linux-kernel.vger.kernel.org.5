Return-Path: <linux-kernel+bounces-154862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3648AE229
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB282283334
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E738D664DD;
	Tue, 23 Apr 2024 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="dreCglqb"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB86261694;
	Tue, 23 Apr 2024 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868096; cv=none; b=SNfyLnqwK9y+sA8Z+UlmXdUT829Y8W+ExneTuKdaiMePNjI1UKvZ7YqnmgtnJPCvVAnbwGTs7F9w1M3aNDv3ieDjVZ3myAmTdZj6tP3oHdLQO5a7eJJaK9bPcjMMNjOzIchoE7DAaFO6UJvxQZpSb/J59+2u8WoltPjkRa5zjJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868096; c=relaxed/simple;
	bh=b7EYECfaQpkuXRm4fwoJzpN0LrsyfwmAPnfkai828dE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R4I5kU5cqq8ZKXsBzecAfqLMpqQqx/vxKDtEa2eFY2sDCtAt2ms+mxptL8p5ptnWL5TaoNLljvpr/hQp1hzpmCO1Fs+GiI0FlIW3m4NbzE+lvV3+CBQgsDh1aDYELqGuy5wMUHxJ74L1JvLHQgoqufOVP9GG84pNsVbNZzvMQaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=dreCglqb; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 69071600AF;
	Tue, 23 Apr 2024 10:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713868087;
	bh=b7EYECfaQpkuXRm4fwoJzpN0LrsyfwmAPnfkai828dE=;
	h=From:To:Cc:Subject:Date:From;
	b=dreCglqb9B46tN4utGlbkHf0tCeEhW1Sqy+zGl1z7i3igNJ0ANs9PuCjrAGUml8PR
	 eGt6Y21FK9E7Dqm3yuxX099PXg9tE9FzMSld1zP1fbOmcsFcw43p1pHQ+nrovGobT+
	 CLHu14yip5KBr/qIrHk+ve5xgYR8IckKFSJ9rCtcbTBrQ3fiY5gDzDRMpCtKwlaFF7
	 ogeeoIR1EZ06u/gk55N8PikAk8jHnVKPNmxHgtAB5nJAlGbQxb8JusTaX1st4UwWdh
	 n7tUTA8j1oHcGjBHCVysdBphyDm40lR9Lc4xgNiInhFtQOtQelMyVuNDyVAkuVGgul
	 umL3JD75v63hQ==
Received: by x201s (Postfix, from userid 1000)
	id A8D1B205A1A; Tue, 23 Apr 2024 10:27:20 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] net: lan966x: cleanup lan966x_tc_flower_handler_control_usage()
Date: Tue, 23 Apr 2024 10:27:17 +0000
Message-ID: <20240423102720.228728-1-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Define extack locally, to reduce line lengths and future users.

Rename goto, as the error message is specific to the fragment flags.

Only compile-tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 .../net/ethernet/microchip/lan966x/lan966x_tc_flower.c   | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c b/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c
index d696cf9dbd19..8baec0cd8d95 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c
@@ -45,6 +45,7 @@ static bool lan966x_tc_is_known_etype(struct vcap_tc_flower_parse_usage *st,
 static int
 lan966x_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
 {
+	struct netlink_ext_ack *extack = st->fco->common.extack;
 	struct flow_match_control match;
 	int err = 0;
 
@@ -59,7 +60,7 @@ lan966x_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
 						    VCAP_KF_L3_FRAGMENT,
 						    VCAP_BIT_0);
 		if (err)
-			goto out;
+			goto bad_frag_out;
 	}
 
 	if (match.mask->flags & FLOW_DIS_FIRST_FRAG) {
@@ -72,15 +73,15 @@ lan966x_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
 						    VCAP_KF_L3_FRAG_OFS_GT0,
 						    VCAP_BIT_1);
 		if (err)
-			goto out;
+			goto bad_frag_out;
 	}
 
 	st->used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL);
 
 	return err;
 
-out:
-	NL_SET_ERR_MSG_MOD(st->fco->common.extack, "ip_frag parse error");
+bad_frag_out:
+	NL_SET_ERR_MSG_MOD(extack, "ip_frag parse error");
 	return err;
 }
 
-- 
2.43.0


