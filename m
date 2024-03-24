Return-Path: <linux-kernel+bounces-115991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CECC889ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEA2BB47A70
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D24439991F;
	Mon, 25 Mar 2024 03:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVd5plhy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A108215EFDD;
	Sun, 24 Mar 2024 23:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322324; cv=none; b=FbWUPr5kX9GOZ7unFBI25W3f1thuIhvchmr4pJs3ugIYJtKeaFn9gNf5s3sclb/P3f8KikthO0QYqNKsG7dbLc4y9bcXLhAg+IXfYnHKhmef5TsV//6inAjPkECPKMKUyiRA84fcR8NYYXBzD8Q6+6iI0fnpcOj5AgSjcWgaNmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322324; c=relaxed/simple;
	bh=OwtCJvgFm1joD9dGpHgZjvWy/3NSqXfs5fo7EoGkYmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFtLrGHvGhwI2z5X5EPt+83gq1W9iVDJb/dG1k0vsMdG2K+/NOTbHAI1SdUrG5x+/Ee72HMQikdjpPk5A81nuWjt4pFWAPMEkrmU7mOGI4Po9s1N3LnAnwe7tFRjhUx1nRYt3nnnvbvYMP8wz2rIJmUHEMehKz3CJSJqvBZuzo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVd5plhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E412FC433F1;
	Sun, 24 Mar 2024 23:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322324;
	bh=OwtCJvgFm1joD9dGpHgZjvWy/3NSqXfs5fo7EoGkYmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dVd5plhyWkF1TPH7GeQnlbvCqU3W8JnmTpXDSjVrvwnftjsPOoDZqRcPQZh+QYviA
	 /KO10gpI3E2p011A95oCpSG68BiMzlerIF+O4SR2SMHosSeO4WBmn+9Et1Zu2AW+ZC
	 fl0u4Ymxf/VQ/JCQGBLygWxDrcZuFEBgXHAeovswO+BG6X+WV/ETo2HfTY/ia/04NC
	 uBHQ7lJ2BZC7vHRcMTk0BO8nNnYDcnEEF1tJaVzFl662DJdtZ9wcTaUHuyfMJD2J4r
	 WFVsltnHiyVGQxf/OFMz5H/ED8vDn6XbkzbFhhzkcjN/K1gkVaWJX8VoFOvXwQ4f/c
	 mTo18qKziaHEw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 407/451] soc: fsl: dpio: fix kcalloc() argument order
Date: Sun, 24 Mar 2024 19:11:23 -0400
Message-ID: <20240324231207.1351418-408-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 72ebb41b88f9d7c10c5e159e0507074af0a22fe2 ]

A previous bugfix added a call to kcalloc(), which starting in gcc-14
causes a harmless warning about the argument order:

drivers/soc/fsl/dpio/dpio-service.c: In function 'dpaa2_io_service_enqueue_multiple_desc_fq':
drivers/soc/fsl/dpio/dpio-service.c:526:29: error: 'kcalloc' sizes specified with 'sizeof' in the earlier argument and not in the later argument [-Werror=calloc-transposed-args]
  526 |         ed = kcalloc(sizeof(struct qbman_eq_desc), 32, GFP_KERNEL);
      |                             ^~~~~~
drivers/soc/fsl/dpio/dpio-service.c:526:29: note: earlier argument should specify number of elements, later size of each element

Since the two are only multiplied, the order does not change the
behavior, so just fix it now to shut up the compiler warning.

Dmity independently came up with the same fix.

Fixes: 5c4a5999b245 ("soc: fsl: dpio: avoid stack usage warning")
Reported-by: Dmitry Antipov <dmantipov@yandex.ru>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/fsl/dpio/dpio-service.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
index 1d2b27e3ea63f..b811446e0fa55 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -523,7 +523,7 @@ int dpaa2_io_service_enqueue_multiple_desc_fq(struct dpaa2_io *d,
 	struct qbman_eq_desc *ed;
 	int i, ret;
 
-	ed = kcalloc(sizeof(struct qbman_eq_desc), 32, GFP_KERNEL);
+	ed = kcalloc(32, sizeof(struct qbman_eq_desc), GFP_KERNEL);
 	if (!ed)
 		return -ENOMEM;
 
-- 
2.43.0


