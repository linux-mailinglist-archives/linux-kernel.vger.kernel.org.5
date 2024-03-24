Return-Path: <linux-kernel+bounces-115444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 068BE889B9B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381061C34A07
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B72F214850;
	Mon, 25 Mar 2024 02:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCZLaLnA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE4D146A95;
	Sun, 24 Mar 2024 22:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320806; cv=none; b=Ae2GNjAlvwnjGJZ8LMhJ1gTVDsBnvZrRYxqJ75xAaZ9NTbHO5YhGRsHHe+tebplCk3KxlZHomYBwvVoQ9XfsiRDJrkqSl9lNgNzrc5TUjU4CsKuPjEfU6Hi7OjAJqSAU+591fvb7q/i9pVsT/YrZ8FX3Z7tBXxZkICNfWZlvNs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320806; c=relaxed/simple;
	bh=fGzJ+yDOc3uNG1UiulHN3KFRF0/HMCzgPfkQ8z7nWQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1Hcre/ksTVgHgr/9TXUHbzzF2WqZsDXMUkiJS94lQ6yKV0NyS1l4GgYD+HjNoHsw6IiaxEkpsZ00KPH1T9pqkdeOcU6ZAj3PrMIuSXhozC4WeQ5/+dub7EvMdI9wW7qpj+cuENrpPuZ29CIeLBQv93S4B6qyjrrMgRi0PNAdgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCZLaLnA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549A1C433C7;
	Sun, 24 Mar 2024 22:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320805;
	bh=fGzJ+yDOc3uNG1UiulHN3KFRF0/HMCzgPfkQ8z7nWQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QCZLaLnAq3P9vbijyh7hLgbX1vUgpQBT01uf0uhNMUOULmv8zF4RGXCz5a4aVjbQX
	 eMuZDciamJDYOfeKgWuMt6LdmMrWeKcGfI0DvmvF/kg10cq1nXewyPMIrPRq4qDdO6
	 BdfiKAQJCApl7UokWFuJCjONcs1UTOewxsWIqaPK41nFJw1QU3dFV/4xucaV1mRVJk
	 W5B7+MZE7RLuaOaUAiZgjj7aaA+Vnm2vahDcum3ix3XSJ2mdnHxLMAb1xSTtUsJAAQ
	 xQ0IFbOAMeNceUJQQIC/P489YMFiNtJyvl2EGfDE/yWD5nq6d2kEyWQt8zB3jkmx+0
	 ms1LZp8yQflpA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiri Pirko <jiri@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 369/713] dpll: fix dpll_xa_ref_*_del() for multiple registrations
Date: Sun, 24 Mar 2024 18:41:35 -0400
Message-ID: <20240324224720.1345309-370-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index f8fbf03942888..e72ebdf621509 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -128,9 +128,9 @@ static int dpll_xa_ref_pin_del(struct xarray *xa_pins, struct dpll_pin *pin,
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
@@ -208,9 +208,9 @@ dpll_xa_ref_dpll_del(struct xarray *xa_dplls, struct dpll_device *dpll,
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


