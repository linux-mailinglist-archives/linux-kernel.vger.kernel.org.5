Return-Path: <linux-kernel+bounces-153631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 738B08AD09E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EAA528609D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8A915381A;
	Mon, 22 Apr 2024 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="LzIvlSLN"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8A4153815;
	Mon, 22 Apr 2024 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799685; cv=none; b=NvgZVR15j2gOBAxugph7HJ875e0rALvrf5QP2M9fXzshTNPpqC5KKGmDUXdM9LWcCxy/ErxIqG2gzca5Fg40ZjkJztrs7QrOdYH1usFyMFO63yCDNwwd6MmUlhqFkgDJ7nJ0uGNk23rZJ85gNU+I/CRjZ65tTWUZIm+iFCU9VAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799685; c=relaxed/simple;
	bh=Yxwk2rzoT3ceJNHFybYzVsfwPWlLFknDIb0RH9YnCdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C4YxJh1WlO03urYaWaTPYkz5Yncvzao95M5GbDDcG/quI/BWWRtVuCxBRl1EUhoY00b9FJvqZXsxuUwMOXL20BwMuzOVjrsjNwcBP6wh3qDWudVePW3P1MM8Rwx6hF73KAk8ijJNuOKjiiJvemkrF+s7gkMSfAlGq7+0Zcqn8RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=LzIvlSLN; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 892C4600B1;
	Mon, 22 Apr 2024 15:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713799681;
	bh=Yxwk2rzoT3ceJNHFybYzVsfwPWlLFknDIb0RH9YnCdc=;
	h=From:To:Cc:Subject:Date:From;
	b=LzIvlSLNdhL7UaTTqaNKdMdwqcvrycqIIaXmFSf6Jl+5mZwEeE5+zWtwkWUk1xjAl
	 h+DYBKWK8H+aQjdJ6+gyHKgj9xCEGpjojPCv/xeXYW2C7Wvj+BuGVJo6A2mgnbslpe
	 2DvtBglRRAG+YuKOxfnONWbX1omtlu/NMo0W+CZ+CG5rsY8nMBHhYm3GP1byFbTE9d
	 gXgKG8Z2uIRVqUcEZo3HrEJrP4dfnhHR4KZS72rEXZa4IVYn51MoKc3SM+UwXgitSe
	 ck7tQcHypfOZFy0iZ/QB7Gw9JC15L48EMgnXOXi2WbDdIHFaU4MmuK5IktfObLCjym
	 r5VuhdaQZl7xQ==
Received: by x201s (Postfix, from userid 1000)
	id 81A89206FD8; Mon, 22 Apr 2024 15:26:49 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH net-next] net: ethernet: ti: am65-cpsw: flower: validate control flags
Date: Mon, 22 Apr 2024 15:26:42 +0000
Message-ID: <20240422152643.175592-1-ast@fiberby.net>
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
 drivers/net/ethernet/ti/am65-cpsw-qos.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
index 816e73a3d6e4..16f192a5b160 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
@@ -1008,6 +1008,9 @@ static int am65_cpsw_qos_clsflower_add_policer(struct am65_cpsw_port *port,
 		return -EOPNOTSUPP;
 	}
 
+	if (flow_rule_match_has_control_flags(rule, extack))
+		return -EOPNOTSUPP;
+
 	if (!flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
 		NL_SET_ERR_MSG_MOD(extack, "Not matching on eth address");
 		return -EOPNOTSUPP;
-- 
2.43.0


