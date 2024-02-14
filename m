Return-Path: <linux-kernel+bounces-64847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A95488543A3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 316521F299D3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADD81173A;
	Wed, 14 Feb 2024 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gKmC1TRD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452A81170A;
	Wed, 14 Feb 2024 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896978; cv=none; b=XQZ/pSlcOLuSNToZdzDrfRSzwoARWf4mheYfw5GLBOcccURsv/+WJjOUOKEaZVVAJjzMqBhYuP2siEpgC8xicjpTNLW9mAym1ngbNP7A37H7naAiBEPozIVlCd2NoPA0a8SC4xxHX1IdBy8VFEPcQYWtBkIH/QB8OV20UlQfxFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896978; c=relaxed/simple;
	bh=+30XBiTpr9kCZxuWOtbH7uq9JMNwSCfUSLWV8UPLEa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mL6yzXtsle6x/44QiGuQkEeisn2/NVXSrg36onSvzYdAzg3UjopfwQyLstlwTiJpMetXL93Yu3lIek8Bkd0/hVFbQ7GLhEwcX4f5eiSxzwej3aatVxuj/4b4JjYBf1B30i5hpK4a72CWLKkbYydOk3f6rvCBZLxZ4B/WVUM9aFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gKmC1TRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E9EC433C7;
	Wed, 14 Feb 2024 07:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707896977;
	bh=+30XBiTpr9kCZxuWOtbH7uq9JMNwSCfUSLWV8UPLEa8=;
	h=From:To:Cc:Subject:Date:From;
	b=gKmC1TRDRwnne/XHIp8Lgxgq7p5Te1ehpGMWvEu6pNona9feQZqCu8cLYSBJCF13J
	 gVOwpEG8dfBce/s/baDD/R9agRbvqzHIAdPJyQjf0JLIWrr+QliLKnq8FP0FZpfAZK
	 KCwFVPCtpOkmhCCD1Y/KO42fbym9tGXzFvKhMNQI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: corbet@lwn.net,
	workflows@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH v2] Documentation: Document the Linux Kernel CVE process
Date: Wed, 14 Feb 2024 08:49:29 +0100
Message-ID: <2024021430-expansion-sporty-4229@gregkh>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 177
X-Developer-Signature: v=1; a=openpgp-sha256; l=8674; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=+30XBiTpr9kCZxuWOtbH7uq9JMNwSCfUSLWV8UPLEa8=; b=owGbwMvMwCRo6H6F97bub03G02pJDKlnCrqqKpOyKoXuHnj81Pv2STbLp8E6jXUHu7ueWzpw/ 6u0EYvtiGVhEGRikBVTZPmyjefo/opDil6Gtqdh5rAygQxh4OIUgImsimNY0GT9MSSq4MQOl4iZ M8o1prR2ttjwMCxYpuvJdr4lRLHv35PX5/eyiLhONNYAAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Linux kernel project now has the ability to assign CVEs to fixed
issues, so document the process and how individual developers can get a
CVE if one is not automatically assigned for their fixes.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Lee Jones <lee@kernel.org>
---
v2: Grammer fixes based on review from Randy
    Updated paragraph about how CVE identifiers will be assigned
    (automatically when added to stable trees, or ask us for one
    directly before that happens if so desired)

 Documentation/process/cve.rst           | 120 ++++++++++++++++++++++++
 Documentation/process/index.rst         |   1 +
 Documentation/process/security-bugs.rst |   6 +-
 3 files changed, 124 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/process/cve.rst

