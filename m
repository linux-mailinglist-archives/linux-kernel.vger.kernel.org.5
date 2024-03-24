Return-Path: <linux-kernel+bounces-114255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A9C888968
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F60F2889D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB30258FB3;
	Sun, 24 Mar 2024 23:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q48AV5dV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15A71386B2;
	Sun, 24 Mar 2024 23:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321609; cv=none; b=aSZRohHzIhOWMqidOMd9pJjIueCgkdwbBACUTb8djrKDg4ugpO3gXJJrfKh4qTN4mxAofcGcKO0V88RC/kabHJd4Jg9AlB0RHfZNpXG5qUjSvQuk3yqRJsdvGuobxuFwnWH19Vt9qvsITSgxrRyITxdGwizFmShk44eERSTWPxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321609; c=relaxed/simple;
	bh=xKWY9aIWFlX1S7/Ym5PK8074P1HxyujIzFzS5hsnloo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7TfIusDp9c6hoAx44KuaDhVN7yNvB36UxbnBVCgNmLswuGIWJzA0P8o2PmJOinKcmH8Fe1iWV30Admu3QvGTOBAU0Mg1cN2j+t/r14+ZqRl27qjjEUcnOI4Wow8lSngKuO91BjlgFJxTvhWG1V3FzHR5WOiEM6UaAZZrsWm3lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q48AV5dV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A1DC433C7;
	Sun, 24 Mar 2024 23:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321608;
	bh=xKWY9aIWFlX1S7/Ym5PK8074P1HxyujIzFzS5hsnloo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q48AV5dVuR3D52hm85Gf5+RtwLuDDV2X+BM+Mmwc1JEAMb8AJ4bbbiqFlCNP2BOre
	 WLnRG6Sx7Dwzgk6FY679Z37LDVDayoO4W+fRnWfl+aCZQRqFwPpYfG2iz0wNkFZX+s
	 Y2AWpyc82TkBfSRXUvOHsYNs6zEyGNuOrwzeW/qqOPVSlnHbjsjVmRNr9GmuRvqzHv
	 +pnXz3qy3t7bRUxp/30Vm3awDCUAZ9rdX+hW5N9u507QOSciTUL731Umr223bzCXQW
	 A2d9tUUYti4MLISgVvw5JeX+6LQTFrQDYte8xw0r7xzyk2SKnMce2FS/rojdsb2THt
	 ij16BDmCxya8A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 338/638] net/x25: fix incorrect parameter validation in the x25_getsockopt() function
Date: Sun, 24 Mar 2024 18:56:15 -0400
Message-ID: <20240324230116.1348576-339-sashal@kernel.org>
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
index 0fb5143bec7ac..f15a4493eb0bf 100644
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


