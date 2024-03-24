Return-Path: <linux-kernel+bounces-114889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE20F88927C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7DC1C2E3D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FD21BCFB8;
	Mon, 25 Mar 2024 00:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hABzEwcd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1321788AB;
	Sun, 24 Mar 2024 23:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323559; cv=none; b=PhKt97dOVfig1OLvzlZEvm1pz+BbTnGJKEMqzjz+uz3itZlc6eQ7u7Ie3FoLLXQlIeHXQ3RqiK65ZVWhioTVt9qnCOQKfnBQVLU3VJ3U+jlpAW8nF1sQwU4Gn0e/wypFGgs39SwJ09chGjM89W9RWs0oeH/nSuJzH1qHwoj92s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323559; c=relaxed/simple;
	bh=n/DivqH/I9rjaV+4WoG2fZKBc8VxgNOqomA49mhUcIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qf+DAMKrzbAIFlQx6nDYD+uVebljDz3IHIEK7TWrBvxolxCBvH7BZ3T9W1kO6gny041ZGvurGrR6wmORTkxBt1g25n6/xBAcDTTEHdqRrgjMAY7Knsyf3VXpxnqw+XI0AIzaF0CG2rHbYmtv/wlJ+KsfzSTQVjEuFQ3H+hLhOTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hABzEwcd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EB7C433A6;
	Sun, 24 Mar 2024 23:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323558;
	bh=n/DivqH/I9rjaV+4WoG2fZKBc8VxgNOqomA49mhUcIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hABzEwcdZRDKoFCT7+2btDOnZMg4I9B++qAUjad/M1W5bhW1skCC+pID4r4l7CU3p
	 q9RAoMULOeK4Tzs0C8JcgAxzHB67FAp6dpce+jhoyeMl9nOAe5my3sRduBrtG5MtkF
	 wAfSnekSpVEsHxkO0f2IG1ubUPdl5VR+EegEXW9A6VdAjRgWBF1xOFy2x0kDVn4ZLc
	 fOHFagdrYsxMf1upwzJSGar6NG5aLDVczsMJxjgxbtdOQFQhoqk1ES6cSzyKqdPpd2
	 Y5ZOlP7CkU3L+9P2UDv2jDnjt86Ez+jzOrbvUtXEUJBc/pdHm2nB33PJ02rstb8lJf
	 iAiX/vBS355IQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 265/317] RDMA/rtrs-clt: Check strnlen return len in sysfs mpath_policy_store()
Date: Sun, 24 Mar 2024 19:34:05 -0400
Message-ID: <20240324233458.1352854-266-sashal@kernel.org>
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
index dbf9a778c3bd7..583c38eb04326 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -131,7 +131,7 @@ static ssize_t mpath_policy_store(struct device *dev,
 
 	/* distinguish "mi" and "min-latency" with length */
 	len = strnlen(buf, NAME_MAX);
-	if (buf[len - 1] == '\n')
+	if (len && buf[len - 1] == '\n')
 		len--;
 
 	if (!strncasecmp(buf, "round-robin", 11) ||
-- 
2.43.0


