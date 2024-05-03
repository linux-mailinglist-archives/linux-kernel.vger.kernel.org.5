Return-Path: <linux-kernel+bounces-167544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE8D8BAB19
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466B428159C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59844152788;
	Fri,  3 May 2024 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="i7WG1q8D"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD3514A4E9;
	Fri,  3 May 2024 10:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714733735; cv=none; b=rX8e1XQ4itGkPbnaz7W7SU4MsMDse8doUSIUz5/DxcSQczV8LiQamYdXYnieCpuh1Z0bkBXajV3xrHuNzAyCk+voYIX2RYMKtmlNRSFMo6gd//9/kHAaJTXIn0gOFYe0XC0LvXBBCKOwXZTU2+pCFf+vF70PB2kmMpJqK8LLgNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714733735; c=relaxed/simple;
	bh=M3HQs9C2Rd0Wt95wYa+Q8dqxkvEUKVv2uyT/x8WU/7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ttn79z0Cnqm6g0qZWKdJJ0n7TaenuNKi+FmjA2tpAa6HafYm9ddaSpJWqucs2yMCvUX4xVcvbJkYm/9zlmRDarScKsnXM838ZemSqniN6FDWfBPqRvHQyoa7hV3vpFgMvqdlS/t8Ubtvb051xz0nlJdRd9pW2meWLPHZFQGZDzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=i7WG1q8D; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 90545600A5;
	Fri,  3 May 2024 10:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1714733723;
	bh=M3HQs9C2Rd0Wt95wYa+Q8dqxkvEUKVv2uyT/x8WU/7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i7WG1q8D9sBq5kFC5O8t04v5P2LMKgg0Xh3jz7cSoTls24QS3pnV1IHoNYmDbX0Br
	 yhAlhrU1tp856DC37dMBjU9nnSFNF35I29dnk5WecqHwyHCj2DKTbJs98NenHQl1dO
	 K0eugXx7qZjR3tJwRMYAHk/gRWEL+oWy48K00TGzZ8wNDlBybGsQd6AkhPQXSBOnu4
	 tirkQ9dxZCTg0K6186P16Hl5TtgGmcB7s79GSRqj9AwHn05eAukikmsSx9MSJk1Y9f
	 cg+WBjYxx5ErfHLcm2OZK1QAb1EiW/+SiBTWwZkitX43/umMt5QuKsA88P70vM36FM
	 dQNPXW5NF11Gw==
Received: by x201s (Postfix, from userid 1000)
	id 012F121BB70; Fri, 03 May 2024 10:55:06 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>
Subject: [PATCH net-next 1/3] net: qede: use return from qede_parse_actions() for flow_spec
Date: Fri,  3 May 2024 10:55:01 +0000
Message-ID: <20240503105505.839342-2-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240503105505.839342-1-ast@fiberby.net>
References: <20240503105505.839342-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In qede_flow_spec_to_rule(), when calling
qede_parse_actions() then the return code
was only used for a non-zero check, and then
-EINVAL was returned.

qede_parse_actions() can currently fail with:
* -EINVAL
* -EOPNOTSUPP

Commit 319a1d19471e ("flow_offload: check for
basic action hw stats type") broke the implicit
assumption that it could only fail with -EINVAL,
by changing it to return -EOPNOTSUPP, when hardware
stats are requested.

However AFAICT it's not possible to trigger
qede_parse_actions() to return -EOPNOTSUPP, when
called from qede_flow_spec_to_rule(), as hardware
stats can't be requested by ethtool_rx_flow_rule_create().

This patch changes qede_flow_spec_to_rule() to use
the actual return code from qede_parse_actions(),
so it's no longer assumed that all errors are -EINVAL.

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index cb6b33a228ea..d5ca4bf6dba5 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1943,6 +1943,8 @@ static int qede_flow_spec_validate(struct qede_dev *edev,
 				   struct qede_arfs_tuple *t,
 				   __u32 location)
 {
+	int err;
+
 	if (location >= QEDE_RFS_MAX_FLTR) {
 		DP_INFO(edev, "Location out-of-bounds\n");
 		return -EINVAL;
@@ -1963,8 +1965,9 @@ static int qede_flow_spec_validate(struct qede_dev *edev,
 		return -EINVAL;
 	}
 
-	if (qede_parse_actions(edev, flow_action, NULL))
-		return -EINVAL;
+	err = qede_parse_actions(edev, flow_action, NULL);
+	if (err)
+		return err;
 
 	return 0;
 }
-- 
2.43.0


