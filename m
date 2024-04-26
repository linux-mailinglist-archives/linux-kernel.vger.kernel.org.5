Return-Path: <linux-kernel+bounces-159761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE238B33A6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FFD71C21C67
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8333113F429;
	Fri, 26 Apr 2024 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="IQwbG6Dj"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0417813D299;
	Fri, 26 Apr 2024 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122804; cv=none; b=bS6L1oCD9t/JnGYhxSSyiNAZUSr0eK4pJeha2xtwPIhRBoj97dD+en6v/SAuk59EgnLsvh0FAaBIBnQ4BUYGpea+z6OxkIY8xl4FEe5/FgcIeNqk4FybIjljJdpgDPZQHpf7fhBER/yge4ghCnmUNjYS5IaPuuUgqdbbFjKI/9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122804; c=relaxed/simple;
	bh=0ToFWkE+BIdond+WXbqiMqObFzawzXIHgGpNFXxnRjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugcc8EJnvF4sDM1j6pe98njmquOtWHOwad/97ZS/6hjmHZRIK5YNbBfLQm3vSxtmSTzoX8Iyi+tn7Iyw7zWHNTKW7tKAOFrv/EjY1ofUh1Bufexm6b+cWnQ9iN4X5oAJtyPd0XnGutcqfdL2h9mMQ/RvNSRvjJ0oHOtBAIXvhlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=IQwbG6Dj; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 569A4600A5;
	Fri, 26 Apr 2024 09:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1714122793;
	bh=0ToFWkE+BIdond+WXbqiMqObFzawzXIHgGpNFXxnRjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IQwbG6DjpVmZC92m8hszY4nji7ACLonfAcYNsms82yiN45LKnaOHDM6Rsxp+3VwH+
	 G3Gm4MR9JI0J4r5VwOH8bfYQL2SPZZIrgcRQgZ4/hpkQLtnMj6q1KF1CByNOLc/TKo
	 f8UU+v34HHFy9zeLMrgItwxBKvI7kdRk3iJmCBHrG2IpgZCZdGItdpOoEtY+9yfNCu
	 3Agn1PcYdwNfFdeRGgGwGBy3UK2lkxx3Hn7hrLJGPTHJ56nuJHtdcZV2lh0U7+tFKi
	 NIDOkMnUacpLO/MZoqjrYtz56DgsjEH5x1B2NU/pYlWMHWm3WzDzHrljVQxNHhO6hx
	 sCcis7GLIWlNw==
Received: by x201s (Postfix, from userid 1000)
	id 955F521BB46; Fri, 26 Apr 2024 09:12:28 +0000 (UTC)
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
Subject: [PATCH net 2/4] net: qede: use return from qede_parse_flow_attr() for flower
Date: Fri, 26 Apr 2024 09:12:24 +0000
Message-ID: <20240426091227.78060-3-ast@fiberby.net>
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

In qede_add_tc_flower_fltr(), when calling
qede_parse_flow_attr() then the return code
was only used for a non-zero check, and then
-EINVAL was returned.

qede_parse_flow_attr() can currently fail with:
* -EINVAL
* -EOPNOTSUPP
* -EPROTONOSUPPORT

This patch changes the code to use the actual
return code, not just return -EINVAL.

The blaimed commit introduced these functions.

Only compile tested.

Fixes: 2ce9c93eaca6 ("qede: Ingress tc flower offload (drop action) support.")
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 8ecdfa36a685..25ef0f4258cb 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1879,10 +1879,9 @@ int qede_add_tc_flower_fltr(struct qede_dev *edev, __be16 proto,
 	}
 
 	/* parse flower attribute and prepare filter */
-	if (qede_parse_flow_attr(edev, proto, f->rule, &t)) {
-		rc = -EINVAL;
+	rc = qede_parse_flow_attr(edev, proto, f->rule, &t);
+	if (rc)
 		goto unlock;
-	}
 
 	/* Validate profile mode and number of filters */
 	if ((edev->arfs->filter_count && edev->arfs->mode != t.mode) ||
-- 
2.43.0


