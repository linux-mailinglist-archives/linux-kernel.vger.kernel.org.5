Return-Path: <linux-kernel+bounces-101965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A1787AD25
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2031C21824
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A884142908;
	Wed, 13 Mar 2024 16:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbYXXriC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B281420CC;
	Wed, 13 Mar 2024 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348174; cv=none; b=AH7f3jKvsISf3NvjqZwESGAXPgRt1jWkCT1zMM2QJovlx/fxWWvPejWiP13tEZG0eCOYHE/0Fd59g+aPm1PdMjTTS4uYr4/XxtzSYWq6Uo05VlD//135TVWuHfZAqRKxiTJJlUGJZNUMUWqgk45UZ4y2zTiZkiMkBqaPSIkJDnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348174; c=relaxed/simple;
	bh=H4DfSV2MBlhDn7HAlV8mC+leAoVxNyHqkIWIC7yYs+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTxu71f8iepXCgp1bd70uTo+1g4FkHxFNjMPif9CNpupnWEoc8TmqYNntFgBFD4EBLiu7gSOWAd1A9GuXXNlEMCMv0pbX4h16aiOgtRgIYzQ4tj7urg0iWaTAMLt+rc4ZWg9bMAFQG6T3Yg6pU/vkca1P3iKW0sQxbuw3UiA8Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbYXXriC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643EBC43394;
	Wed, 13 Mar 2024 16:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348174;
	bh=H4DfSV2MBlhDn7HAlV8mC+leAoVxNyHqkIWIC7yYs+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fbYXXriCqeIPpqtmHHHXgZHNGLCk+s7MsIrIwM9i1ssAo6cqhmR8cKjTTeGrloTYT
	 jXDzO4AortCT84P6jCHvjh4soqD76REpHvg5yTNbEF3+JTp21kXVhETlEanz4XJnih
	 e+YsK52cBw/dFc9yB7SGCLrkis4QUP1kevg4Zf65FwroNnxWRW542DMnSmxFr/1+Nv
	 ISQPMkUfzzoki+eoHztNj3siXnzwSICoe3R2Ju5sL72HKArbrhIkyjnbiew7ibklWe
	 qpGhe9Z6Uj4GOKIrYq+9wRxGNCYNE1ogikkqWeVfg0D3IPBf67vPcLSuJ4VykRuCIY
	 nsU5AMvKY7czQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 25/76] netrom: Fix a data-race around sysctl_netrom_routing_control
Date: Wed, 13 Mar 2024 12:41:32 -0400
Message-ID: <20240313164223.615640-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
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
index e5d24462d5100..56bec5b5b37c7 100644
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


