Return-Path: <linux-kernel+bounces-67048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1315856553
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE141F25F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320E1131E24;
	Thu, 15 Feb 2024 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nl/O2pi5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739D412D74D;
	Thu, 15 Feb 2024 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006077; cv=none; b=B+ERgM4TGiww/vZDcOglX3Vr4t6tC6zsHPoXTYbPHJ2M3k3dFzV3kJB/FUYXdCcJMynaq8dc9hjy9s4yp0FkMchXT5JYVixDmx5pcr2gzttk5V6zWM2S623u2J95AJEohZOYJCN0WLlREoPV+ltYVn6JTi8M2JcpdBH6Bay9b3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006077; c=relaxed/simple;
	bh=B5RIbCSd0ulciUkU7vKMhgbnboAX8gITuQtuV2GPt/c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DRYtCPsL/VvdisZpts9iO/egvA64RuHcyJvA+JfScbQlmzq8T8d3+fgfxMZxYmpGucAvC/NN58Y+upi2MaZ8dh8vmvLz4AP7imyVs4+qR0uRhukDWon/gshJt0eDzh1rm2KEjq2VOExqMFUGSFJIiQvGwvF4oUjFf5FbTVDOsyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nl/O2pi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A7BC433F1;
	Thu, 15 Feb 2024 14:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708006076;
	bh=B5RIbCSd0ulciUkU7vKMhgbnboAX8gITuQtuV2GPt/c=;
	h=From:To:Cc:Subject:Date:From;
	b=nl/O2pi5MSCDfC68M4UbldhztRFgzrS/VNNIjMovmKkCPrJOrU2+YWUw9dE3FB/OE
	 EolRoB0QxYdP3RkRLo6ehmtlzRSzRxlOrZpwJkppS6KvjQUP9I/ZjjIk6HdH+YmoEK
	 1phnAXVqg+OJBEGiQCgg+n07JMa01AT2ugAzNPb7kCfnavr+DycA2IsF/LuU/bg1+B
	 2PYyHgrmRSp7OZePAFrARf4Q3cYyewE8/19dxpfQx5MtGxBseiiL5B1idlV/MXdta5
	 m6C6sCZ8gSLybZLkYTpuCD/qcz5C/3RV3+UmE/hrBjOWOR2oBWhYZGeEigJnhNvOIz
	 NJbSTepkB8klA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Brian Cain <bcain@quicinc.com>,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hexagon: select FRAME_POINTER instead of redefining it
Date: Thu, 15 Feb 2024 23:07:02 +0900
Message-Id: <20240215140702.1910276-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because FRAME_POINTER is defined in lib/Kconfig.debug, the arch Kconfig
should select it.

Add 'select FRAME_POINTER' to HEXAGON. ARCH_WANT_FRAME_POINTERS must
also be selected to avoid the unmet dependency warning.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/hexagon/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index a880ee067d2e..e922026fef09 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -7,7 +7,9 @@ config HEXAGON
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_NO_PREEMPT
+	select ARCH_WANT_FRAME_POINTERS
 	select DMA_GLOBAL_POOL
+	select FRAME_POINTER
 	# Other pending projects/to-do items.
 	# select HAVE_REGS_AND_STACK_ACCESS_API
 	# select HAVE_HW_BREAKPOINT if PERF_EVENTS
@@ -43,9 +45,6 @@ config HEXAGON_PHYS_OFFSET
 	help
 	  Platforms that don't load the kernel at zero set this.
 
-config FRAME_POINTER
-	def_bool y
-
 config LOCKDEP_SUPPORT
 	def_bool y
 
-- 
2.40.1


