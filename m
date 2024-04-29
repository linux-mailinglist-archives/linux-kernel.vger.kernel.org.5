Return-Path: <linux-kernel+bounces-162483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2529B8B5BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEAAB1F22B79
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC89A77F32;
	Mon, 29 Apr 2024 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M4lUK+ST"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2167F484;
	Mon, 29 Apr 2024 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402095; cv=none; b=GLFVUH1Mf+frv2OSvhYjOTpGHps8b7vle5gWNkrjnz+X888jCByt2STM1n9RlricPVXLrIykKADzR5O0/7TVqQcGB+CV9mgMEGIwtTb3rQEBNNj5JSmhgrpmKJjOe3nEUml3TmttFrguP83IvNg7GiSX/u+5P96gnDuShGccIy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402095; c=relaxed/simple;
	bh=f2huQc8fgahHmmdrk7phmkAWcANNiX2OWpdSEhRxXQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a/SXiYWp9h7BTKgpAA7uwB7J8G+uVL1F8CSKVr9+DLvJ2LOGf4XSz5WET8d/yQ4veBK7R1PSGEjSuquiszaM8ddEzh87JEJIbEpizfKK38GtApGvt2Z1xrdyRFF0Vqlwha0tlqtf8AX5JJ1LtazAhC3gkQu8AjuwqkcfyOMkGGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M4lUK+ST; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=a72aaBnq0xl8vUQw09satK7vYq0lUsnM7DmGvD8Qw/w=; b=M4lUK+STHg96v36YHu6yR1iWnh
	lFHxxPMnAQ3FOJycNnT6ILXyel8hhibbfB2qCvlsMFpj0+qNAYLWaUQatyjngBbAumkx3hNk/uiqh
	Nv0/alzeyMASuDFhRoWQDR0p1cFqkNNqrG5XIu8u1aHyVaW0X88Qfi59qF5HUxobM5Mk6MbrMoqX6
	EWRSSY0JFLc2jYUve76OI7v2P4+2JpGFkiR5AVjxVtro4UWU9jcZNpuQv119yu0kVBEDjKG6d36ZA
	W/skIqqQJeSqHcMlCoKN7XvsNFS52gKuF/4h2/Ux5aR18HmIjDmN2l1+xlJcxvns83PSznzOiHoy8
	0rOqKhMw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1SIb-0000000Cdfi-3vd5;
	Mon, 29 Apr 2024 14:48:10 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	=?UTF-8?q?=D0=9C=D0=B8=D1=85=D0=B0=D0=B8=D0=BB=20=D0=9D=D0=BE=D0=B2=D0=BE=D1=81=D0=B5=D0=BB=D0=BE=D0=B2?= <m.novosyolov@rosalinux.ru>,
	=?UTF-8?q?=D0=98=D0=BB=D1=8C=D1=84=D0=B0=D1=82=20=D0=93=D0=B0=D0=BF=D1=82=D1=80=D0=B0=D1=85=D0=BC=D0=B0=D0=BD=D0=BE=D0=B2?= <i.gaptrakhmanov@rosalinux.ru>,
	stable@vger.kernel.org,
	Rik van Riel <riel@surriel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] bounds: Use the right number of bits for power-of-two CONFIG_NR_CPUS
Date: Mon, 29 Apr 2024 15:47:51 +0100
Message-ID: <20240429144807.3012361-1-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

bits_per() rounds up to the next power of two when passed a power of
two.  This causes crashes on some machines and configurations.

Reported-by: Михаил Новоселов <m.novosyolov@rosalinux.ru>
Tested-by: Ильфат Гаптрахманов <i.gaptrakhmanov@rosalinux.ru>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3347
Link: https://lore.kernel.org/all/1c978cf1-2934-4e66-e4b3-e81b04cb3571@rosalinux.ru/
Fixes: f2d5dcb48f7b (bounds: support non-power-of-two CONFIG_NR_CPUS)
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 kernel/bounds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bounds.c b/kernel/bounds.c
index c5a9fcd2d622..8553368ccf79 100644
--- a/kernel/bounds.c
+++ b/kernel/bounds.c
@@ -19,7 +19,7 @@ int main(void)
 	DEFINE(NR_PAGEFLAGS, __NR_PAGEFLAGS);
 	DEFINE(MAX_NR_ZONES, __MAX_NR_ZONES);
 #ifdef CONFIG_SMP
-	DEFINE(NR_CPUS_BITS, bits_per(CONFIG_NR_CPUS));
+	DEFINE(NR_CPUS_BITS, bits_per(CONFIG_NR_CPUS - 1));
 #endif
 	DEFINE(SPINLOCK_SIZE, sizeof(spinlock_t));
 #ifdef CONFIG_LRU_GEN
-- 
2.43.0


