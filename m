Return-Path: <linux-kernel+bounces-114917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079C8888BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353441C29D6C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D980427EE46;
	Mon, 25 Mar 2024 00:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7oqBrbJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E681791F9;
	Sun, 24 Mar 2024 23:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323585; cv=none; b=JuI8tn96JSwem81MUm4Aui72xTybBhUN3MRdOs6zg3P1MNPcXT4HaMXxzvlk4n3AJCRkU3mNr8kQwdir6lCJbnvS20xmXrBy6dB5AWne5AcKlxbr8f2+bvCV80rmZ1/fyOKKeEzqkTeVTadcXvVCgkPdQxwQn6WPz/Ep4tqfq1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323585; c=relaxed/simple;
	bh=CBebaG+0xbdd5y6jn27EFF7OtljaxvopzEok4XjCYh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LfQ9rVGFRWHGcXNIKoAoPWq3y2BXzXKKWiOh7bkKZWCwWugAA5s6FJSyj5NEYdT8GULMUPzEk70r1bjLpHXbg/baPnA3lzy0LM5mXRjC45C+VpVWtbDC+UmV9ht/JByzvShg/pqB2UdHF/W2522a3USkMI/bJz0mPdisQBaznAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7oqBrbJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1593FC43399;
	Sun, 24 Mar 2024 23:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323584;
	bh=CBebaG+0xbdd5y6jn27EFF7OtljaxvopzEok4XjCYh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s7oqBrbJffoZhOT0e30Tkr95EqYCoNABGe8xvubkndxKl/kKf+/VSvkR1RnoxpNzB
	 t6YCflJzk60QZw3jvCL8klzHQwHkcBvKZZ8oGYMohHNpzYT4ht5YOG0E8Hl2gVXY5W
	 8k1DsHJiP0Ydjzil6MTUqMUkcjfpyauE25kIC/66Ir9Krsa6JSyjc87aHwf4FrV+qC
	 GInav06aRD+ndp/zG8LSTfO9lkEtKlBTXgkXxgES+HmdC42Rt3cOVgDJngdFsa5XDn
	 Cwh6XCpwk0ijC4K4cN+uqLMwRcCH6KbdKUI6cRQIkohXn6+od/ZQ8hN/GUpeUz7Jr6
	 wAwltp/hgaPOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 291/317] soc: fsl: dpio: fix kcalloc() argument order
Date: Sun, 24 Mar 2024 19:34:31 -0400
Message-ID: <20240324233458.1352854-292-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 779c319a4b820..6cdd2c517ba68 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -485,7 +485,7 @@ int dpaa2_io_service_enqueue_multiple_desc_fq(struct dpaa2_io *d,
 	struct qbman_eq_desc *ed;
 	int i, ret;
 
-	ed = kcalloc(sizeof(struct qbman_eq_desc), 32, GFP_KERNEL);
+	ed = kcalloc(32, sizeof(struct qbman_eq_desc), GFP_KERNEL);
 	if (!ed)
 		return -ENOMEM;
 
-- 
2.43.0


