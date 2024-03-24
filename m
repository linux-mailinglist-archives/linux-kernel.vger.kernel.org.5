Return-Path: <linux-kernel+bounces-115089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CEA889305
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D276C1F3286A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5CA2F840E;
	Mon, 25 Mar 2024 01:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLQzYfrZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812D31802C0;
	Sun, 24 Mar 2024 23:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324081; cv=none; b=NpQ4Ff+FuCMgdly2zhp5HC+xzsqrGUb4ETtQFIkjflZZiK7JAEhBjjEpbHR7WhNsn6+VBEE7WnnIxRxe4qajPvxJc6mG6YMof+/Buj4SvT4rwlTQZgjhIlXR472XFVv55qQ/+uCPNjNWcNIBRFEkVnJ4w2Qqxn7W+CjqvIC0Dpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324081; c=relaxed/simple;
	bh=jlq9gbxywDwNsqbzWZRis+/iVmpZIiTCgDSTxuMz0/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NelOyhFxWWt94SEBgUq3FxXHqzxvfCWSHLW+h2rM6uhbN2dcly4O0SDE6x/FhW66jRxTn7lDZ/LZCYakO1NIrnVLKjs//rgAAd4A0KvBofLEILQZ/1l/+hI2THC1TieTZ60Jup86bIQDLbIaJFQS7wc+E0HZbS40HONR9Bq9ou8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLQzYfrZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB364C433C7;
	Sun, 24 Mar 2024 23:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324080;
	bh=jlq9gbxywDwNsqbzWZRis+/iVmpZIiTCgDSTxuMz0/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KLQzYfrZ0xE//iAFvYOQxtNoiMUzp+SzbTkkDVOcwiozP3mmBE5uiPn/BBrbqKKT2
	 Sz0Ma+/OJlMDtzMpPd9vk5huil2TyfzBWeqonKUdMnKmfVWh0Imrc4OfY720Q0zRWX
	 F8zzSO9c4Zf1ZOLanlmfsp0cyHuo+PO6ACor6Qln2Lr0Nye7aIbUJBMsTKRPVdEiMf
	 l4y4RHIbJG0YlzeZkTZ8ct9PrXrp6SCtnarYS5FmuCdwcD7RtKBA6exFhmuWln2FjQ
	 WDhhwwnY7laJMlzOtvHLpUbg/mRXCbYJIJXVhSjEtzxdKwudGLSYcQ2aganvcj9RIu
	 FiUg39YIx+Oaw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 080/183] net: kcm: fix incorrect parameter validation in the kcm_getsockopt) function
Date: Sun, 24 Mar 2024 19:44:53 -0400
Message-ID: <20240324234638.1355609-81-sashal@kernel.org>
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

[ Upstream commit 3ed5f415133f9b7518fbe55ba9ae9a3f5e700929 ]

The 'len' variable can't be negative when assigned the result of
'min_t' because all 'min_t' parameters are cast to unsigned int,
and then the minimum one is chosen.

To fix the logic, check 'len' as read from 'optlen',
where the types of relevant variables are (signed) int.

Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/kcm/kcmsock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 8a8ea7e6774d5..920b0ebf1cb80 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1277,10 +1277,11 @@ static int kcm_getsockopt(struct socket *sock, int level, int optname,
 	if (get_user(len, optlen))
 		return -EFAULT;
 
-	len = min_t(unsigned int, len, sizeof(int));
 	if (len < 0)
 		return -EINVAL;
 
+	len = min_t(unsigned int, len, sizeof(int));
+
 	switch (optname) {
 	case KCM_RECV_DISABLE:
 		val = kcm->rx_disabled;
-- 
2.43.0


