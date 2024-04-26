Return-Path: <linux-kernel+bounces-159759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7398B33A3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21EB1F22582
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2037E13E892;
	Fri, 26 Apr 2024 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="qRE12cjV"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A07C13D2BF;
	Fri, 26 Apr 2024 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122804; cv=none; b=kLbu8ZE3IkFx1Juy54QE2jaA+A1vu4gZTxBQwDQb82RzYKQa94bWZtWCwKHUBdYOpA/l48qV3p47EM4k24CWphEcXOGPnAZxiWvoSeutV+/C8M4FcTYUlDS8N3iLTFGMvotQGY647ZGprbvUBLak6I9cGLGgOJrFm/tKIx7RNl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122804; c=relaxed/simple;
	bh=eV33PMxw0Cc21m0h+LKsBOgy4HzT4yeVL9NTNgNOzUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jiTdlSMrEAbVz27o9B7peGy3SIf5byuHWEc3y5KIpRZRrKXPp+I4cskeiz0ayBWUihBppkqu4EFyFj6mq/R+eqgDxddYzxFfApvMcxdrU43sZzTWjY2m3wa2LpzlBJuxJUTEuNtRqZ7MGudCnc7hhNc3xtoTViQDFVSc/Ys4nGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=qRE12cjV; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 4A1B2600A2;
	Fri, 26 Apr 2024 09:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1714122793;
	bh=eV33PMxw0Cc21m0h+LKsBOgy4HzT4yeVL9NTNgNOzUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qRE12cjVZ4Mcz4/uXis4EX/HjYv7KESNpmUUDkna1CHOODlCdCLzVGDlH8z8QEwM0
	 7bJxthBBffvjqhGEohwNiOVIVpVGV8+cHtN0+Q6g8YVTi82OYjFtr9UCZJkrEDkOUi
	 9kb/p0eoLm7nCE39hLCOTatwYVd3dwiw8wifA5FFIZAN06UjBcDn5QiCBur8yalR/h
	 3r5HMzEYQ+RqVp9tzGk8fD6Du65BtqZY/wNisRh3536kwqWdsGu2sdX29pGZpCXRbP
	 YmG0nsiyKSUoftwLIQZ4k1BXFxII5SV82U+9zBdm7ktmJflxmu/F4qbOK32U9m/O/0
	 F2EpjEy4KyI4A==
Received: by x201s (Postfix, from userid 1000)
	id B838721BB48; Fri, 26 Apr 2024 09:12:28 +0000 (UTC)
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
Subject: [PATCH net 3/4] net: qede: use return from qede_parse_flow_attr() for flow_spec
Date: Fri, 26 Apr 2024 09:12:25 +0000
Message-ID: <20240426091227.78060-4-ast@fiberby.net>
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

In qede_flow_spec_to_rule(), when calling
qede_parse_flow_attr() then the return code
was only used for a non-zero check, and then
-EINVAL was returned.

qede_parse_flow_attr() can currently fail with:
* -EINVAL
* -EOPNOTSUPP
* -EPROTONOSUPPORT

This patch changes the code to use the actual
return code, not just return -EINVAL.

The blaimed commit introduced qede_flow_spec_to_rule(),
and this call to qede_parse_flow_attr(), it looks
like it just duplicated how it was already used.

Only compile tested.

Fixes: 37c5d3efd7f8 ("qede: use ethtool_rx_flow_rule() to remove duplicated parser code")
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 25ef0f4258cb..377d661f70f7 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -2002,10 +2002,9 @@ static int qede_flow_spec_to_rule(struct qede_dev *edev,
 	if (IS_ERR(flow))
 		return PTR_ERR(flow);
 
-	if (qede_parse_flow_attr(edev, proto, flow->rule, t)) {
-		err = -EINVAL;
+	err = qede_parse_flow_attr(edev, proto, flow->rule, t);
+	if (err)
 		goto err_out;
-	}
 
 	/* Make sure location is valid and filter isn't already set */
 	err = qede_flow_spec_validate(edev, &flow->rule->action, t,
-- 
2.43.0


