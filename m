Return-Path: <linux-kernel+bounces-114522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D4B888AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229C328B497
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE8D182EF3;
	Sun, 24 Mar 2024 23:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ub99mFR9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A503915B142;
	Sun, 24 Mar 2024 23:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322148; cv=none; b=fJKM9/h8zJmlHiK75CYVtQn1C6RxHFKYTz+eQcGCxc/7pvDM2ommMJWWFdneCa+rLj0bwF//8ay0sZq7yv75fe4bywKuvFb4Mka4gQ/KRksO91XgBL7s1LOmIrAZZVXrS1C6ITq8Ua7BWfUKuIIwpUOeRYIRSvfaPr6+Bb4ZRAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322148; c=relaxed/simple;
	bh=iBFdlvoaK/4k9N28EWGDTW5mTR6JAbLH0cIeNaIIj3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJhX+mBHOHLDaxCx8Zqut8uLKFltUsf419BtqXnMYz4+o9CRq00TlKFZja3z2cHqGjuZ2Ai1/bAtHdXX53KZcSRV1K10WczZkp3J5XC+qX9UiOaQNCJRt+zDXAu5GoZXdyCKPxFlnOBUNFe8t9KGfFO7daUJFgX/O+WmTxaa7Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ub99mFR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F963C433F1;
	Sun, 24 Mar 2024 23:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322147;
	bh=iBFdlvoaK/4k9N28EWGDTW5mTR6JAbLH0cIeNaIIj3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ub99mFR9VMz+tpvPUb82F4E9AQDplG2QLQrpL39fRJRYM8lcaXkN1oaZFfovNo4US
	 tlWnEuGvmgdYVjKbOnrHHvmWvC/+0VR2XghU22UDaPbQD5CJZ4QtLvmhUELdG3Nadu
	 PVPSZrV+o70Jdj2Y5iaabtgvSSm/kbPBuEIVBxcifaHUldzurvzEsmu46VQ/kwBTof
	 GO6DmjL54DMMJUBymBwqS2oyvN5P9EGbPTevCLCRxPRJCkLWiKxziXygCHsr4nbm0i
	 rN9u+7JsJyGLW0AfUf1mw/2Y0T+QlPZ6xbOLBAgNf0iCMvkHaBbZYEUchHoyhJ3LEG
	 me2jcXZJMRYGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Jason Xing <kerneljasonxing@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 224/451] tcp: fix incorrect parameter validation in the do_tcp_getsockopt() function
Date: Sun, 24 Mar 2024 19:08:20 -0400
Message-ID: <20240324231207.1351418-225-sashal@kernel.org>
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

[ Upstream commit 716edc9706deb3bb2ff56e2eeb83559cea8f22db ]

The 'len' variable can't be negative when assigned the result of
'min_t' because all 'min_t' parameters are cast to unsigned int,
and then the minimum one is chosen.

To fix the logic, check 'len' as read from 'optlen',
where the types of relevant variables are (signed) int.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 86e7695d91adf..5a165e29f7be4 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4102,11 +4102,11 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 	if (copy_from_sockptr(&len, optlen, sizeof(int)))
 		return -EFAULT;
 
-	len = min_t(unsigned int, len, sizeof(int));
-
 	if (len < 0)
 		return -EINVAL;
 
+	len = min_t(unsigned int, len, sizeof(int));
+
 	switch (optname) {
 	case TCP_MAXSEG:
 		val = tp->mss_cache;
-- 
2.43.0


