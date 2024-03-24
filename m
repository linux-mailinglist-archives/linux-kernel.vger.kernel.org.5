Return-Path: <linux-kernel+bounces-113972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3702B8887B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC101F25EA0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020C81420B7;
	Sun, 24 Mar 2024 23:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1EMZSpL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6878112D1F2;
	Sun, 24 Mar 2024 22:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321095; cv=none; b=u/+foyb2pXIgociIPi1yf3XltRKg3K0TeOFmGrP0hunICAeKalNYdPjE6Z1Y/0SXskfUM9kCCjYR07UioldMhp4BHXuZvWaHPH1XGgu1RBGcM4Ia9ro0YGYgy73zOeM8TNHf9kNwt+frI4oBVX3q9I8229CXJYEzSa2tQVfNMAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321095; c=relaxed/simple;
	bh=OwtCJvgFm1joD9dGpHgZjvWy/3NSqXfs5fo7EoGkYmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Op+ahoj7b8u6rLtqRf94cOMXcNv6qGXPnoReUyM2/rkKgkA3LkNXq6VkpiIgivL3wld2ng8gih5HKWVP2hHDDE+EKNF8nUILZhXPsk4nTmCrhSo/sGgMn8cw+hTjxDBUfEueit/rm5rqkI5MbNtaqYi1+bqNS/EmuFioRVcnGAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1EMZSpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA073C43399;
	Sun, 24 Mar 2024 22:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321094;
	bh=OwtCJvgFm1joD9dGpHgZjvWy/3NSqXfs5fo7EoGkYmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s1EMZSpLxeroDsy/DL7y+va7uyJJStAAKPfKrsFXH5Lcn9vDQhh07C6aqjsipkMce
	 Wr0TmahTkqbKFB5kUb3jyPcIc7rVlH3ZOQF68STwNs/02ZZSSzM6tQjzZlushcCaZc
	 QHvdHJ+Q9JAe7a3ef4nzgEJWulnG21SdNXkMb92YQ1cS/R4oYR5g/dtyd1U2H0PYTQ
	 9K+3ZCEUowmcz+kNwAn6ttnxxXv8543of0Cihnxxqfskp87HrmA37fhr7eWBaLOpfp
	 5X+oyyQq6Apbuf7AOvDvUiGzqdrfeFsncIGi/Gv+jtTKSh6jK/Wn4Pi0SPhDT37Q2S
	 A575+6W5hoZ+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 657/713] soc: fsl: dpio: fix kcalloc() argument order
Date: Sun, 24 Mar 2024 18:46:23 -0400
Message-ID: <20240324224720.1345309-658-sashal@kernel.org>
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


