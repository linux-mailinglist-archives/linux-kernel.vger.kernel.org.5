Return-Path: <linux-kernel+bounces-114254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B24968890B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F36B8B31B51
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28E4258FA3;
	Sun, 24 Mar 2024 23:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTBA77pj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E7B20AF9D;
	Sun, 24 Mar 2024 23:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321608; cv=none; b=mbl9qEajQZPPV0GzydK7tUGnWnLeogeUJytvlVgfyvG1JGL/iVK12SvyXVgwK9jdAZ6EkAVTR2sHo6MBKBpSJ+HB9RyxWWrpQtya2VgtDGldEMd7ROe4y214C3T8x6IjB9vew1nGUOR3nN3gehyWrkUi4zgkaZ0GfHTECmqjup4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321608; c=relaxed/simple;
	bh=5LFTDjBBznADyvpRgwfaW9rOgpMVy5gxH2pX37SvfuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJNlMKHZrDHx+sFfdlzi6HJn27bDpEzWh5mGUmgBqPobWvZegBjhjZ+HNuh/8V4Fx+FQhS+kA5wTSTo02nn9meg8c8il+aXThzAuXoMqgMnqIVAV7Ilxn05DbuKCNx9T9Rs6cQWMKZj/s6ME9sHR7Muy7RBM0wIvZXIxdxWLed8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTBA77pj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEEEC43330;
	Sun, 24 Mar 2024 23:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321607;
	bh=5LFTDjBBznADyvpRgwfaW9rOgpMVy5gxH2pX37SvfuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WTBA77pjUxJsbuuWSPsPaqoUWvTRmoOUeJlsnOBSw4wrLnzgNzPV/sp5KmO1zeCAC
	 tcaUphMVcCKdbb2Zw389tGoNCJc+dOgU43/d71yrUzWpIINIyXNa+urzbGiEmcanUa
	 BaAt7C85UfxKFOC8VwZsb6jOJX2TzPgnkmd2RiWzqQlhEgTzIjqFjomilRLHfux7Gb
	 5ZTYBx0sN04GvdWD5vi6t+Ey5S7w1o5ADW/ZQ8HuI4j2Fy3CeMH+Gvb37ziz9N5GIq
	 6JZDJPVWqkO9DuCtFwVTCx8cbJBpFiVFPAsUOPZ//gv8D6g4e5HUevR8bzDtMOck7L
	 5oMWuoih5sGVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 337/638] net: kcm: fix incorrect parameter validation in the kcm_getsockopt) function
Date: Sun, 24 Mar 2024 18:56:14 -0400
Message-ID: <20240324230116.1348576-338-sashal@kernel.org>
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
index 083376ea237e8..41d892bf12cc6 100644
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


