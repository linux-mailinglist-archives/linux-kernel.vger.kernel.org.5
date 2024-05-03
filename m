Return-Path: <linux-kernel+bounces-167543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DED688BAB18
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F2F2812C8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211E9152518;
	Fri,  3 May 2024 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="v78ztFAp"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDCF150984;
	Fri,  3 May 2024 10:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714733735; cv=none; b=oR3ipcwj6QpIYed+1QssOCDUmec7ufTEgsZQZ+v6LoLRAUTZL/jt2V3KSYxO5SI4emFYSVkiAf2gUgxpwKdA26QYfyk7faK7vKOPvcEepmRTqRrSrVfXwBw9/0quavv6KkF0QV3r0ClXuZIbONdkTu3S9sUD7GuMhWUKgaXB6nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714733735; c=relaxed/simple;
	bh=S7EjJzKWts/3lIkCKkOS7cqWMaPmFMhdsePJ8a3+zl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jcaK4+CcJhNjKHhN0Wl+OA+9hFTbmiNS3lpWhIc1d48wj/Yat6DvEO7TB2G83NFjHiDds1OLo4BfCVdlDAeYsjybaw04w0V1oHoHxOeqm5BhathNW1pz1U4V+C/znOouPNPHZKXbUsLXvfPoZNevUpGw1CmpJ3bvzRgB4eYt2mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=v78ztFAp; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 98281600A9;
	Fri,  3 May 2024 10:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1714733723;
	bh=S7EjJzKWts/3lIkCKkOS7cqWMaPmFMhdsePJ8a3+zl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v78ztFApfZoFHIOBiMthKWcZ/M1ZLSifn8R00B1zO+p15HYJPZQRkvCzs+iRJP+wo
	 AsFPtP3mkIvHmbFVx2IkqqTWTU2cShOyl/C71tKCkMsu93pYy6CuHbJ9xTaspABX3b
	 NP0raoPpwE02tzbfCKfwp27ki27AEGu18r8Ij1i7djgpvlYhRDfGFLQ8r1l48z3cvq
	 nYRqnY5wAA1nHDE1UIIUOUQcaQz0vWzM272yk6TQ2j5Ej6JKQ/vXj8tc3JN+qDm83K
	 qobFHOiYaQTR6M3uO9yBXQIqsCh+OmKQNEywfAxthjRaMq3ArCSKnbinJTHn+pZP3Y
	 lH6hkbs9zR3vA==
Received: by x201s (Postfix, from userid 1000)
	id 0AB2A21BB72; Fri, 03 May 2024 10:55:11 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>
Subject: [PATCH net-next 2/3] net: qede: use return from qede_flow_spec_validate_unused()
Date: Fri,  3 May 2024 10:55:02 +0000
Message-ID: <20240503105505.839342-3-ast@fiberby.net>
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

When calling qede_flow_spec_validate_unused() then
the return code was only used for a non-zero check,
and then -EOPNOTSUPP was returned.

qede_flow_spec_validate_unused() can currently fail with:
* -EOPNOTSUPP

This patch changes qede_flow_spec_to_rule() to use the
actual return code from qede_flow_spec_validate_unused(),
so it's no longer assumed that all errors are -EOPNOTSUPP.

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index d5ca4bf6dba5..07af0464eb1e 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1979,10 +1979,11 @@ static int qede_flow_spec_to_rule(struct qede_dev *edev,
 	struct ethtool_rx_flow_spec_input input = {};
 	struct ethtool_rx_flow_rule *flow;
 	__be16 proto;
-	int err = 0;
+	int err;
 
-	if (qede_flow_spec_validate_unused(edev, fs))
-		return -EOPNOTSUPP;
+	err = qede_flow_spec_validate_unused(edev, fs);
+	if (err)
+		return err;
 
 	switch ((fs->flow_type & ~FLOW_EXT)) {
 	case TCP_V4_FLOW:
-- 
2.43.0


