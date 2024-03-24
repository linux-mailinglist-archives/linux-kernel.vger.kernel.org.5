Return-Path: <linux-kernel+bounces-114423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00279888AA2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7A1FB2C795
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D66727A85B;
	Sun, 24 Mar 2024 23:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkDBeZRB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5859C21C184;
	Sun, 24 Mar 2024 23:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321838; cv=none; b=GcOa2gDNN11nrdKcK3xrBz+x7Tmyp2Ej0diZLRy8Bh4LBPi3aXoccFybHFBMHD7y6/b2G5CmqIbE2uSpSU+GwXih9HY/JkEP2twS1p9z6nLaMbPpYu11G35IOYhllg3jOZ7vA9avF6ykdC4DAnL9Jy1eRJ4kHxPHrKqTUozb9xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321838; c=relaxed/simple;
	bh=pRFSzQtLhCFk2XS/KpLm33y704/cqDGYsr0aJwn7PQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7rFoM5mQE5DKJ3rMorJ2KtBKOpGcd5UwDZ9V1Rgr0KOYxXjBRzsnpXQnBAKpHmWBpH+tK24ZFk6nuS8l5J1nqJ4KG7yMea2tRsIFE/xC70xZrD6jFX1U5EnIqGmlbDWkbMd491DNsbzvDpkEYojD+X0NB3TCr90DuP7tZoH/jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkDBeZRB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9F4C433F1;
	Sun, 24 Mar 2024 23:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321837;
	bh=pRFSzQtLhCFk2XS/KpLm33y704/cqDGYsr0aJwn7PQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kkDBeZRB+KpL4Hf0FwYFKDHw20+Jbu5M/j/DkiFV/G3bAltRboRn8hKVGKjp07A+H
	 LdVL51HvdtLK3weL6tAMRHjT7NSztFyZe24aUWqvAv3dSY49yoq+MNoP7JVM2E3uL2
	 Ys/o9xTwWMltfWxs4l53cPyu0t6HKUQVZlDxyORN68ZZrJtKSxIGH68Rtgi1wRNchx
	 OzMN+BhgK5U9dqxiGPav5cZ6Bb72qR8BBqzVxF+5IzG9ZVbIhG4h7wJPwlWThu8ch+
	 e4A7GlhxWB5KuYQnIyxhUQu+D+PKLk0BUpr/96AvlmKJ333ie7lfL07F+Fw6xBatbR
	 111ueP7JIfkcA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 566/638] iio: gts-helper: Fix division loop
Date: Sun, 24 Mar 2024 19:00:03 -0400
Message-ID: <20240324230116.1348576-567-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


