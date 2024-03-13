Return-Path: <linux-kernel+bounces-101789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAC187AB9C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30AB3B2468B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F740657C2;
	Wed, 13 Mar 2024 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3Ffo/YE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714BF657A9;
	Wed, 13 Mar 2024 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347624; cv=none; b=METNFzZiH489ihtLDvZ8spkmaoLfJiaKNukOnHAM70rciw68UIAA1YgOaLbJl4lfF4uoOp1kdeympoS6Jyg2yCr4/IP22isf99/NrZrZ1zp+bZNKPmAX9hDQ0VM2u5lwLvp82gqQnRECTv5p+1qK6ltCryeP9aq/Ji8aGqcJOU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347624; c=relaxed/simple;
	bh=b6KsHVP9jXsryXOWt2jPStQpGxz36MdmKep8sRoqC5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTNB8EsMnLsozv4fCVJ5me7Jx/2W+s9ALXkyXx2ZBIj3i4swN+oLhhdz+bgjEe+JmSXQrFuDlXvZo5wujv23co4PPaaBoxXlWhQitfnsMBQvy5djN4reXOEjcXJy96tsaNMCk7+9HbDt6+x1JxBQd+82ENgwBTKnU6Q4k2lThoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3Ffo/YE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BABDC43390;
	Wed, 13 Mar 2024 16:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347624;
	bh=b6KsHVP9jXsryXOWt2jPStQpGxz36MdmKep8sRoqC5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h3Ffo/YEshQJa8jw0/Q3RSgfYTEMb2i9MeT3OI0s80jM8sEFAqPrTXur4V/pUg2se
	 iVTwpan1w8AIz4gU7lAB9baO68EH/YyDLM+K7g0uD3nVh8d73C97D3e7SKqXAbjJGY
	 CrMZfgETMUVMzwFQGLcyCibEvaVntLofdCNTG+7q9t1W05cAPm+icU5usW3Rak9/5l
	 vwAR/xwhx/DnsswBWrObxewMptamohaB2tASuNBaNgL88/qfjMNt8opwaDC5iCY6AW
	 F9mV5CmabAiKDMw9e/RxM3Em/dOSD2H0/GuMIBDQ9M9wN5bSWri08LLj6yR1tdQQ/Q
	 GfC7YO0zGGFXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 50/61] netrom: Fix a data-race around sysctl_netrom_transport_requested_window_size
Date: Wed, 13 Mar 2024 12:32:25 -0400
Message-ID: <20240313163236.613880-51-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit a2e706841488f474c06e9b33f71afc947fb3bf56 ]

We need to protect the reader reading the sysctl value because the
value can be changed concurrently.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netrom/af_netrom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index 10eee02ef99ed..e65418fb9d882 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -462,7 +462,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_busy_delay));
 	nr->idle   =
 		msecs_to_jiffies(sysctl_netrom_transport_no_activity_timeout);
-	nr->window = sysctl_netrom_transport_requested_window_size;
+	nr->window = READ_ONCE(sysctl_netrom_transport_requested_window_size);
 
 	nr->bpqext = 1;
 	nr->state  = NR_STATE_0;
-- 
2.43.0


