Return-Path: <linux-kernel+bounces-116046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7023688952B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12A31C2F70A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F75B273DB8;
	Mon, 25 Mar 2024 03:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WebdqqqQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893001769E7;
	Sun, 24 Mar 2024 23:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323446; cv=none; b=nBGs2X43px6XRFhxyIr5I0KcynGenQGfyl2eX02hAeXecEqgaRMMoWB2FxHwFY+0QnW0T+4Kfu+S1FxopGeq6ryZpt61pEFKcfVTGdwOwJOantFTZzEjhE6D3On1YAzgMZwhSARk6Jn8LkYWi8W0tg0MhWtWs/GEIQg8eVQAV58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323446; c=relaxed/simple;
	bh=SsSv/d1AqjxdLmdNQv7XU4Xc7XOK/CXqj/W6WILv7OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dV9yBkZFn6wKSDdy/A9gtyZxsKe4ifuznXnnGN260D8xTaaHeMwevEjHSPVG9EqvqdevpKJNabcpEVqOC1tHfox7fw2tUrgtFQwJKmH00xdpXxgNfgyydFZANNDaYFtJ6Qd4FdjzoxqvYaVDjowhnGeerCRCVEZvtnPt9BLFu/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WebdqqqQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76E1C43390;
	Sun, 24 Mar 2024 23:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323445;
	bh=SsSv/d1AqjxdLmdNQv7XU4Xc7XOK/CXqj/W6WILv7OE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WebdqqqQ6OsXiCq1CbtaOBYyWHtvOZ32L6c9TC8FSoWjSOYHMJz/gWa8cu5/ZySNM
	 IvMylsB0oU4N4PdP1P74dhAf4qXPymMekjfdhHYgLJNeoB83NtEk2u+6o2LFzoCKfu
	 iA6wT+qS2GnevJ4Yth6Y7xy7n2QmeHX2Q4fOq0s7ADNU5VWdHhMUxn8jY/mQmmpOVc
	 s2Nd0QAWBUFF9XGqpWhuI+qQDZkXVaFogScxhNKMOX10y2xJOXxpN+qjwmV7rdAg1M
	 n74lidck4xmpAR/zd/bUSMhWJk/lkygHF97JgVOUr01K0v6smXkeHDxSlFCJy4v4vZ
	 RYGy6+1hmiY7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 148/317] ipmr: fix incorrect parameter validation in the ip_mroute_getsockopt() function
Date: Sun, 24 Mar 2024 19:32:08 -0400
Message-ID: <20240324233458.1352854-149-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index eb3c09340aef8..c9a633559258c 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1574,9 +1574,11 @@ int ip_mroute_getsockopt(struct sock *sk, int optname, sockptr_t optval,
 
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


