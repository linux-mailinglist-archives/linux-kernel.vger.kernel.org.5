Return-Path: <linux-kernel+bounces-57085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9269C84D3E3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ECDC282812
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23FA13699D;
	Wed,  7 Feb 2024 21:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHdMvTet"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E931136988;
	Wed,  7 Feb 2024 21:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340942; cv=none; b=MrnMkcP1YLflhp69p92+PEkLyycBmhhI+q3AdRANAY0UMUhOkbgzwCK5iLjZ1FFxe6QVK0CRSSoyQ9YX02y7nyTm9IsOWPWyoeJTU/rc+DmuTjsJ2DVfvpiEgDsR1n4bkq0gOc0OawcEoV6fjoErjjFQYTm2U/WeZ5xwZvuQfAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340942; c=relaxed/simple;
	bh=iKLsFpxZAKXdU3Dh4xq8EBlGqQ0v28uGCDiERYwasto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vz98zYjnn0Ud1kdiGhuDPTjqmx4AmDDJZ8VoCh5zZz3HkLZW5fWDP9TDFZtI0mDJEyv68hVXBuJOxWgc+vosAotJBfO8bmn5FxfuGO2CVK2swpx/OhvJEpO20sy5GxkVgz+BXF6S1Ul8CXiMihMw8M2FThQ6w4aDMtqBltDdX9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHdMvTet; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4EAC433C7;
	Wed,  7 Feb 2024 21:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340942;
	bh=iKLsFpxZAKXdU3Dh4xq8EBlGqQ0v28uGCDiERYwasto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FHdMvTettUzONRi08MrMasZ53Mc/F7gFWutr9BX/lWmLjOrVV/nNfHoMq6WXyT5I5
	 2APBZsDh8qoaj8ZnjB9YkSb05841WiyV6Wo14FDVW1TCxSL2pZIkDzu4C4krM8MXU0
	 MQmWSlX9tWmof4aLzZrv8zfvifl11AZZ1pgNxzpbWWMUuhEixj/bS2U1wzczYDKZRB
	 8WqjBLWgsif5IswiSJ4H8u9mYMRBN/k76NhTPQlZdQIPBbDqPRPJd3Okcx8TTAdT+6
	 2j5HygkHy3VcZTskF4nzZAZV4dSEm+UWmtLxqHDMZOxPfuL6vYPdu5PVVVnFG8xdF1
	 /8lOsQbFjvB8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 20/44] spi: sh-msiof: avoid integer overflow in constants
Date: Wed,  7 Feb 2024 16:20:47 -0500
Message-ID: <20240207212142.1399-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 6500ad28fd5d67d5ca0fee9da73c463090842440 ]

cppcheck rightfully warned:

 drivers/spi/spi-sh-msiof.c:792:28: warning: Signed integer overflow for expression '7<<29'. [integerOverflow]
 sh_msiof_write(p, SIFCTR, SIFCTR_TFWM_1 | SIFCTR_RFWM_1);

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://msgid.link/r/20240130094053.10672-1-wsa+renesas@sang-engineering.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-sh-msiof.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index cfc3b1ddbd22..6f12e4fb2e2e 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -136,14 +136,14 @@ struct sh_msiof_spi_priv {
 
 /* SIFCTR */
 #define SIFCTR_TFWM_MASK	GENMASK(31, 29)	/* Transmit FIFO Watermark */
-#define SIFCTR_TFWM_64		(0 << 29)	/*  Transfer Request when 64 empty stages */
-#define SIFCTR_TFWM_32		(1 << 29)	/*  Transfer Request when 32 empty stages */
-#define SIFCTR_TFWM_24		(2 << 29)	/*  Transfer Request when 24 empty stages */
-#define SIFCTR_TFWM_16		(3 << 29)	/*  Transfer Request when 16 empty stages */
-#define SIFCTR_TFWM_12		(4 << 29)	/*  Transfer Request when 12 empty stages */
-#define SIFCTR_TFWM_8		(5 << 29)	/*  Transfer Request when 8 empty stages */
-#define SIFCTR_TFWM_4		(6 << 29)	/*  Transfer Request when 4 empty stages */
-#define SIFCTR_TFWM_1		(7 << 29)	/*  Transfer Request when 1 empty stage */
+#define SIFCTR_TFWM_64		(0UL << 29)	/*  Transfer Request when 64 empty stages */
+#define SIFCTR_TFWM_32		(1UL << 29)	/*  Transfer Request when 32 empty stages */
+#define SIFCTR_TFWM_24		(2UL << 29)	/*  Transfer Request when 24 empty stages */
+#define SIFCTR_TFWM_16		(3UL << 29)	/*  Transfer Request when 16 empty stages */
+#define SIFCTR_TFWM_12		(4UL << 29)	/*  Transfer Request when 12 empty stages */
+#define SIFCTR_TFWM_8		(5UL << 29)	/*  Transfer Request when 8 empty stages */
+#define SIFCTR_TFWM_4		(6UL << 29)	/*  Transfer Request when 4 empty stages */
+#define SIFCTR_TFWM_1		(7UL << 29)	/*  Transfer Request when 1 empty stage */
 #define SIFCTR_TFUA_MASK	GENMASK(26, 20) /* Transmit FIFO Usable Area */
 #define SIFCTR_TFUA_SHIFT	20
 #define SIFCTR_TFUA(i)		((i) << SIFCTR_TFUA_SHIFT)
-- 
2.43.0


