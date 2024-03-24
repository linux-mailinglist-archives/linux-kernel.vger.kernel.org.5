Return-Path: <linux-kernel+bounces-116051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E2E889583
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59F21F30B88
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B02A157A55;
	Mon, 25 Mar 2024 03:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mk6rssw5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822811769E6;
	Sun, 24 Mar 2024 23:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323446; cv=none; b=uKvpcdAf7WOBc0mPrp+9YnFx0VpcdJUcIVCmbqLVbhPLbM8S3WQ5/2t7tjeLAvBHZqA+zLWDEqLNNvC2bN9Yh+qspoog+sjDEO0wn6cxsqX3+wdDSLpBtMLvKhEDjjxC8Kx+oDCxyZyD6LPFlssk5BOQpkQPTlx9TtsH7zX3uno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323446; c=relaxed/simple;
	bh=wkw81QTNMZE7CcCiJK6eFwijCpAGFyOZ4hyjY259Npg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3E9q8IYBf4wBDRP4Bqe/CE59NubOgVfXwem/mbvZtxQg/n4r7rLJJNyIZyxzBn6rkyYMqhlRhxEyxAX4AWFpBGuePePyNAhoagzgFi3mFwVJQpoSAcsY5FBZwg12iBbbjN0shOhrsGfguAJPpka++a7xMPjfnnBnGs40TodfsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mk6rssw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBF1C43394;
	Sun, 24 Mar 2024 23:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323446;
	bh=wkw81QTNMZE7CcCiJK6eFwijCpAGFyOZ4hyjY259Npg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mk6rssw5V8iVlyh3n4xmSm7hR0MkB7UN4AxSXQJJI/N1mcrHC7rrJowMzXeKqWxyN
	 br4Mw58RXgSAs4rCN4zbxyDIepb6M1uZfN062U15eos5T6pOkf64Yz+nUUifuJWMUs
	 l3jWeb0jMCFlrP6qns6peSM+Xomv5/YFG35rmfHXa9xT7U1hWOu+XeabLJLngIj6Bz
	 RcyTazodIJE9hmWPFIM9vLANykNaPwsMQxWJNnKPtGyuFBEb9uPoXKZAh6aAQy15rL
	 LKc1/vVeNC9SRbLrbuQdtaea3rhZDEN9e9vLZSFiJykVdkwj7Wxsq2yS4a3vCngSt7
	 1tMMAf9444vlw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Tom Parkin <tparkin@katalix.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 149/317] l2tp: fix incorrect parameter validation in the pppol2tp_getsockopt() function
Date: Sun, 24 Mar 2024 19:32:09 -0400
Message-ID: <20240324233458.1352854-150-sashal@kernel.org>
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

[ Upstream commit 955e9876ba4ee26eeaab1b13517f5b2c88e73d55 ]

The 'len' variable can't be negative when assigned the result of
'min_t' because all 'min_t' parameters are cast to unsigned int,
and then the minimum one is chosen.

To fix the logic, check 'len' as read from 'optlen',
where the types of relevant variables are (signed) int.

Fixes: 3557baabf280 ("[L2TP]: PPP over L2TP driver core")
Reviewed-by: Tom Parkin <tparkin@katalix.com>
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/l2tp/l2tp_ppp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 9cef8e080f644..55de42b000d8a 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1357,11 +1357,11 @@ static int pppol2tp_getsockopt(struct socket *sock, int level, int optname,
 	if (get_user(len, optlen))
 		return -EFAULT;
 
-	len = min_t(unsigned int, len, sizeof(int));
-
 	if (len < 0)
 		return -EINVAL;
 
+	len = min_t(unsigned int, len, sizeof(int));
+
 	err = -ENOTCONN;
 	if (!sk->sk_user_data)
 		goto end;
-- 
2.43.0


