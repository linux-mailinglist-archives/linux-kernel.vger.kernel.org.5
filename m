Return-Path: <linux-kernel+bounces-14079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBDE8217AA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834111F21CB8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91124693;
	Tue,  2 Jan 2024 06:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sO0SmGJI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506182583;
	Tue,  2 Jan 2024 06:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=YpIRPyFf90I4Z3IJEoDmkRte1e+hElppoVNgHQl0hWA=; b=sO0SmGJIunwG0I7STeC1KWrsQn
	hyWznpREMw2uAcfZi44vGzWDRwznblH9ldUnCCXRZKpDKEK0hIdUAfzkGMsOGuHl/sS3h2ipnegKP
	dR4JCxF62Bk9J9tOjsqtz9JtkDFk7tpV83+EIx8u9fEg1wuyUCC/naInDcKuemnYmVYBc2I0eywSJ
	ZOxonysIIV4+WlqM3WIOLeB49zs/DFPhMih7gaMY38+GTzCvXWGPuHrinx6qY5STHKHr5qEFMNCdI
	U4MHZOe835i3yvO1Sqh0LckyhKGGkCH3D1htKtT89Qa9YXOeWVXQHm/7IDH/yCxyLMfym4svbxbi0
	Gm8HLM4Q==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rKY5F-007ALs-1T;
	Tue, 02 Jan 2024 06:17:01 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [RFC PATCH] kernel-doc: handle X86 DEFINE_IDTENTRY() variants
Date: Mon,  1 Jan 2024 22:17:00 -0800
Message-ID: <20240102061700.3807-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach scripts/kernel-doc to handle the various DEFINE_IDTENTRY*() flavors.

This corrects 2 kernel-doc warnings:

arch/x86/entry/common.c:211: warning: expecting prototype for int80_emulation(). Prototype was for DEFINE_IDTENTRY_RAW() instead

arch/x86/kernel/apic/apic.c:2170: warning: expecting prototype for spurious_interrupt(). Prototype was for DEFINE_IDTENTRY_IRQ() instead

The script uses 'uname -m' to determine if it is running on i386 or x86_64
or something else. It also uses "ARCH=<arch>" in the environment variables
to allow for overriding the processed ARCH.

