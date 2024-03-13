Return-Path: <linux-kernel+bounces-101851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6BE87AC25
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B48A28146E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BCA745EF;
	Wed, 13 Mar 2024 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsRMuTIl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC13A745C8;
	Wed, 13 Mar 2024 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347887; cv=none; b=EMm0rEPR4nRRu2aYLPfQcHiK4P2QK7rXeymWddZLk+cu6lv/VuJhtPXC1xCHNaJVQnc8YBfMrn7iMd4iSTvvsdSJYg0RzY1Qoge27wiVcx6sHNope4B6fxvWGCW+DfFPN5RoHvUf2GJtamBzVDDSJHBdg1mDOf002Lxj4XEeLP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347887; c=relaxed/simple;
	bh=D4rW9sjI93khwkpaWq93aiNXmRpAIL3WWyb7UQAT1cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GE6L9bn8JKx5J1wzr7G4JvonOfHLFq8S09jOhrHp7TbOJGiVWBDKIcluKYdTV+8sPCeI8Hc4ROhIK5K8oeLxnSQ3BtjqFVKs7vk7LhsBJi5431Eme4ZyOiq4XZ6xLeWmtyCIrqH1+oeeehru14R1so5fkFaeMMwUKD0hUNGMi28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsRMuTIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0D1C433C7;
	Wed, 13 Mar 2024 16:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347887;
	bh=D4rW9sjI93khwkpaWq93aiNXmRpAIL3WWyb7UQAT1cQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lsRMuTIlxPAmbsHKqPabf/ZcoaofTdJHI/YIuYcOLatp/65u7hTvuFtb41tYIaJTX
	 T8X6ud9LNNs+mWga4OPuSKZTe2DdFI/xnoQsIVjMnaSEH26iwwKla2PanqNSKXXTJE
	 2IdSLVjKdpIC1Dnrcy7aYDjAzkbq8hsFiiC0764zgf7WExWVbukvf0sUKznEpIFdug
	 0z8TFNupWAc4ZhIpSVqQ1I7rqkm1OIbe3/5xsif/mqZhzvT0qHjA4QduBkE1cAufFC
	 vjKsd2sbOi55qpoSG7Tbg4gLvzs9FTUA3PQc7J8UsqQqN8HfePEGhT3+C8ZD1ODIlC
	 plj+baAm4qQ2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 48/60] netrom: Fix a data-race around sysctl_netrom_link_fails_count
Date: Wed, 13 Mar 2024 12:36:55 -0400
Message-ID: <20240313163707.615000-49-sashal@kernel.org>
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

[ Upstream commit bc76645ebdd01be9b9994dac39685a3d0f6f7985 ]

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
index 89e12e6eea2ef..70480869ad1c5 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -728,7 +728,7 @@ void nr_link_failed(ax25_cb *ax25, int reason)
 	nr_neigh->ax25 = NULL;
 	ax25_cb_put(ax25);
 
-	if (++nr_neigh->failed < sysctl_netrom_link_fails_count) {
+	if (++nr_neigh->failed < READ_ONCE(sysctl_netrom_link_fails_count)) {
 		nr_neigh_put(nr_neigh);
 		return;
 	}
-- 
2.43.0


