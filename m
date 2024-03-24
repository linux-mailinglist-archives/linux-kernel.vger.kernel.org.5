Return-Path: <linux-kernel+bounces-114528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45879888B2F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59553B2FD84
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08EC22B685;
	Sun, 24 Mar 2024 23:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vs134Gea"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF1822AB8E;
	Sun, 24 Mar 2024 23:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322153; cv=none; b=hx7h1XDjpYQEYe6b3V7USmhaS13H7GKpwSt9a/NFKZurUEgpgahSgD3sVewrV+uT1gk/d43jf6okr/Eaz0Lnqc8W3nIfashhI05IBHDeqMVgL48gKg9uNrafuxOfNn46qwMR4+5T2PMELqRuw9g35N3bLA5NVsDBXKR0PnE6DsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322153; c=relaxed/simple;
	bh=CbLgNHq9wuBDvXwk6sKhAkCYE4QpPtRCb8lxBQLNJHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUNf7FJMfAccYPazURJbBlIr6mRnfVBy7nHd+YAAG48lydlEV1C21CpsjMKTSGlHA+n/uxUifHzrniiddzIN2m+OJX4C/4DHfOV4wC6RXJNoZpWxHvgWO5ypxlbg1ZMftg9PQx4HLF2PwEFtLuP7IEBFhYtgp5LE4ND/8lsr5ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vs134Gea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499F3C43399;
	Sun, 24 Mar 2024 23:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322151;
	bh=CbLgNHq9wuBDvXwk6sKhAkCYE4QpPtRCb8lxBQLNJHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vs134GeaL7PR8u+haNfq3TrQqUHXMKcYxH/5uY7UkV7DBhIAPpDQ85mkMhjYuzr8k
	 wLcAX2k6iTQAezKIBNEOqM3QYv7Bmdwmo0G2q9IWeixuUOwNtR7JfTUluXyoFAFRYv
	 3p9z96kGEA/lcEJvkQti+wnA1q/nKn2b8qIaYwOLqTFN9jThlSHL12IBCWmEvCDj3u
	 M1Swng5lZfBYD90qTjyw2KGjIoGQs2TJcdOl4IYhM7jZZRzfDxHcslA0JD2Ypl4+7c
	 aBF1y++SlaStLwScL0HfT0x2CQqjcRvvlSPVrYzeSIBJ1RCofjeZwD1/CR8KUc3iK3
	 x4Qwf9gyXKmDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 229/451] net/x25: fix incorrect parameter validation in the x25_getsockopt() function
Date: Sun, 24 Mar 2024 19:08:25 -0400
Message-ID: <20240324231207.1351418-230-sashal@kernel.org>
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

[ Upstream commit d6eb8de2015f0c24822e47356f839167ebde2945 ]

The 'len' variable can't be negative when assigned the result of
'min_t' because all 'min_t' parameters are cast to unsigned int,
and then the minimum one is chosen.

To fix the logic, check 'len' as read from 'optlen',
where the types of relevant variables are (signed) int.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/x25/af_x25.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 5c7ad301d742e..5a8b2ea56564e 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -460,12 +460,12 @@ static int x25_getsockopt(struct socket *sock, int level, int optname,
 	if (get_user(len, optlen))
 		goto out;
 
-	len = min_t(unsigned int, len, sizeof(int));
-
 	rc = -EINVAL;
 	if (len < 0)
 		goto out;
 
+	len = min_t(unsigned int, len, sizeof(int));
+
 	rc = -EFAULT;
 	if (put_user(len, optlen))
 		goto out;
-- 
2.43.0


