Return-Path: <linux-kernel+bounces-37158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A42E83AC2A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CDC51C21C64
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2388E7E795;
	Wed, 24 Jan 2024 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3qfDgTJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601F812FF67;
	Wed, 24 Jan 2024 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106639; cv=none; b=C6Lx9nypWId/g1kbWEnjwl97o/1Tajo7jU+ScIJLXzgvD+nGPRQBh1xLZhWY9wpnJYMTnzWwc7KWt880qq1l1lBTH7dH/mx07fTe+QZJTICXtYmFrQeHQttYtQZi+215uqntG5pxdCCfmueoDDf/v6rE/8+yzUp6m6QQfB8QIw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106639; c=relaxed/simple;
	bh=NBFJOzl5bfKAkHYYmyRbiEGkZcNR0p56JZOagMWvQEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmSkSvsULcnHF4eIm5DG0kVRpW0X7nsweoXWKaTzlxrp8952llw2s8qa0Y7I1KrG/xMV+2KP5OiNolGKaP/KQDwQTtth+lP0O6AauYPuLH4X36GZJ5lgNsS/CZQsFvyigFa9Ow+ElHEBCCoeu1xYcIZqR29IjVsRyDIGytDSk1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3qfDgTJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01164C43394;
	Wed, 24 Jan 2024 14:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106639;
	bh=NBFJOzl5bfKAkHYYmyRbiEGkZcNR0p56JZOagMWvQEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o3qfDgTJ3sIGNruqgsTbmprWgZnQJMWmJJQ7/njYJ4fh27MIXyAWhjv3ydD3Ups3A
	 fNg2wB63ENVO4CXARf5kBxkyzPNOfA9x3iEDwSiZJ2IHkGb24TUk33f7+TyuWyJBQY
	 JVonFNEDEqXZrV92t4UBsEqqCrJviCCwmxhVpHCPlklkpBogqT+sxQuo6dXYbfBx7p
	 j8Fdkta7UuuvfQY/FXCX6gSnhfAAOzqfbJ2xss03YLemP4h5/1T19DVARRIQTT6kgl
	 1OLpADN6Vt2WTAjLNwnM/OQX2bi8iM+xobEcn3N6BRept2uEE/3TbjrdmNffC9y2Xx
	 xcIsokphHnY3A==
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
Subject: [PATCH AUTOSEL 5.15 4/9] um: net: Fix return type of uml_net_start_xmit()
Date: Wed, 24 Jan 2024 09:30:07 -0500
Message-ID: <20240124143024.1284046-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124143024.1284046-1-sashal@kernel.org>
References: <20240124143024.1284046-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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
index 2fc0b038ff8a..e24bc9aaff4a 100644
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


