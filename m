Return-Path: <linux-kernel+bounces-86075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731C786BF3F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30C4284064
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C92337141;
	Thu, 29 Feb 2024 03:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBAmpfkJ"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF593612E;
	Thu, 29 Feb 2024 03:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709175718; cv=none; b=Ullj8NyIOTQ73vDqiYPu3eRR6KUa+v67VXvvS7kxQ5XCuO/O44VNEwf7XmaQr5VqD04NEiyKH1TXzxW9f8LFRIQb8HeO5LLChF5DoTENBEnCSdaieFNnbuLKqD6eY5XttIIuIjrIyeJESEudl/6DVfVRG13c/jkIWVCnBkv0tgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709175718; c=relaxed/simple;
	bh=N92dlXOFXA3dVLJee/sshaVOnCnjnC7uqbPyQ8Xi/Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W1l1DtNw8nZAllCCi7Yh+AIJKV4y4PQx7WII3THwItbWB6Z48cNaummvc6ZrzvoSoaX04hhqp71ogKp0jxth6yyUZE/BmDdzuq4NqZ0nl9EMoQgIEtQ3G2NpO/Ed9LJiIB2sSZmXQ8wpO2xTqeo+DtRmZ9TcfmEhcGIGMG1drMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBAmpfkJ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512b3b04995so306539e87.3;
        Wed, 28 Feb 2024 19:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709175714; x=1709780514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7KK9KeU9gbD3ParVFiGULJfVsmLKlcoHXVExeZNnWFs=;
        b=iBAmpfkJ1/ytoFOpscAEB1T8+tEPwrsh5/3hfkIr71TE4vX9s5KUGUuEUnF1DoDRYa
         25rT8Z0C+7WAZ+9CiQdn9rG3LEqPums+scxyh8W5bels+yJ50G8hEOFLVB2EGnVpMTCo
         5So2Aptb30WqrBeUybxjIPgJRf8l4ZDiCi1XHJu+JOZPquF+k3MBhbd+15ekEU6LOd+i
         00sZMvYwMpkjU7CuhCZi2IqSqNP+WCurl236Y761l9BNdSTAXcqAbPXtdAXVR8RnlsON
         0uskPSqiMnLOm7E7xPwCuR5i86287pXy8zXvBhu7Pv8SviXMjfOj615JXABiQR2+VF41
         kvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709175714; x=1709780514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7KK9KeU9gbD3ParVFiGULJfVsmLKlcoHXVExeZNnWFs=;
        b=vYAVfFpEGoJv9rNw5Kdhrgbd/v7ajI1xR/eOIRhLsI9EstJ+/idIjneEEhiMxpEh52
         nxG89trmjgajJYRFCLZAfw0MLIvgUTGYmtHW/8xcFGtQaSN5NkDw46opgV4qpiZL+u8m
         Bi/N9XeIzVnGysydALVYrZKXsxVCgIQYZ8xPoeyMBUGUJhS5KMJFYcljgGuLCskROIE3
         EG9Uzs66qYv669iZJJmXXDwdtppG2tbtwu8I3ueHEaPV1Xkb+0884DrrRx6DqmjockyK
         g4I74ZTob3UVbs4hruaN4USTrKPNGvl6Pc+XBtc+9u1Xch48JcJ+BSJAS6/3JKcCW1t1
         CNTg==
X-Forwarded-Encrypted: i=1; AJvYcCXNeN8IPzeS4UpLRBDP+9Ej/ZG0LyEK0bDAiCNd6V8vvgBtC4vwDUkYyxBYoVs5J+tX7+kYC8JLp0N/q5RY2KAfMHCDZH6RW7gpgLQoUATb5jnXiPXjNLB/SUvFZ6+tRSQpktUqbJQCMlbjhvY8nWirFC8XSmYbDsy35HHmFyLLqHjY
X-Gm-Message-State: AOJu0YyfWmckKmMZK/TiUmKxFtpzDTLY2zZmiiHWuaHQ8VDqtF0w41wG
	2/8LujiJhsUA7QDSP+nud1euv8+h77VuvHx/w1fJXJsyuvla4LLz
X-Google-Smtp-Source: AGHT+IFPzGU6cfZ3DLvdt4tgc4oqBtHvBQY1uT2zr92el843pIeKnAkUdBn2uxJph9COS0HKWqnByA==
X-Received: by 2002:a19:c20d:0:b0:512:f5ad:ccac with SMTP id l13-20020a19c20d000000b00512f5adccacmr440108lfc.2.1709175713799;
        Wed, 28 Feb 2024 19:01:53 -0800 (PST)
