Return-Path: <linux-kernel+bounces-113796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5A488869B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3016A1F241DB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A6B1F9C01;
	Sun, 24 Mar 2024 23:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Noh4FoI7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC7B1DA179;
	Sun, 24 Mar 2024 22:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320815; cv=none; b=qbegBNJWloyEkrtJ+KgkAN7EXCvrEIKGeA7R4201rmM7gnnYqTLx95TtAcerrkE5Tig6P+vVFPsu7bHPDdCA8+ibQlOYe+Vr/cBYRUhq6B8725DQkMs87aecHMLEFp4yNcX7+cRoguinK3fl9SCyL4aMW1xjU6GH3lAAYT0rIDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320815; c=relaxed/simple;
	bh=FkpSNpSlpycCmcF3vPsdKNwVZjnMaXFcSIOgP4WTv0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cs53/wyDAq1UygpnXtpe+tIwpJ5E8o39fLTrHqCPR1d94knUnIJqqR5p0ma2ixjIQQWmn/vK0na0IGaYhIbHauNIsUxkbAjGuljZKpDyzW3DJMEMSOBVVDb9nDkH4Ju8qSnyGVkIv2lkRhSPrj5TpeUcd/CE/0IuDp7byUclYhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Noh4FoI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B80C433F1;
	Sun, 24 Mar 2024 22:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320814;
	bh=FkpSNpSlpycCmcF3vPsdKNwVZjnMaXFcSIOgP4WTv0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Noh4FoI7Uotl4LBilO2RLK/zF8zJKxpDdZ2WRDOROfUZQR2q2RstffbWYSJvwyeFz
	 dBgLeh6N+hwXFY2qJEnveyoTS6dqQNeZL81QQZmoCrpa6DVdLx7bw67qrB0x0PeJZY
	 5XYTB9NkbhELrDEGdJFOaUBj/puVMQzFwkOsanAtmRYr06whEJKEpSAV/iJRkb626Z
	 MICZyxaMAKVNPhdbfA+gtylgxNP8e/Frili6LMqMCextsWLH9imwySNZSmpQWD2jiV
	 RzaAKPQ8ny9So92uCqEDTqudp+zCpl3P47B0wQx9XjkNMYLK/WqOAwvBWcxk52yBZ1
	 WRw4dmfcHifZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 379/713] ipmr: fix incorrect parameter validation in the ip_mroute_getsockopt() function
Date: Sun, 24 Mar 2024 18:41:45 -0400
Message-ID: <20240324224720.1345309-380-sashal@kernel.org>
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

[ Upstream commit 5c3be3e0eb44b7f978bb6cbb20ad956adb93f736 ]

The 'olr' variable can't be negative when assigned the result of
'min_t' because all 'min_t' parameters are cast to unsigned int,
and then the minimum one is chosen.

To fix the logic, check 'olr' as read from 'optlen',
where the types of relevant variables are (signed) int.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ipmr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index e49242706b5f5..66eade3fb629f 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1603,9 +1603,11 @@ int ip_mroute_getsockopt(struct sock *sk, int optname, sockptr_t optval,
 
 	if (copy_from_sockptr(&olr, optlen, sizeof(int)))
 		return -EFAULT;
-	olr = min_t(unsigned int, olr, sizeof(int));
 	if (olr < 0)
 		return -EINVAL;
+
+	olr = min_t(unsigned int, olr, sizeof(int));
+
 	if (copy_to_sockptr(optlen, &olr, sizeof(int)))
 		return -EFAULT;
 	if (copy_to_sockptr(optval, &val, olr))
-- 
2.43.0


