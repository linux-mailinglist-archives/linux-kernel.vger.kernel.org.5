Return-Path: <linux-kernel+bounces-113230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0014788827E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00EF28A26E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF6C13C8EF;
	Sun, 24 Mar 2024 22:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYULRwlJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4015317ADF6;
	Sun, 24 Mar 2024 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320031; cv=none; b=OgklmFEm1YsMOaWGEB32FtCmO92gFcTWxATOTgvmoGctXWqRIUdPTWver6jD1BsgxkLSwp2QL1MMIbSss/gVF2vavwAvvsutO+STZXYxq03CL3IqfI9fWTkyPDzyCNGE4ZH43G97ilFJ+6Id4K/ojvHtV4GKwbJzeO3bt51/QmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320031; c=relaxed/simple;
	bh=OQsM+h49KmJCuY/Vc4xjJEjsD2hIGGvvSko+Q3j56jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TL4C4y2Au/FwgTgGWTPFdKcXvtvxZPg4uOy0rpPB6UsdrQh2N3AxTb1GdZkoVIYtcOL/x3ftnIGXuG6flDCbBcLVUUhizIFC/Oxnx3RJmncXuJN3M8TpYUv6p65xVdcKpnolClvv0gRg/QniH/1s99rO2LgTgCHG477ZL2A1mgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYULRwlJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66660C43399;
	Sun, 24 Mar 2024 22:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320031;
	bh=OQsM+h49KmJCuY/Vc4xjJEjsD2hIGGvvSko+Q3j56jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aYULRwlJ/djr+dv4WDo+TDKpLcYJ0GvckMxx/YYGjUh2gEh33KoOOnG7lO/YlZijO
	 pn6IPfDIhvWvDmqZm6qZ0+7U3nQ+e37bUCAV/kXKv18pvA6Ae+y22zKO49SQaGkgER
	 kDX2n77/BTzE+wZqqkJ1kPXB7fGO0iQCheRK/25kXldCBUXKCDj4U/sArXqI+hrdrs
	 IaqEqk7cRamQubfvC7zITvvg5e95yr7pALaNuKVQayjHumgNHJVCaVRLsslX0tmf8F
	 Q8QvtBkXcjLwkdi9k0L+FLCibGc7sAnmBDs02wzwnOb++cLEqU+0NZk6er6+Ktpck8
	 4XVm6UU4iOkoQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Tom Parkin <tparkin@katalix.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 339/715] l2tp: fix incorrect parameter validation in the pppol2tp_getsockopt() function
Date: Sun, 24 Mar 2024 18:28:38 -0400
Message-ID: <20240324223455.1342824-340-sashal@kernel.org>
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


