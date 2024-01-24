Return-Path: <linux-kernel+bounces-37184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6CC83AC5F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097AB1C220A8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DA085C54;
	Wed, 24 Jan 2024 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQR0AxOb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0B5136659;
	Wed, 24 Jan 2024 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106723; cv=none; b=isZ4m6xwEfRkatE3JYBmIzi40W6iEB4AmS2tCuDZR73HaY7OHwmLjEA5nH9HbQWX/ALpWqVwfNWW3HSD4LeD/5D9rTEWGWMUFIqT8a8AV5QlLhEbKuqmq+1mnQYzqSSMU014AZzE79N6bndwsISiAiAahNWlNrUqWrI5nbmsiJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106723; c=relaxed/simple;
	bh=mZYcVx9gMgfUQ5ilhRlIwp9WinJInYUB+SgCavnzUo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQpFKeYaaoP+CwqtDV8I0R52b9MZCz7S9ORurgRHgYVqvEprjTPjTfuC39BS1hZ4Fuk4twmnn207JxWu1g7IvplFoJSpo2kB4tifnaBFgrRvBSCVyjGYiv8frqQZLlCtGGxjw9DjKXnmEafQRug/EjTd0vBw4ygJNip01J8NhfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQR0AxOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A558C433F1;
	Wed, 24 Jan 2024 14:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106723;
	bh=mZYcVx9gMgfUQ5ilhRlIwp9WinJInYUB+SgCavnzUo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NQR0AxObCk8di578tOlttQbYlmcmw2NvQ6tbKiG/IpVPfB6ESo/dbobmTbHAQIKO1
	 HWBzpKP9JPPNuRTc/8E1tRzdyagqlDqF54rT7WaXUXKTT0p7uid5OywRZRYfDXnJnd
	 zR+y4NP6l0+h/W3dz32O/ahfqYsOmmYp1SYdycsoK5BokHk3s22/e2AE5HD/wTTuw3
	 a5fEzjzyqiJtWEwyp87iMW6jSbpNHrSTXw0HNNzGDl9T6nqSBT2vpeNNvUlugmdIdv
	 037H2SFQDvBgH1KNwDFgRAARi2TWnqF06XzeO+7ydHajWP59edy+8rkrQ5Vv8/8glh
	 uwP7GNhCe4zjg==
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
Subject: [PATCH AUTOSEL 4.19 4/5] um: net: Fix return type of uml_net_start_xmit()
Date: Wed, 24 Jan 2024 09:31:39 -0500
Message-ID: <20240124143149.1284622-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124143149.1284622-1-sashal@kernel.org>
References: <20240124143149.1284622-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
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
index 3ef1b48e064a..0216e3254c90 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -206,7 +206,7 @@ static int uml_net_close(struct net_device *dev)
 	return 0;
 }
 
-static int uml_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t uml_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct uml_net_private *lp = netdev_priv(dev);
 	unsigned long flags;
-- 
2.43.0


