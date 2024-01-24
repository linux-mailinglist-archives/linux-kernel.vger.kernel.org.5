Return-Path: <linux-kernel+bounces-37178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EB183AC53
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085C91F2456C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349ED1353EC;
	Wed, 24 Jan 2024 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tU1uNLvM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717CD1350FB;
	Wed, 24 Jan 2024 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106697; cv=none; b=b+C0pa1vZYWgpOZnpY9TmgfZ+E5kQSM7T+O0oZwvywe7IIzSCmCWHnicVkoTNZIXVyS6ztmmLkPFrliSvjGce46uejNClIlvkMiTfAOOaFwFrPqrMC8PV+KM6VywvbAI01pMKzdGIrFm+sPZ7yrvve7uokFncGDNAuSgM5iBUxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106697; c=relaxed/simple;
	bh=WPgTDbwZHBEEvDEi42IR8aSgfy52la3w+9qNgLVPM6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJ5XxV901t5vubiHVqmU7Ui2xSprAZsqtZybBkT+HyxZ2/pAt15Qdg1HdqUHtT/Sh0d+JQjnxeJGMMHWXddf8GhSXWr61JTbvrqQrHYaXApRf/+DhP4p3jee6++rSkh3pVIeoD4fsUKf7CobgaVQxhTWlPKwjriMjgJRZ33RWjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tU1uNLvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8C2C433C7;
	Wed, 24 Jan 2024 14:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106697;
	bh=WPgTDbwZHBEEvDEi42IR8aSgfy52la3w+9qNgLVPM6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tU1uNLvMatxyaJUIWvtjFwDYd+xVjDXao0Llb5bryLt2JwP4mWckOFMeEVNNeczLq
	 bZ3rfs5n8nWxz4jXBXMYYsdS8i5v+1s3MT4M1MWOnoQJH64F1/4zsz+O7IWjEXG1fv
	 bDvlarA402TGXW+hVO9knaUgWyjeBSTs0qolJqW0Ye3oqf2Hc0DAWXDWEN+p1xceE8
	 COOgXWzlfGw9dCqbZhU3jMMaKvpJl1Ju9K5Y95laMwf4ES92B7T6/hBv0zf2lAF7hr
	 rWiZ11A1aVJTdRnlzww9qfkLRp7IqRVvVbThcehG0cQGurUkjGcBEVhmRt2MVzOUJ6
	 h4i6KDJhe2Jag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 5.4 4/6] um: net: Fix return type of uml_net_start_xmit()
Date: Wed, 24 Jan 2024 09:31:13 -0500
Message-ID: <20240124143124.1284462-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124143124.1284462-1-sashal@kernel.org>
References: <20240124143124.1284462-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Nathan Chancellor <nathan@kernel.org>

[ Upstream commit 7d748f60a4b82b50bf25fad1bd42d33f049f76aa ]

With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
indirect call targets are validated against the expected function
pointer prototype to make sure the call target is valid to help mitigate
ROP attacks. If they are not identical, there is a failure at run time,
which manifests as either a kernel panic or thread getting killed. A
warning in clang aims to catch these at compile time, which reveals:

  arch/um/drivers/net_kern.c:353:21: warning: incompatible function pointer types initializing 'netdev_tx_t (*)(struct sk_buff *, struct net_device *)' (aka 'enum netdev_tx (*)(struct sk_buff *, struct net_device *)') with an expression of type 'int (struct sk_buff *, struct net_device *)' [-Wincompatible-function-pointer-types-strict]
    353 |         .ndo_start_xmit         = uml_net_start_xmit,
        |                                   ^~~~~~~~~~~~~~~~~~
  1 warning generated.

->ndo_start_xmit() in 'struct net_device_ops' expects a return type of
'netdev_tx_t', not 'int'. Adjust the return type of uml_net_start_xmit()
to match the prototype's to resolve the warning. While UML does not
currently implement support for kCFI, it could in the future, which
means this warning becomes a fatal CFI failure at run time.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310031340.v1vPh207-lkp@intel.com/
Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/net_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 327b728f7244..db15a456482f 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -204,7 +204,7 @@ static int uml_net_close(struct net_device *dev)
 	return 0;
 }
 
-static int uml_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t uml_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct uml_net_private *lp = netdev_priv(dev);
 	unsigned long flags;
-- 
2.43.0


