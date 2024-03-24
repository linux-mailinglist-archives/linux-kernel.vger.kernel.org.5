Return-Path: <linux-kernel+bounces-114524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB3B888ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F031F26F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5D3182F06;
	Sun, 24 Mar 2024 23:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6y0k+0u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3117115B14D;
	Sun, 24 Mar 2024 23:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322149; cv=none; b=kb1f0t29BBuvgXj4MORCb+/h9laZvGf+NJ0GczvVx29zw69r8btAgF3a+BVP5dPIpTsMa9VTS9XD8oLPLWBo0wbApegfG6mkcjZUFBDz/qD4YwwtIQFoNaGzrACaL9Wo+P6K5evv9llbraClZtKecFwtqH3NTNReIx3TY5g4a3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322149; c=relaxed/simple;
	bh=FM28f//Mzk8CaXeMxxnqF+Tg1NbVMrowH8UlXPoSelk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlosU6eT+ai8absSmrzM5ScxtVoomDWj0yoNW/+SyczZbar5ZL9PGN5FPzc0/u5FXlxcJrOgLCpDvUNq1Y0qVmUGoqAQPG9IOJ659QArXrhlzjR5dO/a8fUjSN7y1AgPI3JB/82ODXnT/32vCh9Z99lUt6eqYNdNhv6ghjpSYDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6y0k+0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB51C43399;
	Sun, 24 Mar 2024 23:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322148;
	bh=FM28f//Mzk8CaXeMxxnqF+Tg1NbVMrowH8UlXPoSelk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m6y0k+0u3/jetJP/wXSbkVHMGBFbHRjfNamGmUv9wrM6LUPm6XuAg+BeA104Gbl0g
	 oGL7fhr3fWbS6KVXt6u1lCFMQFEqoh19p2QAbM33gjkH7m2mX7Vq8XQSIOxukbbtG2
	 g2J32XHDt9fTsUSGkU/Y2ti/wO6NX0bxekyIrUMqPXkk2OoCf7p1doTv3NwCt2UzhF
	 ZZDx6nzoqhRkXBg58TGoobn6W7RfekMJmmktZ8TVbv0yiQyFw5tubpLLm15GNsscUL
	 KozPkAy1aHVeObCYQViVbciFnHi2NAKbXjjLbgn/5BrxbLB6sb5LlBxVxW0HT0OhGF
	 ejdkZrRTYh5eg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 225/451] ipmr: fix incorrect parameter validation in the ip_mroute_getsockopt() function
Date: Sun, 24 Mar 2024 19:08:21 -0400
Message-ID: <20240324231207.1351418-226-sashal@kernel.org>
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
index d5421c38c2aae..3ed9ed2bffd29 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1581,9 +1581,11 @@ int ip_mroute_getsockopt(struct sock *sk, int optname, sockptr_t optval,
 
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


