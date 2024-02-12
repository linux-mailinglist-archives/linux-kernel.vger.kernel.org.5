Return-Path: <linux-kernel+bounces-61412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7286485120D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4E90B2570C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E5B38FA0;
	Mon, 12 Feb 2024 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0tHGYpz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950EC2B9BA;
	Mon, 12 Feb 2024 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707736895; cv=none; b=BEqhoz+veG7Nv+nEa+vkhUzC8MGd8c38dUmgn7ZqGYAN+OigNrP1MNE2qT1FJsPRGwISGu6DoaXZdkkev0KDCGPe/v1cwiMAvSTG5tidYBRQcdFqLqMeKoIe27r7V0ojODphfSANn17vdpujNnzFABZdrka2f64TN3M4XtzXT8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707736895; c=relaxed/simple;
	bh=UTZ/9b2upkmRO95sG+xHWOW0d11yUPZoWANmO++M5FM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P9aHEeta127NpClLlpRhfCWuqCPsXnKOaSxbBkdde+dKQwZtUFDBGqIjFnt2UNNtKB1hzCeLy4q38IvM/KgEm/DN3SCuFBPU/485Tbt7EjgPR0zFEYjFS8V/9msJHQ1kg1V1rni/iLmx//gKHqVaPM1DanpmY0ScWfjhcET30H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0tHGYpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA2BC433F1;
	Mon, 12 Feb 2024 11:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707736895;
	bh=UTZ/9b2upkmRO95sG+xHWOW0d11yUPZoWANmO++M5FM=;
	h=From:To:Cc:Subject:Date:From;
	b=K0tHGYpzwxi+MvDfiDXiharKqhX53nsijHtTAfHaPuEyRVZRCh1RlbYhm8oN+JB3+
	 0Jw0TmtYdYfEAlO0cux+pHdgTNnQQLcv8qO3ImWACnV6IsnIYhTa2AeH4+kfCE1P1L
	 UwsNGr52kxqQAU+krN60B66P1+Et459zeQPCej3BoGoo2Ixx5xGbhmE0GG5vrLhunT
	 m1opfSUen0IIhZhPm6DHpFiQu1DK9KJHKoYuXdyybec3Xsxwp3i8pvaL9kTFQZ7Gqm
	 hTwXqbS13G4BnXw8Qd/xeULy25tZkj9NTtJrNKfZ29qHSoIucU4ql6EtnbX33nJmEr
	 89pcg257duIGA==
From: Arnd Bergmann <arnd@kernel.org>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] parisc: avoid c23 'nullptr' idenitifier
Date: Mon, 12 Feb 2024 12:20:51 +0100
Message-Id: <20240212112129.1076631-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Starting in c23, this is a reserved keyword, so in the future, using it
will start causing build failures:

arch/parisc/math-emu/frnd.c:36:23: error: expected ';', ',' or ')' before 'nullptr'

Since I can't think of a good replacement name, add a leading underscore
to the function argument to avoid this namespace conflict. Apparently
all of these arguments are unused.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Feel free to come up with a better name here and apply a different
patch, treating this as a bug report.
---
 arch/parisc/math-emu/dfsqrt.c  |  4 ++--
 arch/parisc/math-emu/fcnvff.c  |  8 ++++----
 arch/parisc/math-emu/fcnvfu.c  | 16 ++++++++--------
 arch/parisc/math-emu/fcnvfut.c | 16 ++++++++--------
 arch/parisc/math-emu/fcnvfx.c  | 16 ++++++++--------
 arch/parisc/math-emu/fcnvfxt.c | 16 ++++++++--------
 arch/parisc/math-emu/fcnvuf.c  | 16 ++++++++--------
 arch/parisc/math-emu/fcnvxf.c  | 16 ++++++++--------
 arch/parisc/math-emu/frnd.c    |  8 ++++----
 arch/parisc/math-emu/sfsqrt.c  |  4 ++--
 10 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/arch/parisc/math-emu/dfsqrt.c b/arch/parisc/math-emu/dfsqrt.c
index 63d339c81c14..e3a3a19b966b 100644
--- a/arch/parisc/math-emu/dfsqrt.c
+++ b/arch/parisc/math-emu/dfsqrt.c
@@ -15,7 +15,7 @@
  *	Double Floating-point Square Root
  *
  *  External Interfaces:
