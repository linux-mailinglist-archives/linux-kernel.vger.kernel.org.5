Return-Path: <linux-kernel+bounces-101842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B70987AC10
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0361B259F0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF99971755;
	Wed, 13 Mar 2024 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQFfbLNZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5C971740;
	Wed, 13 Mar 2024 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347878; cv=none; b=dJNEI82U1XPhcjVUbuzgaDOao1GIKddoEEGwXJiACKoexwv/gREFaWAFRxJfjOA5L9TOTEnAfYBuDNgkvCYDZHqNUO+7RDOPZoD/cRjOoMlHvjeVG9nvaopgOHY2rJoS+a210ClTJ6FvIoy9YBRbZ22lGWTJoL/EFAcPH4+7A4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347878; c=relaxed/simple;
	bh=zoz/s8A/E4JPfDEwpZXOOhtjTptdKp3RunG4UOVpAz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUW5Zv3Mb+hyBHMMNvXIRfa35WtJj3PY1dl6Hll8eJcheISTfjsO77XbT3dIwssJL0+HP6P8n+Ij7rgplJVbYMQTiah+rLSnQafb6zlXL1a1ugRjSO0OmpRXEG0h3KMg6EL4qyCOOmUObTZtWsUbNxbE/FzSjvIMQ1q//VuaJB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQFfbLNZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439F8C433C7;
	Wed, 13 Mar 2024 16:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347878;
	bh=zoz/s8A/E4JPfDEwpZXOOhtjTptdKp3RunG4UOVpAz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FQFfbLNZbfmuthY4IdzwQExQ0HALlUnRtQutUU1PbPKv4yHi5vyP9yuJt/+q2reFx
	 2RfGL6jlIJDfk4LJ2tnrup+B5CnwNgnYKwMv2P2gpayXGJk8YsfgZExVv0Bo+Zn142
	 0jnsUElA2DzksF4peBjvFrkNFc/BL0TO+O+0317I7TmidjEnyr3Hew69+y9XujT9WI
	 iWqwWzHgNqlTR/ZW01Zad6v5xx6ywQLCEttmpDZw/4bC24tDFaQQE7tm2QIiZrsEIa
	 BXhAHrZAi7OgiI9IF90oZLrqmopbtCZT8S6eoxuE/sQJPnt/WJ7Akccv6UUs3WHU5g
	 atA6vLYjRhwVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 39/60] netrom: Fix a data-race around sysctl_netrom_obsolescence_count_initialiser
Date: Wed, 13 Mar 2024 12:36:46 -0400
Message-ID: <20240313163707.615000-40-sashal@kernel.org>
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

[ Upstream commit cfd9f4a740f772298308b2e6070d2c744fb5cf79 ]

We need to protect the reader reading the sysctl value
because the value can be changed concurrently.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netrom/nr_route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index 6f709fdffc11f..b8ddd8048f352 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -766,7 +766,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 	if (ax25 != NULL) {
 		ret = nr_add_node(nr_src, "", &ax25->dest_addr, ax25->digipeat,
 				  ax25->ax25_dev->dev, 0,
-				  sysctl_netrom_obsolescence_count_initialiser);
+				  READ_ONCE(sysctl_netrom_obsolescence_count_initialiser));
 		if (ret)
 			return ret;
 	}
-- 
2.43.0


