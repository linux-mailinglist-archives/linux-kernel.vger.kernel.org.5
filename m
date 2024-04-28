Return-Path: <linux-kernel+bounces-161370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0898B4B3C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C2F5B21112
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA8956B6F;
	Sun, 28 Apr 2024 10:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWY1lxHD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E8A548FE
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 10:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714299709; cv=none; b=SieVHyduU4VHIIU6SCxIfNoWy8YzQ0jBXnuMvjTipZguWi7fECKGmqtGl6V7wbXEJTVFBzitgoQ4MKB5vcK5H7aTO3ODhom3C9EKE7j4r8LYuUGMxmXDqNygXCrNC0Tou1OYQaYpKgL/pxfs8mbr0PP5KkFa7nLHnECPyAzwuDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714299709; c=relaxed/simple;
	bh=QlCUdnNAyQOZpiQNsoq6PWEnD9uFk6RH5G4yH0I7ybo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X7dBkHGEBJJP2VCq4954k1YkKUuB93yMFdK09HxWJ26mBotPTc/Mae0XTDoj+GOVbA9AibK/eWQMltUE62hvUGSBtJiwvl4vb7RtaGO+cpfDl1RA+x2z/gNygrNHdovGJ05unH8pzOiTfn6Tc5zveTpDOZ/tZ9bC6rb5ok7TStA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWY1lxHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F3FC113CC;
	Sun, 28 Apr 2024 10:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714299707;
	bh=QlCUdnNAyQOZpiQNsoq6PWEnD9uFk6RH5G4yH0I7ybo=;
	h=From:To:Cc:Subject:Date:From;
	b=WWY1lxHD+T4rfbcpGi4Kk3isU7kJMOZQJFnP+0LgVVkgtJ2B1af+ojLowHZwtQAV2
	 iC5+GS5PgpfsYHK9hxx1PO9wmCHFINtQKofThnhISNwQ0HedzJhbAWc5OVayWP6c+V
	 KYNRTrysLYUICoUukDnHXkzt99Er4pVlPX1qwSQuSV4KdNUIVjm3MiOziPfbYywBUC
	 L2N2E2A7nAiyOIMuzuHIyhlPQLlwde/S3fslsVFDvDliA2sesaczh++nxS9bK0vB+Y
	 qvOzkX8c4U6236dj5+omxbBvp9YPzb/65zuWdYA+oCOxTqGEIyHcB4L7y3jVfyjS8P
	 q2GUrxaObJ8DQ==
From: Borislav Petkov <bp@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] clocksource: Make the int help prompt unit readable in ncurses
Date: Sun, 28 Apr 2024 12:21:43 +0200
Message-ID: <20240428102143.26764-1-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

When doing

  make menuconfig

and searching for the CLOCKSOURCE_WATCHDOG_MAX_SKEW_US config item, the
help says:

  │ Symbol: CLOCKSOURCE_WATCHDOG_MAX_SKEW_US [=125]
  │ Type  : integer
  │ Range : [50 1000]
  │ Defined at kernel/time/Kconfig:204
  │   Prompt: Clocksource watchdog maximum allowable skew (in   s)
  							     ^^^^^

  │   Depends on: GENERIC_CLOCKEVENTS [=y] && CLOCKSOURCE_WATCHDOG [=y]

because on some terminals, it cannot display the 'μ' char, unicode
number 0x3bc.

So simply write it out so that there's no trouble.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Waiman Long <longman@redhat.com>
---
 kernel/time/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index fc3b1a06c981..8ebb6d5a106b 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -202,7 +202,7 @@ config HIGH_RES_TIMERS
 	  the size of the kernel image.
 
 config CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
-	int "Clocksource watchdog maximum allowable skew (in μs)"
+	int "Clocksource watchdog maximum allowable skew (in microseconds)"
 	depends on CLOCKSOURCE_WATCHDOG
 	range 50 1000
 	default 125
-- 
2.43.0


