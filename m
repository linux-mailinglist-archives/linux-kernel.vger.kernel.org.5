Return-Path: <linux-kernel+bounces-115939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB1E889C91
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0826B25291
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2BD38E702;
	Mon, 25 Mar 2024 03:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDq70iqd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2266B22AB83;
	Sun, 24 Mar 2024 23:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322152; cv=none; b=kqytF4+xFaqCPx2UkXJhmfXL7UyWk2LXHXd/63MkCc8ewLUgsIphhfFwBCHZ6df0yoivxHvrJyl879YlcBNaj3tN4zmDL4bftH62IKZ3x6hhU7CukrFyCHqjbJpKy1vhQGOKdrtMX3s0zSf3x75E3G4wKyxGIYzAHZPH/lvqmE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322152; c=relaxed/simple;
	bh=6x6msOVMKp0/WxQjJkJWGJR+nmYrvvXpeCfppaZ6xwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsGx8dAU22LDXfbXGnj6N7O40TcBoYhbqcuVBrwYqz3rqJd1rbnjBXywej5ZmjfwpPZ2O4eU9RREJ7N++aYiogCeqRg2d4BOky5r7uRcwCkE+U6hD5DkVggSL82CyDE83iK4MKDkUNhPmdSn7Pz9QN1bNW9wl3gi+2Gk15U5Q0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDq70iqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6136AC43390;
	Sun, 24 Mar 2024 23:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322151;
	bh=6x6msOVMKp0/WxQjJkJWGJR+nmYrvvXpeCfppaZ6xwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HDq70iqdpfyRZR32Gz23/3RlhFT8vBohO4Rtaq/VyKVzHAB1oodNCThzH9ZP+HTTS
	 MRuiLvEBYpxw4BMREV8NQHwl5/4MjbEtM2E+U7SHLaiRX/nIrJ6l6hgxNmDC4l4uzC
	 Gt9Jhy+jDuZxu71O/efHO3ap3jXfzKbhZLGf26SxPlRQU41eL7Y+KUKvJE6l1cAo20
	 1rIuqaaXDYHTH9OYbEOjGxQBslOppIiF5noIeeS1+ckcZHpzaGUQGNeKFSDuDwBXD8
	 Xp0nwn/8quglNrv8BUtp4krAqfnaBahK5Th+lc0ERBEqaDhTk0I+bsLkkWEwFPuzUJ
	 biWMH/lJIa89w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 228/451] net: kcm: fix incorrect parameter validation in the kcm_getsockopt) function
Date: Sun, 24 Mar 2024 19:08:24 -0400
Message-ID: <20240324231207.1351418-229-sashal@kernel.org>
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
index 65845c59c0655..7d37bf4334d26 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1274,10 +1274,11 @@ static int kcm_getsockopt(struct socket *sock, int level, int optname,
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


