Return-Path: <linux-kernel+bounces-101787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CD787AB93
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9211728564E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA896518F;
	Wed, 13 Mar 2024 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHLKq9th"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6556518E;
	Wed, 13 Mar 2024 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347622; cv=none; b=G/Ju/XtB6cVLSutpy8QCnEhY6Nu5KxVBe6D1jztajCsIMP5Bf3McP+pPSTR/DmlOOohHYjcHk20rsQ40ptfCJXpbBiu2czvjOcMHap+mC0OxsXx1aQPLrIR9ncE+kN/OGu4A4fmKXvvipya//6ixVpDG4A7ghrTRMXwdyudur98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347622; c=relaxed/simple;
	bh=50cYx1tS1wHW2mJ/yB8+DCwD4D+TAt8HjU5iUpgnBss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLW3Omxjcbcak9P+fKe/JHVBB4mGadkxLg42lrYMRpgI9JJV3RmWXj84cY/EZbezRUu0Eosv0aZqiAWcDumjSPbO379D0N5PCTZLyGi58kJuPE3eXYlbqxqjdOkcOgDFc5r+19YXuI+Xc5E7opVXedlMLeykQlsAm6SfMOUADJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHLKq9th; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1841C43390;
	Wed, 13 Mar 2024 16:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347621;
	bh=50cYx1tS1wHW2mJ/yB8+DCwD4D+TAt8HjU5iUpgnBss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LHLKq9thMhoJtRlr5lFmtd9OEF7rwc4xxBxx66dAG7bX3KOEKrfiVnLVwUqbkywxo
	 CnNe88yxSFtqq0Qmu3UtoXR+gsSAWPWtr+abSX1PxQRUW/eKGgIKYpAyes++31rbEh
	 WCVYDZCqdqUY+W5qPJnEhdVZNFcklINiVkcs5b8Rouaov9YvtXscx3GLGiQOUQQva+
	 Cr6DsD8EoMkNoQFk2CRfKD4Ksdqh5BisI75Hw6cHHgAqZCyF7Pq3cJRRWjYWYNKmr3
	 vrjU8ae8Qk7vt2Uj+th7EKRp7DIbBbS9pTHRITuz11BabB0FaJFMYjVGgDnkiz9wac
	 ojlABnARGeLMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 48/61] netrom: Fix a data-race around sysctl_netrom_transport_acknowledge_delay
Date: Wed, 13 Mar 2024 12:32:23 -0400
Message-ID: <20240313163236.613880-49-sashal@kernel.org>
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

[ Upstream commit 806f462ba9029d41aadf8ec93f2f99c5305deada ]

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
index 312fc745db7ff..8ada0da3c0e08 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -455,7 +455,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 	nr->t1     =
 		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_timeout));
 	nr->t2     =
-		msecs_to_jiffies(sysctl_netrom_transport_acknowledge_delay);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_acknowledge_delay));
 	nr->n2     =
 		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_maximum_tries));
 	nr->t4     =
-- 
2.43.0


