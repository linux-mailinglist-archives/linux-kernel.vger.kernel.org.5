Return-Path: <linux-kernel+bounces-116163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4653889CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C14CB332B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22863B3E1B;
	Mon, 25 Mar 2024 03:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rb6ORpPB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D6C5C60D;
	Sun, 24 Mar 2024 23:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323733; cv=none; b=eoFK6VvNHuV0bx/FH50xWqR59zGTQMlzvX14FoRNtSWszgmJE15beEQUmsHplhcXyW5n/hMRcqWRrTBrD3I4qyqiNV6MSbgkvNtKulMTk82fe1kXysKWY4SVoRPuQuPRsOMqShBznfUybf8g9YWe11yA/c6QQt3zTnRWMiCXMQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323733; c=relaxed/simple;
	bh=D5Tipd9xo1HJm1VvdgmJe7YzPbbv3V3wVv5yCSQb65w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S51/1H+9G5yB3N8GrQ8/2JxpuEHrO45h9iBkh9MvijlW02HxH8VqlrHfW3rYH1bDQFptgZ68DerqoNv/w0EmAUW9p9pnLnKTerkMGhjCNwlIbgpYsLJzJsvwcnX7b7T0S5yh2IHZP/N4bq095JGpBxB+wnZZGenDsviiBq3LgU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rb6ORpPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD306C43394;
	Sun, 24 Mar 2024 23:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323733;
	bh=D5Tipd9xo1HJm1VvdgmJe7YzPbbv3V3wVv5yCSQb65w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rb6ORpPBrYBfVyHCAcEtCooZxITYGErnNCJUewKWpEezSHlOZbcIXcETSyGFxqnSe
	 //XL+v1X81ItP/SwNRtZIg/AE5ILzLGuhUAq9reL9t4wUqPFwt0WYIhlJEe2dX0z43
	 odf5B9FcV0nSu63s45/0FH+SZrLGA1PyX1my8HdqP86/84GX0TsjO703DpnPwu9TZn
	 +pCZXM8ed63lRslwshqU3za9uBa1WRFI3HCHB6kRq8U0hRgKQEz+Iu0ufqx1B2pBMi
	 irYF3ZJds/uVZpaHD+9zEBdlyNRY/q+BaFiMPta4eUUHfwUc+Jk7Fuy97El/vW1Oqn
	 Ox7kDaVkmS7pw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 107/238] udp: fix incorrect parameter validation in the udp_lib_getsockopt() function
Date: Sun, 24 Mar 2024 19:38:15 -0400
Message-ID: <20240324234027.1354210-108-sashal@kernel.org>
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

[ Upstream commit 4bb3ba7b74fceec6f558745b25a43c6521cf5506 ]

The 'len' variable can't be negative when assigned the result of
'min_t' because all 'min_t' parameters are cast to unsigned int,
and then the minimum one is chosen.

To fix the logic, check 'len' as read from 'optlen',
where the types of relevant variables are (signed) int.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/udp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 476f79f1563a8..b2541c7d7c87f 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2748,11 +2748,11 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 	if (get_user(len, optlen))
 		return -EFAULT;
 
-	len = min_t(unsigned int, len, sizeof(int));
-
 	if (len < 0)
 		return -EINVAL;
 
+	len = min_t(unsigned int, len, sizeof(int));
+
 	switch (optname) {
 	case UDP_CORK:
 		val = READ_ONCE(up->corkflag);
-- 
2.43.0


