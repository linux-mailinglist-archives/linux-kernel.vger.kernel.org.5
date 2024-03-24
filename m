Return-Path: <linux-kernel+bounces-113542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D88918893B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B3A1C2E96B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EA81C2309;
	Sun, 24 Mar 2024 22:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKNt0BCz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350EA1C1C16;
	Sun, 24 Mar 2024 22:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320344; cv=none; b=Gg/pZ6lY63uhM4JZvPs3Qof11miXdhyTWsCcMR1BnTm8s2Gdiz+HlQvf4tI6k7wvSg9s5quGSb2EhTvY1wZotj96VeV/yOYdtRvngPt7aVJoL9+oUwvPXJnypoRKYJyM+uczBYU5+D8DQQYlSGdpjnDM0890uPLz/vjqA+sfMnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320344; c=relaxed/simple;
	bh=OwtCJvgFm1joD9dGpHgZjvWy/3NSqXfs5fo7EoGkYmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9qkne3o0DHJWzC/Pwkxhzd4G1uDRlaAnEFp/vVerpQbVqfOce6GOHGoFIfvjmdkkzE9xwY4z+rnSNRQIuyQloGXZAKhmpMAOvDRbVbJyPkM9U7W6puGGYLVoOeqiWGHJzs7gY0RlbzxxkVqAplzJTzSEs94i+TZ9U3zl41DP6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKNt0BCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FBAC43399;
	Sun, 24 Mar 2024 22:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320343;
	bh=OwtCJvgFm1joD9dGpHgZjvWy/3NSqXfs5fo7EoGkYmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IKNt0BCz4v5+59+yNEOFkyVBP6Fub1xvuMVDBf8WB4GT3tptKZl7rKAQl0YQ+NvwF
	 I3c2BBa+WZeIcuiwW0942S7epa6ZDXxZLZTYSmlKDouVpkTUn+W3zK/9v3PnglhdAq
	 0pXsaScK0+4dyydPpYeAaM/f66nKLaqw/1F4529vHgEN6FlT5IxUrNWEzVBB8k1vxM
	 wwN3pmu7/HgJA1MnZIRyVAdss7OcR7DwG5R+PQQzEpSxxM9vEVxmW7ofVOPHZHbCGY
	 ossd5jqn9cAiAX7s2XkVhPI2Ft8MKYg38s61s6abJ9UAB/ns6ezxL2VpW26g7YrKuF
	 A1qB3QNyyPcdQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 651/715] soc: fsl: dpio: fix kcalloc() argument order
Date: Sun, 24 Mar 2024 18:33:50 -0400
Message-ID: <20240324223455.1342824-652-sashal@kernel.org>
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


