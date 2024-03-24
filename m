Return-Path: <linux-kernel+bounces-115092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2664D889306
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D420A29643A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDCB2F843D;
	Mon, 25 Mar 2024 01:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHW+FS6w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391A018131D;
	Sun, 24 Mar 2024 23:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324079; cv=none; b=W3ROHds3qi9kch64IK4A+kASq27pYfiFh/AsmQKmWACpyrqylsKd0Uv8Hw0gs6kYfwpLkD8gl5mUrmiHlMxCZQRoiYIJNY1Rym8B5j3bIBiMw3Het7c4SVcwDjvfGCR45KyOcJaCqwj0pvkquFQtSSgh7rnQ2G0QKyG1gIjF9ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324079; c=relaxed/simple;
	bh=ailGeBSfJgMzEpZuwHurgRKPqnFr2eQF5sRu0J0sxfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2oC5YQn43vTz18o98PfoLqHgDtn8WUOOGzsv+QtTSLNHqveVuzK0Rls9S6JI5Jgo0NwraQbQ/anZBrr5eN3KGpFAfw2KCaRDeCzPDtvRM4QYq2mV0qQoAC3QxWV67DfCMdlaEk4/wxe9+8WKBorkxP266WQjmDPS0YiXgmfwxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHW+FS6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BD6C433C7;
	Sun, 24 Mar 2024 23:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324078;
	bh=ailGeBSfJgMzEpZuwHurgRKPqnFr2eQF5sRu0J0sxfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DHW+FS6wEW1n7BGGcMXlFcsce8jk9rFzn/j+0u09Ov09mUbnkcuIzjtTD8Imxes3q
	 WsmU8v2ESkMCk6GYU0ratLOGOjnX2vnfEY23XxcEIJp2rZ74GqHLBkn+5og0oL9R9D
	 V8crDozKdJTxghI/rdCzfwxszeXTsGLZu6tfFjeI79c9HIinjOMqxnKnhlzFUhVrpF
	 I2TTmhEpCOSEUbdvnsdaPY+7q5Dx1wb1QZO69ySxTCyP0P7ZqjwT8LXHOm8t+fn4rY
	 fgDK4pQHhbxFWSySbgWQFr+QSDopiCCiTeA0sZM94OZAoHPVs+b++BAXh+jUFy3g6S
	 MsWJ0i6iKct6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Tom Parkin <tparkin@katalix.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 078/183] l2tp: fix incorrect parameter validation in the pppol2tp_getsockopt() function
Date: Sun, 24 Mar 2024 19:44:51 -0400
Message-ID: <20240324234638.1355609-79-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index c54cb59593ef8..7d3c782e5ab1e 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1375,11 +1375,11 @@ static int pppol2tp_getsockopt(struct socket *sock, int level, int optname,
 	if (get_user(len, optlen))
 		return -EFAULT;
 
-	len = min_t(unsigned int, len, sizeof(int));
-
 	if (len < 0)
 		return -EINVAL;
 
+	len = min_t(unsigned int, len, sizeof(int));
+
 	err = -ENOTCONN;
 	if (sk->sk_user_data == NULL)
 		goto end;
-- 
2.43.0


