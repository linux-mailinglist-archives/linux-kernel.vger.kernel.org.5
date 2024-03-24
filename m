Return-Path: <linux-kernel+bounces-113515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C48028884F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652CD1F21B5F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABB71BD037;
	Sun, 24 Mar 2024 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtJSih5G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A181BB74B;
	Sun, 24 Mar 2024 22:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320316; cv=none; b=cPA0cxPJkGYUqyrI+vayvSdlKfUxE1Wj4BNhmezGqn+JyUbz2oFZ60Xpv5m+uwc0zM+wVCDYvslSZn8dUH4ZRhoYkL6WUbp081/z5ncyyE56x+RiDZTvwAarSxGwV+7zQsJbAL2vpacdwAs4OGKaCJaRDkbFMwMkru2lyDaQGOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320316; c=relaxed/simple;
	bh=pRFSzQtLhCFk2XS/KpLm33y704/cqDGYsr0aJwn7PQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ol7GEoGHvXm/ekgNhZbv6ygBhgTfLh1vxeAh7cp1pR5WMN0Pqx0HE+OsS3Rj+M3FSMplWsDLajZdoHbxey03NQsPqaMbHdx/mg7GVwe7W28TgsXB1gpiNQdCj3p5sQNrhZbn16e9DbbZkHDM8tTf7JNYvtQdNZ9FvQCOvFfqCQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtJSih5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C1FC433A6;
	Sun, 24 Mar 2024 22:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320316;
	bh=pRFSzQtLhCFk2XS/KpLm33y704/cqDGYsr0aJwn7PQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MtJSih5Ge5smdn+mHDm3Z+od0QQ9mYLSHK9Qf958nkOe5HCU9E0n9Dvjn1ow21Bjp
	 AkVYV++2zzytSPZ03aCnHgV2wlDT5CP7xS4haEFBuhF8KcXYHWQQJwg6o3SDWfVoEu
	 DlQy5DC8B250yO42D1Pgz5RPQJmc7BJ0XdQbvZM6EvNnDEFUCD63yy0TcAaSuaYblB
	 f0DuEgX0/DZNkmBuaoSAq0BltpzyaX55ihiqPLVSKdbmSDgXVp6rKFGbeVWEfBBZ7K
	 nHc3o30+8nms9dyom3bZXCltWj8BpVLciQgNVcPVCfaFLdkOPy8/uUYQkxGNcJzt01
	 0MTbEQM3T6Pzw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 624/715] iio: gts-helper: Fix division loop
Date: Sun, 24 Mar 2024 18:33:23 -0400
Message-ID: <20240324223455.1342824-625-sashal@kernel.org>
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

From: Matti Vaittinen <mazziesaccount@gmail.com>

[ Upstream commit bb76cc45dcdfcd962a5994b8fe19ab74fc6c3c3a ]

The loop based 64bit division may run for a long time when dividend is a
lot bigger than the divider. Replace the division loop by the
div64_u64() which implementation may be significantly faster.

Tested-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
Link: https://lore.kernel.org/r/Zcn-6e-0-nh2WcfU@drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/industrialio-gts-helper.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
index 7653261d2dc2b..b51eb6cb766f3 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -34,24 +34,11 @@
 static int iio_gts_get_gain(const u64 max, const u64 scale)
 {
 	u64 full = max;
-	int tmp = 1;
 
 	if (scale > full || !scale)
 		return -EINVAL;
 
-	if (U64_MAX - full < scale) {
-		/* Risk of overflow */
-		if (full - scale < scale)
-			return 1;
-
-		full -= scale;
-		tmp++;
-	}
-
-	while (full > scale * (u64)tmp)
-		tmp++;
-
-	return tmp;
+	return div64_u64(full, scale);
 }
 
 /**
-- 
2.43.0


