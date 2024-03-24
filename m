Return-Path: <linux-kernel+bounces-113229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA1788827C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5C61F21DB5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C58C17ADF1;
	Sun, 24 Mar 2024 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdk1dxN5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C2117ADD8;
	Sun, 24 Mar 2024 22:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320030; cv=none; b=JOUSv5bVaXwCAJ9H7c8m1qREq66+R0wzcBGm5ykbOH4Tvvq6qTSmSZ7+jhyI94A0O09PSvOMiEj25yGao4Aj082AhbwASYSj+YimpQv1M4PnmnHcLByK475F1mh5BIGvTYEvyfk1y/yIkcvIFui2UMIyzj3BWKd6lE2wB5Pqtb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320030; c=relaxed/simple;
	bh=EqXoCEfhgL+N/2DamQ2dbWHZzTTUlT7qV+UoCXKktWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qy2C0MqapIixfGvnIk5rh/OUM2mBpTa8YELFYk2h2ww1+/R3bx6NCeIsUiay1GYhrKypAF+6ReRzO/3s40mi6PVq8kGgO9RTXQb7vJwgVLAQ8s3I583SYbBsmRT5iX48lX7je/G/xWJfXVXFdMnfOoSp/8Jlq8aPFzqcgFwVT5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdk1dxN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C12BC433B2;
	Sun, 24 Mar 2024 22:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320030;
	bh=EqXoCEfhgL+N/2DamQ2dbWHZzTTUlT7qV+UoCXKktWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bdk1dxN5ueZJG8D1xEq7hmI8WSJ5ptjeUCQFTkcy8/noQA/VwhjIwFFqS6+iW9Cur
	 +QkhzZqB6d3rFCzSswS8idDOfU0v3o3zsArRireeRguPAzxnUKkVdcT946zSa9NR52
	 nd6rL9su/eVVj2pSRsRE2qN/EFv2kVKFsPhuP5uH8DqDZzmkibniGoVotOPtLirVsC
	 6Uq6uBXSgGXiiVHja7nBU5DqNliYnDrRdJAEt/JHJOv5aX6fs8xB0sG2Vn+80USC7g
	 koEsA59NtimlPniXOgXt5DGGCrD8pnCowWqFuh6VOIEjlng3uKUSsxNnexEES6Xg8G
	 1BmZzfMZjWV1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 338/715] ipmr: fix incorrect parameter validation in the ip_mroute_getsockopt() function
Date: Sun, 24 Mar 2024 18:28:37 -0400
Message-ID: <20240324223455.1342824-339-sashal@kernel.org>
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
index 3622298365105..b53c36c473a5b 100644
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