Received: from lola.. ([2a02:810d:7e40:14b0:d371:e319:5dd0:9b35])
        by smtp.gmail.com with ESMTPSA id bh3-20020a05600005c300b0033df1dc39f0sm407418wrb.4.2024.02.28.19.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 19:01:53 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Jani Nikula <jani.nikula@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2-squashed] docs: submit-checklist: structure by category
Date: Thu, 29 Feb 2024 04:01:46 +0100
Message-ID: <20240229030146.8418-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While going through the submit checklist, the list order seemed rather
random, probably just by historical coincidences of always adding yet the
next point someone thought of at the end of the list.

Structure and order them by the category of such activity,
reviewing, documenting, checking with tools, building and testing.

As the diff of the reordering is large:
Review code now includes previous points 1, 5 and 22.
Review Kconfig includes previous 6, 7 and 8.
Documenting includes previous 11, 15, 16, 17, 18 and 23.
Checking with tools includes previous 5, 9 and 10.
Building includes previous 2, 3, 20 and 24.
Testing includes previous 12, 13, 14, 19 and 21.

Previous point 4 (compile for ppc64) was merged into point 3 (build for
many architectures), as it was just a further note to cross-compiling.

Previous point 5 was split into one in review and one in checking
to have every previous point in the right category.
Point 11 was shortened, as building documentation is mentioned already
in Build your code, 1d.

A note that was presented visually much too aggressive in the HTML view was
turned into a simple "Note that..." sentence in the enumeration.

The recommendation to test with the -mm patchset (previous 21, now
testing, point 5) was updated to the current state of affairs to test with
a recent tag of linux-next.

Note that the previous first point still remains the first list even after
reordering. Randy confirmed that it was important to Stephen Rothwell to
keep 'include what you use' to be the first in the list.

On stylistic improvements, use subheadings to indicate the categories,
adjust to common heading adornment and use autonumbered lists.

While at it, replace the reference to the obsolete CONFIG_DEBUG_SLAB with
CONFIG_SLUB_DEBUG.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/process/submit-checklist.rst | 163 +++++++++++----------
 1 file changed, 88 insertions(+), 75 deletions(-)

diff --git a/Documentation/process/submit-checklist.rst b/Documentation/process/submit-checklist.rst
index b1bc2d37bd0a..c984b747a755 100644
--- a/Documentation/process/submit-checklist.rst
+++ b/Documentation/process/submit-checklist.rst
@@ -1,7 +1,8 @@
 .. _submitchecklist:
 
+=======================================
 Linux Kernel patch submission checklist
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+=======================================
 
 Here are some basic things that developers should do if they want to see their
 kernel patch submissions accepted more quickly.
@@ -10,111 +11,123 @@ These are all above and beyond the documentation that is provided in
 :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
 and elsewhere regarding submitting Linux kernel patches.
 
+Review your code
+================
 
-1) If you use a facility then #include the file that defines/declares
+#. If you use a facility then #include the file that defines/declares
    that facility.  Don't depend on other header files pulling in ones
    that you use.
 
-2) Builds cleanly:
+#. Check your patch for general style as detailed in
+   :ref:`Documentation/process/coding-style.rst <codingstyle>`.
 
-  a) with applicable or modified ``CONFIG`` options ``=y``, ``=m``, and
-     ``=n``.  No ``gcc`` warnings/errors, no linker warnings/errors.
+#. All memory barriers {e.g., ``barrier()``, ``rmb()``, ``wmb()``} need a
+   comment in the source code that explains the logic of what they are doing
+   and why.
 
-  b) Passes ``allnoconfig``, ``allmodconfig``
+Review Kconfig changes
+======================
 
-  c) Builds successfully when using ``O=builddir``
+#. Any new or modified ``CONFIG`` options do not muck up the config menu and
+   default to off unless they meet the exception criteria documented in
+   ``Documentation/kbuild/kconfig-language.rst`` Menu attributes: default value.
 
-  d) Any Documentation/ changes build successfully without new warnings/errors.
-     Use ``make htmldocs`` or ``make pdfdocs`` to check the build and
-     fix any issues.
+#. All new ``Kconfig`` options have help text.
 
