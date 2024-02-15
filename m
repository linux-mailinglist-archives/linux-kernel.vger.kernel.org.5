Return-Path: <linux-kernel+bounces-66862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 280918562BA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2AA289ABB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6151A12BF15;
	Thu, 15 Feb 2024 12:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ci5TOMtk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB1A12AAD0;
	Thu, 15 Feb 2024 12:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999069; cv=none; b=LPhV+UerSSo2uIeliTzMqDLxcBX/6kL/JWdJc6GTtmn0gbG68PPLehdEK5Qb4CoB45XokUKqK4frWAiBTrIEkdBY8C5oqBOdzUR0PHYEBG31KQnEFhJSHY1K8EvN9aIb8eTQV6Lg/oLiXSdBe3LnvZSAyidgf70fZ9+Tn9rMDho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999069; c=relaxed/simple;
	bh=9nHF1JeNWGrnT34kmP6Im2nsYTxU6ZcFOHGWkk5gonw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fn8tNhsQU2EBHRwSYk+FHnS9mxdy43OxYRrkj8Kg52nny9RKidBWHmecCJuIlq/WGOIZtrURV15wetsol4qydU+UltAqw4Fd1VFU1DHDdpIK2UuARUFNnoCmttMGYsu47ij7oM+K/lZnzpru1FrLOGG2orVZiH47H2Bd5lhU/5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ci5TOMtk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FE5C433C7;
	Thu, 15 Feb 2024 12:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707999069;
	bh=9nHF1JeNWGrnT34kmP6Im2nsYTxU6ZcFOHGWkk5gonw=;
	h=From:To:Cc:Subject:Date:From;
	b=ci5TOMtkEJMMxJrQLFozu2b17KbIxL8Om9im8w1SZOoNXyzk6yodb0px5j4QXpzmR
	 blxn6Yh1usZ5Q5qPcXabPlax1FAlkMYQ8ovYXTTNJfFMBhe56yohvZvv98kBXB3DAL
	 8h1OwdjlggDXbO1dxOuxZfJi7gvH29VvyhAILPmk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: corbet@lwn.net,
	workflows@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	linux@leemhuis.info,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <keescook@chromium.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH v4] Documentation: Document the Linux Kernel CVE process
Date: Thu, 15 Feb 2024 13:10:55 +0100
Message-ID: <2024021500-laziness-grimace-ed80@gregkh>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 204
X-Developer-Signature: v=1; a=openpgp-sha256; l=9697; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=9nHF1JeNWGrnT34kmP6Im2nsYTxU6ZcFOHGWkk5gonw=; b=owGbwMvMwCRo6H6F97bub03G02pJDKln/4csYYyV7Kn9p6Ej/1ig3o91XlL4lUdd4Y/9Lz1Zz +t08zFrRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEyEYRXDHM7JIl+nCD/4G9FT J5ZjYRXLcVC/mmHBOq0jt99JzBMIWXHuvkPxDSYGqVR9AA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Linux kernel project now has the ability to assign CVEs to fixed
issues, so document the process and how individual developers can get a
CVE if one is not automatically assigned for their fixes.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Lee Jones <lee@kernel.org>
---
v4: Add MAINTAINER entry
    Lots of tiny wording changes based on many reviews
    Collected some Reviewed-by: tags
    Fixed documenation build by properly referencing the security
    process documentation file.
v3: fix up wording in security-bugs.rst based on the changes to the cve
    assignment process from v1, thanks to a private reviewer for
    pointing that out.
v2: Grammer fixes based on review from Randy
    Updated paragraph about how CVE identifiers will be assigned
    (automatically when added to stable trees, or ask us for one
    directly before that happens if so desired)

 Documentation/process/cve.rst           | 120 ++++++++++++++++++++++++
 Documentation/process/index.rst         |   1 +
 Documentation/process/security-bugs.rst |   5 +-
 MAINTAINERS                             |   5 +
 4 files changed, 128 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/process/cve.rst

diff --git a/Documentation/process/cve.rst b/Documentation/process/cve.rst
new file mode 100644
index 000000000000..6b244d938694
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
+security identifiers, and ongoing abuses by individuals and companies
+outside of the kernel community has made it clear that the kernel
+community should have control over those assignments.
+
+The Linux kernel developer team does have the ability to assign CVEs for
+potential Linux kernel security issues.  This assignment is independent
+of the :doc:`normal Linux kernel security bug reporting
+process<../process/security-bugs>`.
+
+A list of all assigned CVEs for the Linux kernel can be found in the
+archives of the linux-cve mailing list, as seen on
+https://lore.kernel.org/linux-cve-announce/.  To get notice of the
+assigned CVEs, please `subscribe
+<https://subspace.kernel.org/subscribing.html>`_ to that mailing list.
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
+process<../process/security-bugs>`.
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
+https://kernel.org/releases.html
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
+assigned to all fixes for all issues, but sometimes we will fail to
+notice fixes, therefore assume that some changes without a CVE assigned
+might be relevant to take.
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
index 692a3ba56cca..56c560a00b37 100644
--- a/Documentation/process/security-bugs.rst
+++ b/Documentation/process/security-bugs.rst
@@ -99,9 +99,8 @@ CVE assignment
 The security team does not assign CVEs, nor do we require them for
 reports or fixes, as this can needlessly complicate the process and may
 delay the bug handling.  If a reporter wishes to have a CVE identifier
-assigned, they should find one by themselves, for example by contacting
-MITRE directly.  However under no circumstances will a patch inclusion
-be delayed to wait for a CVE identifier to arrive.
+assigned for a confirmed issue, they can contact the :doc:`kernel CVE
+assignment team<../process/cve>` to obtain one.
 
 Non-disclosure agreements
 -------------------------
diff --git a/MAINTAINERS b/MAINTAINERS
index 73d898383e51..4d05ac516ded 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5610,6 +5610,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/can/ctu,ctucanfd.yaml
 F:	drivers/net/can/ctucanfd/
 
+CVE ASSIGNMENT CONTACT
+M:	CVE Assignment Team <cve@kernel.org>
+S:	Maintained
+F:	Documentation/process/cve.rst
+
 CW1200 WLAN driver
 S:	Orphan
 F:	drivers/net/wireless/st/cw1200/
-- 
2.43.1


