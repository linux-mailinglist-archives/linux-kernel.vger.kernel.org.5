Return-Path: <linux-kernel+bounces-159762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBDC8B33A7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590281C21A09
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A73F13FD9B;
	Fri, 26 Apr 2024 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="W6B1Df0b"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040F3282EA;
	Fri, 26 Apr 2024 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122805; cv=none; b=dvq54TXGjvKWmF4dJDmH2bBf0UaZMcLkMsxy+P4FRrvggzpJuVgUJCB6GG5i+BsAGZNin7iLDQY/xbSF/xR4aY4cx50TiV11BWvdgPbj05vJPB/2JN8CcK1FVGbckkixKqqDKHegntLR7OMmWeKXljty8bH/45AhfhxWue9dEBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122805; c=relaxed/simple;
	bh=3ii8rmx58QKPD7NlzblSbXJrF9bHIa8Z3g1LxRb5V34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PSdGYMefTAkRboC5sGvj79pJRDeWFKYl2AZjr2aX8OKJuIkSJkt6tujDMet5cVABXwXQWgZMDNVOiLWBcY/8n3QOMUXOMMBElFz8SJncOML24ftDgiJDga+d3mDYFdzTFRnNw+J4jZwCeFwDR7JqDyKHR6ZY8uGN/Vq/yif0kJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=W6B1Df0b; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 58F0D600A7;
	Fri, 26 Apr 2024 09:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1714122793;
	bh=3ii8rmx58QKPD7NlzblSbXJrF9bHIa8Z3g1LxRb5V34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W6B1Df0bBRIS+HdXLLJ7mdkIpCR4Hb08D7PeltSSSKjp6ABE3HuWqO/ZvAILCJIiv
	 oSilXzgIeYw6AaRMHL3yWLsK0ZOE7K05oU3ZvcTYomSmHf8c1uLAOwovSxGFeIOWsW
	 K8i3C2CW08r2SQuCHuVdXnEcrrSiPGfnE1Mfwo2Uzk4IpQkWYqyP6qgRAlYFy3yIn2
	 J4oxlEOBIrMDVB1D8FvbzMzGNQwOB3lOl4Fj5xogP9NXKjfok1nTxRKDBHFZKP3JQ3
	 F0fOY8Z8DmRX/dJQ+DOQyDTyxe4tHuNKQgQzBxrXhBPHqT3rKtBujijTLIqF4G/RP3
	 l4jdnlQBIWnaw==
Received: by x201s (Postfix, from userid 1000)
	id E1B9821BB4A; Fri, 26 Apr 2024 09:12:28 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH net 4/4] net: qede: use return from qede_parse_actions()
Date: Fri, 26 Apr 2024 09:12:26 +0000
Message-ID: <20240426091227.78060-5-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240426091227.78060-1-ast@fiberby.net>
References: <20240426091227.78060-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When calling qede_parse_actions() then the
return code was only used for a non-zero check,
and then -EINVAL was returned.

qede_parse_actions() can currently fail with:
* -EINVAL
* -EOPNOTSUPP

This patch changes the code to use the actual
return code, not just return -EINVAL.

The blaimed commit broke the implicit assumption
that only -EINVAL would ever be returned.

Only compile tested.

Fixes: 319a1d19471e ("flow_offload: check for basic action hw stats type")
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 377d661f70f7..cb6b33a228ea 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1894,10 +1894,9 @@ int qede_add_tc_flower_fltr(struct qede_dev *edev, __be16 proto,
 	}
 
 	/* parse tc actions and get the vf_id */
-	if (qede_parse_actions(edev, &f->rule->action, f->common.extack)) {
-		rc = -EINVAL;
+	rc = qede_parse_actions(edev, &f->rule->action, f->common.extack);
+	if (rc)
 		goto unlock;
-	}
 
 	if (qede_flow_find_fltr(edev, &t)) {
 		rc = -EEXIST;
-- 
2.43.0


