Return-Path: <linux-kernel+bounces-113232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9EF888282
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C201F21F84
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEA0183B86;
	Sun, 24 Mar 2024 22:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fp1jWJ8W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E69013C911;
	Sun, 24 Mar 2024 22:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320033; cv=none; b=kcLOGeE2ceIknPdlSST2XQNUmJjxY3DtI53Se12b2olEsgblnpIoAGJB6Hnjsor1MGfMFvhwrPiho2bdWi/m+uTcA1HvyvR0NyAUgsIUa1duAChrVdgSJzSPPooen4e0FkgHdyk+NUG4Kuyqi0OPkKqb8C8++hDc3bxbc3IBe4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320033; c=relaxed/simple;
	bh=KEnJYE7iFGmp2/B2QX8PVoBww/lPOvrAXRR2IkS82Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNp6DNTTxDIftg5/Ibz+9XXpHEeFYsM6mQGMBpM5IOoCcq3zYYvrFfITmzp5zvjE1v8dZyNY5a5oWPe+6BoN9xnviXpuPiyni32KfhVfgBixb4wKBdMkTQ0VucdOv+f0UnQEmbCe/0LRP7icdCbswyrs4AzoVTDCAScbzamN5ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fp1jWJ8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6002EC433C7;
	Sun, 24 Mar 2024 22:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320033;
	bh=KEnJYE7iFGmp2/B2QX8PVoBww/lPOvrAXRR2IkS82Ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fp1jWJ8W5X34j5sdTgMUPr/iCSiupe9ekZKv4hrTNY3HC9e4sspiKeyCR1mryceJ7
	 SBuX8ReIGtmhcmUtFqXYsViKGixlCNSKGbdiCdqsYwycZIJSAX0IgxwxR9aiRxv+E9
	 wzJeGH1emxpQLHCb3ziNfH5z4tWRSgxVTotBlvLZtnyIBNxp8l/DfUg6U5Iq3wxpvj
	 iUSlSF9RMJb6qioC0L8oaWGNgwU0nqxuyJ72MStRUkZ2GQknRoXXhYtOtVwBQCWUEm
	 yMyEPQ3iqJ9GTbTw3bXC8vbdxH97jvJTIVMCPagAcht8cvYE1h2lNVNqliwU6LY7pm
	 eeVusImKeVsww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 341/715] net: kcm: fix incorrect parameter validation in the kcm_getsockopt) function
Date: Sun, 24 Mar 2024 18:28:40 -0400
Message-ID: <20240324223455.1342824-342-sashal@kernel.org>
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
index 1184d40167b86..eda933c097926 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1152,10 +1152,11 @@ static int kcm_getsockopt(struct socket *sock, int level, int optname,
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


