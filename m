Return-Path: <linux-kernel+bounces-113228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF74988827B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB14A1C229B0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A600917ADE2;
	Sun, 24 Mar 2024 22:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rH64gniD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B113A17ADC2;
	Sun, 24 Mar 2024 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320029; cv=none; b=OZe/68Qpu4ZLSmxFOCP7wQmW5FaImpWL5j0KPVQFBdp85r8pmxvdhHmXWyCO4uWGwHJFJlX7a/FtKDuqI159/zyy7jaJ0fkgIvqzL1dYJRuDR0uIdOqQtVPWuG9PaohdzhurB9RQEaAQcYLF7brorADQVSXq7V9COt1XC9qeU+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320029; c=relaxed/simple;
	bh=srNq0NrXfKRCl3FfFu+LjLJpVTxyIDjYe4yjGKTjrvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTA/Lti5afQihANSdoUl4dMaMfvNuAr+uTq7mGLBBEFAB+TFkyMFBCMrLLsKp4/vzBi0u4fheEdFSXC3Et+eai3mdENNxo3ge7VwtuxqJqtQib3V2oWykEWTwjsIdnqTuyGAw44MQs33NgwCkgkS3/KDXOFw2EUWUy1SstmZ1Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rH64gniD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FC6C433C7;
	Sun, 24 Mar 2024 22:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320029;
	bh=srNq0NrXfKRCl3FfFu+LjLJpVTxyIDjYe4yjGKTjrvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rH64gniDb6gKQtyQtf2OROLNX4XmVHSLmlsGPCqjgNzIkv2p+ICpjg0MZ6UjRdqfo
	 Ko63O0rtWhtRIfY+PxLgm5U94E+YJv0HXs2U3A+4SgckDePS3oNwgl0sftVfG3FjJ+
	 msZL/e9A9L3fUXzpXGMq3ZJq2sWCS6W7td6l6zgReN5BBD9Mx+zy2WD6gbZL/nvu/I
	 zT7hdzYXcipO8a/jak8ZfcrhXLS/EC0e7fGhElfCAgcGAk0/Yfbrnjil2gcgISVMmU
	 lorv1mv7JgP0JI1sVOuwn9BOuxAFaAAW4/09NnVOqe4o5nOSMpWGmHsRA2/Kjyaad1
	 7ScjrtnL5STHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Jason Xing <kerneljasonxing@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 337/715] tcp: fix incorrect parameter validation in the do_tcp_getsockopt() function
Date: Sun, 24 Mar 2024 18:28:36 -0400
Message-ID: <20240324223455.1342824-338-sashal@kernel.org>
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
index c82dc42f57c65..a4f4185923144 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4010,11 +4010,11 @@ int do_tcp_getsockopt(struct sock *sk, int level,
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


