Return-Path: <linux-kernel+bounces-105220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1B587DAAC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07AF51F229FC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 16:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1751BC2F;
	Sat, 16 Mar 2024 16:02:49 +0000 (UTC)
Received: from mail.lichtvoll.de (luna.lichtvoll.de [194.150.191.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A31BF2B;
	Sat, 16 Mar 2024 16:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.150.191.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710604969; cv=none; b=IjOyqjyPI+QOi8dH5emADdMZQmvO+PlkL6od9wD9kvAyVHQXdI2478J9OQwESH3RBhfApvGvhQ6JmZZmiUeU2AkkB36zsD5rp07U2Vn4SQilGOtZcmrrQcIxgSF2UZ6G3f/V6CeIG3QQv/wqwVwka6DU+ZjsqrAFrZV/AdlYHx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710604969; c=relaxed/simple;
	bh=psWNJLyeG2dJDUOJLnxmct4u0lVIvH8kn+tzl248vrI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LnXcbr4oVtSc3p4FzYSAhR51ALeHaSsFrVoHMHdjQSRtG8NJhD10//svnHLisltkBPBBFK1TWeTutBvZwsamWS7REdeMybo0eAN2mgVwxv0ELrdlE/6o6U+HiuV607Wma4vkwbIeLlEZujHfvzBcRAcION+u7s4df0mHSP0teo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=194.150.191.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id 420E78C2375;
	Sat, 16 Mar 2024 17:02:45 +0100 (CET)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: linux-pm@vger.kernel.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject:
 [regression] 6.8.1: fails to hibernate with
 pm_runtime_force_suspend+0x0/0x120 returns -16
Date: Sat, 16 Mar 2024 17:02:44 +0100
Message-ID: <2325246.ElGaqSPkdT@lichtvoll.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi!

ThinkPad T14 AMD Gen 1 fails to hibernate with self-compiled 6.8.1.
Hibernation works correctly with self-compiled 6.7.9.

Trying to use "no_console_suspend" to debug next. Will not do bisect
between major kernel releases on a production machine.

[  409.847217] PM: hibernation: hibernation entry
[  409.874672] Filesystems sync: 0.027 seconds
[  409.875204] Freezing user space processes
[  409.877765] Freezing user space processes completed (elapsed 0.002 seconds)
[  409.877770] OOM killer disabled.
[  409.878027] PM: hibernation: Marking nosave pages: [mem 0x00000000-0x00000fff]
[  409.878031] PM: hibernation: Marking nosave pages: [mem 0x0009f000-0x000fffff]
[  409.878034] PM: hibernation: Marking nosave pages: [mem 0x09c00000-0x09d00fff]
[  409.878039] PM: hibernation: Marking nosave pages: [mem 0x09f00000-0x09f0ffff]
[  409.878041] PM: hibernation: Marking nosave pages: [mem 0xa2356000-0xa2356fff]
[  409.878042] PM: hibernation: Marking nosave pages: [mem 0xa2363000-0xa2364fff]
[  409.878043] PM: hibernation: Marking nosave pages: [mem 0xa2372000-0xa2373fff]
[  409.878045] PM: hibernation: Marking nosave pages: [mem 0xa2384000-0xa2384fff]
[  409.878046] PM: hibernation: Marking nosave pages: [mem 0xb9c57000-0xb9ce7fff]
[  409.878049] PM: hibernation: Marking nosave pages: [mem 0xbd9de000-0xcc3fdfff]
[  409.878530] PM: hibernation: Marking nosave pages: [mem 0xce000000-0xffffffff]
[  409.879306] PM: hibernation: Basic memory bitmaps created
[  409.884500] PM: hibernation: Preallocating image memory
[  412.146014] PM: hibernation: Allocated 2800864 pages for snapshot
[  412.146022] PM: hibernation: Allocated 11203456 kbytes in 2.26 seconds (4957.28 MB/s)
[  412.146025] Freezing remaining freezable tasks
[  412.147610] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  412.147829] printk: Suspending console(s) (use no_console_suspend to debug)
[  412.158400] port 0000:02:00.1:0.0: PM: dpm_run_callback(): pm_runtime_force_suspend+0x0/0x120 returns -16
[  412.158418] port 0000:02:00.1:0.0: PM: failed to freeze: error -16
[  413.879379] PM: hibernation: Basic memory bitmaps freed
[  413.879847] OOM killer enabled.
[  413.879852] Restarting tasks ... done.
[  413.882304] PM: hibernation: hibernation exit

Best,
-- 
Martin



