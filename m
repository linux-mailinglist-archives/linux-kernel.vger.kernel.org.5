Return-Path: <linux-kernel+bounces-145287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6618A5218
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57281F23188
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAC77175F;
	Mon, 15 Apr 2024 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaWGXug7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94A81E4B0;
	Mon, 15 Apr 2024 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188737; cv=none; b=Tnn0G/0csk3xo5be4PsBkXxbj3pYGYuhD8M+0zWMOSmYLWv5H5PswuaGXVXHef4cXHZ62v8lhv43Z5xF18akWQeoX7VYZBiNoFgJ6jfJk4c8IbHrNejoSu3ZRx7rbkU8HlNBJQVok9SzMsae9vgpF03RAQQ+rpqhtZAuDqSsqVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188737; c=relaxed/simple;
	bh=WYM10ESJW8h7DBMF+Db5WIGDUBmBDs04mXycZHqmaEA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iMA3/aIagZxiloTSx91vWNkO5VDZ7NcEQssBBZDC1u/wYf6WJtF7Ok8OvbapGBfyv67e/t+sA75P6snaLPWtshaygGaVXxT/9fJxCsPxJv42pyDfLmX1UiozqFCDlGt7ZD2yFMFOCuyr6WrMTqeR9mjL9ZdDT4Qjw9Z3k5uvhLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaWGXug7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1AA2C113CC;
	Mon, 15 Apr 2024 13:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713188737;
	bh=WYM10ESJW8h7DBMF+Db5WIGDUBmBDs04mXycZHqmaEA=;
	h=From:To:Cc:Subject:Date:From;
	b=WaWGXug7lg1qOdoEdpwCH8xdeoWLj0G7xLfF7yJgwLjJ2/AOfTJXFcy7li2lMCZyq
	 sEV1wjEXO3qwZ5p/1VfVP7Mlqwa+O5g6cLQT6sjd2Ocrp1GJjNfO+ZgaXJ+uuqY0N8
	 CsI5N2ZhF20r05koJJSBuySXoIYtWcXGV8+sj8sDuZpUyRVGKNYu9FVGjv2aGYnf3a
	 1o7+oZP5qX6by9fq70kOy+b8V2gVIjs0+MNrrUcmDugklatp3LTibq2GqrpyjBwIB7
	 i/kcJgO5/1lV7Q5w0pgAcctQkM/v5LR8kO/Gb/rd+zcxkpKAg2eL+xp4zGL7BO6aya
	 tiOBY2mNqmLWA==
From: Arnd Bergmann <arnd@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clk: sophgo: avoid open-coded 64-bit division
Date: Mon, 15 Apr 2024 15:45:20 +0200
Message-Id: <20240415134532.3467817-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

On 32-bit architectures, the 64-bit division leads to a link failure:

arm-linux-gnueabi-ld: drivers/clk/sophgo/clk-cv18xx-pll.o: in function `fpll_calc_rate':
clk-cv18xx-pll.c:(.text.fpll_calc_rate+0x26): undefined reference to `__aeabi_uldivmod'

This one is not called in a fast path, and there is already another div_u64()
variant used in the same function, so convert it to div64_u64_rem().

Fixes: 80fd61ec4612 ("clk: sophgo: Add clock support for CV1800 SoC")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/sophgo/clk-cv18xx-pll.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/sophgo/clk-cv18xx-pll.c b/drivers/clk/sophgo/clk-cv18xx-pll.c
index c546dad1791c..29e24098bf5f 100644
--- a/drivers/clk/sophgo/clk-cv18xx-pll.c
+++ b/drivers/clk/sophgo/clk-cv18xx-pll.c
@@ -205,8 +205,7 @@ static unsigned long fpll_calc_rate(unsigned long parent_rate,
 	unsigned long rate;
 
 	dividend <<= PLL_SYN_FACTOR_DOT_POS - 1;
-	rate = dividend / factor;
-	dividend %= factor;
+	rate = div64_u64_rem(dividend, factor, &dividend);
 
 	if (is_full_parent) {
 		dividend <<= 1;
-- 
2.39.2


