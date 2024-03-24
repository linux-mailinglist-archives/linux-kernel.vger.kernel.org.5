Return-Path: <linux-kernel+bounces-114989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53375888C67
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830031C29E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36BB282B55;
	Mon, 25 Mar 2024 00:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jn7Z5jjI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B02B17AFB7;
	Sun, 24 Mar 2024 23:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323733; cv=none; b=n34XFQIk0MLozDF7YTDtRGuvuQNWYRiPT5WN2J6bwmlRlQ/tH74WVGHtY9htBbJRJQecsZJCXMdsgoRzgWsLIHwv1h5iNhWDYEh+r6X6u+BYBgrhLfyA0HqCbsc/FrZ9hEf04Y3Hxckc7ztcYvBwrYd+ilIvpPGtq3JeVpTlcYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323733; c=relaxed/simple;
	bh=gqPHBBF2ax2icTiLyCdAlg2u8IRmIS8YXsj+rVQeX6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CkRdOpng9xVuOqe1dz8NhzVLPsazokmJmuXoyGR/nIZQSAYqYy4oulnmAXEjS5NlXZQKn89bENtq2VUeW6eTOdCihkJjlznz/zqOWrTwKRyAvzr/7PewhzkDvRGHYHzX4/NL2vHLVs+JJtjFi5qS3xG1vs+SeGObJg4AmuXmkL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jn7Z5jjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0ECFC433F1;
	Sun, 24 Mar 2024 23:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323732;
	bh=gqPHBBF2ax2icTiLyCdAlg2u8IRmIS8YXsj+rVQeX6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jn7Z5jjIbfWwPpbQ2GNQvyjMECMcTs9JMm2egVSdTpI2WWHpmtdZ4H3Vv5uBt1eJD
	 8onSc/S1a1F/32p8EICRTjFUIJpnQYtP5zq02jlCTOgb7Z7bHZfEgzMkn1RqBDUPKF
	 HnvTpBjwKCokvjynY1jQMD1gOIrcuJe/iFI3mwYnf9CdXWVpka/Hkjf76vruJ5xI6h
	 U0wV9Btg6MFqU8ZF7OWvaaF0M23oURfoNa5ITTjFrpKVgXlacF5O7Q1AWz3eRsjtJD
	 RoBLOcg7t2i6Z3+sD+MdbjLkozplaFEkqS/A9iX5Lpav/mr+ENhaGc1vseRncodEiA
	 ingXpsLSjGy6Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Tom Parkin <tparkin@katalix.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 106/238] l2tp: fix incorrect parameter validation in the pppol2tp_getsockopt() function
Date: Sun, 24 Mar 2024 19:38:14 -0400
Message-ID: <20240324234027.1354210-107-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 5ecc0f2009444..b1d89c850f686 100644
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


