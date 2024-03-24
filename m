Return-Path: <linux-kernel+bounces-113926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE61889088
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B73FB2F20F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B516C1EEF05;
	Sun, 24 Mar 2024 23:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/UJPF6a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D061DF7A7;
	Sun, 24 Mar 2024 22:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321021; cv=none; b=Ck4Ykt/PiE9QseqOxP5sdGKZT15yTeHEZYzXMkCosJbsScdTkQFg/IlH/TcXeVFbgAdFMvhbeEKrYhRUvizcEW0CS/4l9+tMqrjwym/D+AdU37a/IvhqnCdrFcEXh3G/JOerloKUNuHva3m7ZfiiaocxRR/CRJZ2i6S9SUtHeYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321021; c=relaxed/simple;
	bh=DnIEbnQD9ob1MO8/v30ZkD/ZbTdidfNE4UviQRjCoEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGt+ucxNdK67tZrSm8EOk+yp/c+6gQjbN2uarrSg3dvV3ZlcGn6G/3XI3qBZVQ+T3el8afAbc+dtbeKHTCS2jNeF4EZ/XK1tgZB0u+57Jph5MHM+Rk1/7ykQvoOwuIcht1NrGDqnvOlJej1Eptd9iBngopk5Iirgz8t3WcDhKhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/UJPF6a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9712C433F1;
	Sun, 24 Mar 2024 22:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321021;
	bh=DnIEbnQD9ob1MO8/v30ZkD/ZbTdidfNE4UviQRjCoEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d/UJPF6aggbyvwY/hws/WfWqFudFI8et+5oqdmbLUeVjtiCdSJlqnZPahfzM5Zz3o
	 QItexT1TbK2ZUjIUbf/dPwMna/bhxb/I22yex5yeDbnIArq5jFgomg1k0Jv94ZCBda
	 QkGdDMVHrbjz2GtrILeBxBd2giS+GEpDgaNylU7nYGV6bbHGTvhv0ROyLr/KMpJVGe
	 lxqxJ9x+eyXpZrrWZbAa/XNPQGI4XSJQnCnFa3erB5blNv20+/6dYnuLMiBrksEsjd
	 cHAmXZgsik1Q6wt+aD8C/KUoD2Purfc2WVLvgSLeAzR5WZ9Dt0RU/gpRfC8ctZWSuA
	 SCTvfzVAEFsgw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 584/713] RDMA/rtrs-clt: Check strnlen return len in sysfs mpath_policy_store()
Date: Sun, 24 Mar 2024 18:45:10 -0400
Message-ID: <20240324224720.1345309-585-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


