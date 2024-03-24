Return-Path: <linux-kernel+bounces-115978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0908898FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA321F34954
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F592695EF;
	Mon, 25 Mar 2024 03:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+eF0dKF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAFC234530;
	Sun, 24 Mar 2024 23:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322284; cv=none; b=YQChpZXKtIYix8fawVP5iAb4So4MEEuC+SSzFFDUEpvylPp/UjrmpwcUQHlByFfvvwbnDjj+yhvlXZMVThbTnIixJF8cjyCXQ/WBPFc6kJjGEsGTr5U1QBBdyEM7aTyNOFqsFt9wTJ/Eam3Imp7ZiX361zl+Q7EikOr7UTEHe2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322284; c=relaxed/simple;
	bh=DnIEbnQD9ob1MO8/v30ZkD/ZbTdidfNE4UviQRjCoEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8eiC7FPS3vpFssZF9Q0+y169OxWUboDIYM7rWijOiV8JGX6emJSQrnp6dD2G6WEOZzgK08uSkq+eerxLZlygAalY7b1C+GKI1AF78vGYrdQxQr0tRDO8SmP6CoIEbtEt7IfCc2LnN/4rGBPn/tYts6sA+0GSR44U76Bv0qw/Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+eF0dKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F173C43394;
	Sun, 24 Mar 2024 23:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322284;
	bh=DnIEbnQD9ob1MO8/v30ZkD/ZbTdidfNE4UviQRjCoEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h+eF0dKFvdC9b1LdumtKmc9LR2ZSBink7sC32jgmQ+u4cXcck3zNlr26G58vmG557
	 6EhQcGw2+FvO5hgdyqhD+qz/3B22Gz+v4sFyt+L+P/w3BpxFnlKgqQ8TNXpLbKO+6S
	 rooB8c/BdpVwqtGvOwHRnmBcKSte+44mQKQXKGX49s6npUsPem+I/48Y2exFkuXs3f
	 TOGSNuh8u/pKnS+mOSuQulw4Y1jRHhbCzUgMcjgq2auZ6mSeF3gwq50giZZHsvR39A
	 D3WvkeZRz2aI3UB2Anhsbqj2OU70Ps1p6UuuAxRKj0u5NYD2lYONPoKB3LWDBRoKg8
	 dpRJjx4O5Nrog==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 367/451] RDMA/rtrs-clt: Check strnlen return len in sysfs mpath_policy_store()
Date: Sun, 24 Mar 2024 19:10:43 -0400
Message-ID: <20240324231207.1351418-368-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>

[ Upstream commit 7a7b7f575a25aa68ee934ee8107294487efcb3fe ]

strnlen() may return 0 (e.g. for "\0\n" string), it's better to
check the result of strnlen() before using 'len - 1' expression
for the 'buf' array index.

Detected using the static analysis tool - Svace.

Fixes: dc3b66a0ce70 ("RDMA/rtrs-clt: Add a minimum latency multipath policy")
Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Link: https://lore.kernel.org/r/20240221113204.147478-1-aleksei.kodanev@bell-sw.com
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
index d3c436ead6946..4aa80c9388f05 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -133,7 +133,7 @@ static ssize_t mpath_policy_store(struct device *dev,
 
 	/* distinguish "mi" and "min-latency" with length */
 	len = strnlen(buf, NAME_MAX);
-	if (buf[len - 1] == '\n')
+	if (len && buf[len - 1] == '\n')
 		len--;
 
 	if (!strncasecmp(buf, "round-robin", 11) ||
-- 
2.43.0


