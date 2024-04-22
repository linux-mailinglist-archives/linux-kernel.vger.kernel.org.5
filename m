Return-Path: <linux-kernel+bounces-153630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F938AD097
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98EE21C211D2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415CD153565;
	Mon, 22 Apr 2024 15:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="i4+/65a3"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC94152DEE;
	Mon, 22 Apr 2024 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799678; cv=none; b=LppVupMc54RZ/eGdHovfTkikgHvy4cbFhJjlRSR3C34vGC4O7kuMk0zu1NPni/1khHCZ8aaQFuzTXXo8lbXOOaIrplP8XatG4KCCqDnrz3ZSKq52284Jqk5phfSkdxhgu/NQZ43NgVNDIWeqwi3FbD2KMjK0zbZ9Ck6MrIGI9fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799678; c=relaxed/simple;
	bh=PgMgV906dQV29XTm6swQ99RMW8rFFJ1Z5BLFx0F/mWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sNERPjf3SYyvbzOfXInBAloiZIcqK2D3dDAMO3ZsJw2WyPZ48QTClz2dlAt55Ye9S6HPEqs9bBgCQnLOaZavHtEpM90RbQutobJE8drUbHUw1AKeK4xTWdSCnSeVFlj259ae2Fb25RHXd8rGCfk7E+HVIa0gJ11OVIsGkoRrxow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=i4+/65a3; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 238A0600A7;
	Mon, 22 Apr 2024 15:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713799675;
	bh=PgMgV906dQV29XTm6swQ99RMW8rFFJ1Z5BLFx0F/mWU=;
	h=From:To:Cc:Subject:Date:From;
	b=i4+/65a3GbXEMxzAQU1QcGwBF98t4iFEYyuBCZtlU0QwmV8vp3KKAhud393jZ9a6p
	 uFeAR9COPXfofloTOzwVxXfXZ7q48Oe18P0SH7d6mdN2aXsSvk0W5w+WIn34hJ6ZGg
	 VNkl2jN5E731fHKQ6KPtomZsJs2++zg1IHEMrmBmIfC3dTL2jbFkXHuuu30j1P2jKd
	 uoZWAVxGb3KRhh4aoIxHavUBdoE4WoJ+A8SCJwHMGxi2yhbbGfnD6XlGqz77moJhB0
	 PpRRILz3ShR8nPi+YNJmC2c+R3iecdGPiDdsjhCXZY9fWxGyV32hBK0g3k8LYuK8Gp
	 LfbGbBZpgqrLg==
Received: by x201s (Postfix, from userid 1000)
	id 4CEF72050C0; Mon, 22 Apr 2024 15:26:31 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michael Chan <michael.chan@broadcom.com>
Subject: [PATCH net-next] bnxt_en: flower: validate control flags
Date: Mon, 22 Apr 2024 15:26:23 +0000
Message-ID: <20240422152626.175569-1-ast@fiberby.net>
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
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
index 273c9ba48f09..d2ca90407cce 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
@@ -370,6 +370,7 @@ static int bnxt_tc_parse_flow(struct bnxt *bp,
 			      struct bnxt_tc_flow *flow)
 {
 	struct flow_rule *rule = flow_cls_offload_flow_rule(tc_flow_cmd);
+	struct netlink_ext_ack *extack = tc_flow_cmd->common.extack;
 	struct flow_dissector *dissector = rule->match.dissector;
 
 	/* KEY_CONTROL and KEY_BASIC are needed for forming a meaningful key */
@@ -380,6 +381,9 @@ static int bnxt_tc_parse_flow(struct bnxt *bp,
 		return -EOPNOTSUPP;
 	}
 
+	if (flow_rule_match_has_control_flags(rule, extack))
+		return -EOPNOTSUPP;
+
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC)) {
 		struct flow_match_basic match;
 
-- 
2.43.0


