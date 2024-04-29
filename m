Return-Path: <linux-kernel+bounces-161847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654B38B5227
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 884CB1C20FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF5417BB6;
	Mon, 29 Apr 2024 07:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="dhzlXPvo"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7CF134B0;
	Mon, 29 Apr 2024 07:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375119; cv=none; b=VrFTeNul7N1bpHh5xeC3WPK1olphrmgio7is3bit1E0olHLpCDPOyIAagGPao/pmny2GVp2OHczmJq9EVMIPNog6JmRKNpaFA6zwYM0vUp3+3MUKngJJsFU5HqhFdcjGM5kVyAPmmSu+VBCg2LZMI+pskwz+UpQ/xvT0mt3G9eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375119; c=relaxed/simple;
	bh=pkTdCPFPyFQGIM0YbW1TgN0veBd4bLODfLEaaGxTIFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/nbIUhNaTK/J+4KzRI0HBaRvCBIw2jt/7ed0511kI3sN4woBLqie/DwfKGgZVpWzyuT2yCHAviuXsgTPjUjU0FROowBT9NhBkb3VQGkb5O3vEMpuO3wIgP6fBo92nEedupA+WwbBYD/qjz62MjBI2g8XY2aNWq91xzDXGMgkx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=dhzlXPvo; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=OPqX/QH/B+ex+KDquokfbHorkpVO9YGgihZVxMtqQjQ=; t=1714375117;
	x=1714807117; b=dhzlXPvoxcaD3ViVYBSzoVUo+UmWRmOYiyAQzXaR7A6AhCilY4EIGKsgXxbnA
	L5U7HoBqyzleCUm3u9SN+ibjr7h1peI0L+5xh1Qe9n7Y/LmF91YRl2KiUxtcsVd/W/7vti7Rl9uoo
	z18rSSSE5tmHFn5Q5mUeIwlzgRw0Frcj/X0dnYmdaZfef0AYHFv/CnD+Bt+OYT6YEBWnAkhy86oz4
	kSiupZupsid+wZFvlpIIr83GxSHIal5VfBrC+WJlFg4OD39ZU2a9UkK9HNc33gz+Z7VzlRXWkFm+9
	AKURwqp6ed+/+XhvH8NIViklhIm2wtC6QAsZVhZMSBOerfrOFQ==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1s1LHU-0004e1-HZ; Mon, 29 Apr 2024 09:18:32 +0200
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] docs: stable-kernel-rules: remove code-labels tags and a indention level
Date: Mon, 29 Apr 2024 09:18:28 +0200
Message-ID: <755afbeafc8e1457154cb4b30ff4397f34326679.1714367921.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714367921.git.linux@leemhuis.info>
References: <cover.1714367921.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1714375117;b475376d;
X-HE-SMSGID: 1s1LHU-0004e1-HZ

Remove the 'code-block:: none' labels and switch to the shorter '::' to
reduce noise.

Remove a unneeded level of indentation, as that reduces the chance that
readers have to scroll sideways in some of the code blocks.

No text changes. Rendered html output looks like before, except for the
different level of indentation.

CC: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/process/stable-kernel-rules.rst | 225 ++++++++----------
 1 file changed, 102 insertions(+), 123 deletions(-)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index d28072b570f872..b4af627154f1d8 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -6,29 +6,29 @@ Everything you ever wanted to know about Linux -stable releases
 Rules on what kind of patches are accepted, and which ones are not, into the
 "-stable" tree:
 
- - It or an equivalent fix must already exist in Linux mainline (upstream).
- - It must be obviously correct and tested.
- - It cannot be bigger than 100 lines, with context.
- - It must follow the
-   :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
-   rules.
- - It must either fix a real bug that bothers people or just add a device ID.
-   To elaborate on the former:
-
-   - It fixes a problem like an oops, a hang, data corruption, a real security
-     issue, a hardware quirk, a build error (but not for things marked
-     CONFIG_BROKEN), or some "oh, that's not good" issue.
-   - Serious issues as reported by a user of a distribution kernel may also
-     be considered if they fix a notable performance or interactivity issue.
-     As these fixes are not as obvious and have a higher risk of a subtle
-     regression they should only be submitted by a distribution kernel
-     maintainer and include an addendum linking to a bugzilla entry if it
-     exists and additional information on the user-visible impact.
-   - No "This could be a problem..." type of things like a "theoretical race
-     condition", unless an explanation of how the bug can be exploited is also
-     provided.
-   - No "trivial" fixes without benefit for users (spelling changes, whitespace
-     cleanups, etc).
+- It or an equivalent fix must already exist in Linux mainline (upstream).
+- It must be obviously correct and tested.
+- It cannot be bigger than 100 lines, with context.
+- It must follow the
+  :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
+  rules.
+- It must either fix a real bug that bothers people or just add a device ID.
+  To elaborate on the former:
+
+  - It fixes a problem like an oops, a hang, data corruption, a real security
+    issue, a hardware quirk, a build error (but not for things marked
+    CONFIG_BROKEN), or some "oh, that's not good" issue.
+  - Serious issues as reported by a user of a distribution kernel may also
+    be considered if they fix a notable performance or interactivity issue.
+    As these fixes are not as obvious and have a higher risk of a subtle
+    regression they should only be submitted by a distribution kernel
+    maintainer and include an addendum linking to a bugzilla entry if it
+    exists and additional information on the user-visible impact.
+  - No "This could be a problem..." type of things like a "theoretical race
+    condition", unless an explanation of how the bug can be exploited is also
+    provided.
+  - No "trivial" fixes without benefit for users (spelling changes, whitespace
+    cleanups, etc).
 
 
 Procedure for submitting patches to the -stable tree
