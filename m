Return-Path: <linux-kernel+bounces-37134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB4C83ABEB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 619B5B2E3B9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CF21272D0;
	Wed, 24 Jan 2024 14:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKTF24G0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722501272C1;
	Wed, 24 Jan 2024 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106564; cv=none; b=Qc0G+mrWUNQJaWqTADp55P/j/yDk0rIk12ZGbLY6XG9sdYprfLCyyPgvI3PaTxVk4yFZecu9mwgFXWlCPwUhJbbfkiy/4iePzZg9LajqGqchnZAPNi4jcDDlDwAoOUDzQdVSemPs3+qtrJfhRBcQtbuJwkbOIFdCn0QBTwDbSNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106564; c=relaxed/simple;
	bh=wtfwbC0flSGPe7mDEkJ8Xw4cI7oiAV5gBbx/tJOQfFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8k1OIoJSIBASZl6pE9AHbOrQiRNp7tm55jix+uOxAfVkc2k+JOn5z6x9YN8OivJZBM0aX6M09Pld/sTp+0j14i6sna8lRsNOi/pC1r5pVzWK7gzrwbIOEsSn+ReD/mtpUyRx5LRNq54iuVVB1pKPWYTel7C/USd6KuEPZEjfc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKTF24G0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FBBC433A6;
	Wed, 24 Jan 2024 14:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106564;
	bh=wtfwbC0flSGPe7mDEkJ8Xw4cI7oiAV5gBbx/tJOQfFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XKTF24G0OP+1OE57E8tB+YOOc/AwtRDZ1KeJXGt8DZnA8m8128GzN912SgCsamU+G
	 oPrbgxh+YwWA/mrUVTuavr+VIr0KK+VXroHhM0WrS5YwzY4JBs3DJfKRUWoqHt7zmP
	 F+qsUs7LT1B4rGe2hmG6jgrP1xk1m+E8nul7pzHs6fT/84Y9GnHMNVAE2v3ecTXNyl
	 mVu/onWtZvDl/hp9DuKNGlLNuDrjd6uISpjmcAjWGjI/7XCesq5mxuv7b8G6RPhahN
	 kRdcZLQPzEmI0ajYQRtjDpwJRIjbuhZnuL5YUGb4k6Q8RgsyHQ0Epz9WwY4yfWFQjf
	 WyY/m+ouNzZdQ==
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
Subject: [PATCH AUTOSEL 6.6 05/11] um: net: Fix return type of uml_net_start_xmit()
Date: Wed, 24 Jan 2024 09:28:48 -0500
Message-ID: <20240124142907.1283546-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124142907.1283546-1-sashal@kernel.org>
References: <20240124142907.1283546-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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
index 3d7836c46507..cabcc501b448 100644
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


