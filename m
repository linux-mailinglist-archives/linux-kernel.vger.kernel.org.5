Return-Path: <linux-kernel+bounces-28015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE7982F91D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE1BA28465E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367D713EFFE;
	Tue, 16 Jan 2024 19:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJqlJ3O/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7777013EFEC;
	Tue, 16 Jan 2024 19:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434841; cv=none; b=dkQ085skN9aZp5SfCT7EbQVBEVOuoP0NTL3Bx31xR9I2BrWskjGL30sAC9yRM4pNpfA7ELAoH2nWWIhGgb9sGWGL7vR14KzN7q+HuzLLhU9WXayO23S5yxmX797SiA8GsBJzv8o70JgukBICaPOjD9I6V0gc+GCy1ZErTQfmcUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434841; c=relaxed/simple;
	bh=zutujsRMdZhrU+KgfsLpX4GoUcelJZb0Go6/dPDMhWo=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=BaKIyCbkmJg98DlWJh5DRZxhstJffAcZGdnAd5XpnDeXNqiE1c7SsK2KINffEu+EGeUUwyWAnuDhBYbZplHZVgzHlHy9vBmI5S2GRpISTTNzdYn5AhoR7MzIyZdlfwps5gP3Dvvo1ammVnK8Rm9YSfYEJm6hII6QKfTtXCawjok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJqlJ3O/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BF5C433B1;
	Tue, 16 Jan 2024 19:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434841;
	bh=zutujsRMdZhrU+KgfsLpX4GoUcelJZb0Go6/dPDMhWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YJqlJ3O/vpcbQ2JWk+W9ICHpNyIWN4DGwcsdf+dFSP/gyQrWBcsrSURQ3k0DxdVi2
	 L1ipcloKEKX93iLQKEq4LBqmXQ87xsacYsUSS6JTuWlMh3m85fWxugWZMbtkc1OLBM
	 zJ8XBhvcSWj2nZWZhu1t4yKe6OejHI6uiLdk3NOqbmLgfwFH3iR2kZq3zkeliAe6zT
	 6/uZRCbFUF5QaFxPLlnOYbnMOvWh0iwzbTlGL3vPYh0gkLDW1Sb/TAQbhxtnKKVeZO
	 2zimg6bvYPjlKF6txO+p0iVmyjTiazi3KGQrywZN42IcMdpa+tfzKNhJgBVB/qF/Pj
	 yAcoqjnkkDtbw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dhowells@redhat.com,
	syoshida@redhat.com,
	peilin.ye@bytedance.com,
	kuniyu@amazon.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 103/104] net: kcm: fix direct access to bv_len
Date: Tue, 16 Jan 2024 14:47:09 -0500
Message-ID: <20240116194908.253437-103-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Mina Almasry <almasrymina@google.com>

[ Upstream commit b15a4cfe100b9acd097d3ae7052448bd1cdc2a3b ]

Minor fix for kcm: code wanting to access the fields inside an skb
frag should use the skb_frag_*() helpers, instead of accessing the
fields directly.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Link: https://lore.kernel.org/r/20240102205959.794513-1-almasrymina@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/kcm/kcmsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index dd1d8ffd5f59..083376ea237e 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -634,7 +634,7 @@ static int kcm_write_msgs(struct kcm_sock *kcm)
 
 		msize = 0;
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
-			msize += skb_shinfo(skb)->frags[i].bv_len;
+			msize += skb_frag_size(&skb_shinfo(skb)->frags[i]);
 
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE,
 			      skb_shinfo(skb)->frags, skb_shinfo(skb)->nr_frags,
-- 
2.43.0


