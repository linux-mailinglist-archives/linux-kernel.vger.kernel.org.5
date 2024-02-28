Return-Path: <linux-kernel+bounces-85028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1301986AF4E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C147528818E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9D0145FE8;
	Wed, 28 Feb 2024 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNDwjU+F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF6041A91
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709123957; cv=none; b=mjhe5LOKxbdYpt8LzVGFw+FzGGGM1IMfR1X0BUCEz2ccHoVxKJY9Xw/uUovNHKW4y/S/2R8RTOqhLGGXMqnZ4l1Jes7VzXjOPCTp79Bvucc8esNZWDjIGCFnNvNj7aou4rxTMBNn43+M1OI0x299275ZDRkSvvlQPPVZlEhj+po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709123957; c=relaxed/simple;
	bh=bseaJOEK/c5MecAUNtAoKFET6o0lT4gHWnFIu3pMeyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nb3EpY8X0SLkCh4rKQ6HdIE4j9yBiUKAzXID8b3JQdAGaYVcHYozDID93dLWeXRYiyBJ0gIlUXxNdLissgN0VPJ2v1rhLmZ+n6D80arZsayzGKWlM1ht05R1TAENczzqsejmmYDpplIkOugUNcfrZUzsVEgOoye8RqiQfPQb7Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNDwjU+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AF7C433C7;
	Wed, 28 Feb 2024 12:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709123956;
	bh=bseaJOEK/c5MecAUNtAoKFET6o0lT4gHWnFIu3pMeyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FNDwjU+FDQa6E87E/XZD7Dm1GjuTunKtbCAKCndFMrCZ7ct0/1X0h5SFEd8hT5ao1
	 Vf2FteZzC0JOT4LuqurAkB2SENRTOwebd1ajdMr70TK2q5xNWxGn5oBsufmFm3hbt9
	 QjK3KJQ/8Dgm/2jynSGwQG6qbhlKsx26E1Eh8aLiQIZ41rJQAaUp2R/mB63XQh+p61
	 UP+1nJ/9QpbJQzXm6ACkG7bg7kmNKiZ9lzLQCuXaT912hIDlaKn2YMyNEDIcDw1Rj2
	 OW7FJI4xHV6PqCadSPY7tNauGcQ+Ti7/OVWuYx+MJx0uQ7ME174dXwleYrvxTjjOFK
	 9UxRTH3LZHvsg==
From: Arnd Bergmann <arnd@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: bcm: stop selecing CONFIG_TICK_ONESHOT
Date: Wed, 28 Feb 2024 13:38:42 +0100
Message-Id: <20240228123850.3499024-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228123850.3499024-1-arnd@kernel.org>
References: <20240228123850.3499024-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

ARCH_BCM_MOBILE is the only platform that selects CONFIG_TICK_ONESHOT,
the others stopped 12 years ago in commit 98fab064d321 ("ARM: Remove
unnecessary selection of TICK_ONESHOT").

This inconsistency caused a build regression after an otherwise
correct change to the timers subsystem:

kernel/time/tick-sched.c:1599:6: error: redefinition of 'tick_sched_timer_dying'
 1599 | void tick_sched_timer_dying(int cpu)
      |      ^
kernel/time/tick-sched.h:111:20: note: previous definition is here
  111 | static inline void tick_sched_timer_dying(int cpu) { }

Drop this dead select.

Fixes: 3aedb7fcd88a ("tick/sched: Remove useless oneshot ifdeffery")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-bcm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 8df4b23e2699..ed6415e7e3a4 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -93,7 +93,6 @@ config ARCH_BCM_MOBILE
 	select ARM_ERRATA_775420
 	select ARM_GIC
 	select GPIO_BCM_KONA
-	select TICK_ONESHOT
 	select HAVE_ARM_ARCH_TIMER
 	select PINCTRL
 	select ARCH_BCM_MOBILE_SMP if SMP
-- 
2.39.2