@@ -42,11 +42,11 @@ Procedure for submitting patches to the -stable tree
 
 There are three options to submit a change to -stable trees:
 
- 1. Add a 'stable tag' to the description of a patch you then submit for
-    mainline inclusion.
- 2. Ask the stable team to pick up a patch already mainlined.
- 3. Submit a patch to the stable team that is equivalent to a change already
-    mainlined.
+1. Add a 'stable tag' to the description of a patch you then submit for
+   mainline inclusion.
+2. Ask the stable team to pick up a patch already mainlined.
+3. Submit a patch to the stable team that is equivalent to a change already
+   mainlined.
 
 The sections below describe each of the options in more detail.
 
@@ -68,79 +68,62 @@ Option 1
 ********
 
 To have a patch you submit for mainline inclusion later automatically picked up
-for stable trees, add the tag
+for stable trees, add this tag in the sign-off area::
 
-.. code-block:: none
+  Cc: stable@vger.kernel.org
 
-     Cc: stable@vger.kernel.org
-
-in the sign-off area. Once the patch is mainlined it will be applied to the
-stable tree without anything else needing to be done by the author or
-subsystem maintainer.
+Once the patch is mainlined it will be applied to the stable tree without
+anything else needing to be done by the author or subsystem maintainer.
 
 To sent additional instructions to the stable team, use a shell-style inline
 comment to pass arbitrary or predefined notes:
 
- * Specify any additional patch prerequisites for cherry picking:
-
-   .. code-block:: none
-
-     Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
-     Cc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle
-     Cc: <stable@vger.kernel.org> # 3.3.x: fd21073: sched: Fix affinity logic
-     Cc: <stable@vger.kernel.org> # 3.3.x
-     Signed-off-by: Ingo Molnar <mingo@elte.hu>
-
-   The tag sequence has the meaning of:
-
-   .. code-block:: none
+* Specify any additional patch prerequisites for cherry picking::
 
-     git cherry-pick a1f84a3
-     git cherry-pick 1b9508f
-     git cherry-pick fd21073
-     git cherry-pick <this commit>
+    Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
+    Cc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle
+    Cc: <stable@vger.kernel.org> # 3.3.x: fd21073: sched: Fix affinity logic
+    Cc: <stable@vger.kernel.org> # 3.3.x
+    Signed-off-by: Ingo Molnar <mingo@elte.hu>
 
-   Note that for a patch series, you do not have to list as prerequisites the
-   patches present in the series itself. For example, if you have the following
-   patch series:
+  The tag sequence has the meaning of::
 
-   .. code-block:: none
+    git cherry-pick a1f84a3
+    git cherry-pick 1b9508f
+    git cherry-pick fd21073
+    git cherry-pick <this commit>
 
-     patch1
-     patch2
+  Note that for a patch series, you do not have to list as prerequisites the
+  patches present in the series itself. For example, if you have the following
+  patch series::
 
-   where patch2 depends on patch1, you do not have to list patch1 as
-   prerequisite of patch2 if you have already marked patch1 for stable
-   inclusion.
+    patch1
+    patch2
 
- * Point out kernel version prerequisites:
+  where patch2 depends on patch1, you do not have to list patch1 as
+  prerequisite of patch2 if you have already marked patch1 for stable
+  inclusion.
 
-   .. code-block:: none
+* Point out kernel version prerequisites::
 
-     Cc: <stable@vger.kernel.org> # 3.3.x
+    Cc: <stable@vger.kernel.org> # 3.3.x
 
-   The tag has the meaning of:
+  The tag has the meaning of::
 
-   .. code-block:: none
+    git cherry-pick <this commit>
 
-     git cherry-pick <this commit>
+  For each "-stable" tree starting with the specified version.
 
-   For each "-stable" tree starting with the specified version.
+  Note, such tagging is unnecessary if the stable team can derive the
+  appropriate versions from Fixes: tags.
 
-   Note, such tagging is unnecessary if the stable team can derive the
-   appropriate versions from Fixes: tags.
+* Delay pick up of patches::
 
- * Delay pick up of patches:
+    Cc: <stable@vger.kernel.org> # after -rc3
 