diff --git a/Documentation/process/cve.rst b/Documentation/process/cve.rst
new file mode 100644
index 000000000000..6465e6a79c18
--- /dev/null
+++ b/Documentation/process/cve.rst
@@ -0,0 +1,120 @@
+CVEs
+====
+
+Common Vulnerabilities and Exposure (CVE®) numbers were developed as an
+unambiguous way to identify, define, and catalog publicly disclosed
+security vulnerabilities.  Over time, their usefulness has declined with
+regards to the kernel project, and CVE numbers were very often assigned
+in inappropriate ways and for inappropriate reasons.  Because of this,
+the kernel development community has tended to avoid them.  However, the
+combination of continuing pressure to assign CVEs and other forms of
+security identifiers, and ongoing abuses by community members outside of
+the kernel community has made it clear that the kernel community should
+have control over those assignments.
+
+The Linux kernel developer team does have the ability to assign CVEs for
+potential Linux kernel security issues.  This assignment is independent
+of the :doc:`normal Linux kernel security bug reporting
+process<../process/security_bugs>`.
+
+A list of all assigned CVEs for the Linux kernel can be found in the
+archives of the linux-cve mailing list, as seen on
+https://lore.kernel.org/linux-cve-announce/.  To get notice of the
+assigned CVEs, please subscribe to that mailing list.
+
+Process
+-------
+
+As part of the normal stable release process, kernel changes that are
+potentially security issues are identified by the developers responsible
+for CVE number assignments and have CVE numbers automatically assigned
+to them.  These assignments are published on the linux-cve-announce
+mailing list as announcements on a frequent basis.
+
+Note, due to the layer at which the Linux kernel is in a system, almost
+any bug might be exploitable to compromise the security of the kernel,
+but the possibility of exploitation is often not evident when the bug is
+fixed.  Because of this, the CVE assignment team is overly cautious and
+assign CVE numbers to any bugfix that they identify.  This
+explains the seemingly large number of CVEs that are issued by the Linux
+kernel team.
+
+If the CVE assignment team misses a specific fix that any user feels
+should have a CVE assigned to it, please email them at <cve@kernel.org>
+and the team there will work with you on it.  Note that no potential
+security issues should be sent to this alias, it is ONLY for assignment
+of CVEs for fixes that are already in released kernel trees.  If you
+feel you have found an unfixed security issue, please follow the
+:doc:`normal Linux kernel security bug reporting
+process<../process/security_bugs>`.
+
+No CVEs will be automatically assigned for unfixed security issues in
+the Linux kernel; assignment will only automatically happen after a fix
+is available and applied to a stable kernel tree, and it will be tracked
+that way by the git commit id of the original fix.  If anyone wishes to
+have a CVE assigned before an issue is resolved with a commit, please
+contact the kernel CVE assignment team at <cve@kernel.org> to get an
+identifier assigned from their batch of reserved identifiers.
+
+No CVEs will be assigned for any issue found in a version of the kernel
+that is not currently being actively supported by the Stable/LTS kernel
+team.  A list of the currently supported kernel branches can be found at
+https://kernel.org/category/releases.html
+
+Disputes of assigned CVEs
+-------------------------
+
+The authority to dispute or modify an assigned CVE for a specific kernel
+change lies solely with the maintainers of the relevant subsystem
+affected.  This principle ensures a high degree of accuracy and
+accountability in vulnerability reporting.  Only those individuals with
+deep expertise and intimate knowledge of the subsystem can effectively
+assess the validity and scope of a reported vulnerability and determine
+its appropriate CVE designation.  Any attempt to modify or dispute a CVE
+outside of this designated authority could lead to confusion, inaccurate
+reporting, and ultimately, compromised systems.
+
+Invalid CVEs
+------------
+
+If a security issue is found in a Linux kernel that is only supported by
+a Linux distribution due to the changes that have been made by that
+distribution, or due to the distribution supporting a kernel version
+that is no longer one of the kernel.org supported releases, then a CVE
+can not be assigned by the Linux kernel CVE team, and must be asked for
+from that Linux distribution itself.
+
+Any CVE that is assigned against the Linux kernel for an actively
+supported kernel version, by any group other than the kernel assignment
+CVE team should not be treated as a valid CVE.  Please notify the
+kernel CVE assignment team at <cve@kernel.org> so that they can work to
+invalidate such entries through the CNA remediation process.
+
+Applicability of specific CVEs
+------------------------------
+
+As the Linux kernel can be used in many different ways, with many
+different ways of accessing it by external users, or no access at all,
+the applicability of any specific CVE is up to the user of Linux to
+determine, it is not up to the CVE assignment team.  Please do not
+contact us to attempt to determine the applicability of any specific
+CVE.
+
+Also, as the source tree is so large, and any one system only uses a
+small subset of the source tree, any users of Linux should be aware that
+large numbers of assigned CVEs are not relevant for their systems.
+
+In short, we do not know your use case, and we do not know what portions
+of the kernel that you use, so there is no way for us to determine if a
+specific CVE is relevant for your system.
+
+As always, it is best to take all released kernel changes, as they are
+tested together in a unified whole by many community members, and not as
+individual cherry-picked changes.  Also note that for many bugs, the
+solution to the overall problem is not found in a single change, but by
+the sum of many fixes on top of each other.  Ideally CVEs will be
+assigned to all fixes for all issues, but sometimes we do not notice
+fixes in released kernels, so do not assume that because a specific
+change does not have a CVE assigned to it, that it is not relevant to
+take.
+
diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index 6cb732dfcc72..de9cbb7bd7eb 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -81,6 +81,7 @@ of special classes of bugs: regressions and security problems.
 
    handling-regressions
    security-bugs
+   cve
    embargoed-hardware-issues
 
 Maintainer information
diff --git a/Documentation/process/security-bugs.rst b/Documentation/process/security-bugs.rst
index 692a3ba56cca..132842d8b377 100644
--- a/Documentation/process/security-bugs.rst
+++ b/Documentation/process/security-bugs.rst
@@ -99,9 +99,9 @@ CVE assignment
 The security team does not assign CVEs, nor do we require them for
 reports or fixes, as this can needlessly complicate the process and may
 delay the bug handling.  If a reporter wishes to have a CVE identifier
-assigned, they should find one by themselves, for example by contacting
-MITRE directly.  However under no circumstances will a patch inclusion
-be delayed to wait for a CVE identifier to arrive.
+assigned, after a fix is created and merged into a public tree, they can
+contact the :doc:`kernel CVE assignment team<../process/cve>` to obtain
+one.
 
 Non-disclosure agreements
 -------------------------
-- 
2.43.1


