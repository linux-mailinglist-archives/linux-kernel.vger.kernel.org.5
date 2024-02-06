Return-Path: <linux-kernel+bounces-55645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6615184BF64
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987061C2345B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3827F1BC5E;
	Tue,  6 Feb 2024 21:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="MslBc6fW"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CED1BC35
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 21:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707255861; cv=none; b=QlgysGq+5pa1nPEXTg3JhEGZfBNPSMnQN2dRDOWjQ6UmEcOCLZ03zQ4wXLOjQQ3j0yd02ZA9IHlGejDmNMWWZZXfiFfh2ty6dHQDCA4GWhbN0BGT5gFUnMybnzXfrkRlgeJxEhP+Jw7AEGb4WQwlCz8+pxHamRmZMSx5n7BEXUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707255861; c=relaxed/simple;
	bh=lH5sVaiLtqfzbtaHk3feLejvLIsj4MXSS+5uIQz64KA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Pc4RbXc1g3frNa2Hw3tCpxQBpWg/m4lBEtXLKnMJkDUExaPaHEhnAp5ygt8ZqlDaQ7VhWZiXIu0Tr3UX7z4JxkvqelF8TkgwgmPele6gMUx0GjuF11f05RGxUYXeSHj7qKGpEU2HkNJolgCqEiXwnDArwmwUtZq5/ROtF9u4AfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=MslBc6fW; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id CEC31176E0F; Tue,  6 Feb 2024 21:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1707255542; bh=lH5sVaiLtqfzbtaHk3feLejvLIsj4MXSS+5uIQz64KA=;
	h=Date:From:To:Subject:From;
	b=MslBc6fWC1O/HL7WEIkwStU/meOS2aJg/sQ6wGFsrMUfntp/gxPKLMg099WZbT5tE
	 uvtLgQ3gOeV5lnIgeLBze/RzYQTbhvN31VGeLF8Go4kmmV8HkWBIKGK5ulkWJgf95B
	 izBdpYtkVU9ozPzbgaRTpd0MkOJgi011mTUsviZm0khmasvJm/Dq/kybSl/FMU0ItV
	 EkxC2TbxL5a4kNnj04ZT/IbakBdu3uzdNu7U0VCY7YU1rcUOC9KA1ISQrTHPXZHEu2
	 TSvcjVF+OPH/HU3T58YNTcU/9Y8eqmm4TNGFhSs/g6zmvqnwTjys+g2LdqeYlmtzsa
	 zaD8d5OxKmqdg==
Date: Tue, 6 Feb 2024 21:39:02 +0000
From: Nir Lichtman <nir@lichtman.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] kernel: add boot param to disable stack dump on panic
Message-ID: <20240206213902.GA1490631@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Nir Lichtman <nir@lichtman.org>
Date: Sat, 3 Feb 2024 10:19:30 +0200
Subject: [PATCH] kernel: add boot param to disable stack dump on panic

---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 kernel/panic.c                                  | 12 +++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31b3a2568..433e3e5d1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1127,6 +1127,11 @@
 			MTRR settings.  This parameter disables that behavior,
 			possibly causing your machine to run very slowly.
 
+	disable_stack_dump_on_panic
+			This parameter disables call stack dumping when there
+			is a panic, which can help obscure less earlier messages
+			that lead to the panic.
+
 	disable_timer_pin_1 [X86]
 			Disable PIN 1 of APIC timer
 			Can be useful to work around chipset bugs.
diff --git a/kernel/panic.c b/kernel/panic.c
index 2807639aa..a1e1d064e 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -266,6 +266,16 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
 		crash_smp_send_stop();
 }
 
+static int disable_stack_dump_on_panic __initdata;
+
+static int __init disable_stack_dump_on_panic_setup(char *str)
+{
+	disable_stack_dump_on_panic = 1;
+	return 0;
+}
+
+early_param("disable_stack_dump_on_panic", disable_stack_dump_on_panic_setup);
+
 /**
  *	panic - halt the system
  *	@fmt: The text string to print
@@ -340,7 +350,7 @@ void panic(const char *fmt, ...)
 	/*
 	 * Avoid nested stack-dumping if a panic occurs during oops processing
 	 */
-	if (!test_taint(TAINT_DIE) && oops_in_progress <= 1)
+	if (!test_taint(TAINT_DIE) && oops_in_progress <= 1 && !disable_stack_dump_on_panic)
 		dump_stack();
 #endif
 
-- 
2.39.2


