Return-Path: <linux-kernel+bounces-102133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B71E87AEB1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B941F2F5B5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790986F08E;
	Wed, 13 Mar 2024 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3IzFWE/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85346F069;
	Wed, 13 Mar 2024 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349349; cv=none; b=L96TNLVWSpko3GLOE7cKds6N0aUIQIlaWRdpwI3ll0HxezGJXwQV5HBRlDqDsEO4R/cT9LxNOb5r4KnSjh20XvfrAs/I3sU42bEFRoVsJa2+k9alCMcfac2DRWftt6tZ2WKzPI0x0qwCA7andONMyDg64C8Tz6JhNwDgqD9k7lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349349; c=relaxed/simple;
	bh=l/CM9cNtzUmoj23fIZpLxyaZqa5jZnBswmiV9CkHVGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvN2xdOSl9gtVApmCt9EQVvzZSRpeEBPww7qfpnPL7E4TgkEyshthdm0dQvQpzooJVJ3erIcOAnMnBRpBE7H7tcaxiB3UsOn0GL1dYAbD+zNr3HtlZ7Ot8BUBUUwbqrbYEBmguoO0cMTuc1wdtrgZHaFUJFNwyP4GafkEavb4bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3IzFWE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8733C433C7;
	Wed, 13 Mar 2024 17:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349349;
	bh=l/CM9cNtzUmoj23fIZpLxyaZqa5jZnBswmiV9CkHVGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X3IzFWE/x21EkG7ZKVIT4iaTmXthwZNsWDvEYPcWBzxD5nWhH6IXrgx4ip1kRbn4z
	 4NODl4dzx9gAidGIqyfaMPOLOuuk2O9tCIKYF9cJsDoxnegsjk2437aDhXToD5UG2J
	 Wfa7UpXk5z+dW29qo7Fcd4/L8X7ttmFSR3GkuV4hmXjOJbTtyljLuCVzcwHsVHA9Sf
	 RbMGjAIX2oov4MtEZWpwRWee07ah22gaiigzIpmz/DHtgFDw66hnokXI5lY51jbXo8
	 SWfSy9YzZX331lu6OZsNHMI/MxJe5wJI0Hs8PXHLKdKdxDd/nJYse0HxllbFacw8Ei
	 UAS/jzYPHjh0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 13/51] netrom: Fix a data-race around sysctl_netrom_default_path_quality
Date: Wed, 13 Mar 2024 13:01:34 -0400
Message-ID: <20240313170212.616443-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170212.616443-1-sashal@kernel.org>
References: <20240313170212.616443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.272-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.272-rc1
X-KernelTest-Deadline: 2024-03-15T17:02+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit 958d6145a6d9ba9e075c921aead8753fb91c9101 ]

We need to protect the reader reading sysctl_netrom_default_path_quality
because the value can be changed concurrently.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netrom/nr_route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index 89cd9de215948..b7be86d41d965 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -153,7 +153,7 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 		nr_neigh->digipeat = NULL;
 		nr_neigh->ax25     = NULL;
 		nr_neigh->dev      = dev;
-		nr_neigh->quality  = sysctl_netrom_default_path_quality;
+		nr_neigh->quality  = READ_ONCE(sysctl_netrom_default_path_quality);
 		nr_neigh->locked   = 0;
 		nr_neigh->count    = 0;
 		nr_neigh->number   = nr_neigh_no++;
-- 
2.43.0


