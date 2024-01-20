Return-Path: <linux-kernel+bounces-31856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA2C83358B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 18:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C92C1F21AE7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 17:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939F410A0D;
	Sat, 20 Jan 2024 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e4pQPbmU"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ED9125C7
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705772180; cv=none; b=C9klGXJnzTfcebAuiaJcaLoNB7VY1pxPfluu2QVj19ihjKEGQi5uT001pZIYJ+0+gd0QGooxcRKusHS0i6BcvX2ueyKTz1wfBmR/WqBqVIp5KIH9PwWf4Cd4/ECHgvb+zsModeQi7s84gQEu10OeoHxpbM4GeYbEWvvAShlc04A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705772180; c=relaxed/simple;
	bh=pXWTtQeYMDcbtI7UKVH6r2deaPdNKhK/SWYxlEBTevw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dETdEinnubpx8XDatmpjQ9IZ59qogvNq3dZqVjUMsDDIJ+jtHS3+EOYj6nS1ZY53s0qFCs0+mrbz0HSnADF8xAneL/y3KtbThMDuwpCwicAH4wxBoj0j35dBbRrzqbXYjjOwvHoQ4RdTmvjA7OQ02fDxO498BBx3Y1exZOFEPlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e4pQPbmU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Dr3AYoemxsJQsUNY4cGcaMUpSAy5oBZ9eLf/W+bCNgs=; b=e4pQPbmUeqhFgfYJRm0ZrXtsEV
	SUFnKtsvKE/LvTZfUfPLzDmQhUg+vbxg6TYUP76oRiaTm0zD4h6UV+I3zYwBjt9X/peWG7iOu2DvM
	O0rX2dGNNJy7W998OPDTMjqJcGheVHa/I08Ep3+Bk1sYV+8kJ1qJQNGAuptTOUBXW306T9K39o/eX
	Hp35p+buRMHCCIdCaCY/xJ+ay7bQnQUr9kHg5Ms7YqPS+s6dVvGT4RuJ8FvAAHIHFLj97trCYDjNp
	ioR6CJk4qGRcbXV7y2WiGzLm2i93QSCgJO5ANxlX5jjvh0jSPUdxgywpABTQ92xXru3i80P27AeIn
	2n/z6OzA==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rRFGS-008A15-20;
	Sat, 20 Jan 2024 17:36:16 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] clocksource: stm32: fix all kernel-doc warnings
Date: Sat, 20 Jan 2024 09:36:15 -0800
Message-ID: <20240120173615.14618-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a "Returns:" section in one function description.
Use the correct function name in another function description.

These changes prevent 2 warnings:

timer-stm32.c:79: warning: No description found for return value of 'stm32_timer_of_bits_get'
timer-stm32.c:189: warning: expecting prototype for stm32_timer_width(). Prototype was for stm32_timer_set_width() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/clocksource/timer-stm32.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -73,7 +73,7 @@ static void stm32_timer_of_bits_set(stru
  * Accessor helper to get the number of bits in the timer-of private
  * structure.
  *
- * Returns an integer corresponding to the number of bits.
+ * Returns: an integer corresponding to the number of bits.
  */
 static int stm32_timer_of_bits_get(struct timer_of *to)
 {
@@ -177,7 +177,7 @@ static irqreturn_t stm32_clock_event_han
 }
 
 /**
- * stm32_timer_width - Sort out the timer width (32/16)
+ * stm32_timer_set_width - Sort out the timer width (32/16)
  * @to: a pointer to a timer-of structure
  *
  * Write the 32-bit max value and read/return the result. If the timer

