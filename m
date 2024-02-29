Return-Path: <linux-kernel+bounces-86082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7206D86BF55
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007351F23F2C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3A13984D;
	Thu, 29 Feb 2024 03:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q78TqmbO"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2A3383A6;
	Thu, 29 Feb 2024 03:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709176093; cv=none; b=siaOKr5FmKb8yGyLOoek4FgxE3xIuBt9vh0khR++bteAP3dHfAc5DrDbSMB5JKld4QwWmvh/OvW4EkMwq/lJuTNuVbjWAoqb0zqW3lqTQhc2dDPjoPGmQQ8Xvc8PwLuCKxRnOTRrw4CKSksdWgBA2c+ouhB1v7muHP2U3jLv2UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709176093; c=relaxed/simple;
	bh=h8Fxr5NUFoLpC353g62oc1r7IAnypkRWof+Jd0EtDyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KuHMLKHS4/+6f3N10eXvj3tbS1RJoua26rKiOglO5TizT5QO2LwW+W2aaxixdoXXu/HLID+BpnUHA+oWkTLiw9nUTRpNww5g+Wg5J85h6+/ugvjiuqKP6FB9fHU8cKB71DzFgr6m9Aa5jXdUv94AwE9nYDyICtsGNtXQ4RUDT6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q78TqmbO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412ae15b06fso2847175e9.1;
        Wed, 28 Feb 2024 19:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709176090; x=1709780890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9qU0UCk8gIG4bcK7mpR2nYnDILfB/g3vlRutl/cxbE=;
        b=Q78TqmbO127GL4gf2doJH0Oq+1t6AegEI6QYqXUkSEmKzCbn3zvexsB/tur/bWT1tf
         N/oKXYyfVzHg0mviNWoAt9jXPpP+oihSS73jns/HQEgYvUhfc4jHRtyrxvW/VCQ+jRDv
         2po8MFXumtl9bN4Sbc+0ST0ABCBsKY3u0n1715iB/qysUCSL1RKWJt/lY8vW5fvxnU+p
         cqdVBIG6X5qq/xTVI9wLz0L3MZ8ve9Q8mLACzTJbvGUFPGCakaqqmvHh2zFgFCw2Cb8X
         s7aq5J/Xc+D/CONYnjE7K0lfHCgtrmmWpvIfaSnxnyKntfw3lzCQIJI9WVyXtVjFZQD7
         AGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709176090; x=1709780890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9qU0UCk8gIG4bcK7mpR2nYnDILfB/g3vlRutl/cxbE=;
        b=SRa2rbdwOWv/uxoosCpPrNRLkpAZfntOP4DKYu7g/fPbUtH2Ss+YCoaD2342z/4RLS
         8Ha3U8skNWnah4KiZt3afFNWVZSjx/mhVinBTCmX90dEFYRoMZqH1MubMr++la9kfjGH
         dTohEYHPc8wYSjcWkeTnWzqJ9l9QGCPzXtmQNcooau9Dmf3tl2/cjpknXvqo8axBtaq0
         45evEpQ2CeVJASoRunTtl1iB1/RlGxZTvHUruXgF6YCPPS1eRX0G74TYboyRx9PrKUfw
         51K+nwgYBgIzLjQ78QejyqO5D8XXe0M1ZSicVBwwFcA+LjmP3cxMM0cf0E8FCWE/7BDc
         8YPg==
X-Forwarded-Encrypted: i=1; AJvYcCWQGmCEmrAOFJlBb45c5DSLi5Hwd+Fkgj/xQx7E6CKXoB8TkiQMeNR9r0Jp41z0YN5+9R5jYof/HrnxM2CqhOURnlrzjTJs9PFyxe0Ey4wQeVQCO76iSp2S3AeO44XcPxyjqVdJEOl7FECjG+pr/+feK72Jx6+A1772ZT2pWFZ4SwQG
X-Gm-Message-State: AOJu0YxiQt1nxzLKz0Jk2f+SdvtJG2nE8l0GWZIrRlNZQwtnVgUnl5Vz
	lw6hTlTBMafeNNDjXBXOzNxicj5YaAU7UOhaWDH8Jya5nZl/slsNJ43MHrBlScA=
