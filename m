Return-Path: <linux-kernel+bounces-151960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A605F8AB645
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B66A282FB1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EAF13D50B;
	Fri, 19 Apr 2024 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFhMXi3Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2BF13D2A1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713560999; cv=none; b=unYwxnkVCpbxaxgk81mHz3qZARnpS7+JFfSPukl/WHFKU00Jtg+9ViKhLYuwgW21R3402msC21oDtoSfmPZ0wPVqgh/UcZ6sCplhDxS2zM537Rp/iHLkjNX5hXXmTac+EynP4JhM+KDqp17ViU2YfdUGXJQ+1EJhAO/99tPShuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713560999; c=relaxed/simple;
	bh=1pOp7H6ONa8rNfkfdp1+cHrXMNg+IHDkIHDMg0sIPP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWfsJEADN25cZ0a7K22VabVv7gVc+4uziRQa1z4bQhPmi3k2whMz2h0YL3OXe/DsDV2yteLh7lxpKLF6VPZeWAC83JjvKzLiRaDc7q9OEnbyy3JpeiVnRZJPrj/FZatt4jzwJeBdOh5LpR5KjJ51ME0VTt9NK+SgHI489Teptno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFhMXi3Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D369C2BD11;
	Fri, 19 Apr 2024 21:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713560999;
	bh=1pOp7H6ONa8rNfkfdp1+cHrXMNg+IHDkIHDMg0sIPP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UFhMXi3Y3O+S6lhGECkAE9otSVDwIyPmkoXVOhFUMwHyHFEgDbMgHy8R3KiW60qTA
	 cE/Xfr49JNmX0ES0jYyQmA/4BoRdkVzKrjZhAmwAzYzXpjr8Ca3nyy3zl1x6Bzslmj
	 gHph/qR/nkkp6DsS+s7d9BW4h4GfWGidAaQ2g/kHMxaKLbeKqeVgS3Jy78dc11hVFt
	 7h2qShY5BAaH80VuvpMusk+qMMEVKwo9ylF123wLQZZzfAnnciaV6oHZQsq1zHRWjP
	 KADU32zXCGxMjuvzV893mdDBIdb9pPSl+vU0BCnMw1YG/vSvRl1qBtsM6/wrnMwZ4a
	 JCX0rWDBYzJtg==
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
	Ingo Molnar <mingo@kernel.org>,
	Maksim Davydov <davydov-max@yandex-team.ru>
Subject: [PATCH v4 5/5] x86/bugs: Add 'spectre_bhi=vmexit' cmdline option
Date: Fri, 19 Apr 2024 14:09:51 -0700
Message-ID: <72d86c6da24138f39ca6fc9459b1d037301c1427.1713559768.git.jpoimboe@kernel.org>
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

In cloud environments it can be useful to *only* enable the vmexit
mitigation and leave syscalls vulnerable.  Add that as an option.

This is similar to the old spectre_v2=auto option which was removed with
the following commit:

  36d4fe147c87 ("x86/bugs: Remove CONFIG_BHI_MITIGATION_AUTO and spectre_bhi=auto")

with the main difference being that this has a more descriptive name and
is disabled by default.

Requested-by: Maksim Davydov <davydov-max@yandex-team.ru>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 12 +++++++++---
 arch/x86/kernel/cpu/bugs.c                      | 16 +++++++++++-----
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 902ecd92a29f..83c4889b88d2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6069,9 +6069,15 @@
 			deployment of the HW BHI control and the SW BHB
 			clearing sequence.
 
-			on   - (default) Enable the HW or SW mitigation
-			       as needed.
-			off  - Disable the mitigation.
+			on     - (default) Enable the HW or SW mitigation as
+				 needed.  This protects the kernel from
+				 both syscalls and VMs.
+			vmexit - On systems which don't have the HW mitigation
+				 available, enable the SW mitigation on vmexit
+				 ONLY.  On such systems, the host kernel is
+				 protected from VM-originated BHI attacks, but
+				 may still be vulnerable to syscall attacks.
+			off    - Disable the mitigation.
 
 	spectre_v2=	[X86,EARLY] Control mitigation of Spectre variant 2
 			(indirect branch speculation) vulnerability.
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 5fca46c78daf..575a4bb5a78d 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1625,6 +1625,7 @@ static bool __init spec_ctrl_bhi_dis(void)
 enum bhi_mitigations {
 	BHI_MITIGATION_OFF,
 	BHI_MITIGATION_ON,
+	BHI_MITIGATION_VMEXIT_ONLY,
 };
 
 static enum bhi_mitigations bhi_mitigation __ro_after_init =
@@ -1639,6 +1640,8 @@ static int __init spectre_bhi_parse_cmdline(char *str)
 		bhi_mitigation = BHI_MITIGATION_OFF;
 	else if (!strcmp(str, "on"))
 		bhi_mitigation = BHI_MITIGATION_ON;
+	else if (!strcmp(str, "vmexit"))
+		bhi_mitigation = BHI_MITIGATION_VMEXIT_ONLY;
 	else
 		pr_err("Ignoring unknown spectre_bhi option (%s)", str);
 
@@ -1659,6 +1662,7 @@ static void __init bhi_select_mitigation(void)
 			return;
 	}
 
+	/* Mitigate in hardware if supported */
 	if (spec_ctrl_bhi_dis())
 		return;
 
@@ -1671,13 +1675,15 @@ static void __init bhi_select_mitigation(void)
 	 */
 	setup_clear_cpu_cap(X86_FEATURE_INDIRECT_BRANCH_OK);
 
-	/* Mitigate KVM by default */
-	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
-	pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit\n");
+	if (bhi_mitigation == BHI_MITIGATION_VMEXIT_ONLY) {
+		pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit only\n");
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
+		return;
+	}
 
-	/* Mitigate syscalls when the mitigation is forced =on */
+	pr_info("Spectre BHI mitigation: SW BHB clearing on syscall and vm exit\n");
 	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP);
-	pr_info("Spectre BHI mitigation: SW BHB clearing on syscall\n");
+	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
 }
 
 static void __init spectre_v2_select_mitigation(void)
-- 
2.44.0