-   .. code-block:: none
+* Point out known problems::
 
-     Cc: <stable@vger.kernel.org> # after -rc3
-
- * Point out known problems:
-
-   .. code-block:: none
-
-     Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for <= 6.3
+    Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for <= 6.3
 
 .. _option_2:
 
@@ -160,17 +143,13 @@ Option 3
 Send the patch, after verifying that it follows the above rules, to
 stable@vger.kernel.org and mention the kernel versions you wish it to be applied
 to. When doing so, you must note the upstream commit ID in the changelog of your
-submission with a separate line above the commit text, like this:
-
-.. code-block:: none
-
-    commit <sha1> upstream.
+submission with a separate line above the commit text, like this::
 
-or alternatively:
+  commit <sha1> upstream.
 
-.. code-block:: none
+Or alternatively::
 
-    [ Upstream commit <sha1> ]
+  [ Upstream commit <sha1> ]
 
 If the submitted patch deviates from the original upstream patch (for example
 because it had to be adjusted for the older API), this must be very clearly
@@ -191,55 +170,55 @@ developers and by the relevant subsystem maintainer.
 Review cycle
 ------------
 
- - When the -stable maintainers decide for a review cycle, the patches will be
-   sent to the review committee, and the maintainer of the affected area of
-   the patch (unless the submitter is the maintainer of the area) and CC: to
-   the linux-kernel mailing list.
- - The review committee has 48 hours in which to ACK or NAK the patch.
- - If the patch is rejected by a member of the committee, or linux-kernel
-   members object to the patch, bringing up issues that the maintainers and
-   members did not realize, the patch will be dropped from the queue.
- - The ACKed patches will be posted again as part of release candidate (-rc)
-   to be tested by developers and testers.
- - Usually only one -rc release is made, however if there are any outstanding
-   issues, some patches may be modified or dropped or additional patches may
-   be queued. Additional -rc releases are then released and tested until no
-   issues are found.
- - Responding to the -rc releases can be done on the mailing list by sending
-   a "Tested-by:" email with any testing information desired. The "Tested-by:"
-   tags will be collected and added to the release commit.
- - At the end of the review cycle, the new -stable release will be released
-   containing all the queued and tested patches.
- - Security patches will be accepted into the -stable tree directly from the
-   security kernel team, and not go through the normal review cycle.
-   Contact the kernel security team for more details on this procedure.
+- When the -stable maintainers decide for a review cycle, the patches will be
+  sent to the review committee, and the maintainer of the affected area of
+  the patch (unless the submitter is the maintainer of the area) and CC: to
+  the linux-kernel mailing list.
+- The review committee has 48 hours in which to ACK or NAK the patch.
+- If the patch is rejected by a member of the committee, or linux-kernel
+  members object to the patch, bringing up issues that the maintainers and
+  members did not realize, the patch will be dropped from the queue.
+- The ACKed patches will be posted again as part of release candidate (-rc)
+  to be tested by developers and testers.
+- Usually only one -rc release is made, however if there are any outstanding
+  issues, some patches may be modified or dropped or additional patches may
+  be queued. Additional -rc releases are then released and tested until no
+  issues are found.
+- Responding to the -rc releases can be done on the mailing list by sending
+  a "Tested-by:" email with any testing information desired. The "Tested-by:"
+  tags will be collected and added to the release commit.
+- At the end of the review cycle, the new -stable release will be released
+  containing all the queued and tested patches.
+- Security patches will be accepted into the -stable tree directly from the
+  security kernel team, and not go through the normal review cycle.
+  Contact the kernel security team for more details on this procedure.
 
 
 Trees
 -----
 
- - The queues of patches, for both completed versions and in progress
-   versions can be found at:
+- The queues of patches, for both completed versions and in progress
+  versions can be found at:
 
-	https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
+    https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
 
- - The finalized and tagged releases of all stable kernels can be found
-   in separate branches per version at:
+- The finalized and tagged releases of all stable kernels can be found
+  in separate branches per version at:
 
-	https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
+    https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
 
- - The release candidate of all stable kernel versions can be found at:
+- The release candidate of all stable kernel versions can be found at:
 
-        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/
+    https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/
 
-   .. warning::
-      The -stable-rc tree is a snapshot in time of the stable-queue tree and
-      will change frequently, hence will be rebased often. It should only be
-      used for testing purposes (e.g. to be consumed by CI systems).
+  .. warning::
+     The -stable-rc tree is a snapshot in time of the stable-queue tree and
+     will change frequently, hence will be rebased often. It should only be
+     used for testing purposes (e.g. to be consumed by CI systems).
 
 
 Review committee
 ----------------
 
- - This is made up of a number of kernel developers who have volunteered for
-   this task, and a few that haven't.
+- This is made up of a number of kernel developers who have volunteered for
+  this task, and a few that haven't.
-- 
2.44.0


