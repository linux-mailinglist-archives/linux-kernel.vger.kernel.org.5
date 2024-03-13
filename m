Return-Path: <linux-kernel+bounces-101956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3AF87AD12
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3B01C20A09
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E010663116;
	Wed, 13 Mar 2024 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rms4OHVa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2219C13AA3A;
	Wed, 13 Mar 2024 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348165; cv=none; b=n2ZJtUviQjS2Dh1tsDERcuauOcIpCB5h0cjO4DC001z88zqjX2fuCCWqNfhK3pSXqG1PUHZvePpODxwOVyAkqF8GHBokU3Kj8WrWzz6i7jteeRROSzGMTf0SJfCxDDS8zUpud3D+aKTSNR3g9/NrUcPMm5EsKqnCVPHlAugv65M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348165; c=relaxed/simple;
	bh=rWMYncKdMocrxg/cIRj1vKvh3WgJfF1dzGcufwTEIFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1yLof09aT/XbEtJ+ORY8rC6KEzr7suT5qVfTj8PFN52TArMsTmUiO2Slqipa5YtgI3EKR/81nZT/YmFGZaq8WhYRtIPEoDQCXO0wK1ZddlCSdLRNVI27pCyuwr/1eM7p0gmUd/JYhTJJdxCT4HLTK0ZH5ScZdTgQGzEh8qOThQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rms4OHVa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E02BC433C7;
	Wed, 13 Mar 2024 16:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348165;
	bh=rWMYncKdMocrxg/cIRj1vKvh3WgJfF1dzGcufwTEIFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rms4OHVakEouPbnK9qk8bySPUEdwICpNfi73j0xRQn6X06Qzu089Hf6mPptg5f1BT
	 n50/hTlha3hxu3y3bw5d/xSdVDg1OIh+A7/bIdMSf132V/9vL2AvFJb3WBE9rFrjT1
	 kFeIfjQ8DGMs9GZM13D+PCwQ16Q6XW2ohUNMA5NLJCYx4e1Z3GlRCVUgsIA6BVM+N5
	 DDPgcV94VObMsJ3L5l65gxcPu2Vr20hrcl00cmcSv9Ip4fy6FyXQ43LyE01jyGToUz
	 uCdJ/USV98pjBPZ7tBW2kOBUf2XLdDwY2ZLBtO8vAUab+zsm4pvN1MQsU3qziEZYIe
	 B8KMF5FfNXrcA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 16/76] netrom: Fix a data-race around sysctl_netrom_default_path_quality
Date: Wed, 13 Mar 2024 12:41:23 -0400
Message-ID: <20240313164223.615640-17-sashal@kernel.org>
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
index ddd5cbd455e39..55cd51977fbc2 100644
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


