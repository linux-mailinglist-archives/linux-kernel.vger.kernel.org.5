Return-Path: <linux-kernel+bounces-102197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC0F87AF57
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512B61C2556A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A7D1509D5;
	Wed, 13 Mar 2024 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLfKYPjo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005D976C7D;
	Wed, 13 Mar 2024 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349492; cv=none; b=mXkhZllv8W9RTpyufCbkOXimKiRdApGmoYd5e3CAtc1zAMkW7xUWtBKnsRju9HPGhEGYgVHij9wXfEUac30c/BsaJLACT3Vjg7hzaXA1rGUfOhAqWg/mKaXTtLKL8v9cLboaBPTkCOoJ2UmDxiGcItKgxNbkLkeB9QKuUJG0H3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349492; c=relaxed/simple;
	bh=pg3AI6ksEZdlcORWBo2CvZB6jVB+HNks4B6EK0JR8Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AiGGvL5w7zZZO52w96qjjwIDLmRuooHOcw/Pw1L0I064jQztkrR4/pzaeT5Kcyln+8RnvhsEbZQ455fpHbk0JIpyPlnSHZsKQwwt5DXywpQ+em0Ycvij9EvWE/dlD8AEo6/ufwsYg5O4/0nBIbOHg7JgHsLGcdVgAQLdQkYp4Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLfKYPjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D9CC433F1;
	Wed, 13 Mar 2024 17:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349491;
	bh=pg3AI6ksEZdlcORWBo2CvZB6jVB+HNks4B6EK0JR8Lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YLfKYPjoylqHXoNDT2uqX/Zm/gO9Uy0dmo6Xk5wvz0gMZO0kH7vUxDGMMhpAibzON
	 OdPSrt0XAX0Ayg+Lx+roilDjpIzK/Vt07VBYeSyxP5Hgc8DGVspPu9X0CJ/CGmtC+n
	 Oj398xxUMeXE4YwRX791vwpeBZlMS8ZXN5rgMnmn72ZOtaEw5kBau5gpg/BYuTFpvm
	 ENitXmavjQjVG/WcN8/70RXsKEd/iN57bBe8OeuSFsF0K3hw3jCgQ5thZ6MgyJVKhm
	 Mt4/oGiwAErNnTSDUsvWvAo5a42CRswInTok2MXg2H5XwCEPz/TZbSWCH/40igxz4x
	 bl7C0HKMcocsA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 12/41] netrom: Fix a data-race around sysctl_netrom_default_path_quality
Date: Wed, 13 Mar 2024 13:04:06 -0400
Message-ID: <20240313170435.616724-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170435.616724-1-sashal@kernel.org>
References: <20240313170435.616724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.310-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.310-rc1
X-KernelTest-Deadline: 2024-03-15T17:04+00:00
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
index 53ced34a1fdd2..e3ce3531608c4 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -156,7 +156,7 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
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


