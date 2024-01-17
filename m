Return-Path: <linux-kernel+bounces-28406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5154982FE30
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E6B1F26293
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC2D4690;
	Wed, 17 Jan 2024 01:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="skGViRzC"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF761364;
	Wed, 17 Jan 2024 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705453808; cv=none; b=TI6c6S7vmxwPXwrr47u6K5BkedvLq2tHT9MtucWCETKLWib5C2IM7ooMASe1oJwsmR+7YehaLJbL/2DFod6DS+DiNd5Jg8AP5RdnM8+XZNz/0/rzMzP7fFncp4HKxxvYuzRRIgmiOHS7kHLT8295+v6b2wUME3xG2Y1Ykhwu34o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705453808; c=relaxed/simple;
	bh=GDGvBeEuZedQmmdqzrb0IUiOWtmnnqmYPR6IwXtu+sA=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=mYc7OZVmfkmOPs/9wTbs89kM0kosg3Oih1jdV/5W8RHgEcz9ewyvaqVzC5HcDDV2YAqXG4+/hcjO0/LnEl3y4raELfwAKdJVP57FBhL/bDXQVFIy0Q4wn7xo7rDnAHasP/rdX9reOdqBYuBaVZzWF6Y45g/jiqwX4f8NTEVBxd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=skGViRzC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GzmUU8PGwflALYNKPwqoYlVViTOygYuZAItzHQWuVIE=; b=skGViRzCgYQcPm6bM40SdWTMuf
	mSmz7kkMhigWCGztA73qw4c1aGpGx7m2/r5C3XBbtJX2xywSJ4ORAhjybQvCcwYmhjThrV5yEEcHH
	hloChlU+LXEWBT41UwTIveT4MfHWYa3yPfs5P2bDQO4YQRpj5OVOncoW8TmTNFJAHb1Br0ZU83D83
	O5t8iID1tmJCnkYLmmZpg8O6yNa9khNnNpy/9g4BfKr95FZtOV9zZ9V5LmOmiFxmmdccGXDk3A3qM
	xtMx3MR3HRosv1nYGfkGH3fQUoWYmn0GHgnT3JW90ERp2qMlA2kYzdVLc/msD47oILkh9BEHoXajv
	UDxxrS/A==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rPuRR-00E6zu-2w;
	Wed, 17 Jan 2024 01:10:05 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	patches@armlinux.org.uk
Subject: [PATCH 01/13] ARM: OMAP2+: am33xx-restart: fix function name in kernel-doc
Date: Tue, 16 Jan 2024 17:09:49 -0800
Message-ID: <20240117011004.22669-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117011004.22669-1-rdunlap@infradead.org>
References: <20240117011004.22669-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the correct name in kernel-doc notation to prevent a
kernel-doc warning:

am33xx-restart.c:20: warning: expecting prototype for am3xx_restart(). Prototype was for am33xx_restart() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: patches@armlinux.org.uk
---
KernelVersion: 0dd3ee31125508cd67f7e717

 arch/arm/mach-omap2/am33xx-restart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/arm/mach-omap2/am33xx-restart.c b/arch/arm/mach-omap2/am33xx-restart.c
--- a/arch/arm/mach-omap2/am33xx-restart.c
+++ b/arch/arm/mach-omap2/am33xx-restart.c
@@ -9,7 +9,7 @@
 #include "prm.h"
 
 /**
- * am3xx_restart - trigger a software restart of the SoC
+ * am33xx_restart - trigger a software restart of the SoC
  * @mode: the "reboot mode", see arch/arm/kernel/{setup,process}.c
  * @cmd: passed from the userspace program rebooting the system (if provided)
  *

