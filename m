Return-Path: <linux-kernel+bounces-30376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67539831DEB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EFDB281E18
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BAE2C854;
	Thu, 18 Jan 2024 16:56:06 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95E92576D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705596966; cv=none; b=JrNbyQe2zJ2J1t1UdzjEkiNYZkr7/Dayt5doAEysBrBFeHmhXuq3Wx2migO/gRAUSK2gwp7u2Vkz7ehbcGLhsC/1y1Vs44cBE3GlmJAFPjz0/6fkBzA/Cfkk5wEq1uidDS3jjDylYu0CRT461ZiK4TJwibIKfpGnyKx59V36+go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705596966; c=relaxed/simple;
	bh=nHGH1MAxtPuNGs+pqDYaFl/U2EYOI3Z+/QVLpFkrnTI=;
	h=Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-SA-Exim-Connect-IP:
	 X-SA-Exim-Mail-From:X-SA-Exim-Scanned:X-PTX-Original-Recipient; b=gSiygUfnfgBzYG4o+dlsy3ZWqHaPHkzdgru6Xtw9Fe55DWsKbv1NOMshe+xsX9u52bjNj9aWdENoafPzA+/cB+iThbDwy+5XMq7aBX4bx3/MJzYL2itq8zoG93XyjhQ971Q2VOvAqKF4m5vj3DakABoAqlJx9/PthtsPN3vtixo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1rQVgE-0004xK-0X; Thu, 18 Jan 2024 17:55:50 +0100
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <l.stach@pengutronix.de>)
	id 1rQVgD-000jWU-Cr; Thu, 18 Jan 2024 17:55:49 +0100
From: Lucas Stach <l.stach@pengutronix.de>
To: Russell King <linux@armlinux.org.uk>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	patchwork-lst@pengutronix.de
Subject: [PATCH RFC] ARM: VDSO: don't drop clock_gettime when architected timer isn't available
Date: Thu, 18 Jan 2024 17:55:49 +0100
Message-Id: <20240118165549.1935000-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Dropping the clock_gettime entry points when the architected timer is not
available is done to gain some efficiency, as it allows libc to fall back
to the syscall without dispatching through the vDSO.

The difference on a i.MX6 system using the vdso test utility [1]
looks like this:
$ vdsotest clock-gettime-monotonic bench -d 10

           w/o vDSO entrypoint        with vDSO entrypoint
syscall:   987 nsec/call              974 nsec/call
libc:      1095 nsec/call             1148 nsec/call
vdso:      not available              not available

Going through libc adds a ~100ns penalty compared to calling the syscall
directly. Dispatching through the vDSO adds another ~50ns, which isn't
negligible, but also not huge.

The downside of dropping the entry points is that now also the COARSE
versions of the clocks have to go through the syscall, while they can
be accelerated through the vDSO even without the architected timer when
the entry points are kept.

$ vdsotest clock-gettime-monotonic-coarse bench -d 10

           w/o vDSO entrypoint	      with vDSO	entrypoint
syscall:   659 nsec/call              662 nsec/call
libc:      772 nsec/call              137 nsec/call
vdso:      not available              63 nsec/call

This is quite a nice speedup, but arguably coarse clocks are also not
as widely used as the high-res versions. Still, this patch proposes to
to take the hit on his-res clocks by dispatching through the vDSO to gain
the ability to accelerate coarse clocks.

[1] https://github.com/nlynch-mentor/vdsotest

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/kernel/vdso.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index f297d66a8a76..947f3d8144fc 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -172,11 +172,8 @@ static void __init patch_vdso(void *ehdr)
 	 * want programs to incur the slight additional overhead of
 	 * dispatching through the VDSO only to fall back to syscalls.
 	 */
-	if (!cntvct_ok) {
+	if (!cntvct_ok)
 		vdso_nullpatch_one(&einfo, "__vdso_gettimeofday");
-		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime");
-		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime64");
-	}
 }
 
 static int __init vdso_init(void)
-- 
2.43.0


