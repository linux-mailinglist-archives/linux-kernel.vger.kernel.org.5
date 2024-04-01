Return-Path: <linux-kernel+bounces-126698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CDC893BBA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48CF91C2094B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EC7405EB;
	Mon,  1 Apr 2024 14:06:08 +0000 (UTC)
Received: from mail.inka.de (quechua.inka.de [193.197.184.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05A93FE52;
	Mon,  1 Apr 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.197.184.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980368; cv=none; b=n0Jl2n/RvXjIywVwjbbnkGFnz1aw9n9fHcws41d1ycD8kK4dGT8H49dNXe4L1yxRyvXGIR9n6YHm/0UXFzwuRe5Dkaa0YItK62az/W4D0kFS0U73LhgIEoxUvgf2QIQG8nq1TR48ip2dt84cRWGJzNbPECTkibZJoz7a5fuj6rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980368; c=relaxed/simple;
	bh=5Zt86hbg+IWRJfODskmP4KA6bw6Ujfy1jtcfs7KEcuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rDjouLOy7Kr8HQDC8EKbUH6N+1U2XCaui0B/ozRRr4mlBDWZu2vc3ELT/JjvdSYcHjQpuNZtugGO3h9i6xRVnEe8ndakuk3FSLP4HE5wHLuFhUbqGxWgbStxCaWcuLWiWuKP4IezmcUVUgGeA1//duWsOSm6P0hiYVGaAm3xwHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inka.de; spf=pass smtp.mailfrom=inka.de; arc=none smtp.client-ip=193.197.184.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inka.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inka.de
Received: from mail.berkhan-weisser.de ([2a03:4000:54:b9a::4])
	by mail.inka.de with esmtpsa 
	id 1rrHsj-00Ap2r-85; Mon, 01 Apr 2024 15:39:25 +0200
Received: from 127.0.0.1 (helo=localhost.localdomain)
	by mail.berkhan-weisser.de with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <Enrik.Berkhan@inka.de>)
	id 1rrHsi-003vlF-3C;
	Mon, 01 Apr 2024 15:39:25 +0200
From: Enrik Berkhan <Enrik.Berkhan@inka.de>
To: Alex Hung <alexhung@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Enrik Berkhan <Enrik.Berkhan@inka.de>
Subject: [PATCH] platform/x86/intel/hid: Ignore power button release in wakeup mode
Date: Mon,  1 Apr 2024 15:39:19 +0200
Message-ID: <20240401133919.4304-1-Enrik.Berkhan@inka.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 0c4cae1bc00d ("PM: hibernate: Avoid missing wakeup events
during hibernation"), the return value of hibernation_platform_enter() is
used. This will, for example, cancel every hibernation attempt if a wakeup
event is registered during the (long) preparation time needed before
entering platform hibernate mode.

As reported in https://bugzilla.kernel.org/show_bug.cgi?id=218634 several
notebooks will fail to hibernate since then, logging "PM: hibernation:
Wakeup event detected during hibernation, rolling back." (Looks like mostly
Dell systems are affected.)

A little investigation has shown that at least one affected device's "Intel
5 button array" sends spurious "Power button release" events (0xCF) in this
case. Most probably, this is completely independent from the
hibernation_platform_enter() change above, and even with kernels before
6.8, the hibernation was probably not fully prepared before halting the
system, i.e., hibernation_platform_enter() may have failed early and the
failure has been ignored.

It ist he spurious "Power button release" event that leads to a wakeup
during the hibernation preparation. Therefore, ignore these events while
the intel-hid driver is in "wakeup mode". "Power button press" will still
be processed as before to not disturb the wakeup from S2Idle.

Only tested on one Dell Inspiron 16 (7640) having BIOS 1.3.0, so far.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218634
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218634

Signed-off-by: Enrik Berkhan <Enrik.Berkhan@inka.de>
---
 drivers/platform/x86/intel/hid.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index 7457ca2b27a6..9df4a114334a 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -528,6 +528,13 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 		 */
 		if (event == 0xce)
 			goto wakeup;
+		/*
+		 * Other platforms may send spurious notifies for power button
+		 * release while entering hibernation mode. Ignore these in
+		 * wakeup mode.
+		 */
+		if (event == 0xcf)
+			return;
 
 		/*
 		 * Some devices send (duplicate) tablet-mode events when moved
-- 
2.44.0


