Return-Path: <linux-kernel+bounces-31971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE232835497
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 06:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9711B2296E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 05:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438B5364CD;
	Sun, 21 Jan 2024 05:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OFLjP3E9"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03092364B1;
	Sun, 21 Jan 2024 05:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705814328; cv=none; b=fwj8ey6+GLPGjlyToTYm/Ej0L6YaDzQO7pm75z+zokN1vl/LJ9FWtyLru7x2BWcUQxiC3Ynxoqn5eDnBH1YofqSXxuENKI/5HDirZnSy1IJSmX6p8HFJAmmLZbXtCUsuiDs6VQpCMYROe0qalcUKCJ6liAXyfT7QMiyOJIsFjGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705814328; c=relaxed/simple;
	bh=hsLzJQ0rjE0NKaalRlXuR3w1rqawiIH9+0ZgHTrJpNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tbKOpAEPXa3jm8y8eMqPnpSn5w0JQ+G6z48DzVT7nORL6jb7N+aGI5LdGd8jTNasBkl6Q2MUxDIda2a6eBwhBpzyfffkB42CLZxnIuvu2v2d/mclAbwqaqcytQZhoT+CMkYQrGe3UfgJoQWS4/8ktvwT7NK+C3Gomn4+c1taIrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OFLjP3E9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=DG9d2kLJoo+UCrnUD4R0HJVXaKa26B5GHvpgiXimCgA=; b=OFLjP3E9USROZf++sX2F6XpRc+
	+9P7nkP2qJwip9svA44AVQJjtB8RHvY0cYjoxiwyLopI83NkwCtymQbMLk/AeaPy4mhJhikGYAB2e
	ZLRIJB+3hA+KoWxtngquW2LPWQyiTxNG14jQR5IN8qrMN7qppGhl7rzOg1EcBlvDosA4pFPdKpk0Z
	U1/v3iv6kgDDzvEuQTenn9dnQBUB/OKiKFV47CkSq8dxg7bD5w0K37HOt8mXllO9S7DMoNoTwUNKE
	iMqmco9vuqg/NdJpwR10c6dEYZOyI+EcIuEXy8mTwLO9pyCpwnhhtoCZ0cQ/gHq2R7g4l0D4eLDXr
	qnKTvcQQ==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rRQEI-008uM0-10;
	Sun, 21 Jan 2024 05:18:46 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	=?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-clk@vger.kernel.org,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH] clk: sunxi: sun9i-cpus: fix kernel-doc warnings
Date: Sat, 20 Jan 2024 21:18:44 -0800
Message-ID: <20240121051845.17603-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move the function description kernel-doc comment to immediately above
the function implementation, correct the function name in the comment,
then add a function parameter description to prevent these kernel-doc
warnings:

drivers/clk/sunxi/clk-sun9i-cpus.c:25: warning: expecting prototype for sun9i_a80_cpus_clk_setup(). Prototype was for SUN9I_CPUS_MAX_PARENTS() instead
clk-sun9i-cpus.c:184: warning: Function parameter or struct member 'node' not described in 'sun9i_a80_cpus_setup'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Emilio López <emilio@elopez.com.ar>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-sunxi@lists.linux.dev
---
 drivers/clk/sunxi/clk-sun9i-cpus.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff -- a/drivers/clk/sunxi/clk-sun9i-cpus.c b/drivers/clk/sunxi/clk-sun9i-cpus.c
--- a/drivers/clk/sunxi/clk-sun9i-cpus.c
+++ b/drivers/clk/sunxi/clk-sun9i-cpus.c
@@ -18,9 +18,6 @@
 
 static DEFINE_SPINLOCK(sun9i_a80_cpus_lock);
 
-/**
- * sun9i_a80_cpus_clk_setup() - Setup function for a80 cpus composite clk
- */
 
 #define SUN9I_CPUS_MAX_PARENTS		4
 #define SUN9I_CPUS_MUX_PARENT_PLL4	3
@@ -180,6 +177,10 @@ static const struct clk_ops sun9i_a80_cp
 	.set_rate	= sun9i_a80_cpus_clk_set_rate,
 };
 
+/**
+ * sun9i_a80_cpus_setup() - Setup function for a80 cpus composite clk
+ * @node: &struct device_node for the clock
+ */
 static void sun9i_a80_cpus_setup(struct device_node *node)
 {
 	const char *clk_name = node->name;