-3) Builds on multiple CPU architectures by using local cross-compile tools
-   or some other build farm.
+#. Has been carefully reviewed with respect to relevant ``Kconfig``
+   combinations.  This is very hard to get right with testing---brainpower
+   pays off here.
 
-4) ppc64 is a good architecture for cross-compilation checking because it
-   tends to use ``unsigned long`` for 64-bit quantities.
+Provide documentation
+=====================
 
-5) Check your patch for general style as detailed in
-   :ref:`Documentation/process/coding-style.rst <codingstyle>`.
-   Check for trivial violations with the patch style checker prior to
-   submission (``scripts/checkpatch.pl``).
-   You should be able to justify all violations that remain in
-   your patch.
+#. Include :ref:`kernel-doc <kernel_doc>` to document global kernel APIs.
+   (Not required for static functions, but OK there also.)
 
-6) Any new or modified ``CONFIG`` options do not muck up the config menu and
-   default to off unless they meet the exception criteria documented in
-   ``Documentation/kbuild/kconfig-language.rst`` Menu attributes: default value.
+#. All new ``/proc`` entries are documented under ``Documentation/``
 
-7) All new ``Kconfig`` options have help text.
+#. All new kernel boot parameters are documented in
+   ``Documentation/admin-guide/kernel-parameters.rst``.
 
-8) Has been carefully reviewed with respect to relevant ``Kconfig``
-   combinations.  This is very hard to get right with testing -- brainpower
-   pays off here.
+#. All new module parameters are documented with ``MODULE_PARM_DESC()``
 
-9) Check cleanly with sparse.
+#. All new userspace interfaces are documented in ``Documentation/ABI/``.
+   See ``Documentation/ABI/README`` for more information.
+   Patches that change userspace interfaces should be CCed to
+   linux-api@vger.kernel.org.
 
-10) Use ``make checkstack`` and fix any problems that it finds.
+#. If any ioctl's are added by the patch, then also update
+   ``Documentation/userspace-api/ioctl/ioctl-number.rst``.
 
-    .. note::
+Check your code with tools
+==========================
 
-       ``checkstack`` does not point out problems explicitly,
-       but any one function that uses more than 512 bytes on the stack is a
-       candidate for change.
+#. Check for trivial violations with the patch style checker prior to
+   submission (``scripts/checkpatch.pl``).
+   You should be able to justify all violations that remain in
+   your patch.
 
-11) Include :ref:`kernel-doc <kernel_doc>` to document global  kernel APIs.
-    (Not required for static functions, but OK there also.) Use
-    ``make htmldocs`` or ``make pdfdocs`` to check the
-    :ref:`kernel-doc <kernel_doc>` and fix any issues.
+#. Check cleanly with sparse.
 
-12) Has been tested with ``CONFIG_PREEMPT``, ``CONFIG_DEBUG_PREEMPT``,
-    ``CONFIG_DEBUG_SLAB``, ``CONFIG_DEBUG_PAGEALLOC``, ``CONFIG_DEBUG_MUTEXES``,
-    ``CONFIG_DEBUG_SPINLOCK``, ``CONFIG_DEBUG_ATOMIC_SLEEP``,
-    ``CONFIG_PROVE_RCU`` and ``CONFIG_DEBUG_OBJECTS_RCU_HEAD`` all
-    simultaneously enabled.
+#. Use ``make checkstack`` and fix any problems that it finds.
+   Note that ``checkstack`` does not point out problems explicitly,
+   but any one function that uses more than 512 bytes on the stack is a
+   candidate for change.
 
-13) Has been build- and runtime tested with and without ``CONFIG_SMP`` and
-    ``CONFIG_PREEMPT.``
+Build your code
+===============
 
-14) All codepaths have been exercised with all lockdep features enabled.
+#. Builds cleanly:
 
-15) All new ``/proc`` entries are documented under ``Documentation/``
+  a) with applicable or modified ``CONFIG`` options ``=y``, ``=m``, and
+     ``=n``.  No ``gcc`` warnings/errors, no linker warnings/errors.
 
-16) All new kernel boot parameters are documented in
-    ``Documentation/admin-guide/kernel-parameters.rst``.
+  b) Passes ``allnoconfig``, ``allmodconfig``
+
+  c) Builds successfully when using ``O=builddir``
+
+  d) Any Documentation/ changes build successfully without new warnings/errors.
+     Use ``make htmldocs`` or ``make pdfdocs`` to check the build and
+     fix any issues.
 
