Return-Path: <linux-kernel+bounces-101791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2498A87ABA2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F2B1C21A7C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D71535B7;
	Wed, 13 Mar 2024 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7savGLo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A246F65BC2;
	Wed, 13 Mar 2024 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347633; cv=none; b=tWMm/a9urlgEJpBDagx9Rlz/fgLCJOUm9os8ijFi3mykf2Yn/Ck+cbybWQO+cIG8zFISjzYKVJtq8uo67HFGY+yPUvX1Cf03zXEDjXWp4aiQYh2/PawTMI2Qdw88wLn4MTMfkqup8es3WJI/xGLOuprFpxKuZisFowNkajrlZxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347633; c=relaxed/simple;
	bh=3AWhKptyhC8XfLyB3pmytWkHsxrKPkwi3z7ElI2NOhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMGdHIf6eDCAwfLdZiz/Ck5xdI5LATGQsIAYxPS250FVdoSzy9G/Sj3WkNlj89gkAZA6GBZIlUrPXLwDLPF62bDMkb8sGypNKPF3ZKpl8Mdww5uc5j9ki1KptwmCmay4PvgXd37hDGv0eWmgkWxCQ5Rbt/xVmdmxoFShjom9oKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7savGLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732F6C433F1;
	Wed, 13 Mar 2024 16:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347633;
	bh=3AWhKptyhC8XfLyB3pmytWkHsxrKPkwi3z7ElI2NOhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M7savGLowgeTPa2bGzBQRcS7lnAUHGWfEt3JuQG0fgq7J+OBumHs9BHABd/AcSiv7
	 ANd12l6gxtcbD2/8ump56w3t2Xa0NdI1ur7RA6WY1Mk4x3mrbuKqgGohGucXrP6eBs
	 RSlxXJAhH6OSD5z0vOU+veBXsjs2BTMdKu27brXKR4bvCV1lzETR6LTHYyKmBq3Lv3
	 4Qo0TUDkYc0R33xf2KAfezd/gzok3Ww4gQ0aZ5Nnx+uTCdmCUR4sooRNMLHgj3daD0
	 6vXohQO6U73mcc41dc/Ll/kcZHN13bPoNktekW793i9Ybo9e+xQHxkIZ2aGRItkuGg
	 GVsBgxNR5bPCA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 52/61] netrom: Fix a data-race around sysctl_netrom_routing_control
Date: Wed, 13 Mar 2024 12:32:27 -0400
Message-ID: <20240313163236.613880-53-sashal@kernel.org>
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