X-Google-Smtp-Source: AGHT+IHOgypU5Q+mTc/4l0GolZRObJHUKnu8LPW+QzhJhiPMpzHSzPSnBgqZkK4bqXnAWAduclIdGw==
X-Received: by 2002:a5d:58fb:0:b0:33d:9c56:37f4 with SMTP id f27-20020a5d58fb000000b0033d9c5637f4mr443986wrd.46.1709176090184;
        Wed, 28 Feb 2024 19:08:10 -0800 (PST)
Received: from lola.. ([2a02:810d:7e40:14b0:d371:e319:5dd0:9b35])
        by smtp.gmail.com with ESMTPSA id u1-20020adfb201000000b0033b1c321070sm417512wra.31.2024.02.28.19.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 19:08:10 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Jani Nikula <jani.nikula@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2 3/3] docs: submit-checklist: change to autonumbered lists
Date: Thu, 29 Feb 2024 04:07:43 +0100
Message-ID: <20240229030743.9125-4-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240229030743.9125-1-lukas.bulwahn@gmail.com>
References: <20240229030743.9125-1-lukas.bulwahn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During review (see Link), Jani Nikula suggested to use autonumbered
lists instead of manually-maintained bullet numbering.

Turn all lists into autonumbered lists.

Link: https://lore.kernel.org/linux-doc/87o7c3mlwb.fsf@intel.com/
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/process/submit-checklist.rst | 48 +++++++++++-----------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/Documentation/process/submit-checklist.rst b/Documentation/process/submit-checklist.rst
index e531dd504b6c..c984b747a755 100644
--- a/Documentation/process/submit-checklist.rst
+++ b/Documentation/process/submit-checklist.rst
@@ -14,62 +14,62 @@ and elsewhere regarding submitting Linux kernel patches.
 Review your code
 ================
 
-1) If you use a facility then #include the file that defines/declares
+#. If you use a facility then #include the file that defines/declares
    that facility.  Don't depend on other header files pulling in ones
    that you use.
 
-2) Check your patch for general style as detailed in
+#. Check your patch for general style as detailed in
    :ref:`Documentation/process/coding-style.rst <codingstyle>`.
 
-3) All memory barriers {e.g., ``barrier()``, ``rmb()``, ``wmb()``} need a
+#. All memory barriers {e.g., ``barrier()``, ``rmb()``, ``wmb()``} need a
    comment in the source code that explains the logic of what they are doing
    and why.
 
 Review Kconfig changes
 ======================
 
-1) Any new or modified ``CONFIG`` options do not muck up the config menu and
+#. Any new or modified ``CONFIG`` options do not muck up the config menu and
    default to off unless they meet the exception criteria documented in
    ``Documentation/kbuild/kconfig-language.rst`` Menu attributes: default value.
 
-2) All new ``Kconfig`` options have help text.
+#. All new ``Kconfig`` options have help text.
 
-3) Has been carefully reviewed with respect to relevant ``Kconfig``
+#. Has been carefully reviewed with respect to relevant ``Kconfig``
    combinations.  This is very hard to get right with testing---brainpower
    pays off here.
 
 Provide documentation
 =====================
 
-1) Include :ref:`kernel-doc <kernel_doc>` to document global kernel APIs.
+#. Include :ref:`kernel-doc <kernel_doc>` to document global kernel APIs.
    (Not required for static functions, but OK there also.)
 
-2) All new ``/proc`` entries are documented under ``Documentation/``
+#. All new ``/proc`` entries are documented under ``Documentation/``
 
-3) All new kernel boot parameters are documented in
+#. All new kernel boot parameters are documented in
    ``Documentation/admin-guide/kernel-parameters.rst``.
 
-4) All new module parameters are documented with ``MODULE_PARM_DESC()``
+#. All new module parameters are documented with ``MODULE_PARM_DESC()``
 
