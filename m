Return-Path: <linux-kernel+bounces-113463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 503B6888489
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B585289330
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A14F1B1FE9;
	Sun, 24 Mar 2024 22:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLgKwcuT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887771B1FCE;
	Sun, 24 Mar 2024 22:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320264; cv=none; b=gIRJChwOOFechH5CeBxtkjBUAlJMsQyCG+taVy6UoooLQbIn2beo5GVefJTPdgweSSwGLtcleBSvTp40h37GxyxZTvMjsRiLCJkESPz6qzOk6qDJTpo6asxWv+9hJOZ0vnNJz0mk+a/oglnydXwRJKK1PQWfKWeRjBW8kDlyCyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320264; c=relaxed/simple;
	bh=DnIEbnQD9ob1MO8/v30ZkD/ZbTdidfNE4UviQRjCoEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIQWBE1iM1bv1qtkHFSnL2Q8cWiHU8o8dtZRZzi8asVeHgWCxQBB2t/4cvAud7/x73TnQJPEwTCUTPt9MFUCwnrLxHELdG+mY1/r38WQBTNYq2HUfBT3pkE9Xq7vKcCC0tdaUSSrkQxqT70ZoJD2zmYdIj2aFo0WolyCRA8c9yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLgKwcuT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BD9C43399;
	Sun, 24 Mar 2024 22:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320264;
	bh=DnIEbnQD9ob1MO8/v30ZkD/ZbTdidfNE4UviQRjCoEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YLgKwcuTyyrMaJrtxanZhjBBSwdxx4vHWL+DIF+GTAkT0Kwt1bLbEZ3Wo99IjBM+c
	 kkK3pGDFzxxoUOCjITuu0V5SvFxHNMXycMSQmR9MbOnRlBLnnOcZyXPSnjpX1rH5RO
	 YqTUpD4UpDa9xgN8VUgohdpd+JOXoLEoRkiwHTL0CZ074XCzb5jKb0ih3TQgh2kRho
	 IvGb5/+FVGbsxnEAheiAApgGZG6A0Sn4YsukBbbiGMKnaZTaM2YQa2ngfzxjLexG9l
	 RVsK3rI9GbIKvi+EglVNT/QXQOdq0DH/psBHGm7uNt6VWZZd3HDQw0ZAEyv4pbbI9X
	 8TSPrL0KY7C2g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 572/715] RDMA/rtrs-clt: Check strnlen return len in sysfs mpath_policy_store()
Date: Sun, 24 Mar 2024 18:32:31 -0400
Message-ID: <20240324223455.1342824-573-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


