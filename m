Return-Path: <linux-kernel+bounces-151959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F588AB644
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80DA0B22396
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E0813D2A2;
	Fri, 19 Apr 2024 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEjKo5iB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972B813D278
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 21:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713560998; cv=none; b=J2dqP3nYPW2Hz8ITmYgqtG0BstWl9/sqj0aBHAqs+Vc9wOIxhMW5DSW3+eaVPvM0eNw0rQJHI4pNuE6JtAMGzLlrf36EyphxnRAaVXM6ITGkvLyEglkR+Qbw0fRpy1kzOzxM+0nhWuYNxjDA4A/kpzOldsfYE9NGgtKmbArtbmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713560998; c=relaxed/simple;
	bh=2mmHXkHoIDd4IMtBzLUixZKjNwd7j1hlbGi1zfFJhhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aH460ldc152SGa4RqtsPt2VaDV/WED+KrPgn/ak1Wcm76jxuxXlsBUlPN4yq1lza7aZOyza9e54uYbILyxgMnWNy3YJiGDoHkDOYd/ppAfsa3wAkPewg9Cf8lAjEPf73hsUTmt8kDnwPI4sd6TCO3iM6lta9GrA2k78OhHOyZl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEjKo5iB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C6BC32786;
	Fri, 19 Apr 2024 21:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713560998;
	bh=2mmHXkHoIDd4IMtBzLUixZKjNwd7j1hlbGi1zfFJhhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uEjKo5iB/3niZzMJSg2NPJZ/idQB5q5uRC39vu8MBIC9OUuxP+XeWjQATKrklMcl/
	 fOr0rLOdUFq1w3tqOCVYNdy0zNfMblMzo0SVsi3pgZlyIYFMKlZsmMtHFC1AHWksKL
	 u6I7CdJ/Dpd+/R2ne2RSGdfxPnLcq8BSWCcQzBy45i4IvscTuP2cEq17plCxGOoKOa
	 g8br8pCAlhKtr9A0zfbYAk7ALub2ReR2hmc+mb+xcNWc0cvmbU50WAUYs5n5GNJqLw
	 1U38WjwzvhujAsFNSAg4Xhgd17LZjnXa7Ab0SCCbttzzxKy0zy9FwvLq0e6RZYmWdi
	 /K+6tC8UgKlGA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v4 4/5] x86/bugs: Remove duplicate Spectre cmdline option descriptions
Date: Fri, 19 Apr 2024 14:09:50 -0700
Message-ID: <7862dbc387213d8b3bb208c421caaf92623be856.1713559768.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713559768.git.jpoimboe@kernel.org>
References: <cover.1713559768.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Duplicating the documentation of all the Spectre kernel cmdline options
in two separate places is unwieldy and error-prone.  Instead just add a
reference to kernel-parameters.txt from spectre.rst.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 Documentation/admin-guide/hw-vuln/spectre.rst | 84 ++-----------------
 1 file changed, 9 insertions(+), 75 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index 25a04cda4c2c..f9797ab6b38f 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -592,85 +592,19 @@ Spectre variant 2
 Mitigation control on the kernel command line
 ---------------------------------------------
 
-Spectre variant 2 mitigation can be disabled or force enabled at the
-kernel command line.
+In general the kernel selects reasonable default mitigations for the
+current CPU.
+
+Spectre default mitigations can be disabled or changed at the kernel
+command line with the following options:
 
 	nospectre_v1
-
-		[X86,PPC] Disable mitigations for Spectre Variant 1
-		(bounds check bypass). With this option data leaks are
-		possible in the system.
-
 	nospectre_v2
+	spectre_v2={option}
+	spectre_v2_user={option}
+	spectre_bhi={option}
 
-		[X86] Disable all mitigations for the Spectre variant 2
-		(indirect branch prediction) vulnerability. System may
-		allow data leaks with this option, which is equivalent
-		to spectre_v2=off.
-
-
-        spectre_v2=
-
-		[X86] Control mitigation of Spectre variant 2
-		(indirect branch speculation) vulnerability.
-		The default operation protects the kernel from
-		user space attacks.
-
-		on
-			unconditionally enable, implies
-			spectre_v2_user=on
-		off
-			unconditionally disable, implies
-		        spectre_v2_user=off
-		auto
-			kernel detects whether your CPU model is
-		        vulnerable
-
-		Selecting 'on' will, and 'auto' may, choose a
-		mitigation method at run time according to the
-		CPU, the available microcode, the setting of the
-		CONFIG_MITIGATION_RETPOLINE configuration option,
-		and the compiler with which the kernel was built.
-
-		Selecting 'on' will also enable the mitigation
-		against user space to user space task attacks.
-
-		Selecting 'off' will disable both the kernel and
-		the user space protections.
-
-		Specific mitigations can also be selected manually:
-
-                retpoline               auto pick between generic,lfence
-                retpoline,generic       Retpolines
-                retpoline,lfence        LFENCE; indirect branch
-                retpoline,amd           alias for retpoline,lfence
-                eibrs                   Enhanced/Auto IBRS
-                eibrs,retpoline         Enhanced/Auto IBRS + Retpolines
-                eibrs,lfence            Enhanced/Auto IBRS + LFENCE
-                ibrs                    use IBRS to protect kernel
-
-		Not specifying this option is equivalent to
-		spectre_v2=auto.
-
-		In general the kernel by default selects
-		reasonable mitigations for the current CPU. To
-		disable Spectre variant 2 mitigations, boot with
-		spectre_v2=off. Spectre variant 1 mitigations
-		cannot be disabled.
-
-	spectre_bhi=
-
-		[X86] Control mitigation of Branch History Injection
-		(BHI) vulnerability.  This setting affects the deployment
-		of the HW BHI control and the SW BHB clearing sequence.
-
-		on
-			(default) Enable the HW or SW mitigation as
-			needed.
-		off
-			Disable the mitigation.
-
-For spectre_v2_user see Documentation/admin-guide/kernel-parameters.txt
+For more details on the available options, refer to Documentation/admin-guide/kernel-parameters.txt
 
 Mitigation selection guide
 --------------------------
-- 
2.44.0


