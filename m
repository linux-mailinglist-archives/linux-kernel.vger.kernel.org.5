Return-Path: <linux-kernel+bounces-114825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F097688918F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907331F2D8CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3622C14DF;
	Mon, 25 Mar 2024 00:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZD8w+aw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815ED278980;
	Sun, 24 Mar 2024 23:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323448; cv=none; b=lxt3oYwLATI+VqL/Ty30ZUe1W61O0ki60k2B57JIjcZ07Rd/e9xveT13of5Cme2b+xiLYQ+hMkQ8bVJrW94EoIzdum2qsCaFYqPQnve7uHU+DEcKHDKv/W8iJezWuWDj4g/AP2y9se/ISwK0ilnR/+RUM7MhO45JaNyJyMSaY/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323448; c=relaxed/simple;
	bh=wUqvi6MCxNDoX/IRXsB3IsgmfWpXe5W73W19ynJlO4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSYqKE9amrS9IDBPbDfZG+cfvKP1pi2KyZYIchuo5YzTuqW9SYt9VRSxfNQMlgVzs3FrjfrD/Phm2q7xuEfjejSbMBnhbfrBBXJ1cIfNyLvwOIwcJdA6lvF3y6ojyeLalrjWUytdbPrRTIvCbID45Gv1G3aCZbajxEEpCMGFM9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZD8w+aw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7672C433A6;
	Sun, 24 Mar 2024 23:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323447;
	bh=wUqvi6MCxNDoX/IRXsB3IsgmfWpXe5W73W19ynJlO4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mZD8w+aw3EKleGKA1GhUCoNWA77HnPJok10XE5zgFk9sJTjGj/VS7t6pTYRXEPw/o
	 ZJzbsZSrP/DHv83ja+Chxn3XGfKXyyBQ+f6N0xVdrbS+C9I/SohmznFTex7LYNAitP
	 hm2Zh+jz5r2RRvFASToq7HMZJgLsJqhk11VD71td6b34SZlIxO5hnKASfJZD2cPZDZ
	 yD1VunvowQdlKSqr67/0697mN+7BY9RWn+vz5nG6EQPYxj7LPmFrPvrkHlVFLri0U/
	 H6fl3wL0a2DVbi7U/hdToqb6wVZrchvV+hJqNRmZ8OGW+9WDgDJUrP7aZGmsxe2nKt
	 SSuVqRpXwW0Rw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 150/317] udp: fix incorrect parameter validation in the udp_lib_getsockopt() function
Date: Sun, 24 Mar 2024 19:32:10 -0400
Message-ID: <20240324233458.1352854-151-sashal@kernel.org>
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

[ Upstream commit 4bb3ba7b74fceec6f558745b25a43c6521cf5506 ]

The 'len' variable can't be negative when assigned the result of
'min_t' because all 'min_t' parameters are cast to unsigned int,
and then the minimum one is chosen.

To fix the logic, check 'len' as read from 'optlen',
where the types of relevant variables are (signed) int.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/udp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c454daa78a2f8..2caf54c241037 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2814,11 +2814,11 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 	if (get_user(len, optlen))
 		return -EFAULT;
 
-	len = min_t(unsigned int, len, sizeof(int));
-
 	if (len < 0)
 		return -EINVAL;
 
+	len = min_t(unsigned int, len, sizeof(int));
+
 	switch (optname) {
 	case UDP_CORK:
 		val = READ_ONCE(up->corkflag);
-- 
2.43.0


