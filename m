Return-Path: <linux-kernel+bounces-135173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8068F89BC2C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5961B20812
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589D04A9B0;
	Mon,  8 Apr 2024 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nexgo.de header.i=@nexgo.de header.b="eD7U1rVc"
Received: from mr6.vodafonemail.de (mr6.vodafonemail.de [145.253.228.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4D633E5;
	Mon,  8 Apr 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.253.228.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712569508; cv=none; b=sZHnnkSQXG6xIKydYCbrF0Db3kayf5yVtYtFokW62UbwMVu6ACUf2JsiAuTkkBoP5mgpljOaRI8QsLRTrJOX2NGkC4sIp/rnrNEkNWgJu0xT6p8qtM/c5GpybDsHXfiPYyvKjtm93ZO3Vwy5HsjMobaxUcass03IDqPhmEq5FG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712569508; c=relaxed/simple;
	bh=X0+GQa7QJ2+3lukQWG0Jx1+GaK8WmLAHvsunURfwHCc=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=qoilTeIY6ftgh3+ItuY5nuqJ5eAk3j6Na1NrmleAS+XvbevzvQbktkT1adzMRHlnGpS3OogfDFRotvWsGbuKzvvEWiMoyQsc+fAFo6lxKG+lYryR8QKN79qUkXuaDdKeBoWMIMvDNQZ8c481IBw+PDdeYKDnf6eUx/USqbnO4bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=nexgo.de; dkim=pass (1024-bit key) header.d=nexgo.de header.i=@nexgo.de header.b=eD7U1rVc; arc=none smtp.client-ip=145.253.228.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexgo.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nexgo.de;
	s=vfde-mb-mr2-23sep; t=1712568976;
	bh=pOkgtZPXHcLCh8JIwfivwUiRNJ3JAm6xtfDDutHPJL8=;
	h=Message-ID:From:To:Subject:Date:Content-Type:X-Mailer:From;
	b=eD7U1rVcYpcg0WNu98zJuFtrF/sFjyObnk0n4nHZHw7ZduUm2kpi1YNGl3bk5yGz8
	 T7wkKfeBzOr+bnaavIietCLv50fZarVrhlBr1ao/QVPQTqWW4shUtuN/AyKamNNuOf
	 RZ6cUUcSXylBaeu40sG+rN29hJMskRueI0VJ4+Rk=
Received: from smtp.vodafone.de (unknown [10.0.0.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mr6.vodafonemail.de (Postfix) with ESMTPS id 4VCkVm26cKz1xxm;
	Mon,  8 Apr 2024 09:36:16 +0000 (UTC)
Received: from H270 (p5de6d4c4.dip0.t-ipconnect.de [93.230.212.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.vodafone.de (Postfix) with ESMTPSA id 4VCkVV2rsPzMlrq;
	Mon,  8 Apr 2024 09:35:59 +0000 (UTC)
Message-ID: <5EEE09A9021540A5AAD8BFEEE915512D@H270>
From: "Stefan Kanthak" <stefan.kanthak@nexgo.de>
To: <linux-kernel@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>
Cc: <tim.c.chen@linux.intel.com>,
	<sean.m.gulley@intel.com>
Subject: [PATCH 1/2] crypto: s(h)aving 40+ bytes off arch/x86/crypto/sha256_ni_asm.S
Date: Mon, 8 Apr 2024 11:26:52 +0200
Organization: Me, myself & IT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6002.18197
X-MimeOLE: Produced By Microsoft MimeOLE V6.1.7601.24158
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 11383
X-purgate-ID: 155817::1712568971-97FFDBA7-240A3DCD/0/0

Use shorter SSE2 instructions instead of some SSE4.1
use short displacements into K256

--- -/arch/x86/crypto/sha256_ni_asm.S
+++ +/arch/x86/crypto/sha256_ni_asm.S
@@ -108,17 +108,17 @@
          * Need to reorder these appropriately
          * DCBA, HGFE -> ABEF, CDGH
          */
-        movdqu          0*16(DIGEST_PTR), STATE0
-        movdqu          1*16(DIGEST_PTR), STATE1
+        movdqu          0*16(DIGEST_PTR), STATE0        /* DCBA */
+        movdqu          1*16(DIGEST_PTR), STATE1        /* HGFE */
 
-        pshufd          $0xB1, STATE0,  STATE0          /* CDAB */
-        pshufd          $0x1B, STATE1,  STATE1          /* EFGH */
         movdqa          STATE0, MSGTMP4
-        palignr         $8, STATE1,  STATE0             /* ABEF */
-        pblendw         $0xF0, MSGTMP4, STATE1          /* CDGH */
+        punpcklqdq      STATE1, STATE0                  /* FEBA */
+        punpckhqdq      MSGTMP4, STATE1                 /* DCHG */
+        pshufd          $0x1B, STATE0,  STATE0          /* ABEF */
+        pshufd          $0xB1, STATE1,  STATE1          /* CDGH */
 
         movdqa          PSHUFFLE_BYTE_FLIP_MASK(%rip), SHUF_MASK
-        lea             K256(%rip), SHA256CONSTANTS
+        lea             K256+8*16(%rip), SHA256CONSTANTS
 
 .Lloop0:
         /* Save hash values for addition after rounds */
@@ -129,18 +129,18 @@
         movdqu          0*16(DATA_PTR), MSG
         pshufb          SHUF_MASK, MSG
         movdqa          MSG, MSGTMP0
-                paddd           0*16(SHA256CONSTANTS), MSG
+                paddd           -8*16(SHA256CONSTANTS), MSG
                 sha256rnds2     STATE0, STATE1
-                pshufd          $0x0E, MSG, MSG
+                punpckhqdq      MSG, MSG
                 sha256rnds2     STATE1, STATE0
 
         /* Rounds 4-7 */
         movdqu          1*16(DATA_PTR), MSG
         pshufb          SHUF_MASK, MSG
         movdqa          MSG, MSGTMP1
-                paddd           1*16(SHA256CONSTANTS), MSG
+                paddd           -7*16(SHA256CONSTANTS), MSG
                 sha256rnds2     STATE0, STATE1
-                pshufd          $0x0E, MSG, MSG
+                punpckhqdq      MSG, MSG
                 sha256rnds2     STATE1, STATE0
         sha256msg1      MSGTMP1, MSGTMP0
 
@@ -148,9 +148,9 @@
         movdqu          2*16(DATA_PTR), MSG
         pshufb          SHUF_MASK, MSG
         movdqa          MSG, MSGTMP2
-                paddd           2*16(SHA256CONSTANTS), MSG
+                paddd           -6*16(SHA256CONSTANTS), MSG
                 sha256rnds2     STATE0, STATE1
-                pshufd          $0x0E, MSG, MSG
+                punpckhqdq      MSG, MSG
                 sha256rnds2     STATE1, STATE0
         sha256msg1      MSGTMP2, MSGTMP1
 
@@ -158,151 +158,151 @@
         movdqu          3*16(DATA_PTR), MSG
         pshufb          SHUF_MASK, MSG
         movdqa          MSG, MSGTMP3
-                paddd           3*16(SHA256CONSTANTS), MSG
+                paddd           -5*16(SHA256CONSTANTS), MSG
                 sha256rnds2     STATE0, STATE1
         movdqa          MSGTMP3, MSGTMP4
         palignr         $4, MSGTMP2, MSGTMP4
         paddd           MSGTMP4, MSGTMP0
         sha256msg2      MSGTMP3, MSGTMP0
-                pshufd          $0x0E, MSG, MSG
+                punpckhqdq      MSG, MSG
                 sha256rnds2     STATE1, STATE0
         sha256msg1      MSGTMP3, MSGTMP2
 
         /* Rounds 16-19 */
         movdqa          MSGTMP0, MSG
-                paddd           4*16(SHA256CONSTANTS), MSG
+                paddd           -4*16(SHA256CONSTANTS), MSG
                 sha256rnds2     STATE0, STATE1
         movdqa          MSGTMP0, MSGTMP4
         palignr         $4, MSGTMP3, MSGTMP4
         paddd           MSGTMP4, MSGTMP1
         sha256msg2      MSGTMP0, MSGTMP1
-                pshufd          $0x0E, MSG, MSG
+                punpckhqdq      MSG, MSG
                 sha256rnds2     STATE1, STATE0
         sha256msg1      MSGTMP0, MSGTMP3
 
         /* Rounds 20-23 */
         movdqa          MSGTMP1, MSG
-                paddd           5*16(SHA256CONSTANTS), MSG
+                paddd           -3*16(SHA256CONSTANTS), MSG
                 sha256rnds2     STATE0, STATE1
         movdqa          MSGTMP1, MSGTMP4
         palignr         $4, MSGTMP0, MSGTMP4
         paddd           MSGTMP4, MSGTMP2
         sha256msg2      MSGTMP1, MSGTMP2
-                pshufd          $0x0E, MSG, MSG
+                punpckhqdq      MSG, MSG
                 sha256rnds2     STATE1, STATE0
         sha256msg1      MSGTMP1, MSGTMP0
 
         /* Rounds 24-27 */
         movdqa          MSGTMP2, MSG
-                paddd           6*16(SHA256CONSTANTS), MSG
+                paddd           -2*16(SHA256CONSTANTS), MSG
                 sha256rnds2     STATE0, STATE1
         movdqa          MSGTMP2, MSGTMP4
         palignr         $4, MSGTMP1, MSGTMP4
         paddd           MSGTMP4, MSGTMP3
         sha256msg2      MSGTMP2, MSGTMP3
-                pshufd          $0x0E, MSG, MSG
+                punpckhqdq      MSG, MSG
                 sha256rnds2     STATE1, STATE0
         sha256msg1      MSGTMP2, MSGTMP1
 
         /* Rounds 28-31 */
         movdqa          MSGTMP3, MSG
-                paddd           7*16(SHA256CONSTANTS), MSG
+                paddd           -1*16(SHA256CONSTANTS), MSG
                 sha256rnds2     STATE0, STATE1
         movdqa          MSGTMP3, MSGTMP4
         palignr         $4, MSGTMP2, MSGTMP4
         paddd           MSGTMP4, MSGTMP0
         sha256msg2      MSGTMP3, MSGTMP0
-                pshufd          $0x0E, MSG, MSG
+                punpckhqdq      MSG, MSG
                 sha256rnds2     STATE1, STATE0
         sha256msg1      MSGTMP3, MSGTMP2
 
         /* Rounds 32-35 */
         movdqa          MSGTMP0, MSG
-                paddd           8*16(SHA256CONSTANTS), MSG
+                paddd           0*16(SHA256CONSTANTS), MSG
                 sha256rnds2     STATE0, STATE1
         movdqa          MSGTMP0, MSGTMP4
         palignr         $4, MSGTMP3, MSGTMP4
         paddd           MSGTMP4, MSGTMP1
         sha256msg2      MSGTMP0, MSGTMP1
-                pshufd          $0x0E, MSG, MSG
+                punpckhqdq      MSG, MSG
                 sha256rnds2     STATE1, STATE0
         sha256msg1      MSGTMP0, MSGTMP3
 
         /* Rounds 36-39 */
         movdqa          MSGTMP1, MSG
-                paddd           9*16(SHA256CONSTANTS), MSG
+                paddd           1*16(SHA256CONSTANTS), MSG
                 sha256rnds2     STATE0, STATE1
         movdqa          MSGTMP1, MSGTMP4
         palignr         $4, MSGTMP0, MSGTMP4
         paddd           MSGTMP4, MSGTMP2
         sha256msg2      MSGTMP1, MSGTMP2
-                pshufd          $0x0E, MSG, MSG
+                punpckhqdq      MSG, MSG
                 sha256rnds2     STATE1, STATE0
         sha256msg1      MSGTMP1, MSGTMP0
 
         /* Rounds 40-43 */
         movdqa          MSGTMP2, MSG
-                paddd           10*16(SHA256CONSTANTS), MSG
+                paddd           2*16(SHA256CONSTANTS), MSG
                 sha256rnds2     STATE0, STATE1
         movdqa          MSGTMP2, MSGTMP4
         palignr         $4, MSGTMP1, MSGTMP4
         paddd           MSGTMP4, MSGTMP3
         sha256msg2      MSGTMP2, MSGTMP3
-                pshufd          $0x0E, MSG, MSG
+                punpckhqdq      MSG, MSG
                 sha256rnds2     STATE1, STATE0
         sha256msg1      MSGTMP2, MSGTMP1
 
         /* Rounds 44-47 */
         movdqa          MSGTMP3, MSG
-                paddd           11*16(SHA256CONSTANTS), MSG
+                paddd           3*16(SHA256CONSTANTS), MSG
                 sha256rnds2     STATE0, STATE1
         movdqa          MSGTMP3, MSGTMP4
         palignr         $4, MSGTMP2, MSGTMP4
         paddd           MSGTMP4, MSGTMP0
         sha256msg2      MSGTMP3, MSGTMP0
-                pshufd          $0x0E, MSG, MSG
+                punpckhqdq      MSG, MSG
                 sha256rnds2     STATE1, STATE0
         sha256msg1      MSGTMP3, MSGTMP2
 
         /* Rounds 48-51 */
         movdqa          MSGTMP0, MSG
-                paddd           12*16(SHA256CONSTANTS), MSG
+                paddd           4*16(SHA256CONSTANTS), MSG
                 sha256rnds2     STATE0, STATE1
         movdqa          MSGTMP0, MSGTMP4
         palignr         $4, MSGTMP3, MSGTMP4
         paddd           MSGTMP4, MSGTMP1
         sha256msg2      MSGTMP0, MSGTMP1
-                pshufd          $0x0E, MSG, MSG
+                punpckhqdq      MSG, MSG
                 sha256rnds2     STATE1, STATE0
         sha256msg1      MSGTMP0, MSGTMP3
 
         /* Rounds 52-55 */
         movdqa          MSGTMP1, MSG
-                paddd           13*16(SHA256CONSTANTS), MSG
+                paddd           5*16(SHA256CONSTANTS), MSG
                 sha256rnds2     STATE0, STATE1
         movdqa          MSGTMP1, MSGTMP4
         palignr         $4, MSGTMP0, MSGTMP4
         paddd           MSGTMP4, MSGTMP2
         sha256msg2      MSGTMP1, MSGTMP2
-                pshufd          $0x0E, MSG, MSG
+                punpckhqdq      MSG, MSG
                 sha256rnds2     STATE1, STATE0
 
         /* Rounds 56-59 */
         movdqa          MSGTMP2, MSG
-                paddd           14*16(SHA256CONSTANTS), MSG
+                paddd           6*16(SHA256CONSTANTS), MSG
                 sha256rnds2     STATE0, STATE1
         movdqa          MSGTMP2, MSGTMP4
         palignr         $4, MSGTMP1, MSGTMP4
         paddd           MSGTMP4, MSGTMP3
         sha256msg2      MSGTMP2, MSGTMP3
-                pshufd          $0x0E, MSG, MSG
+                punpckhqdq      MSG, MSG
                 sha256rnds2     STATE1, STATE0
 
         /* Rounds 60-63 */
         movdqa          MSGTMP3, MSG
-                paddd           15*16(SHA256CONSTANTS), MSG
+                paddd           7*16(SHA256CONSTANTS), MSG
                 sha256rnds2     STATE0, STATE1
-                pshufd          $0x0E, MSG, MSG
+                punpckhqdq      MSG, MSG
                 sha256rnds2     STATE1, STATE0
 
         /* Add current hash values with previously saved */
@@ -315,11 +315,11 @@
         jne             .Lloop0
 
         /* Write hash values back in the correct order */
-        pshufd          $0x1B, STATE0,  STATE0          /* FEBA */
-        pshufd          $0xB1, STATE1,  STATE1          /* DCHG */
         movdqa          STATE0, MSGTMP4
-        pblendw         $0xF0, STATE1,  STATE0          /* DCBA */
-        palignr         $8, MSGTMP4, STATE1             /* HGFE */
+        punpcklqdq      STATE1, STATE0                  /* GHEF */
+        punpckhqdq      MSGTMP4, STATE1                 /* ABCD */
+        pshufd          $0xB1, STATE0,  STATE0          /* HGFE */
+        pshufd          $0x1B, STATE1,  STATE1          /* DCBA */
 
         movdqu          STATE0, 0*16(DIGEST_PTR)
         movdqu          STATE1, 1*16(DIGEST_PTR)


