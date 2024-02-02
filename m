Return-Path: <linux-kernel+bounces-50349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3858477D6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7431C26DD8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D423154BEC;
	Fri,  2 Feb 2024 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYRvzNcd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D3F15444D;
	Fri,  2 Feb 2024 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899176; cv=none; b=bMa89eyiEfdeqWbQZaqkOdjvQdisJBu9sgt29IZ7Ed+h7EQcibOF4pUXVnXaOGVCPQEoWXvBZ6nykpqEVjnfCTi0YQcTckhiuMac5gC7B78MiVE6m8m0/xjT4G245HPOKxNJOvnzPoqmHonJU1QJCbbjhn56u8BhkhLs9l6P5XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899176; c=relaxed/simple;
	bh=N+iMXqBMlZrQ+J+4xgN6PKCTFmhrm6XrOnA1jsh8+Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYDiMM7EAagmy0tbjsRmUgocUofosWo7M3GKGmv0LjMJM3FUGWrX5zx4EFhdUv7lzQGivk009nSqhKBoLjNkgTbL5VCLlOUXA/mlKEoKhWWSVbCjARBOw+9P9QHEKMTuO9Z36L1StBnSUn6xTvfXxJq/eEP4asLS/JXT1PJxaRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYRvzNcd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CBAC43390;
	Fri,  2 Feb 2024 18:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899175;
	bh=N+iMXqBMlZrQ+J+4xgN6PKCTFmhrm6XrOnA1jsh8+Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QYRvzNcdr8hc30kvL/TpCjshNW84mUGmJpkYjLxxswUiovN0VS6nwmeSL4nnHB42d
	 ERNLZMtHwzNByg5IPwTajGRZ5Yqd/gvsiXNirsMQFiEEZHr3DVD2ar5oKuAdpxWmd8
	 gvzLQ5X7HePL1Oki23rvnGXL29+HnhdqQHoxKDuhyQ5pUZK4KjPjK0wWb+XtqaL2yk
	 5IkcAuwwRF4/hapUTS6FXXvPQY9NhOdd3kqWiOj0wUNKomBSW483H+MTc5i9JBRxAI
	 sNhPJQ07ebA/kH/6PYeHsyFIYreMi4IeeTFVqUmdJPc7zbNVXDyBrTaT6T/uWafaUV
	 tSMHmS8zb4ljg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 05/23] dpll: fix broken error path in dpll_pin_alloc(..)
Date: Fri,  2 Feb 2024 13:39:01 -0500
Message-ID: <20240202183926.540467-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202183926.540467-1-sashal@kernel.org>
References: <20240202183926.540467-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.3
Content-Transfer-Encoding: 8bit

From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

[ Upstream commit b6a11a7fc4d6337f7ea720b9287d1b9749c4eae0 ]

If pin type is not expected, or pin properities failed to allocate
memory, the unwind error path shall not destroy pin's xarrays, which
were not yet initialized.
Add new goto label and use it to fix broken error path.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dpll/dpll_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 3568149b9562..36f5c0eaf604 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -440,7 +440,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 	if (WARN_ON(prop->type < DPLL_PIN_TYPE_MUX ||
 		    prop->type > DPLL_PIN_TYPE_MAX)) {
 		ret = -EINVAL;
-		goto err;
+		goto err_pin_prop;
 	}
 	pin->prop = prop;
 	refcount_set(&pin->refcount, 1);
@@ -448,11 +448,12 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
 	ret = xa_alloc(&dpll_pin_xa, &pin->id, pin, xa_limit_16b, GFP_KERNEL);
 	if (ret)
-		goto err;
+		goto err_xa_alloc;
 	return pin;
-err:
+err_xa_alloc:
 	xa_destroy(&pin->dpll_refs);
 	xa_destroy(&pin->parent_refs);
+err_pin_prop:
 	kfree(pin);
 	return ERR_PTR(ret);
 }
-- 
2.43.0


