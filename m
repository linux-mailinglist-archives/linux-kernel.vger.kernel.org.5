Return-Path: <linux-kernel+bounces-116267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E99DD889DDE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F391F37245
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC7028A58D;
	Mon, 25 Mar 2024 03:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9sQV0pl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CEC181334;
	Sun, 24 Mar 2024 23:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324080; cv=none; b=XbhxvEmlRUjGZS+T8iqVKLDtERiX8WUiOHXur5hdKT754xPXXuiP3atxdCZ51LzxvdoM5MtLIjf/5l/wo4FOQm0qvN3t0d0sP1hASXihrGXvD4FFbxSdCxqfNQyzfN7wcbY4TA27NtRqcKo1N0u0viyZ8Sptwbo+OiGfAHJSMgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324080; c=relaxed/simple;
	bh=Jl624/yQTx+aht0Fvw+Xpx7HC3ohezQCwwbaYhQE/nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mz1lL+mqXZEeZ9UPw1FceJlwnS3dsVO5h2K4K/pPPr++pOE/FPEXcnleY3ja+DEzMRe33YpOivyrx4sPz+qm8Vjlu7JpE15j5eZikm2H9Ofmx7ABpZB8/urzM8qTC/ao2Sz4grtVmGzFVeMMzn+aUuzGycOc3ldIKahOID/uC0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9sQV0pl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F75C43390;
	Sun, 24 Mar 2024 23:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324079;
	bh=Jl624/yQTx+aht0Fvw+Xpx7HC3ohezQCwwbaYhQE/nY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F9sQV0pl8gUPmgV7p53+XCEyY06n3GqNUxkskAcQZ7E09WoZLsdayeyScPj3rhK06
	 8cdfLFZsNh4aws87iAq7J8H1IWmCYsMT00VypdVL5iisypBixgXD67naVC2M68fBa0
	 hLvgHEnj/PPw1Jjd9A9XAd7vM63RcacOHrObbJjvfopnSm6stTdPFXLwwx83sKglUy
	 RFmrL38xzpD8vYlCzGP4bNpAoCLb0SCbQik09hRkkFeQ7ALv4EWOqKGJAU4/VHYwVJ
	 fIcvR0DaX/kT9l2omxNg1cR6PMa2gIiGMmIuuHT6P7k0f1nHUWg5qUHr30OC8pZaCh
	 gyPnaAnD3Uz+A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 079/183] udp: fix incorrect parameter validation in the udp_lib_getsockopt() function
Date: Sun, 24 Mar 2024 19:44:52 -0400
Message-ID: <20240324234638.1355609-80-sashal@kernel.org>
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
index a6f982b2d32af..3b3f944798850 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2679,11 +2679,11 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
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


