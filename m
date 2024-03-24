Return-Path: <linux-kernel+bounces-115742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC665889492
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E711F33970
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756EA25ED63;
	Mon, 25 Mar 2024 02:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+VyzLFd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A61215665A;
	Sun, 24 Mar 2024 23:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321873; cv=none; b=r8aP+Yy8f0z+350eRkOXM/TqiggAUNRGt+APV/tjHfK2e2+WEgOlZjOEC3P06CDyR92XMD4NG4MBWLP43nhZFMkyPTSa0h5BjGQAWoqlJOSiqG+lU39j5OHUzl3yxJDh3lPU6VRDoiZfJbnK/Xm01aVIYC9PAIGaxwYAM0rcyBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321873; c=relaxed/simple;
	bh=IPQUPry+ITtcAdi3zYmL9JlqymXhYmP6surBfz44xq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLXti/53hWhTauOjaebwnEpljI6cg2yXNphzwMiYczXjfCNeHvdEkyuVnZH3HL7QF7LOYT13zyyhBx+Mx8tWZNlcDUDQbk2linE2J5THoISF3ohAkpZCNxBS1oKacuTdinODhgvcW6Z7mhNQGuCeinRSvXPI/7lvyk+LJfKWVjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+VyzLFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C13CC43394;
	Sun, 24 Mar 2024 23:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321873;
	bh=IPQUPry+ITtcAdi3zYmL9JlqymXhYmP6surBfz44xq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m+VyzLFd0h15Iwi3+Zxq5ZMKHC1zWab0GeI1QuzND2B3FomWYvaN3OAV0Tj+T7Bgx
	 IgNtJgIB9EfpNGO3HnXLGeNmuSYukG4wb2Sa8tME+RBjM9dN9Whfkw8JNBMhfD4Cpu
	 VWAceR05xD4fs8mniF9PJHgVCfqB41JSbyq5P6ojjEjEdsdUBbN3qboKYLglwML51m
	 dpkybV1PYeQaKY3NytiY0eq7NX5XuQM2OjJjxqANbm0pvaCk1iGVYcElrdGKKIoamh
	 hoRhQpAQtHPgJVfeuhQx1tPCur0XmrSsRjG/QRPWqCzWXEZrynLAvNOKnmtg+nkLue
	 CLAG5xNaHyAwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 601/638] xfrm: Allow UDP encapsulation only in offload modes
Date: Sun, 24 Mar 2024 19:00:38 -0400
Message-ID: <20240324230116.1348576-602-sashal@kernel.org>
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

From: Leon Romanovsky <leonro@nvidia.com>

[ Upstream commit 773bb766ca4a05bf363203030b72b10088869224 ]

The missing check of x->encap caused to the situation where GSO packets
were created with UDP encapsulation.

As a solution return the encap check for non-offloaded SA.

Fixes: 983a73da1f99 ("xfrm: Pass UDP encapsulation in TX packet offload")
Closes: https://lore.kernel.org/all/a650221ae500f0c7cf496c61c96c1b103dcb6f67.camel@redhat.com
Reported-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 653e51ae39648..6346690d5c699 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -407,7 +407,8 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 	struct xfrm_dst *xdst = (struct xfrm_dst *)dst;
 	struct net_device *dev = x->xso.dev;
 
-	if (!x->type_offload)
+	if (!x->type_offload ||
+	    (x->xso.type == XFRM_DEV_OFFLOAD_UNSPECIFIED && x->encap))
 		return false;
 
 	if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET ||
-- 
2.43.0