-17) All new module parameters are documented with ``MODULE_PARM_DESC()``
+#. Builds on multiple CPU architectures by using local cross-compile tools
+   or some other build farm. Note that ppc64 is a good architecture for
+   cross-compilation checking because it tends to use ``unsigned long`` for
+   64-bit quantities.
 
-18) All new userspace interfaces are documented in ``Documentation/ABI/``.
-    See ``Documentation/ABI/README`` for more information.
-    Patches that change userspace interfaces should be CCed to
-    linux-api@vger.kernel.org.
+#. Newly-added code has been compiled with ``gcc -W`` (use
+   ``make KCFLAGS=-W``).  This will generate lots of noise, but is good
+   for finding bugs like "warning: comparison between signed and unsigned".
 
-19) Has been checked with injection of at least slab and page-allocation
-    failures.  See ``Documentation/fault-injection/``.
+#. If your modified source code depends on or uses any of the kernel
+   APIs or features that are related to the following ``Kconfig`` symbols,
+   then test multiple builds with the related ``Kconfig`` symbols disabled
+   and/or ``=m`` (if that option is available) [not all of these at the
+   same time, just various/random combinations of them]:
 
-    If the new code is substantial, addition of subsystem-specific fault
-    injection might be appropriate.
+   ``CONFIG_SMP``, ``CONFIG_SYSFS``, ``CONFIG_PROC_FS``, ``CONFIG_INPUT``,
+   ``CONFIG_PCI``, ``CONFIG_BLOCK``, ``CONFIG_PM``, ``CONFIG_MAGIC_SYSRQ``,
+   ``CONFIG_NET``, ``CONFIG_INET=n`` (but latter with ``CONFIG_NET=y``).
 
-20) Newly-added code has been compiled with ``gcc -W`` (use
-    ``make KCFLAGS=-W``).  This will generate lots of noise, but is good
-    for finding bugs like "warning: comparison between signed and unsigned".
+Test your code
+==============
 
-21) Tested after it has been merged into the -mm patchset to make sure
-    that it still works with all of the other queued patches and various
-    changes in the VM, VFS, and other subsystems.
+#. Has been tested with ``CONFIG_PREEMPT``, ``CONFIG_DEBUG_PREEMPT``,
+   ``CONFIG_SLUB_DEBUG``, ``CONFIG_DEBUG_PAGEALLOC``, ``CONFIG_DEBUG_MUTEXES``,
+   ``CONFIG_DEBUG_SPINLOCK``, ``CONFIG_DEBUG_ATOMIC_SLEEP``,
+   ``CONFIG_PROVE_RCU`` and ``CONFIG_DEBUG_OBJECTS_RCU_HEAD`` all
+   simultaneously enabled.
 
-22) All memory barriers {e.g., ``barrier()``, ``rmb()``, ``wmb()``} need a
-    comment in the source code that explains the logic of what they are doing
-    and why.
+#. Has been build- and runtime tested with and without ``CONFIG_SMP`` and
+   ``CONFIG_PREEMPT.``
 
-23) If any ioctl's are added by the patch, then also update
-    ``Documentation/userspace-api/ioctl/ioctl-number.rst``.
+#. All codepaths have been exercised with all lockdep features enabled.
 
-24) If your modified source code depends on or uses any of the kernel
-    APIs or features that are related to the following ``Kconfig`` symbols,
-    then test multiple builds with the related ``Kconfig`` symbols disabled
-    and/or ``=m`` (if that option is available) [not all of these at the
-    same time, just various/random combinations of them]:
+#. Has been checked with injection of at least slab and page-allocation
+   failures.  See ``Documentation/fault-injection/``.
+   If the new code is substantial, addition of subsystem-specific fault
+   injection might be appropriate.
 
-    ``CONFIG_SMP``, ``CONFIG_SYSFS``, ``CONFIG_PROC_FS``, ``CONFIG_INPUT``, ``CONFIG_PCI``, ``CONFIG_BLOCK``, ``CONFIG_PM``, ``CONFIG_MAGIC_SYSRQ``,
-    ``CONFIG_NET``, ``CONFIG_INET=n`` (but latter with ``CONFIG_NET=y``).
+#. Tested with the most recent tag of linux-next to make sure that it still
+   works with all of the other queued patches and various changes in the VM,
+   VFS, and other subsystems.
-- 
2.43.2


