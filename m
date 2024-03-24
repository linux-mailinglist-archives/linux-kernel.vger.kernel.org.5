Return-Path: <linux-kernel+bounces-115449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D76C1889B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1363F1C292BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E94B21618B;
	Mon, 25 Mar 2024 02:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAwiXl2P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5A212839D;
	Sun, 24 Mar 2024 22:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320814; cv=none; b=tgsZJVuChHNmyA4zduEWPWYbFe+ll4bATASfwr8hpgjFL5zOMR41ddYsR8msoiKNmu3LagHQkXgapnxs8L7NewGOfntddETJGcMu49Jmj2y6Nr+13A6B8pThVRD5EQCZDnWOsHnhSciBoIXkFLMiQb9UH2kxMgRePqoM3HPlhEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320814; c=relaxed/simple;
	bh=lZLSFq1iJp+1yqZH6jxlI2/fDatifOXhw/hTEBOsvak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYzcYwR2x4SDaQEw+hjccncFCrt8gPXubeG7zm+/NH7mFBypIa/tAtHSdCRRtcZi1ROm3dbyeHEHUVKSHHBMgBa3y0cXORib8xH83yQO+MJE/aGrBjDj04mvSmXh83vk4gZXjyeaw1pcgsaW+uylFieoYzLXigzsjTFS+tRdKlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAwiXl2P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27E2C43390;
	Sun, 24 Mar 2024 22:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320813;
	bh=lZLSFq1iJp+1yqZH6jxlI2/fDatifOXhw/hTEBOsvak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RAwiXl2PmbgRTIlJtTxVSulzOFS9p8MYJOUHmiJbaU+nFBgC+/bLyF0S4KfU8n1e6
	 kvOvoVUCV2xvBTglWdSWYGWMCSUekVHfxj6TLMSMVbiTqjnI06q7Ww30QGoY+aSaoC
	 WEqyG5XjkG15IWCIPQSMdUSn1go6iNx+iAnGxqZQ/tzfcelQpTAXqbQxHorpb3V76n
	 QsZcRX/lCHDmMV30BmXW+MotR6YEAwSfRHP80ec25zQgeobPQCH1XXWHFBY4b3fX8+
	 i598s+m8UItWVFht11kjqvRfU/J+8/6PAfAQJLTiDBtMQSloE4eFXZ3plauHppVU4X
	 BYUh3L0+9kcHA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Jason Xing <kerneljasonxing@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 378/713] tcp: fix incorrect parameter validation in the do_tcp_getsockopt() function
Date: Sun, 24 Mar 2024 18:41:44 -0400
Message-ID: <20240324224720.1345309-379-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index b30ef770a6cca..0d03d48702a4e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4011,11 +4011,11 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 	if (copy_from_sockptr(&len, optlen, sizeof(int)))
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


