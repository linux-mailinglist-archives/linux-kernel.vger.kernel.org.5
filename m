Return-Path: <linux-kernel+bounces-105481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A81C87DEFE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 17:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F061F214F3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FFD1CF8F;
	Sun, 17 Mar 2024 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naAqZ7eV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1450A1CD26;
	Sun, 17 Mar 2024 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710694318; cv=none; b=HMTu1sjvMRLDeq5nE+GPIZebzVj0xDmbWRWwn2v11KJL9Ie4BklysDwgMDqYdFvykyB5knu3+QR6yuDNad3BVust6C/M0lEtWnJqycZ79VvAi8Hm21Gc2mPey+X4ZwWxPDGvZ4nQVVBuL2e9zPbaaqRNjm007Jr3DyuzBvAPyB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710694318; c=relaxed/simple;
	bh=HxWfd1Znm4cUZamAM6TQvmubUOO81Xy3fg/jRpSm4BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cd0sJBzft20zdOT3KYoJ0iCrLlJn8+yM5A/4kJIs6B/vOGQN3URRXfiXux2uNznFYWl3buWGvH4zUdXfz+NzCyUZV4PFiBYFauZWHzUUpxhDbUSfGsIDrEbzE/kzkXIWPfhG2qFyDyp7IiHKdnlG674UaVGpqSLmlsgLUyxyke4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naAqZ7eV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9858EC433C7;
	Sun, 17 Mar 2024 16:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710694317;
	bh=HxWfd1Znm4cUZamAM6TQvmubUOO81Xy3fg/jRpSm4BI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=naAqZ7eVFLhdBU/5dsNz+CCBzniVgBCPwpb/vhB4+sKkEMaIHcuYIIouHufDX7wLl
	 qovkE+LrJgC/RmilV5mhExNDlSqFAHNEBC81/Y7zZ6SPOjYHU9uPTyN4qj0eWLsNru
	 YVO7K7RHFgu3WF4w4Jl2nrcsRnyPYAvj7vf/EosSsTRArVe+IoKo0O4NHFpFjs2lJW
	 OUhnOvvKy4rQd9op8CWgC8yyQeYmgIqRysmIMcV2wyVevAwEzUgEEjMrQ+zdsb/FQP
	 G3pvf2VlekezVJlwgKWTAFHz8gGvHzfQW1x7x5JTSHy1iOfNPK2Kg+d6K3B0DpQAtT
	 yQJaQhcY3KtOw==
Date: Sun, 17 Mar 2024 09:51:57 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: David Hildenbrand <david@redhat.com>, djwong@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	fstests <fstests@vger.kernel.org>, xfs <linux-xfs@vger.kernel.org>
Subject: [RFC PATCH] xfs_io: add linux madvise advice codes
Message-ID: <20240317165157.GE1927156@frogsfrogsfrogs>
References: <20240314161300.382526-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314161300.382526-1-david@redhat.com>

From: Darrick J. Wong <djwong@kernel.org>

Add all the Linux-specific madvise codes.  We're going to need
MADV_POPULATE_READ for a regression test.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 configure.ac          |    1 
 include/builddefs.in  |    1 
 io/Makefile           |    4 ++
 io/madvise.c          |  111 +++++++++++++++++++++++++++++++++++++++++++++++++
 m4/package_libcdev.m4 |   17 ++++++++
 5 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 3786e44db6fd..723bdca506d1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -187,6 +187,7 @@ AC_CONFIG_SYSTEMD_SYSTEM_UNIT_DIR
 AC_CONFIG_CROND_DIR
 AC_CONFIG_UDEV_DIR
 AC_HAVE_BLKID_TOPO
+AC_HAVE_KERNEL_MADVISE_FLAGS
 
 if test "$enable_ubsan" = "yes" || test "$enable_ubsan" = "probe"; then
         AC_PACKAGE_CHECK_UBSAN
