Return-Path: <linux-kernel+bounces-113231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59521888280
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093DB1F21DDD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1577613C90D;
	Sun, 24 Mar 2024 22:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIsuMVlb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420F713C8F5;
	Sun, 24 Mar 2024 22:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320032; cv=none; b=sSMusVqOdOD8Vzn124Klozuh4WLTUeXyMmCBubngLuHKqbM0gXT9QuOlBucYzw1eykUROTlB6JIn2EZ1RutwUQTvN0h8Byp9eAvgCTVLEglwM7+nkYqyF990/RIjj3DGCmUqARGPjusGVByG7ha85L9o5jsuLlxom01Q2yiN9yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320032; c=relaxed/simple;
	bh=v11nOk9WMIawSUi2NTo75pwxYN0u6dGKGLF3hwTXg3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ap7KWONVedc79ot0sZoK6k5x6DKX+z5RzM0d/CxBhYeQOD9iarbwXQDLITXxXwEZACc75lIKX/iFsh0EiPkLdGRghof7IiZg6a2935uUVMYWWhxl0k8QSRj2+V9DPMbWU+jVvNwc83PANg4PJ/EEhK1mQSMalCzPNZ2pcK72XYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIsuMVlb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64445C433F1;
	Sun, 24 Mar 2024 22:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320032;
	bh=v11nOk9WMIawSUi2NTo75pwxYN0u6dGKGLF3hwTXg3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BIsuMVlbn1Aiwegm+OIcEYxJdF/7wmujE2o3DNQbrlOYWvq8OdfZrqHV8ka4wyFiV
	 46ax869zvQsZ9dW0exGO+u7rbA+wr4AH3rzpj4p6wmkxRCzN1vw1jyL+EibYZnCE+d
	 q+7k8hnH2T+Pm54UP1b2RQ5nndq5QitODKCFBdhNEBM7qrYwVxOFiF62Zuy5Dp0B5I
	 /H1pCH4L0uphIRmpMaGpWVjUFA80JmYFFD45NR2RSsyZTfyVwB8bd42tARIYWCm/2U
	 ZkHEV207zoWG0Vyt8vrqTycr3AcY0Q0D43TV3co60oz14pRAclifiO03JJDqkSjb87
	 W7rX7PQf+uUxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 340/715] udp: fix incorrect parameter validation in the udp_lib_getsockopt() function
Date: Sun, 24 Mar 2024 18:28:39 -0400
Message-ID: <20240324223455.1342824-341-sashal@kernel.org>
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
index e474b201900f9..17231c0f88302 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2792,11 +2792,11 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
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
 		val = udp_test_bit(CORK, sk);
-- 
2.43.0