- *	dbl_fsqrt(srcptr,nullptr,dstptr,status)
+ *	dbl_fsqrt(srcptr,_nullptr,dstptr,status)
  *
  *  Internal Interfaces:
  *
@@ -37,7 +37,7 @@
 unsigned int
 dbl_fsqrt(
 	    dbl_floating_point *srcptr,
-	    unsigned int *nullptr,
+	    unsigned int *_nullptr,
 	    dbl_floating_point *dstptr,
 	    unsigned int *status)
 {
diff --git a/arch/parisc/math-emu/fcnvff.c b/arch/parisc/math-emu/fcnvff.c
index 0530e6127797..61e489704c86 100644
--- a/arch/parisc/math-emu/fcnvff.c
+++ b/arch/parisc/math-emu/fcnvff.c
@@ -16,8 +16,8 @@
  *	Double Floating-point to Single Floating-point
  *
  *  External Interfaces:
- *	dbl_to_sgl_fcnvff(srcptr,nullptr,dstptr,status)
- *	sgl_to_dbl_fcnvff(srcptr,nullptr,dstptr,status)
+ *	dbl_to_sgl_fcnvff(srcptr,_nullptr,dstptr,status)
+ *	sgl_to_dbl_fcnvff(srcptr,_nullptr,dstptr,status)
  *
  *  Internal Interfaces:
  *
@@ -40,7 +40,7 @@
 int
 sgl_to_dbl_fcnvff(
 	    sgl_floating_point *srcptr,
-	    unsigned int *nullptr,
+	    unsigned int *_nullptr,
 	    dbl_floating_point *dstptr,
 	    unsigned int *status)
 {
@@ -127,7 +127,7 @@ sgl_to_dbl_fcnvff(
 int
 dbl_to_sgl_fcnvff(
 		    dbl_floating_point *srcptr,
-		    unsigned int *nullptr,
+		    unsigned int *_nullptr,
 		    sgl_floating_point *dstptr,
 		    unsigned int *status)
 {
diff --git a/arch/parisc/math-emu/fcnvfu.c b/arch/parisc/math-emu/fcnvfu.c
index c971618a6f3c..c31790ceecca 100644
--- a/arch/parisc/math-emu/fcnvfu.c
+++ b/arch/parisc/math-emu/fcnvfu.c
@@ -15,10 +15,10 @@
  *	Floating-point to Unsigned Fixed-point Converts
  *
  *  External Interfaces:
- *	dbl_to_dbl_fcnvfu(srcptr,nullptr,dstptr,status)
- *	dbl_to_sgl_fcnvfu(srcptr,nullptr,dstptr,status)
- *	sgl_to_dbl_fcnvfu(srcptr,nullptr,dstptr,status)
- *	sgl_to_sgl_fcnvfu(srcptr,nullptr,dstptr,status)
+ *	dbl_to_dbl_fcnvfu(srcptr,_nullptr,dstptr,status)
+ *	dbl_to_sgl_fcnvfu(srcptr,_nullptr,dstptr,status)
+ *	sgl_to_dbl_fcnvfu(srcptr,_nullptr,dstptr,status)
+ *	sgl_to_sgl_fcnvfu(srcptr,_nullptr,dstptr,status)
  *
  *  Internal Interfaces:
  *
@@ -45,7 +45,7 @@
 int
 sgl_to_sgl_fcnvfu(
 			sgl_floating_point *srcptr,
-			unsigned int *nullptr,
+			unsigned int *_nullptr,
 			unsigned int *dstptr,
 			unsigned int *status)
 {
@@ -166,7 +166,7 @@ sgl_to_sgl_fcnvfu(
 int
 sgl_to_dbl_fcnvfu(
 		    sgl_floating_point *srcptr,
-		    unsigned int *nullptr,
+		    unsigned int *_nullptr,
 		    dbl_unsigned *dstptr,
 		    unsigned int *status)
 {
@@ -285,7 +285,7 @@ sgl_to_dbl_fcnvfu(
  */
 /*ARGSUSED*/
 int
-dbl_to_sgl_fcnvfu (dbl_floating_point * srcptr, unsigned int *nullptr,
+dbl_to_sgl_fcnvfu (dbl_floating_point * srcptr, unsigned int *_nullptr,
 		   unsigned int *dstptr, unsigned int *status)
 {
 	register unsigned int srcp1, srcp2, result;
@@ -408,7 +408,7 @@ dbl_to_sgl_fcnvfu (dbl_floating_point * srcptr, unsigned int *nullptr,
  */
 /*ARGSUSED*/
 int
-dbl_to_dbl_fcnvfu (dbl_floating_point * srcptr, unsigned int *nullptr,
+dbl_to_dbl_fcnvfu (dbl_floating_point * srcptr, unsigned int *_nullptr,
 		   dbl_unsigned * dstptr, unsigned int *status)
 {
 	register int src_exponent;
diff --git a/arch/parisc/math-emu/fcnvfut.c b/arch/parisc/math-emu/fcnvfut.c
index 5b657f852578..2cf1daf3b7ad 100644
--- a/arch/parisc/math-emu/fcnvfut.c
+++ b/arch/parisc/math-emu/fcnvfut.c
@@ -15,10 +15,10 @@
  *	Floating-point to Unsigned Fixed-point Converts with Truncation
  *
  *  External Interfaces:
- *	dbl_to_dbl_fcnvfut(srcptr,nullptr,dstptr,status)
- *	dbl_to_sgl_fcnvfut(srcptr,nullptr,dstptr,status)
- *	sgl_to_dbl_fcnvfut(srcptr,nullptr,dstptr,status)
- *	sgl_to_sgl_fcnvfut(srcptr,nullptr,dstptr,status)
+ *	dbl_to_dbl_fcnvfut(srcptr,_nullptr,dstptr,status)
+ *	dbl_to_sgl_fcnvfut(srcptr,_nullptr,dstptr,status)
+ *	sgl_to_dbl_fcnvfut(srcptr,_nullptr,dstptr,status)
+ *	sgl_to_sgl_fcnvfut(srcptr,_nullptr,dstptr,status)
  *
  *  Internal Interfaces:
  *
@@ -44,7 +44,7 @@
  */
 /*ARGSUSED*/
 int
-sgl_to_sgl_fcnvfut (sgl_floating_point * srcptr, unsigned int *nullptr,
+sgl_to_sgl_fcnvfut (sgl_floating_point * srcptr, unsigned int *_nullptr,
 		    unsigned int *dstptr, unsigned int *status)
 {
 	register unsigned int src, result;
@@ -113,7 +113,7 @@ sgl_to_sgl_fcnvfut (sgl_floating_point * srcptr, unsigned int *nullptr,
  */
 /*ARGSUSED*/
 int
-sgl_to_dbl_fcnvfut (sgl_floating_point * srcptr, unsigned int *nullptr,
+sgl_to_dbl_fcnvfut (sgl_floating_point * srcptr, unsigned int *_nullptr,
 		    dbl_unsigned * dstptr, unsigned int *status)
 {
 	register int src_exponent;
@@ -183,7 +183,7 @@ sgl_to_dbl_fcnvfut (sgl_floating_point * srcptr, unsigned int *nullptr,
  */
 /*ARGSUSED*/
 int
-dbl_to_sgl_fcnvfut (dbl_floating_point * srcptr, unsigned int *nullptr,
+dbl_to_sgl_fcnvfut (dbl_floating_point * srcptr, unsigned int *_nullptr,
 		    unsigned int *dstptr, unsigned int *status)
 {
 	register unsigned int srcp1, srcp2, result;
@@ -252,7 +252,7 @@ dbl_to_sgl_fcnvfut (dbl_floating_point * srcptr, unsigned int *nullptr,
  */
 /*ARGSUSED*/
 int
-dbl_to_dbl_fcnvfut (dbl_floating_point * srcptr, unsigned int *nullptr,
+dbl_to_dbl_fcnvfut (dbl_floating_point * srcptr, unsigned int *_nullptr,
 		    dbl_unsigned * dstptr, unsigned int *status)
 {
 	register int src_exponent;
diff --git a/arch/parisc/math-emu/fcnvfx.c b/arch/parisc/math-emu/fcnvfx.c
index 5e153078d803..99bd61479452 100644
--- a/arch/parisc/math-emu/fcnvfx.c
+++ b/arch/parisc/math-emu/fcnvfx.c
@@ -18,10 +18,10 @@
  *	Double Floating-point to Double Fixed-point 
  *
  *  External Interfaces:
- *	dbl_to_dbl_fcnvfx(srcptr,nullptr,dstptr,status)
- *	dbl_to_sgl_fcnvfx(srcptr,nullptr,dstptr,status)
- *	sgl_to_dbl_fcnvfx(srcptr,nullptr,dstptr,status)
- *	sgl_to_sgl_fcnvfx(srcptr,nullptr,dstptr,status)
+ *	dbl_to_dbl_fcnvfx(srcptr,_nullptr,dstptr,status)
+ *	dbl_to_sgl_fcnvfx(srcptr,_nullptr,dstptr,status)
+ *	sgl_to_dbl_fcnvfx(srcptr,_nullptr,dstptr,status)
+ *	sgl_to_sgl_fcnvfx(srcptr,_nullptr,dstptr,status)
  *
  *  Internal Interfaces:
  *
@@ -44,7 +44,7 @@
 int
 sgl_to_sgl_fcnvfx(
 		    sgl_floating_point *srcptr,
-		    sgl_floating_point *nullptr,
+		    sgl_floating_point *_nullptr,
 		    int *dstptr,
 		    sgl_floating_point *status)
 {
@@ -141,7 +141,7 @@ sgl_to_sgl_fcnvfx(
 int
 sgl_to_dbl_fcnvfx(
 		sgl_floating_point *srcptr,
-		unsigned int *nullptr,
+		unsigned int *_nullptr,
 		dbl_integer *dstptr,
 		unsigned int *status)
 {
@@ -262,7 +262,7 @@ sgl_to_dbl_fcnvfx(
 int
 dbl_to_sgl_fcnvfx(
 		    dbl_floating_point *srcptr,
-		    unsigned int *nullptr,
+		    unsigned int *_nullptr,
 		    int *dstptr,
 		    unsigned int *status)
 {
@@ -373,7 +373,7 @@ dbl_to_sgl_fcnvfx(
 int
 dbl_to_dbl_fcnvfx(
 		    dbl_floating_point *srcptr,
-		    unsigned int *nullptr,
+		    unsigned int *_nullptr,
 		    dbl_integer *dstptr,
 		    unsigned int *status)
 {
diff --git a/arch/parisc/math-emu/fcnvfxt.c b/arch/parisc/math-emu/fcnvfxt.c
index ebec31e40d01..3b7cc62257d0 100644
--- a/arch/parisc/math-emu/fcnvfxt.c
+++ b/arch/parisc/math-emu/fcnvfxt.c
@@ -18,10 +18,10 @@
  *	Double Floating-point to Double Fixed-point /w truncated result
  *
  *  External Interfaces:
- *	dbl_to_dbl_fcnvfxt(srcptr,nullptr,dstptr,status)
- *	dbl_to_sgl_fcnvfxt(srcptr,nullptr,dstptr,status)
- *	sgl_to_dbl_fcnvfxt(srcptr,nullptr,dstptr,status)
- *	sgl_to_sgl_fcnvfxt(srcptr,nullptr,dstptr,status)
+ *	dbl_to_dbl_fcnvfxt(srcptr,_nullptr,dstptr,status)
+ *	dbl_to_sgl_fcnvfxt(srcptr,_nullptr,dstptr,status)
+ *	sgl_to_dbl_fcnvfxt(srcptr,_nullptr,dstptr,status)
+ *	sgl_to_sgl_fcnvfxt(srcptr,_nullptr,dstptr,status)
  *
  *  Internal Interfaces:
  *
@@ -45,7 +45,7 @@
 int
 sgl_to_sgl_fcnvfxt(
 		    sgl_floating_point *srcptr,
-		    unsigned int *nullptr,
+		    unsigned int *_nullptr,
 		    int *dstptr,
 		    unsigned int *status)
 {
@@ -109,7 +109,7 @@ sgl_to_sgl_fcnvfxt(
 int
 sgl_to_dbl_fcnvfxt(
 		    sgl_floating_point *srcptr,
-		    unsigned int *nullptr,
+		    unsigned int *_nullptr,
 		    dbl_integer *dstptr,
 		    unsigned int *status)
 {
@@ -183,7 +183,7 @@ sgl_to_dbl_fcnvfxt(
 int
 dbl_to_sgl_fcnvfxt(
 			dbl_floating_point *srcptr,
-			unsigned int *nullptr,
+			unsigned int *_nullptr,
 			int *dstptr,
 			unsigned int *status)
 {
@@ -248,7 +248,7 @@ dbl_to_sgl_fcnvfxt(
 int
 dbl_to_dbl_fcnvfxt(
 			dbl_floating_point *srcptr,
-			unsigned int *nullptr,
+			unsigned int *_nullptr,
 			dbl_integer *dstptr,
 			unsigned int *status)
 {
diff --git a/arch/parisc/math-emu/fcnvuf.c b/arch/parisc/math-emu/fcnvuf.c
index c54978a0ace1..c166feb57045 100644
--- a/arch/parisc/math-emu/fcnvuf.c
+++ b/arch/parisc/math-emu/fcnvuf.c
@@ -15,10 +15,10 @@
  *	Fixed point to Floating-point Converts
  *
  *  External Interfaces:
- *	dbl_to_dbl_fcnvuf(srcptr,nullptr,dstptr,status)
- *	dbl_to_sgl_fcnvuf(srcptr,nullptr,dstptr,status)
- *	sgl_to_dbl_fcnvuf(srcptr,nullptr,dstptr,status)
- *	sgl_to_sgl_fcnvuf(srcptr,nullptr,dstptr,status)
+ *	dbl_to_dbl_fcnvuf(srcptr,_nullptr,dstptr,status)
+ *	dbl_to_sgl_fcnvuf(srcptr,_nullptr,dstptr,status)
+ *	sgl_to_dbl_fcnvuf(srcptr,_nullptr,dstptr,status)
+ *	sgl_to_sgl_fcnvuf(srcptr,_nullptr,dstptr,status)
  *
  *  Internal Interfaces:
  *
@@ -45,7 +45,7 @@
 int
 sgl_to_sgl_fcnvuf(
 			unsigned int *srcptr,
-			unsigned int *nullptr,
+			unsigned int *_nullptr,
 			sgl_floating_point *dstptr,
 			unsigned int *status)
 {
@@ -104,7 +104,7 @@ sgl_to_sgl_fcnvuf(
 int
 sgl_to_dbl_fcnvuf(
 			unsigned int *srcptr,
-			unsigned int *nullptr,
+			unsigned int *_nullptr,
 			dbl_floating_point *dstptr,
 			unsigned int *status)
 {
@@ -145,7 +145,7 @@ sgl_to_dbl_fcnvuf(
 int
 dbl_to_sgl_fcnvuf(
 			dbl_unsigned *srcptr,
-			unsigned int *nullptr,
+			unsigned int *_nullptr,
 			sgl_floating_point *dstptr,
 			unsigned int *status)
 {
@@ -227,7 +227,7 @@ dbl_to_sgl_fcnvuf(
 int
 dbl_to_dbl_fcnvuf(
 		    dbl_unsigned *srcptr,
-		    unsigned int *nullptr,
+		    unsigned int *_nullptr,
 		    dbl_floating_point *dstptr,
 		    unsigned int *status)
 {
diff --git a/arch/parisc/math-emu/fcnvxf.c b/arch/parisc/math-emu/fcnvxf.c
index 69401797146b..11bc1e8a13aa 100644
--- a/arch/parisc/math-emu/fcnvxf.c
+++ b/arch/parisc/math-emu/fcnvxf.c
@@ -18,10 +18,10 @@
  *	Double Fixed-point to Double Floating-point 
  *
  *  External Interfaces:
- *	dbl_to_dbl_fcnvxf(srcptr,nullptr,dstptr,status)
- *	dbl_to_sgl_fcnvxf(srcptr,nullptr,dstptr,status)
- *	sgl_to_dbl_fcnvxf(srcptr,nullptr,dstptr,status)
- *	sgl_to_sgl_fcnvxf(srcptr,nullptr,dstptr,status)
+ *	dbl_to_dbl_fcnvxf(srcptr,_nullptr,dstptr,status)
+ *	dbl_to_sgl_fcnvxf(srcptr,_nullptr,dstptr,status)
+ *	sgl_to_dbl_fcnvxf(srcptr,_nullptr,dstptr,status)
+ *	sgl_to_sgl_fcnvxf(srcptr,_nullptr,dstptr,status)
  *
  *  Internal Interfaces:
  *
@@ -44,7 +44,7 @@
 int
 sgl_to_sgl_fcnvxf(
 		    int *srcptr,
-		    unsigned int *nullptr,
+		    unsigned int *_nullptr,
 		    sgl_floating_point *dstptr,
 		    unsigned int *status)
 {
@@ -115,7 +115,7 @@ sgl_to_sgl_fcnvxf(
 int
 sgl_to_dbl_fcnvxf(
 		    int *srcptr,
-		    unsigned int *nullptr,
+		    unsigned int *_nullptr,
 		    dbl_floating_point *dstptr,
 		    unsigned int *status)
 {
@@ -166,7 +166,7 @@ sgl_to_dbl_fcnvxf(
 int
 dbl_to_sgl_fcnvxf(
 			dbl_integer *srcptr,
-			unsigned int *nullptr,
+			unsigned int *_nullptr,
 			sgl_floating_point *dstptr,
 			unsigned int *status)
 {
@@ -271,7 +271,7 @@ dbl_to_sgl_fcnvxf(
 int
 dbl_to_dbl_fcnvxf(
 		    dbl_integer *srcptr,
-		    unsigned int *nullptr,
+		    unsigned int *_nullptr,
 		    dbl_floating_point *dstptr,
 		    unsigned int *status)
 {
diff --git a/arch/parisc/math-emu/frnd.c b/arch/parisc/math-emu/frnd.c
index 0b0e8493e08a..825d89650c2d 100644
--- a/arch/parisc/math-emu/frnd.c
+++ b/arch/parisc/math-emu/frnd.c
@@ -14,8 +14,8 @@
  *	Quad Floating-point Round to Integer (returns unimplemented)
  *
  *  External Interfaces:
- *	dbl_frnd(srcptr,nullptr,dstptr,status)
- *	sgl_frnd(srcptr,nullptr,dstptr,status)
+ *	dbl_frnd(srcptr,_nullptr,dstptr,status)
+ *	sgl_frnd(srcptr,_nullptr,dstptr,status)
  *
  * END_DESC
 */
@@ -33,7 +33,7 @@
 /*ARGSUSED*/
 int
 sgl_frnd(sgl_floating_point *srcptr,
-	unsigned int *nullptr,
+	unsigned int *_nullptr,
 	sgl_floating_point *dstptr,
 	unsigned int *status)
 {
@@ -138,7 +138,7 @@ sgl_frnd(sgl_floating_point *srcptr,
 int
 dbl_frnd(
 	dbl_floating_point *srcptr,
-	unsigned int *nullptr,
+	unsigned int *_nullptr,
 	dbl_floating_point *dstptr,
 	unsigned int *status)
 {
diff --git a/arch/parisc/math-emu/sfsqrt.c b/arch/parisc/math-emu/sfsqrt.c
index bd6a84f468d8..8e9e023e7b2e 100644
--- a/arch/parisc/math-emu/sfsqrt.c
+++ b/arch/parisc/math-emu/sfsqrt.c
@@ -15,7 +15,7 @@
  *	Single Floating-point Square Root
  *
  *  External Interfaces:
- *	sgl_fsqrt(srcptr,nullptr,dstptr,status)
+ *	sgl_fsqrt(srcptr,_nullptr,dstptr,status)
  *
  *  Internal Interfaces:
  *
@@ -37,7 +37,7 @@
 unsigned int
 sgl_fsqrt(
     sgl_floating_point *srcptr,
-    unsigned int *nullptr,
+    unsigned int *_nullptr,
     sgl_floating_point *dstptr,
     unsigned int *status)
 {
-- 
2.39.2


