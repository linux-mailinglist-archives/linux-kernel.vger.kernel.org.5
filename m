Return-Path: <linux-kernel+bounces-113233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D438C888284
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6431F21F98
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292B1183BAC;
	Sun, 24 Mar 2024 22:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFLRXasI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE82183B92;
	Sun, 24 Mar 2024 22:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320034; cv=none; b=jk/XhPPSJ1oy6/tmvQXJVFSR86uDeKQDNN9/dq4fsZrEtLBRIFEEjU1pkehqhAyckf2GrJULaLwN3cSfZKEwxPl4kgKMwjxL8q2l5yTHOTDvDk2nk4zCME2NROm7/+QGPHDN/a6SJPue2XoRIQ1WWV2jHN6sw2Qy9Doa/sQDumQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320034; c=relaxed/simple;
	bh=Tbtb83D82ba5U9j7pO0kR77XqAV2NqjGsYQcqKEPiH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOqdsfCOzQ9axX7o34pQ4T/qFGfTrnNHKZfD/PPdt5byRpIK48K4bwVEw8cTeQv2i/BdbaUGR/Ofbi9lDcimhExSpfwUwaz+m8zgjF7dRl8ek/VfjnlLC6tEAQrWcbzIP148u+99a1I2YaU9W9PusesvxS8ImskuyBcZ+fgvNDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFLRXasI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41998C43390;
	Sun, 24 Mar 2024 22:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320033;
	bh=Tbtb83D82ba5U9j7pO0kR77XqAV2NqjGsYQcqKEPiH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FFLRXasI22Tfjx7R9Y89te2gVG/TrLaRx5CpLd60mllYWlRiLv0zZtCdVgvhqgKDm
	 XlVxCryp3dYDE+HgCa+dQn+qNw9n4vBHwuen1F/iJL6m7GUHJwDCqIYf3F1IEk/Nq/
	 rfhtSm/OGubgYeNDz/tvqxsr+uxT3gr0vPdYQEaLOGdOIskObJgnfW716cVxAmrLz5
	 Ce4BxeETRxOBgJzakX5FEqXvFrAqypIJqYLkAKp9LlILnN02FVrKaKa6e3m69f+dn3
	 HntdbS5R+rt693+yFNDn7RuU4TeMbAQubt+eftuBsoJLut+cE64aravO6dUNbYuK7G
	 WqcV1oDF9kdCw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 342/715] net/x25: fix incorrect parameter validation in the x25_getsockopt() function
Date: Sun, 24 Mar 2024 18:28:41 -0400
Message-ID: <20240324223455.1342824-343-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index f7a7c7798c3b2..d18d51412cc00 100644
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