diff --git a/include/builddefs.in b/include/builddefs.in
index 07428206da45..a04f3e70f19d 100644
--- a/include/builddefs.in
+++ b/include/builddefs.in
@@ -193,6 +193,7 @@ HAVE_O_TMPFILE = @have_o_tmpfile@
 HAVE_MKOSTEMP_CLOEXEC = @have_mkostemp_cloexec@
 USE_RADIX_TREE_FOR_INUMS = @use_radix_tree_for_inums@
 HAVE_FSVERITY_DESCR = @have_fsverity_descr@
+HAVE_KERNEL_MADVISE = @have_kernel_madvise@
 
 GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall -Werror -Wextra -Wno-unused-parameter
 #	   -Wbitwise -Wno-transparent-union -Wno-old-initializer -Wno-decl
diff --git a/io/Makefile b/io/Makefile
index 6f903e3df9a7..ce39fda0e82a 100644
--- a/io/Makefile
+++ b/io/Makefile
@@ -84,6 +84,10 @@ ifeq ($(HAVE_GETFSMAP),yes)
 CFILES += fsmap.c
 endif
 
+ifeq ($(HAVE_KERNEL_MADVISE),yes)
+LCFLAGS += -DHAVE_KERNEL_MADVISE
+endif
+
 default: depend $(LTCOMMAND)
 
 include $(BUILDRULES)
diff --git a/io/madvise.c b/io/madvise.c
index 6e9c5b121d72..081666f403bb 100644
--- a/io/madvise.c
+++ b/io/madvise.c
@@ -9,6 +9,9 @@
 #include <sys/mman.h>
 #include "init.h"
 #include "io.h"
+#ifdef HAVE_KERNEL_MADVISE
+# include <asm/mman.h>
+#endif
 
 static cmdinfo_t madvise_cmd;
 
@@ -26,6 +29,47 @@ madvise_help(void)
 " -r -- expect random page references (POSIX_MADV_RANDOM)\n"
 " -s -- expect sequential page references (POSIX_MADV_SEQUENTIAL)\n"
 " -w -- will need these pages (POSIX_MADV_WILLNEED) [*]\n"
+"\n"
+"The following Linux-specific advise values are available:\n"
+#ifdef MADV_COLLAPSE
+" -c -- try to collapse range into transparent hugepages (MADV_COLLAPSE)\n"
+#endif
+#ifdef MADV_COLD
+" -D -- deactivate the range (MADV_COLD)\n"
+#endif
+#ifdef MADV_FREE
+" -f -- free the range (MADV_FREE)\n"
+#endif
+#ifdef MADV_NOHUGEPAGE
+" -h -- disable transparent hugepages (MADV_NOHUGEPAGE)\n"
+#endif
+#ifdef MADV_HUGEPAGE
+" -H -- enable transparent hugepages (MADV_HUGEPAGE)\n"
+#endif
+#ifdef MADV_MERGEABLE
+" -m -- mark the range mergeable (MADV_MERGEABLE)\n"
+#endif
+#ifdef MADV_UNMERGEABLE
+" -M -- mark the range unmergeable (MADV_UNMERGEABLE)\n"
+#endif
+#ifdef MADV_SOFT_OFFLINE
+" -o -- mark the range offline (MADV_SOFT_OFFLINE)\n"
+#endif
+#ifdef MADV_REMOVE
+" -p -- punch a hole in the file (MADV_REMOVE)\n"
+#endif
+#ifdef MADV_HWPOISON
+" -P -- poison the page cache (MADV_HWPOISON)\n"
+#endif
+#ifdef MADV_POPULATE_READ
+" -R -- prefault in the range for read (MADV_POPULATE_READ)\n"
+#endif
+#ifdef MADV_POPULATE_WRITE
+" -W -- prefault in the range for write (MADV_POPULATE_WRITE)\n"
+#endif
+#ifdef MADV_PAGEOUT
+" -X -- reclaim the range (MADV_PAGEOUT)\n"
+#endif
 " Notes:\n"
 "   NORMAL sets the default readahead setting on the file.\n"
 "   RANDOM sets the readahead setting on the file to zero.\n"
