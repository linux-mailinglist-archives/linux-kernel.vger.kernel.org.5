Return-Path: <linux-kernel+bounces-116162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2FB8899DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F3629F5C2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207253B4829;
	Mon, 25 Mar 2024 03:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqygQOFO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A5D4502F;
	Sun, 24 Mar 2024 23:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323732; cv=none; b=OiT8ee4EoHgkP8D1NXYRjsxCYprnmYupVeRdxaXnPzfApykRXcy34kLwlDqsyyuqAjJHFJ3Ax3YhrSLOixu/RxMPkTmNg728X2m66bZSF3NKLpyVV1b8wS40LscLxT+yFd9dcc+PfrDPkstUrjWNyKt4cDE97hMkM4HE8BHDzPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323732; c=relaxed/simple;
	bh=v2Qyu6q2veWbVwn5KD8cFkjNZD8lTAkqpln0vQw4LS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRM+Qdj6WnmrAeXikyfB2b3WxIXcXmyl3mStjW9cQEbfbADvTMwBqgnKgJmB/KXwoE7u5xB6cQ2dcBy+qFmr49u8zTPluMMHX62C4t0rsLHwgSKqltKvqkvE0MT4yrAjvpNDM0ycqy2eFRuOAn1T50VNU5no7qcI+CkXKXxW5p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqygQOFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD915C43330;
	Sun, 24 Mar 2024 23:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323731;
	bh=v2Qyu6q2veWbVwn5KD8cFkjNZD8lTAkqpln0vQw4LS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RqygQOFOSIwsmWUGU9F95A9LXBTTGXe0XQ3NUXSOwCqMi+Y0LK3SxDmLxQuOsbK7n
	 6oJTQf0vl+WjtpQryOVVcOOsq45xljRtolBLOSzEATHzQctc2EsyXcy3eQ9wsam2oS
	 4/ygA+RJtOdJh6q3q0VwkDvjtqBYzpmrtTB/xr5C/0cjdJ8JKMqwUswplx8qX0ZrSJ
	 gAlPlIUoJo0SYPr8STl4Rj5Ms/EXt3OYjDhKHXN/Aejp0nutGiXev1b3kgYcfhK0fV
	 8Ty8HPaRHjax/vtVXEzXf2HI+EDdb0D8yC7F8/ciKae3zdliXm1ZLsHmb9NsyYNcAi
	 MMp+OG++b89GA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 105/238] ipmr: fix incorrect parameter validation in the ip_mroute_getsockopt() function
Date: Sun, 24 Mar 2024 19:38:13 -0400
Message-ID: <20240324234027.1354210-106-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index cdc0a1781fd28..db184cb826b95 100644
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


