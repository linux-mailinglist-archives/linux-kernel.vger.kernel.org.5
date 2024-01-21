Return-Path: <linux-kernel+bounces-31972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B161835499
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 06:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C71B1F23203
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 05:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BCB364DC;
	Sun, 21 Jan 2024 05:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2Myz9u0b"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBDE36AE4;
	Sun, 21 Jan 2024 05:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705814341; cv=none; b=gtNwWONnSl4oxc1+Q2O21Rsr6kMtymIJjDTbyoqBGZCKeEXXvsY/UoPip1WB0UCzacwDmTbYkAfM+5GZ447P/9dhNd/QS6O0bzN16+dq+SPkPbMGTYpgH8XzGOkaNpn0BVYaENAejmvTvoq+0wyu/WzzKiRxxPqT7dywVFv1lLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705814341; c=relaxed/simple;
	bh=33wh/HnX9KwU/ZtNv+g5CnyuEPqn19cIE+EgZJ7bIOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EI2GbBHvkRUi8qBXP//nQR7U9KSPJhNAsEC3UBoeirZweHA0TZwpZIIIO1ihfdcO0V/JV3S4PeDSNrezzfnM5bvTV6HTdqRhYi6yaGW7HmNIc6fZp7ntcRS0MpmIC5bort2UVLeISx7I0RXLTipo71552LjtgDm8t9rXKtAqR20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2Myz9u0b; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ZQhtfV8ocb6IW7VM8vOjHJAD+DetDPqhUntwAuu2V9M=; b=2Myz9u0b24ZNoh0ffiKXpQnTzh
	egHVz841MwVoFwf8VUnXbf7RCY2nxmDP8Yx0yWLdMxulq7mJLAfY3CnX/D2Tszt4uDd6zF4+i34is
	5nMGvzlaFi3VQ+ElLyl3xNusxiXZp0BLGN662EQ/JrDhWjb9fpw+0c82WVSTLo4cUulgfnjKanvTl
	fKZ+jdDIDz5qGormFkhTMYHy+Hm4D+GpXVcsV9X43pWRZUVbb1XAy3oObKY/0ub+EXpjFXl76cIpx
	YIff7nzjqceHmz6e4+rbihZjP55cXKMP67Mkkn5itpZdfxhX/cYff/o+XLAh7eIfKT6kaSk6GIEZj
	YFurHaSA==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rRQEV-008uOq-0m;
	Sun, 21 Jan 2024 05:18:59 +0000
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
Subject: [PATCH] clk: sunxi: usb: fix kernel-doc warnings
Date: Sat, 20 Jan 2024 21:18:57 -0800
Message-ID: <20240121051858.17647-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move the function description comment to immediately above the
function implementation, the add function parameter descriptions to
prevent kernel-doc warnings:

clk-usb.c:80: warning: expecting prototype for sunxi_usb_clk_setup(). Prototype was for SUNXI_USB_MAX_SIZE() instead
clk-usb.c:91: warning: Function parameter or struct member 'node' not described in 'sunxi_usb_clk_setup'
clk-usb.c:91: warning: Function parameter or struct member 'data' not described in 'sunxi_usb_clk_setup'
clk-usb.c:91: warning: Function parameter or struct member 'lock' not described in 'sunxi_usb_clk_setup'

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
 drivers/clk/sunxi/clk-usb.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff -- a/drivers/clk/sunxi/clk-usb.c b/drivers/clk/sunxi/clk-usb.c
--- a/drivers/clk/sunxi/clk-usb.c
+++ b/drivers/clk/sunxi/clk-usb.c
@@ -73,9 +73,6 @@ static const struct reset_control_ops su
 	.deassert	= sunxi_usb_reset_deassert,
 };
 
-/**
- * sunxi_usb_clk_setup() - Setup function for usb gate clocks
- */
 
 #define SUNXI_USB_MAX_SIZE 32
 
@@ -85,6 +82,12 @@ struct usb_clk_data {
 	bool reset_needs_clk;
 };
 
+/**
+ * sunxi_usb_clk_setup() - Setup function for usb gate clocks
+ * @node: &struct device_node for the clock
+ * @data: &struct usb_clk_data for the clock
+ * @lock: spinlock for the clock
+ */
 static void __init sunxi_usb_clk_setup(struct device_node *node,
 				       const struct usb_clk_data *data,
 				       spinlock_t *lock)