Alternatively, we could remove the "/**" kernel-doc markers from those
2 functions. There are 60 uses of DEFINE_IDTENTRY*() that I see and
only 2 of them have kernel-doc comments.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 scripts/kernel-doc |   87 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff -- a/scripts/kernel-doc b/scripts/kernel-doc
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -128,6 +128,7 @@ if ($#ARGV == -1) {
 
 my $kernelversion;
 my ($sphinx_major, $sphinx_minor, $sphinx_patch);
+my ($arch, $arch_is_x86, $arch_x86_64);
 
 my $dohighlight = "";
 
@@ -439,6 +440,31 @@ sub get_kernel_version() {
     return $version;
 }
 
+# get the environment ARCH and x86 flavor
+sub get_arch() {
+
+	my $uname = `uname -m`;
+	chomp($uname);
+	$uname =~ s/i.86/i386/;
+	if ($uname eq "x86") {
+		$uname = "x86_64";
+	}
+
+	# allow ENV ARCH to override uname -m
+	if (defined($ENV{'ARCH'})) {
+		$arch = $ENV{'ARCH'};
+		if ($arch eq "i386" || $arch eq "x86_64") {
+			# use that
+		} else {
+			$arch = $uname;
+		}
+	} else {
+		$arch = $uname;
+	}
+	$arch_is_x86 = ($arch eq "i386") || ($arch eq "x86_64");
+	$arch_x86_64 = $arch eq "x86_64";
+}
+
 #
 sub print_lineno {
     my $lineno = shift;
@@ -1867,6 +1893,62 @@ sub tracepoint_munge($) {
 	}
 }
 
+# idtentry_munge() is only for x86 and can be different for i386 vs. x86_64.
+sub idtentry_munge($) {
+	my $file = shift;
+	my $idtentryname = "";
+	my $idtentryargs = "void";
+	$prototype =~ s/^\s+|\s+$//g;   # remove both leading and trailing whitespace
+
+	if ($prototype =~ m/DEFINE_IDTENTRY\((.*?)\)/) {
+		$idtentryname = $1;
+		$idtentryargs = "struct pt_regs *regs";
+	} elsif ($prototype =~ m/DEFINE_IDTENTRY_ERRORCODE\((.*?)\)/) {
+		$idtentryname = $1;
+		$idtentryargs = "struct pt_regs *regs, unsigned long error_code";
+	} elsif ($prototype =~ m/DEFINE_IDTENTRY_RAW\((.*?)\)/) {
+		$idtentryname = $1;
+		$idtentryargs = "struct pt_regs *regs";
+	} elsif ($prototype =~ m/DEFINE_IDTENTRY_RAW_ERRORCODE\((.*?)\)/) {
+		$idtentryname = $1;
+		$idtentryargs = "struct pt_regs *regs, unsigned long error_code";
+	} elsif ($prototype =~ m/DEFINE_IDTENTRY_IRQ\((.*?)\)/) {
+		$idtentryname = $1;
+		$idtentryargs = "struct pt_regs *regs, u32 vector";
+	} elsif ($prototype =~ m/DEFINE_IDTENTRY_SYSVEC\((.*?)\)/) {
+		$idtentryname = $1;
+		$idtentryargs = "struct pt_regs *regs";
+	} elsif ($prototype =~ m/DEFINE_IDTENTRY_SYSVEC_SIMPLE\((.*?)\)/) {
+		$idtentryname = $1;
+		$idtentryargs = "struct pt_regs *regs";
+	} elsif ($prototype =~ m/DEFINE_IDTENTRY_IST\((.*?)\)/) { # same as _RAW
+		$idtentryname = $1;
+		$idtentryargs = "struct pt_regs *regs";
+	} elsif ($prototype =~ m/DEFINE_IDTENTRY_NOIST\((.*?)\)/) { # same as _RAW
+		$idtentryname = "noist_" . $1;
+		$idtentryargs = "struct pt_regs *regs";
+	} elsif ($prototype =~ m/DEFINE_IDTENTRY_DF\((.*?)\)/) { # same as _RAW_ERRORCODE
+		$idtentryname = $1;
+		$idtentryargs = $arch_x86_64 ? "struct pt_regs *regs, unsigned long error_code"
+			: "struct pt_regs *regs, unsigned long error_code, unsigned long address";
+	} elsif ($prototype =~ m/DEFINE_IDTENTRY_VC_KERNEL\((.*?)\)/) { # same as _RAW_ERRORCODE
+		$idtentryname = $1;
+		$idtentryargs = "struct pt_regs *regs, unsigned long error_code";
+	} elsif ($prototype =~ m/DEFINE_IDTENTRY_VC_USER\((.*?)\)/) { # same as _RAW_ERRORCODE
+		$idtentryname = $1;
+		$idtentryargs = "struct pt_regs *regs, unsigned long error_code";
+	}
+
+	$idtentryname =~ s/^\s+//; #strip leading whitespace
+	if ($idtentryname eq "") {
+		emit_warning("${file}:$.", "Unrecognized IDTENTRY macro: \n".
+			     "$prototype\n");
+	} else {
+		$prototype = "void $idtentryname($idtentryargs)";
+		$identifier = "$idtentryname";
+	}
+}
+
 sub syscall_munge() {
 	my $void = 0;
 
@@ -1931,6 +2013,9 @@ sub process_proto_function($$) {
 	{
 		tracepoint_munge($file);
 	}
+	if ($arch_is_x86 && $prototype =~ /DEFINE_IDTENTRY/) {
+		idtentry_munge($file);
+	}
 	dump_function($prototype, $file);
 	reset_state();
     }
@@ -2374,6 +2459,8 @@ if ($output_mode eq "rst") {
 
 $kernelversion = get_kernel_version();
 
+get_arch();
+
 # generate a sequence of code that will splice in highlighting information
 # using the s// operator.
 for (my $k = 0; $k < @highlights; $k++) {

