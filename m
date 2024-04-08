Return-Path: <linux-kernel+bounces-135500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5360989C6C0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B9C1F235B1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4398C128392;
	Mon,  8 Apr 2024 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nexgo.de header.i=@nexgo.de header.b="OshMzrSd"
Received: from mr3.vodafonemail.de (mr3.vodafonemail.de [145.253.228.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB6912837C;
	Mon,  8 Apr 2024 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.253.228.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585897; cv=none; b=G/dG1MruRzwlgTmiva/0+i6ZJ7UM/iugfj7YT/Pjo9Fs9pzJtBdQuVcVS9Jl3W3tyPyxCAHM6x/clAe+3ZVWqI4kAydc66s0dKL2y5dXeWLFXDBGQkWad2dA53qjWJM2S3J4xd9AbowYj/HJcL+6ChzGaeW8QzacCXgVXQNjY8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585897; c=relaxed/simple;
	bh=irgPcGQf2zed/zi+Zrwi80XgAyLN2AyMzpIrIbtSQE4=;
	h=From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=AkJTqrWEfTWm8X7cp9gKftIqH6rIQXpSirMuPAxKI8FJZjSdeJviZ2f3pgNLh2/kRYAlqpXzGQkOlSsNlFonwNSdJfAtlwxUY9RAjuhsIrikmk4zV5Nu9gPplYLc0ge8j4xc9cdXc5SgsvyPE2dvl5WUjZBY0fh/RSoYtKhzwxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=nexgo.de; dkim=pass (1024-bit key) header.d=nexgo.de header.i=@nexgo.de header.b=OshMzrSd; arc=none smtp.client-ip=145.253.228.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexgo.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nexgo.de;
	s=vfde-mb-mr2-23sep; t=1712585894;
	bh=EqPE8k2XuYVTtDepIsOZ9NsJpR3M/yKeP15J7IxBfJU=;
	h=From:To:Subject:Date:Content-Type:From;
	b=OshMzrSdvWGepEERjICWAnDNdMgEGg9erQFxL0W7p9k4rHL2ooehPhSX3pSBS/Dr/
	 Tks9PdY9KdTGSa6pR9a+kTwknWY8WSlkgE4faDpwchnPSLI9gLW5i0fFXZaI7TjeoZ
	 wzWbGFN5TAOjZuVURdE/2JrzG4UmP6jRZQEWGQEI=
Received: from smtp.vodafone.de (unknown [10.0.0.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mr3.vodafonemail.de (Postfix) with ESMTPS id 4VCrm60SJxz2Fmq;
	Mon,  8 Apr 2024 14:18:14 +0000 (UTC)
Received: from sha1_ni_asm.patch (p5de6d4c4.dip0.t-ipconnect.de [93.230.212.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.vodafone.de (Postfix) with ESMTPSA id 4VCrln1qV6z9thx;
	Mon,  8 Apr 2024 14:17:54 +0000 (UTC)
From: "Stefan Kanthak" <stefan.kanthak@nexgo.de>
To: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Cc: <tim.c.chen@linux.intel.com>, "Eric Biggers" <ebiggers@kernel.org>
Subject: [PATCH v2 1/2] crypto: s(h)aving 16 byte constant off arch/x86/crypto/sha1_ni_asm.S
Date: Mon, 8 Apr 2024 16:08:52 +0200
Organization: Me, myself & IT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 734
X-purgate-ID: 155817::1712585889-6FFFDA4B-A983EAB5/0/0
Message-Id: <20240408141818.4398C128392@smtp.subspace.kernel.org>

Get rid of 16 byte constant, use shift instead of mask

--- -/arch/x86/crypto/sha1_ni_asm.S
+++ +/arch/x86/crypto/sha1_ni_asm.S
@@ -104,9 +104,9 @@
 	add		DATA_PTR, NUM_BLKS	/* pointer to end of data */
 
 	/* load initial hash values */
-	pinsrd		$3, 1*16(DIGEST_PTR), E0
+	pinsrd		$0, 1*16(DIGEST_PTR), E0
 	movdqu		0*16(DIGEST_PTR), ABCD
-	pand		UPPER_WORD_MASK(%rip), E0
+	pslldq		$12, E0
 	pshufd		$0x1B, ABCD, ABCD
 
 	movdqa		PSHUFFLE_BYTE_FLIP_MASK(%rip), SHUF_MASK
@@ -297,8 +297,3 @@
 .align 16
 PSHUFFLE_BYTE_FLIP_MASK:
 	.octa 0x000102030405060708090a0b0c0d0e0f
-
-.section	.rodata.cst16.UPPER_WORD_MASK, "aM", @progbits, 16
-.align 16
-UPPER_WORD_MASK:
-	.octa 0xFFFFFFFF000000000000000000000000

