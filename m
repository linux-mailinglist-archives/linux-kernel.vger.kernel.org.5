Return-Path: <linux-kernel+bounces-154864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F57A8AE22C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392B81F25CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1743B7D408;
	Tue, 23 Apr 2024 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="uTiOqInZ"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE0163099;
	Tue, 23 Apr 2024 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868097; cv=none; b=uxGmiRkYVKqnXEcR7Y4fAs0qx6uH8QTiIHfcpJoVlhnmDFt/YK+OfFmgXMxBQmFvQzxn73+tgTIntwwh1ShmKw7PlzCQatyrT+blcCzEiiVszGwzz0d61PrfB785Z1ZJhBPNTfA2iHAIyp/jXtv9LWOedkyNGA5k8kLTHI+GlTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868097; c=relaxed/simple;
	bh=6KXD0oeK4Ss5GHj0EJM6H4ROKzmr2ymo8levWGdF1ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RzruVgWlJxFp6FXjCTmJwDKG3SeaW+HA9IZ3xtNXoyMAMIrdybQokDtJyBFxHPo6qTQAZZc4vUXW0cyQGRuMAO0ya4vVAWNxjpfbXkUXzAlm5qxxXJ6RJeBMl3QUn8BIrmwguWxXHk2P/QdHa8Rrp2iADzNL5RZlYfkUBXYbaMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=uTiOqInZ; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 7EBF4600B1;
	Tue, 23 Apr 2024 10:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713868087;
	bh=6KXD0oeK4Ss5GHj0EJM6H4ROKzmr2ymo8levWGdF1ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uTiOqInZY5CjiGeY9wc7nv9OVyi+q3o3i/3szMxy/g2GwwdSdha8NTWXY1oVviXYX
	 Rc8/ol+2oS05mjKjZCGcrBVKz53S3TBydH17KWcVwLNvn8Ql8oUq+Jmm4Fb9qUAhqj
	 GVOzRC/mh/O+VhMIv9XFdAlKBplc/NbO1wZgg8DfTqX4oQRTFQ9w6H926cVLwJuT27
	 zAkkK3tw1fYr2dep0Sz24J5XhtLvYrka+zCsgofgqO4YpwbQ8sWLAUjdnSHDpHyNuZ
	 Oy6mBaack3mxyd0O6CJK7uZMnkGSMMoTXDDBDHApy5lA5sxolxoVzbf7HwhffINzLV
	 4D0je5lQlJZhw==
Received: by x201s (Postfix, from userid 1000)
	id 679AA216B8F; Tue, 23 Apr 2024 10:27:21 +0000 (UTC)
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
Subject: [PATCH net-next 2/2] net: lan966x: flower: check for unsupported control flags
Date: Tue, 23 Apr 2024 10:27:18 +0000
Message-ID: <20240423102720.228728-2-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423102720.228728-1-ast@fiberby.net>
References: <20240423102720.228728-1-ast@fiberby.net>
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
 drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c b/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c
index 8baec0cd8d95..43913d6204e1 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c
@@ -76,6 +76,11 @@ lan966x_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
 			goto bad_frag_out;
 	}
 
+	if (!flow_rule_is_supp_control_flags(FLOW_DIS_IS_FRAGMENT |
+					     FLOW_DIS_FIRST_FRAG,
+					     match.mask->flags, extack))
+		return -EOPNOTSUPP;
+
 	st->used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL);
 
 	return err;
-- 
2.43.0