@@ -45,20 +89,85 @@ madvise_f(
 	int		advise = MADV_NORMAL, c;
 	size_t		blocksize, sectsize;
 
-	while ((c = getopt(argc, argv, "drsw")) != EOF) {
+	while ((c = getopt(argc, argv, "cdDfhHmMopPrRswWX")) != EOF) {
 		switch (c) {
+#ifdef MADV_COLLAPSE
+		case 'c':	/* collapse to thp */
+			advise = MADV_COLLAPSE;
+			break;
+#endif
 		case 'd':	/* Don't need these pages */
 			advise = MADV_DONTNEED;
 			break;
+#ifdef MADV_COLD
+		case 'D':	/* make more likely to be reclaimed */
+			advise = MADV_COLD;
+			break;
+#endif
+#ifdef MADV_FREE
+		case 'f':	/* page range out of memory */
+			advise = MADV_FREE;
+			break;
+#endif
+#ifdef MADV_HUGEPAGE
+		case 'h':	/* enable thp memory */
+			advise = MADV_HUGEPAGE;
+			break;
+#endif
+#ifdef MADV_NOHUGEPAGE
+		case 'H':	/* disable thp memory */
+			advise = MADV_NOHUGEPAGE;
+			break;
+#endif
+#ifdef MADV_MERGEABLE
+		case 'm':	/* enable merging */
+			advise = MADV_MERGEABLE;
+			break;
+#endif
+#ifdef MADV_UNMERGEABLE
+		case 'M':	/* disable merging */
+			advise = MADV_UNMERGEABLE;
+			break;
+#endif
+#ifdef MADV_SOFT_OFFLINE
+		case 'o':	/* offline */
+			advise = MADV_SOFT_OFFLINE;
+			break;
+#endif
+#ifdef MADV_REMOVE
+		case 'p':	/* punch hole */
+			advise = MADV_REMOVE;
+			break;
+#endif
+#ifdef MADV_HWPOISON
+		case 'P':	/* poison */
+			advise = MADV_HWPOISON;
+			break;
+#endif
 		case 'r':	/* Expect random page references */
 			advise = MADV_RANDOM;
 			break;
+#ifdef MADV_POPULATE_READ
+		case 'R':	/* fault in pages for read */
+			advise = MADV_POPULATE_READ;
+			break;
+#endif
 		case 's':	/* Expect sequential page references */
 			advise = MADV_SEQUENTIAL;
 			break;
 		case 'w':	/* Will need these pages */
 			advise = MADV_WILLNEED;
 			break;
+#ifdef MADV_POPULATE_WRITE
+		case 'W':	/* fault in pages for write */
+			advise = MADV_POPULATE_WRITE;
+			break;
+#endif
+#ifdef MADV_PAGEOUT
+		case 'X':	/* reclaim memory */
+			advise = MADV_PAGEOUT;
+			break;
+#endif
 		default:
 			exitcode = 1;
 			return command_usage(&madvise_cmd);
diff --git a/m4/package_libcdev.m4 b/m4/package_libcdev.m4
index 84f288dfcfdb..064d050b2b55 100644
--- a/m4/package_libcdev.m4
+++ b/m4/package_libcdev.m4
@@ -322,3 +322,20 @@ struct fsverity_descriptor m = { };
     AC_SUBST(have_fsverity_descr)
   ])
 
+#
+# Check if asm/mman.h can be included
+#
+AC_DEFUN([AC_HAVE_KERNEL_MADVISE_FLAGS],
+  [ AC_MSG_CHECKING([for kernel madvise flags in asm/mman.h ])
+    AC_COMPILE_IFELSE(
+    [	AC_LANG_PROGRAM([[
+#include <asm/mman.h>
+	]], [[
+int moo = MADV_COLLAPSE;
+	]])
+    ], have_kernel_madvise=yes
+       AC_MSG_RESULT(yes),
+       AC_MSG_RESULT(no))
+    AC_SUBST(have_kernel_madvise)
+  ])
+

