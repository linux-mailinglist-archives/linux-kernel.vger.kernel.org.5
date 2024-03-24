Return-Path: <linux-kernel+bounces-114389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324D3888A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638A91C284EF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C98217E0C;
	Sun, 24 Mar 2024 23:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eyj5MB3S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887221EFFD5;
	Sun, 24 Mar 2024 23:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321799; cv=none; b=a4nZl8nwSvK9bm2iInfOGa+m/btdhqHG77AF/W+FpOq/7dY77tQ6YT4hS1Z59SvXSuwEV/3kejv4VhsxlCCqi7M5VthV86D+fHxM1J+60463Ex7qjcZ3WPckrKXXpkwVFhDQLYTtWgqOhCCLBeReZ4i7OG/UjWzDibKMA3T1hOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321799; c=relaxed/simple;
	bh=DnIEbnQD9ob1MO8/v30ZkD/ZbTdidfNE4UviQRjCoEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fn/1UTHA4sM1ysu4+S6SbCRhoHaaiwH4Jermp8ya2NQXgajqLgGmydkAFu8Po1hi1oRRi3Fo1uHyjMFVYy9iZos2rvvxVQrmuHtGSUIbHivxM7QX9UVmMh6oaAk2WuZSP4qWEIzG+in2IyCLhzHqKSbcJ2GkhDVCiXAcwc6rFfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eyj5MB3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF5AC433A6;
	Sun, 24 Mar 2024 23:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321798;
	bh=DnIEbnQD9ob1MO8/v30ZkD/ZbTdidfNE4UviQRjCoEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eyj5MB3SeS4LJ+dj13A7AglyoDKpN9vcVyx46hFN6M4IHk522UGwicMXOX7EmLcAw
	 5b6kqDPBCpFMw06Qox2jgu7C7uFgnMO2hFSmwakH6WwsIRyrXRIlyw8e8pr5ISR0Oy
	 AaWCohX34W9Ci3si7SB7RI8x+8KdqpUa67MW+gURHrL3dDVSZdZzpzS0Zr0HtK82ra
	 bTaV7SDjMAuQcUJ5bW+I6jYUG8cUTtI7FPnenLyr3oofvqQtgeiaBMfkJKy6khIOpF
	 V1Fd7x4HUwVeHtLBnbkIG/2O3+AYbOLqBXu2sKEvBlHgx18nGUSEYyUT2GiWDofEDC
	 bsLXq5EY6Tryg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 526/638] RDMA/rtrs-clt: Check strnlen return len in sysfs mpath_policy_store()
Date: Sun, 24 Mar 2024 18:59:23 -0400
Message-ID: <20240324230116.1348576-527-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


