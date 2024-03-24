Return-Path: <linux-kernel+bounces-115204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 354DA888DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668F11C2AAB4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE9A1CADDF;
	Mon, 25 Mar 2024 01:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxFjuEF1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C324A294483;
	Sun, 24 Mar 2024 23:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324281; cv=none; b=KDyPowbw8ix1lQknDczHYjGlq4QLRSauiH4KXded7zdlj+mfe9cNLNK5Vt6GEMNjEOkLUkc1SPEO+fb6antYOA91gu6XYteFopzLmbYES3DIEA17xQnk7jl/klVfGWUIeeC2roLETjkqWVvZIg6AGF/iGsKFRmU5I3kz5XSwRDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324281; c=relaxed/simple;
	bh=/4z3zV4j4Wj0YNPYCHyF512kgVBeggTd4PFDIWxIE2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RaQq9NPw7ItjtOthr2ZGjLG1nwRJJxwZ8eOtUa6jpks6x6t2phOVtj7wLtY0WcgZwwzKKq/gR/hWpp7J1WD6DeuaDHJLQSq8I6dhg1x9CN6t+Ch8AcT4hmvwp7gsN16Fbox87Qlyljf1/Y8FsAzguIrvyYKy0RVxBWoYB+nub1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxFjuEF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BD9C433C7;
	Sun, 24 Mar 2024 23:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324281;
	bh=/4z3zV4j4Wj0YNPYCHyF512kgVBeggTd4PFDIWxIE2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HxFjuEF1nWozwZ3CLDboeaZBYAuHicxBXSC0SU54tOBNIKgx+nmzD4rs6Q+XDzvEe
	 XghJtcWaIILPu1zqRIoP+fqKGKogTtax5wSdV1VL07cVaN0z4R3NowVer3oJpCsckm
	 dCz0J+TYFX7ZdN/vk5jSdl0ZuDiF958ySGrX+KWKkr3yZi0ZADYgSq5OGaupibsB7d
	 Lz9A5iegZobkHhkue4vqVu2X32Wgb8FH20lA74tGZtKlzd3N+44J9e2k4oClZyL2Gk
	 X4Eco53e4R4FZL69THs47yptl/3Ky+XyruJomburz1LxFHciwWeVKpJ11rE2uwRmEV
	 CJEPceOLzD8rA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Jason Xing <kerneljasonxing@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 058/148] tcp: fix incorrect parameter validation in the do_tcp_getsockopt() function
Date: Sun, 24 Mar 2024 19:48:42 -0400
Message-ID: <20240324235012.1356413-59-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 712186336997b..3df973d22295c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3369,11 +3369,11 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 	if (get_user(len, optlen))
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