-5) All new userspace interfaces are documented in ``Documentation/ABI/``.
+#. All new userspace interfaces are documented in ``Documentation/ABI/``.
    See ``Documentation/ABI/README`` for more information.
    Patches that change userspace interfaces should be CCed to
    linux-api@vger.kernel.org.
 
-6) If any ioctl's are added by the patch, then also update
+#. If any ioctl's are added by the patch, then also update
    ``Documentation/userspace-api/ioctl/ioctl-number.rst``.
 
 Check your code with tools
 ==========================
 
-1) Check for trivial violations with the patch style checker prior to
+#. Check for trivial violations with the patch style checker prior to
    submission (``scripts/checkpatch.pl``).
    You should be able to justify all violations that remain in
    your patch.
 
-2) Check cleanly with sparse.
+#. Check cleanly with sparse.
 
-3) Use ``make checkstack`` and fix any problems that it finds.
+#. Use ``make checkstack`` and fix any problems that it finds.
    Note that ``checkstack`` does not point out problems explicitly,
    but any one function that uses more than 512 bytes on the stack is a
    candidate for change.
@@ -77,7 +77,7 @@ Check your code with tools
 Build your code
 ===============
 
-1) Builds cleanly:
+#. Builds cleanly:
 
   a) with applicable or modified ``CONFIG`` options ``=y``, ``=m``, and
      ``=n``.  No ``gcc`` warnings/errors, no linker warnings/errors.
@@ -90,16 +90,16 @@ Build your code
      Use ``make htmldocs`` or ``make pdfdocs`` to check the build and
      fix any issues.
 
-2) Builds on multiple CPU architectures by using local cross-compile tools
+#. Builds on multiple CPU architectures by using local cross-compile tools
    or some other build farm. Note that ppc64 is a good architecture for
    cross-compilation checking because it tends to use ``unsigned long`` for
    64-bit quantities.
 
-3) Newly-added code has been compiled with ``gcc -W`` (use
+#. Newly-added code has been compiled with ``gcc -W`` (use
    ``make KCFLAGS=-W``).  This will generate lots of noise, but is good
    for finding bugs like "warning: comparison between signed and unsigned".
 
-4) If your modified source code depends on or uses any of the kernel
+#. If your modified source code depends on or uses any of the kernel
    APIs or features that are related to the following ``Kconfig`` symbols,
    then test multiple builds with the related ``Kconfig`` symbols disabled
    and/or ``=m`` (if that option is available) [not all of these at the
@@ -112,22 +112,22 @@ Build your code
 Test your code
 ==============
 
-1) Has been tested with ``CONFIG_PREEMPT``, ``CONFIG_DEBUG_PREEMPT``,
+#. Has been tested with ``CONFIG_PREEMPT``, ``CONFIG_DEBUG_PREEMPT``,
    ``CONFIG_SLUB_DEBUG``, ``CONFIG_DEBUG_PAGEALLOC``, ``CONFIG_DEBUG_MUTEXES``,
    ``CONFIG_DEBUG_SPINLOCK``, ``CONFIG_DEBUG_ATOMIC_SLEEP``,
    ``CONFIG_PROVE_RCU`` and ``CONFIG_DEBUG_OBJECTS_RCU_HEAD`` all
    simultaneously enabled.
 
-2) Has been build- and runtime tested with and without ``CONFIG_SMP`` and
+#. Has been build- and runtime tested with and without ``CONFIG_SMP`` and
    ``CONFIG_PREEMPT.``
 
-3) All codepaths have been exercised with all lockdep features enabled.
+#. All codepaths have been exercised with all lockdep features enabled.
 
-4) Has been checked with injection of at least slab and page-allocation
+#. Has been checked with injection of at least slab and page-allocation
    failures.  See ``Documentation/fault-injection/``.
    If the new code is substantial, addition of subsystem-specific fault
    injection might be appropriate.
 
-5) Tested with the most recent tag of linux-next to make sure that it still
+#. Tested with the most recent tag of linux-next to make sure that it still
    works with all of the other queued patches and various changes in the VM,
    VFS, and other subsystems.
-- 
2.43.2


