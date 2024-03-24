Return-Path: <linux-kernel+bounces-114525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6896C888B80
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4357CB2F84E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF805D49D;
	Sun, 24 Mar 2024 23:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btAVBBRD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366C915B15C;
	Sun, 24 Mar 2024 23:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322150; cv=none; b=lNlA6SMIcmb1V97erqFgvK2pMc1qFmjIF7PPeiR+7/w1JccrvYf0QfD+p9D9Hwub2NOutxc/unwthKlibUrK6mQAgNGbYnk9eJUjNsk02/KDIjedLKHg1MtOi51+5Tcd3R7sZm6YVW0LFjRAnPO90bj4/qp057RyEDpz/9K4T2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322150; c=relaxed/simple;
	bh=OQsM+h49KmJCuY/Vc4xjJEjsD2hIGGvvSko+Q3j56jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sc6tEvg+TLZXcCgU+gL/bP6dp5hiALg6jedFpfm9ml6V54vT1bHVrsVR5uk8cnDlitOA3ACXqmigCbrl6ct9YjyqVpeOmPXLbPCyR92tN/e+sfZmdksawz8WIVdHRT9Ae7Tb4Ar2ihgvcM/6KdbwR771Z8ow1D5mE/1+jYPcI0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btAVBBRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578ABC433C7;
	Sun, 24 Mar 2024 23:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322149;
	bh=OQsM+h49KmJCuY/Vc4xjJEjsD2hIGGvvSko+Q3j56jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=btAVBBRDMwtVvTtNwFtCMJYGIvHJNj6E9lDY6LyOvNMVpfks7l6QYCMMHtzPAwa8P
	 cPjFBl623UTtt1pGHJ7W1M8eIA7LcZG3eCEBwVet29HgUbkZKF0FxL/99TOdI1v+Eq
	 tHLKJdRTPgJtmA2O+NreJPWYoCR+fxEtW6+qFG8DscBKne3jMzLReSXi7YwazEhHrV
	 hR2/6S93SQn0z3joyj3dvJOAb4qM/95DgK+TI46f6AGU+oEF4xU4Rk6NwqZjYC3cfI
	 aohCjL8Q50iTtaxb3g/qG9rAZ6cWfKkHR+ouV1V9aqKE5zf30eQ6SM4SA02xL0vJ4i
	 qJ7B+PjDAlOiA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Tom Parkin <tparkin@katalix.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 226/451] l2tp: fix incorrect parameter validation in the pppol2tp_getsockopt() function
Date: Sun, 24 Mar 2024 19:08:22 -0400
Message-ID: <20240324231207.1351418-227-sashal@kernel.org>
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
index f011af6601c9c..6146e4e67bbb5 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1356,11 +1356,11 @@ static int pppol2tp_getsockopt(struct socket *sock, int level, int optname,
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


