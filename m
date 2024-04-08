Return-Path: <linux-kernel+bounces-135186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB68B89BC6A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181EF1C222B4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35964DA00;
	Mon,  8 Apr 2024 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nexgo.de header.i=@nexgo.de header.b="hSpOHSbS"
Received: from mr3.vodafonemail.de (mr3.vodafonemail.de [145.253.228.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2F72D05D;
	Mon,  8 Apr 2024 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.253.228.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712570153; cv=none; b=NCjLDDAckHAM+KGUOeMfcuVWzbAzlTraeh9z/FohhoRIRXUO4KPy+hvgXyi+4zcYWZKkwUtq6hCTfQM8pwzJ2zJtrwSZ9Sq8/EnZ0zX7fom7p9l4VglTK2QgkFzgtYhsyf8d3uO8H2+YstuLqdhtgTaCqKgaOmw90W9GNaPsS88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712570153; c=relaxed/simple;
	bh=b+ss1pbu8Nyctt8S2ZiLqKtptJtaOp9ebfIid4XFBI8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=GD1A9Ehig5k5HrN0YCFE25TSjtgj7xEjxaDaIdNBXnNi5scbcYmL7s6MiUxn7/rPt/8TVc/hobuwYm3HeB5VAK46jsP1JaZQovyUy+Ru6Ju1xQpAy7ikysBkrAjAmo8FdHf3M0cjhGqA7U35L1ioNrH9XXLY6jAl0JWQZ2V0BuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=nexgo.de; dkim=pass (1024-bit key) header.d=nexgo.de header.i=@nexgo.de header.b=hSpOHSbS; arc=none smtp.client-ip=145.253.228.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexgo.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nexgo.de;
	s=vfde-mb-mr2-23sep; t=1712569759;
	bh=EqPE8k2XuYVTtDepIsOZ9NsJpR3M/yKeP15J7IxBfJU=;
	h=Message-ID:From:To:Subject:Date:Content-Type:X-Mailer:From;
	b=hSpOHSbSrHHQHC4kxvORRyzWIIbKY+CtjK81dCdycNgfJpnylqrdIRZLiILdiov/N
	 Xgcknyjy/OuajgFcgTR9FHRDPXy0CswgO+IdxgAY80rteznJWmfuvi72JxNOlNWh31
	 x+Gwd52Vu1C/pyXXvQR722TTmQV5N1Z/H3JNqE2c=
Received: from smtp.vodafone.de (unknown [10.0.0.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mr3.vodafonemail.de (Postfix) with ESMTPS id 4VCknq2QkLz1ynm;
	Mon,  8 Apr 2024 09:49:19 +0000 (UTC)
Received: from H270 (p5de6d4c4.dip0.t-ipconnect.de [93.230.212.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.vodafone.de (Postfix) with ESMTPSA id 4VCknY4ZKXzMmXC;
	Mon,  8 Apr 2024 09:49:02 +0000 (UTC)
Message-ID: <7F88D9730FA04A02ACCE0B47584422C5@H270>
From: "Stefan Kanthak" <stefan.kanthak@nexgo.de>
To: <linux-kernel@vger.kernel.org>>,
	<linux-crypto@vger.kernel.org>
Cc: <tim.c.chen@linux.intel.com>,
	<sean.m.gulley@intel.com>
Subject: [PATCH 2/2] crypto: s(h)aving 16 byte constant off arch/x86/crypto/sha1_ni_asm.S
Date: Mon, 8 Apr 2024 11:38:56 +0200
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
X-purgate-size: 892
X-purgate-ID: 155817::1712569755-63FEDA4B-F9F1E402/0/0

Get rid of 16 byte constant, use shift instead of mask

--- -/arch/x86/crypto/sha1_ni_asm.S
+++ +/arch/x86/crypto/sha1_ni_asm.S
@@ -104,9 +104,9 @@
         add             DATA_PTR, NUM_BLKS      /* pointer to end of data */
 
         /* load initial hash values */
-        pinsrd          $3, 1*16(DIGEST_PTR), E0
+        pinsrd          $0, 1*16(DIGEST_PTR), E0
         movdqu          0*16(DIGEST_PTR), ABCD
-        pand            UPPER_WORD_MASK(%rip), E0
+        pslldq          $12, E0
         pshufd          $0x1B, ABCD, ABCD
 
         movdqa          PSHUFFLE_BYTE_FLIP_MASK(%rip), SHUF_MASK
@@ -297,8 +297,3 @@
 .align 16
 PSHUFFLE_BYTE_FLIP_MASK:
         .octa 0x000102030405060708090a0b0c0d0e0f
-
-.section        .rodata.cst16.UPPER_WORD_MASK, "aM", @progbits, 16
-.align 16
-UPPER_WORD_MASK:
-        .octa 0xFFFFFFFF000000000000000000000000

