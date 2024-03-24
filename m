Return-Path: <linux-kernel+bounces-113220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B7088826A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AAF51F21B30
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D66F180B9B;
	Sun, 24 Mar 2024 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEzgkEFI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0FC180B7C;
	Sun, 24 Mar 2024 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320021; cv=none; b=PYtaho4skRQi2ShBiLjRo0UxanJClRnYn4ahbVx5IsqEXsSHOmdNI7GFAgpfe9tyTtRF6/Mdms81iffTKyLk9I04S8paWG0X8Wn0urV/8cSkzwLyZVS6eLdvMbExT39C+e7axW7g1BR/ugvgD547fuQ1LxjvpzG6i+QJBgmOliw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320021; c=relaxed/simple;
	bh=FAT2yniJKJbWTQWBE0dDoAbysmicJfUvGas2RFGQpZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDEbOX8PA+jbLblH/ZK/+8h0Nn2lJgKeRxvdKx2thZBvTxYkavWUQlhxICFEoenzQTJ6Ban8nGZSjM1vDp3c6tZkDjzfgcaKs7q1T/nV4/JeZ5ooHyAfDe0wHLAG9ZY37V+dmXgGPWumVq97TrNXqjU7AdcuNamrBAKtMvKEq5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEzgkEFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6A5C43399;
	Sun, 24 Mar 2024 22:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320021;
	bh=FAT2yniJKJbWTQWBE0dDoAbysmicJfUvGas2RFGQpZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dEzgkEFILlTXNzq4zNgBuXXudyxlhgzMYEERqPIeE/D6Vw8v435PIQzB4qCPFquPd
	 zqJJQHPFhjzgWa1Asm8deB+3EbQLHe5gA41IopKDTMzKl7gmRVeV3lxFAwKr9QlQ2l
	 jUyRlLd81Tk4euVWWgKcuw2kLgucWqX1nBJXR8aTzM5HtTK4l+pb5Q8aT/SDf1i/pp
	 NGXSaF0IfJ3zqNDhMPaXf03G4DtTq0rSXJXOoC6zXL4DY0GPeNYDMpiPu80fHjJYtU
	 7SodCQBAZQkDwqTWPKzmCes2MTJZbWAKuR4i0gPmBci1/LRX5dOVGH5bZbr4mXhK9w
	 L3YQN3fbqWEbg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiri Pirko <jiri@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 329/715] dpll: fix dpll_xa_ref_*_del() for multiple registrations
Date: Sun, 24 Mar 2024 18:28:28 -0400
Message-ID: <20240324223455.1342824-330-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

[ Upstream commit b446631f355ece73b13c311dd712c47381a23172 ]

Currently, if there are multiple registrations of the same pin on the
same dpll device, following warnings are observed:
WARNING: CPU: 5 PID: 2212 at drivers/dpll/dpll_core.c:143 dpll_xa_ref_pin_del.isra.0+0x21e/0x230
WARNING: CPU: 5 PID: 2212 at drivers/dpll/dpll_core.c:223 __dpll_pin_unregister+0x2b3/0x2c0

The problem is, that in both dpll_xa_ref_dpll_del() and
dpll_xa_ref_pin_del() registration is only removed from list in case the
reference count drops to zero. That is wrong, the registration has to
be removed always.

To fix this, remove the registration from the list and free
it unconditionally, instead of doing it only when the ref reference
counter reaches zero.

Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dpll/dpll_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 7f686d179fc93..c751a87c7a8e6 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -129,9 +129,9 @@ static int dpll_xa_ref_pin_del(struct xarray *xa_pins, struct dpll_pin *pin,
 		reg = dpll_pin_registration_find(ref, ops, priv);
 		if (WARN_ON(!reg))
 			return -EINVAL;
+		list_del(&reg->list);
+		kfree(reg);
 		if (refcount_dec_and_test(&ref->refcount)) {
-			list_del(&reg->list);
-			kfree(reg);
 			xa_erase(xa_pins, i);
 			WARN_ON(!list_empty(&ref->registration_list));
 			kfree(ref);
@@ -209,9 +209,9 @@ dpll_xa_ref_dpll_del(struct xarray *xa_dplls, struct dpll_device *dpll,
 		reg = dpll_pin_registration_find(ref, ops, priv);
 		if (WARN_ON(!reg))
 			return;
+		list_del(&reg->list);
+		kfree(reg);
 		if (refcount_dec_and_test(&ref->refcount)) {
-			list_del(&reg->list);
-			kfree(reg);
 			xa_erase(xa_dplls, i);
 			WARN_ON(!list_empty(&ref->registration_list));
 			kfree(ref);
-- 
2.43.0


