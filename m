Return-Path: <linux-kernel+bounces-153628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1358AD094
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF20F1C20DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDE01534F5;
	Mon, 22 Apr 2024 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="ihMk0gjH"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8F7152175;
	Mon, 22 Apr 2024 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799677; cv=none; b=uL2Bt/QO0PD5zuePigO4Ib1C3f2q9he/dUy4UaI4Qouf1lFG8Rb9g128WTUHMkd5OrUP1kt9c3dh0l4PGLtS9HmnC/nSTzBolxKG9aulSmU2A6s3Pcr4j4klawcKOrNxdKMXspWtIKYcKV4J0vB55EtNE3eolMiYNjYicVGW9JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799677; c=relaxed/simple;
	bh=m9k1I/2mxgAZ58a9WIgRJHcEnolmbwmpr+xDtZQzpyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RJqW0hiH/eLbS8hZi9fN2+4XKwIxTdSPf0W8WxKFKST/BOgBeBj4u3Gd3Cz0vjxBkfG6e9FJ9tSL+qAjauQ1l+b755WJV27rzYLUei/2ulPtIR3VJ+kq8/fcUmD2i4H6P8Y0etQl/Ex1E2OAj9sjdhjwX4WkA56pDFgfLr4RwSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=ihMk0gjH; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 70F71600A9;
	Mon, 22 Apr 2024 15:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713799672;
	bh=m9k1I/2mxgAZ58a9WIgRJHcEnolmbwmpr+xDtZQzpyU=;
	h=From:To:Cc:Subject:Date:From;
	b=ihMk0gjHCffweyEaajmCsaa7KmDE4YwIsCBICskG4tg+D0y0JvizdEz4PG66fXM5d
	 3akIO/u01D7jMSnVbX3/iUjy7n7vgx+zKf+q4oZtMyT5Tk1i7L7/GOGud0NYssuncB
	 HxDdx2iiIPaVqBOwZwTXJxLEjbg0JmvQhvWXQn12E4jAPXVls/Od/XsNXsVZZA4Wf1
	 kyL38lM4AVeiWOb9bK44MczBBd4roVH0CSWxwt5ne+DncvQutR8sW6HjFMUwR3QlGG
	 b0BNgrb0c1m/3p9OtLy1xwAn4v0wawhljX+GlaSY75436YSAYXLzGOAyvL3Rrabz27
	 EZocAXPGJlPag==
Received: by x201s (Postfix, from userid 1000)
	id 2ADD3209399; Mon, 22 Apr 2024 15:27:35 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
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
	Suman Ghosh <sumang@marvell.com>
Subject: [PATCH net-next] octeontx2-pf: flower: check for unsupported control flags
Date: Mon, 22 Apr 2024 15:27:34 +0000
Message-ID: <20240422152735.175693-1-ast@fiberby.net>
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

Remove FLOW_DIS_FIRST_FRAG specific error message,
and treat it as any other unsupported control flag.

Only compile-tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 6d4ce2ece8d0..e63cc1eb6d89 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -700,10 +700,6 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 		u32 val;
 
 		flow_rule_match_control(rule, &match);
-		if (match.mask->flags & FLOW_DIS_FIRST_FRAG) {
-			NL_SET_ERR_MSG_MOD(extack, "HW doesn't support frag first/later");
-			return -EOPNOTSUPP;
-		}
 
 		if (match.mask->flags & FLOW_DIS_IS_FRAGMENT) {
 			val = match.key->flags & FLOW_DIS_IS_FRAGMENT;
@@ -721,6 +717,10 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 				return -EOPNOTSUPP;
 			}
 		}
+
+		if (!flow_rule_is_supp_control_flags(FLOW_DIS_IS_FRAGMENT,
+						     match.mask->flags, extack))
+			return -EOPNOTSUPP;
 	}
 
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
-- 
2.43.0


