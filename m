Return-Path: <linux-kernel+bounces-37146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1EA83AC0A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C58288BC7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6EB12BE8C;
	Wed, 24 Jan 2024 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtQCUZ2W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A3E12BEA8;
	Wed, 24 Jan 2024 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106603; cv=none; b=EKDGFVnXq8/idwTWNn5wwjOo9pHt8PIR4oIr65ENK0B7b25IhalZvpo5nxwUBAmMeMaJUdJfl0leTr3CDHE32f4X3gYcmU2WzTVRxzpTOGwWSbPV48JHaKzLU7HNlevdx3zwKwiU5yzpRxSXawRVgiTFoMrL3tDqOYFNU+v3ynI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106603; c=relaxed/simple;
	bh=wtfwbC0flSGPe7mDEkJ8Xw4cI7oiAV5gBbx/tJOQfFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBqWe8LR7oxZ61fzyt2yWuBp3BnUWhn445jMo9tOGDZt7IZZq3NpqeCkA1k7Xp8wt+zTGdrwR/mr7Cr7bP3YVAJMtxchLBk0uieizj29HSfjyckEXm1I6VfapdHVV/Y0C6nyFQEbbnz2qAUEPmmgMgGpEvWeXp9UwpIcKTnzRUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtQCUZ2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98591C43394;
	Wed, 24 Jan 2024 14:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106602;
	bh=wtfwbC0flSGPe7mDEkJ8Xw4cI7oiAV5gBbx/tJOQfFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jtQCUZ2WiTKNORqSethBN18uwn8Q0wjKJBsFDo7tWFygB5Tt3iBw7It2vQUJJfNAP
	 qgTnIM59R607PMCwFnw0CpxHGWcbMq2IRoAkB+JEBfTqh9Dcg+RwpLyN6G7q/Q2lQN
	 QvF0Ml8gPAMX1Rj6FIImFSvU/M4NmRDTrkKco46pdloQ/cKsHVfJq7apE3FR3qmZOz
	 1S38uZgE8rqQY2RrAJti4VZmLkwzN4kQ/DBOCtIAhvfo7UiaJRPPONiRDwa4mE6cZu
	 CuSK54QD7zhyd8yoBsUtISGLh5auorsojB2mdVTJL8SY7AOziGBr3XmEuZyEU5E+Mb
	 10wmmjxUUmSng==
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
Subject: [PATCH AUTOSEL 6.1 4/9] um: net: Fix return type of uml_net_start_xmit()
Date: Wed, 24 Jan 2024 09:29:34 -0500
Message-ID: <20240124142949.1283818-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124142949.1283818-1-sashal@kernel.org>
References: <20240124142949.1283818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
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


