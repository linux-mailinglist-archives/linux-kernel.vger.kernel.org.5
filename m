Return-Path: <linux-kernel+bounces-153633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A391E8AD0AC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55A91C214C6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772C2153BE5;
	Mon, 22 Apr 2024 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="EmWtq4BC"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C73C153BD4;
	Mon, 22 Apr 2024 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799691; cv=none; b=S+jgDTsW86SlLfNezdXoCgqokOAImp+LMpBCeFFHMbhpvnuMRkmm9PG6RVH3Zr3Xro70GjIaapafti/y7J78ajQ4L5fR6oSu83gcPWMfIP3Sbnx78siu9TeL6NyKQJU8bk6E8sdD2R/PM1rww8ChQfvKOitj5TVErQILsCw6+ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799691; c=relaxed/simple;
	bh=hQh9FuW56vkudkOGmDgSrmvY96HwoJBQhUhM8CETBGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G3n+0EoNorbRB3VUG3OPqwNd6q03SlkNPNC2uToufd1bk2UYlpg6xd/vE4mufGHEtcZRjkqj5DGwA25X/Th4foHjhwlVLxPY02gSzOSqNVyY8J+wgDDradrjlcPmx9+7H3yyQFa96q7E6fO2s+fkUWVcshxBii2KZiduuFI5LQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=EmWtq4BC; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id BF78C600C8;
	Mon, 22 Apr 2024 15:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713799688;
	bh=hQh9FuW56vkudkOGmDgSrmvY96HwoJBQhUhM8CETBGY=;
	h=From:To:Cc:Subject:Date:From;
	b=EmWtq4BCL95M1z5XhDVo5QGLbrHWa8XJWZPrPmHIY7ioV0JekFUnCn5fAoZWb0Z2J
	 FtTjlIipqnY7hA4qlK6QbmGH1Jf9YUqIBzPjtlQqrgBUTHBwCy65yhclxdgyuQUIon
	 JmqXql7VZEhasPzeJ/s0LZBe8nKLPN7Sy1Imb/lfifgCXRGMLLvTbjNtCoYdZCq7Ur
	 5BRiqFgJQjchggtTVHQ2Bwi/14jwi35HKZyh/qHFdaA1gXVg4tHGAKBj0eYSZm0vD5
	 soh0oHlKeC7/KkXAP6tYhWOo9N0IjGcRiwzlk8ly/eh1UrI6Jsf9Jk4DcXKqhICVyw
	 AzKmqK4i0Slqg==
Received: by x201s (Postfix, from userid 1000)
	id CA433207A4D; Mon, 22 Apr 2024 15:26:56 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	linux-omap@vger.kernel.org
Subject: [PATCH net-next] net: ethernet: ti: cpsw: flower: validate control flags
Date: Mon, 22 Apr 2024 15:26:55 +0000
Message-ID: <20240422152656.175627-1-ast@fiberby.net>
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
 drivers/net/ethernet/ti/cpsw_priv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw_priv.c b/drivers/net/ethernet/ti/cpsw_priv.c
index 764ed298b570..6fe4edabba44 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.c
+++ b/drivers/net/ethernet/ti/cpsw_priv.c
@@ -1404,6 +1404,9 @@ static int cpsw_qos_clsflower_add_policer(struct cpsw_priv *priv,
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


