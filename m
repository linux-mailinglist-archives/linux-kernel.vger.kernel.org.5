Return-Path: <linux-kernel+bounces-101850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AC987AC22
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001641F2675D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A81C74435;
	Wed, 13 Mar 2024 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spfDhtmJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C10574421;
	Wed, 13 Mar 2024 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347886; cv=none; b=oH63wWgvSumeMokGe/3q1OiWe4JmV8cRp24OszJDw793KUCu6T79yPrIAEqrAiidYlKZ1MKJPrw7SQXD6EuR2Ll760iOl3tCUm1BHbvW73HcH0nGctL9yZfX/p/RsjoPNQ2/AJiKlzzcD/mY5jzOUAn/0O9+FMWJKLtYj/kVUI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347886; c=relaxed/simple;
	bh=3AWhKptyhC8XfLyB3pmytWkHsxrKPkwi3z7ElI2NOhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=en+jY2+QRxg0vK28VD2YK071j8iaNY5y8dFdtSo+QS0w5q9JlHeuPojE3HVEG79MbsRtOSEo3jUfo9O2Xp4DgLecO1FCIJpILdPjiYsVBhZes0Be1mK0a7RmT3JuNe05RQ8DvZfz4rgsnxxsAun8YYlmyIAPQu/3imxp5zJZ5Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spfDhtmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83ECDC43394;
	Wed, 13 Mar 2024 16:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347886;
	bh=3AWhKptyhC8XfLyB3pmytWkHsxrKPkwi3z7ElI2NOhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=spfDhtmJf9n/w8guXyUjP3frEDfIKKUkrxwH4R122lEkIQK4gsZdf1qpEBFfJlZ/A
	 gFx00zXYV4zLHgWFtd7ENajLsMTRGXgU2021o2KDgq3lJErk+sXDxjhMluClH7pLnp
	 svWLud/QbvqA3pY0k6B7CdJHM9ZsSR7z7xe2sNF81DB06VCoKqkxkiFZX2tB+h0dUn
	 m74v/OlXUifxkbRTFGBpam/BnDPplH+j+wAghxPfb1N4576ogWrGHevzXUyqt4JThR
	 7W9KRW3P8oi8HVI1RfafNCFx0GPklTHRqvyP6SNkDnTOSFupGKwDECsUo6q/DA0oHz
	 fN9T2deWIpyMw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 47/60] netrom: Fix a data-race around sysctl_netrom_routing_control
Date: Wed, 13 Mar 2024 12:36:54 -0400
Message-ID: <20240313163707.615000-48-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit b5dffcb8f71bdd02a4e5799985b51b12f4eeaf76 ]

We need to protect the reader reading the sysctl value because the
value can be changed concurrently.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netrom/nr_route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index b8ddd8048f352..89e12e6eea2ef 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -780,7 +780,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 		return ret;
 	}
 
-	if (!sysctl_netrom_routing_control && ax25 != NULL)
+	if (!READ_ONCE(sysctl_netrom_routing_control) && ax25 != NULL)
 		return 0;
 
 	/* Its Time-To-Live has expired */
-- 
2.43.0


