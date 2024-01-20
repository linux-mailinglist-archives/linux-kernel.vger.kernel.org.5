Return-Path: <linux-kernel+bounces-31857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEF383358C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 18:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03142B22CC5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 17:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522F012E59;
	Sat, 20 Jan 2024 17:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bI5+QiZq"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1082D11737
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705772190; cv=none; b=sOchnf02XBWkgwHB3t+dfsPYUUEegISKHcMjCcHoKuXk9CiWkH8Wu8O2pxDiw/4yA5PKb0gLG2XsgXeIrqhaUBGgwu3lzwYdFHs4ABkl4IqruIzovS3AmQ5FP4c32myPrO3zmbvCR6mK/XwcI7Lkhg0FZyXt5hZQ+To6bd6HU98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705772190; c=relaxed/simple;
	bh=TMPPsZtbIA8ctRmBAL3F0DbxPb8GxMwox+3KnZQR6YU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eXv82R/Loc10pUbaJ/swmaVr3thoD1mMYgmT9HLlFAl5CBHA/oiADb+03ZFT+DagQFqP/j724EdrMm9wbsybP0gFgrklDDqGUsHnv3eJmMuwkbCFmNACR0k1D1BPTQuqfpjF+piESBYMF8jGzf7FDONFBLVp+/hl49+/nIN/exY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bI5+QiZq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=NuGW4IyKjqVkDxgrYGIZUpCRCNVzXC39xL2WMhato5A=; b=bI5+QiZq5ukqQ6PlNeF8CAwCsE
	er8h95zLqkkUlmXTkIfPhyrcNzJ27WbZEg6DCBnTmcPaYR+cc6dXVGtjPEEWo070S0Yq3iOGqBb0Q
	Kcc6cQJ9JieTwnjb+ggOa1PlGOjteyiTrKtOlm2fUcyW4hEfvLLBBdU5fDMHpHZ/WBKeQcwmhzigS
	ocIRYZnHSisQeXB9Ar5+nMq2zHBu2XKhuaZdnfeZG6M5qGe166+C0gm7EW6Ytn8Rkz+MVsME/IHQH
	Btbua11whf3NvQgHuQbZboOPDkU89q2gKl/d7CrmGwZd2ukJVP7AoHy3oP9bm7LCmOwmZ13SBlGJq
	x4OhjozQ==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rRFGa-008A1r-2P;
	Sat, 20 Jan 2024 17:36:24 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] clocksource: ti-32K: fix misuse of "/**" comment
Date: Sat, 20 Jan 2024 09:36:24 -0800
Message-ID: <20240120173624.16769-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change "/**" to a common "/*" comment in a non-kernel-doc comment to
avoid a kernel-doc warning:

timer-ti-32k.c:42: warning: expecting prototype for timer(). Prototype was for OMAP2_32KSYNCNT_REV_OFF() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/clocksource/timer-ti-32k.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
--- a/drivers/clocksource/timer-ti-32k.c
+++ b/drivers/clocksource/timer-ti-32k.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * timer-ti-32k.c - OMAP2 32k Timer Support
  *
  * Copyright (C) 2009 Nokia Corporation

