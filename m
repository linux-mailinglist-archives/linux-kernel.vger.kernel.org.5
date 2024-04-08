Return-Path: <linux-kernel+bounces-135425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD5B89C1CA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599E0283118
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29807823CB;
	Mon,  8 Apr 2024 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="F3Q1XRoh"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113D38174E;
	Mon,  8 Apr 2024 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582415; cv=none; b=N7iE5tGtpAs8o0UR1Qcfpz6GwXnPsfRNZ7jbxZw1lifKZZo7bqWcjprMDvKovKMl7dEUTKbhUR3OazHcRGLboDy1ePAzWAYBt7+FtQ4ODe803M3t96qL7Rd/h7kofM4FvWr0ifaQXT+TfQ8o+mwtWV8FrZ3qVu7/Rj01tsANAsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582415; c=relaxed/simple;
	bh=bA6hKYZ82VB6o6udzZS2rqCWCcIdVnx+Qp8TMbmLPiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8UAkKME1HP+PIbo7ZjvxlmajWBEoz75tBwchw9MLTehuFVGrePr4RbSlvaVPa5VnrGCeqCRx4eWmyZoylkB22/c+zRh498RWS0K1jDUBc10Yn4VWjk2SvcVM+PMU0Ov2yks3S/69j32T72syz8Q/QGjtOrIyGn9KXOiPDm+D1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=F3Q1XRoh; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 89A85600A7;
	Mon,  8 Apr 2024 13:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712581838;
	bh=bA6hKYZ82VB6o6udzZS2rqCWCcIdVnx+Qp8TMbmLPiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F3Q1XRohx6nleEyeTdL+pgh9xmCk7cMb2eOrrlZDv2oAtbGAm14p7Cm+iyDtVRA/w
	 ABiVn+gb2iVVem/6/Jf4VubV1slww0XYOKMuw5DdngbPtY4cb6+FDzg2qIWe2P9HDf
	 FDU/mfObJ92rmEENQXZtPpGLl0khylNBKUhmDVyIO9pe1um0d2btvcD5tfBtEccjk3
	 IaCP9YhdxFJ9fxbrFwwLH9bBg5u2aUpKY6m3vNziwssM5BpCNxTdg4GMICotIrKAH5
	 p4UkEyY59z2QTka6nwMpaxWGD82W+b+25jKCAVHrsjGoTEicHj1kizzRtk05pGObdX
	 FIqnEOx8KZoig==
Received: by x201s (Postfix, from userid 1000)
	id 9C4C320BDE4; Mon, 08 Apr 2024 13:09:43 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Louis Peens <louis.peens@corigine.com>,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yanguo Li <yanguo.li@corigine.com>,
	oss-drivers@corigine.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net-next 6/6] net: dsa: microchip: ksz9477: flower: validate control flags
Date: Mon,  8 Apr 2024 13:09:24 +0000
Message-ID: <20240408130927.78594-7-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240408130927.78594-1-ast@fiberby.net>
References: <20240408130927.78594-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add check for unsupported control flags.

Only compile-tested, no access to HW.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/dsa/microchip/ksz9477_tc_flower.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz9477_tc_flower.c b/drivers/net/dsa/microchip/ksz9477_tc_flower.c
index 8b2f5be667e01..4823a876ad8ab 100644
--- a/drivers/net/dsa/microchip/ksz9477_tc_flower.c
+++ b/drivers/net/dsa/microchip/ksz9477_tc_flower.c
@@ -124,6 +124,9 @@ static int ksz9477_flower_parse_key(struct ksz_device *dev, int port,
 		return -EOPNOTSUPP;
 	}
 
+	if (!flow_rule_match_no_control_flags(rule, extack))
+		return -EOPNOTSUPP;
+
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC) ||
 	    flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
 		ret = ksz9477_flower_parse_key_l2(dev, port, extack, rule,
-- 
2.43.0


