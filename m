Return-Path: <linux-kernel+bounces-115677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8B3889701
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8281C1F35E84
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9486258A22;
	Mon, 25 Mar 2024 02:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6bhHc8N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9C620AF81;
	Sun, 24 Mar 2024 23:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321605; cv=none; b=qOp3+xqA7jYxN1LbcfQVb6cUPIUT8WNMEyh7NoSnOQ92geW2XGtmf5UVOfAutCUzIyWKhNmQw3mWiky+Oah8qRu75az9Fjij3QEcH6HpETW0haU2Rd1Ibm42Gxa2ujcGSfsZC1awzKvKEojdvfT/wCu01zAIDaQm5lOriEtn+bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321605; c=relaxed/simple;
	bh=FkpSNpSlpycCmcF3vPsdKNwVZjnMaXFcSIOgP4WTv0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6zCS2w1nnmnXArP3DPlWScbJwvPnAUYtvWOtCGiHVxzuOeXL7nmsqNjxL4PpXX7P/n+3EXslL7XVDF8YfYCODFxdal1QQwer1bXrclVaWOxfO2/kd6N7ycxL6cAo1+xjtyLPsBxIkjlHlU24U4dMmX7KOfclR5vnRI8IxbcX4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6bhHc8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EBEC43390;
	Sun, 24 Mar 2024 23:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321604;
	bh=FkpSNpSlpycCmcF3vPsdKNwVZjnMaXFcSIOgP4WTv0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s6bhHc8Nn2SqCdU6xrxsuFam/oEXQcZrPqpIGCGIKOVzjIGs+9Ek02clvp44p8iTS
	 hcGi4oUkPBPPdgAcZuGWdihvsyYjMg3J1E/V9iK3bAb+KpgmrTW9t8guKeBtxaJaJG
	 RmsZNdlsmV1zb5hCC0CydaqpZGZ87NXM5eWvGV3rgtlu4KXSElgGCmB762iG4dlR5n
	 Ak6ZG/f5vcACJy7YYXga2/gNHdst18YDRBsoAcUqkTM6lAAd9cpEaCPQ12a0G8NXsU
	 3Xvp54KjvycdbFcFnbHfnQfYPWYYJ4RiarWJ1YAZ6Diyq8cf5ayUiD/1YUlctuOEEQ
	 JY7NLKC0sRpMw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 334/638] ipmr: fix incorrect parameter validation in the ip_mroute_getsockopt() function
Date: Sun, 24 Mar 2024 18:56:11 -0400
Message-ID: <20240324230116.1348576-335-sashal@kernel.org>
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

From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>

[ Upstream commit 5c3be3e0eb44b7f978bb6cbb20ad956adb93f736 ]

The 'olr' variable can't be negative when assigned the result of
'min_t' because all 'min_t' parameters are cast to unsigned int,
and then the minimum one is chosen.

To fix the logic, check 'olr' as read from 'optlen',
where the types of relevant variables are (signed) int.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ipmr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index e49242706b5f5..66eade3fb629f 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1603,9 +1603,11 @@ int ip_mroute_getsockopt(struct sock *sk, int optname, sockptr_t optval,
 
 	if (copy_from_sockptr(&olr, optlen, sizeof(int)))
 		return -EFAULT;
-	olr = min_t(unsigned int, olr, sizeof(int));
 	if (olr < 0)
 		return -EINVAL;
+
+	olr = min_t(unsigned int, olr, sizeof(int));
+
 	if (copy_to_sockptr(optlen, &olr, sizeof(int)))
 		return -EFAULT;
 	if (copy_to_sockptr(optval, &val, olr))
-- 
2.43.0


