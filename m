Return-Path: <linux-kernel+bounces-116052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5B2889530
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D8D297078
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50DC2261AB;
	Mon, 25 Mar 2024 03:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjdtJ/Yq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694D027898A;
	Sun, 24 Mar 2024 23:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323448; cv=none; b=u1SmfKzyXwLE+RZL62GUbfrjBaoHRw8CUuAT9H+/vzwrzqpEmLk7f8N+pqzSH53VEAvqQLdQT4K9H8qRE6lo6wIKkEe5fpXtyWxLnzitsMwV4wH0Z+Tuv19Nk5loG9KdOBaqYxrnKME7RQZ0Zh1H5I10zU/yYOt1ABowuLSnn2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323448; c=relaxed/simple;
	bh=O1ttdYRd31tN3Bf5moUZC9unMWcanh8NkZgXi6l8KEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWOSjU5Ij0EUjXpH6y8Y+bt60Eiio0pWiwpU6JOtn2+E+qj/ZMMkpEekZpNXi0AqYE7OAvvmGtS6L4noHryy8ZlmlaxBd0HoMoMdMucQIexZ+OtGNnjQIjAJs3qUbYRFMzDY3plCXDSyq6hnL1vJYc9+YTAKJRQRavC/HxXHB9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjdtJ/Yq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BFEC433F1;
	Sun, 24 Mar 2024 23:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323448;
	bh=O1ttdYRd31tN3Bf5moUZC9unMWcanh8NkZgXi6l8KEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QjdtJ/YqoJicYxdqfENfPMgUuDE6LRw70R9HFirT+NaQz2oB36kZQ4Tx5uvgTQ8rx
	 LtMYPsPreo2/sLKIIYSMZeQ1mL+yqCheSIFoLPKr0WK2WZNmv0aUoyVXE0rGdhq+hl
	 Bq2i0n/83EedccdQmRYRDKrwjuyZt+FaKc70cNPSZtt5bxFUSszCgFquMPYwz/djRY
	 qj2B9nGbnVmoBQjUKhLcmibIY55aiQnelW/RbV2TENCUoQJmU9/1hvABnvDzxoztak
	 czmVXptA3y3kfc05tGBGIfbhFfx7S/JOrSEkM67ZPHWEWA6qLUjg7A/CkPyOG1KiXT
	 1h6EqLxQ5t5Pg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 151/317] net: kcm: fix incorrect parameter validation in the kcm_getsockopt) function
Date: Sun, 24 Mar 2024 19:32:11 -0400
Message-ID: <20240324233458.1352854-152-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>

[ Upstream commit 3ed5f415133f9b7518fbe55ba9ae9a3f5e700929 ]

The 'len' variable can't be negative when assigned the result of
'min_t' because all 'min_t' parameters are cast to unsigned int,
and then the minimum one is chosen.

To fix the logic, check 'len' as read from 'optlen',
where the types of relevant variables are (signed) int.

Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/kcm/kcmsock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 0d1ab4149553c..5457ca1909801 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1275,10 +1275,11 @@ static int kcm_getsockopt(struct socket *sock, int level, int optname,
 	if (get_user(len, optlen))
 		return -EFAULT;
 
-	len = min_t(unsigned int, len, sizeof(int));
 	if (len < 0)
 		return -EINVAL;
 
+	len = min_t(unsigned int, len, sizeof(int));
+
 	switch (optname) {
 	case KCM_RECV_DISABLE:
 		val = kcm->rx_disabled;
-- 
2.43.0


