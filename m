Return-Path: <linux-kernel+bounces-25355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2D782CE2D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 19:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69455B22732
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 18:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09B263B3;
	Sat, 13 Jan 2024 18:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="s6GswYBU"
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A23963A6;
	Sat, 13 Jan 2024 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Content-Type:From:Reply-To:Subject:Content-ID:
	Content-Description:In-Reply-To:References:X-Debbugs-Cc;
	bh=RuJgwh+4GbW/+hxO9wfk+hS1gNlricVg+fWINBANyag=; b=s6GswYBUChRyFi0RUQt7eFa348
	THJNVCSfF9dsOWDNXQ2FyYVugMB2FDC7WvDNfGy6Ub8SxZ1fbGUolaOirL8G0fDVKIyUmFY3VsvfV
	iSHyPD0pkTADxfCse4NF8BlBkXEN9Fqa9BpS3FFcKOJwHjdD6iMcl79QZl05Y91WfIX+QU+MrIfn2
	bQ4uKuxrr63dBE8vqAydFK0b8Opj6Cx3T2RT/3o+xMuz1NPCLfyeR1JZIt6HmibnsU2OQzrbGj3c6
	N7BkRNkTDIbAleC4mkFNs201XSU3vS48Ov1Ec4/yQEUjAAaiqS2RHtZSW+OrU+sJykf/ZuNWfoA0u
	UIt+sGkw==;
Received: from ohm.aurel32.net ([2001:bc8:30d7:111::2] helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1rOip8-00HYMM-1w;
	Sat, 13 Jan 2024 19:33:38 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: linux-kernel@vger.kernel.org,
	Bluecherry Maintainers <maintainers@bluecherrydvr.com>,
	Anton Sviridenko <anton@corp.bluecherry.net>,
	Andrey Utkin <andrey_utkin@fastmail.com>,
	Ismael Luceno <ismael@iodev.co.uk>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org (open list:SOFTLOGIC 6x10 MPEG CODEC)
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
	Andrew Morton' <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig' <hch@infradead.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	Jiri Slaby <jirislaby@gmail.com>,
	stable@vger.kernel.org,
	David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH] media: solo6x10: replace max(a, min(b, c)) by clamp(b, a, c)
Date: Sat, 13 Jan 2024 19:33:31 +0100
Message-ID: <20240113183334.1690740-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch replaces max(a, min(b, c)) by clamp(b, a, c) in the solo6x10
driver. This improves the readability and more importantly, for the
solo6x10-p2m.c file, this reduces on my system (x86-64, gcc 13):
- the preprocessed size from 121 MiB to 4.5 MiB;
- the build CPU time from 46.8 s to 1.6 s;
- the build memory from 2786 MiB to 98MiB.

In fine, this allows this relatively simple C file to be built on a
32-bit system.

Reported-by: Jiri Slaby <jirislaby@gmail.com>
Closes: https://lore.kernel.org/lkml/18c6df0d-45ed-450c-9eda-95160a2bbb8e@gmail.com/
Cc: stable@vger.kernel.org # v6.7+
Suggested-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 drivers/media/pci/solo6x10/solo6x10-offsets.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/pci/solo6x10/solo6x10-offsets.h b/drivers/media/pci/solo6x10/solo6x10-offsets.h
index f414ee1316f2..fdbb817e6360 100644
--- a/drivers/media/pci/solo6x10/solo6x10-offsets.h
+++ b/drivers/media/pci/solo6x10/solo6x10-offsets.h
@@ -57,16 +57,16 @@
 #define SOLO_MP4E_EXT_ADDR(__solo) \
 	(SOLO_EREF_EXT_ADDR(__solo) + SOLO_EREF_EXT_AREA(__solo))
 #define SOLO_MP4E_EXT_SIZE(__solo) \
-	max((__solo->nr_chans * 0x00080000),				\
-	    min(((__solo->sdram_size - SOLO_MP4E_EXT_ADDR(__solo)) -	\
-		 __SOLO_JPEG_MIN_SIZE(__solo)), 0x00ff0000))
+	clamp(__solo->sdram_size - SOLO_MP4E_EXT_ADDR(__solo) -	\
+	      __SOLO_JPEG_MIN_SIZE(__solo),			\
+	      __solo->nr_chans * 0x00080000, 0x00ff0000)
 
 #define __SOLO_JPEG_MIN_SIZE(__solo)		(__solo->nr_chans * 0x00080000)
 #define SOLO_JPEG_EXT_ADDR(__solo) \
 		(SOLO_MP4E_EXT_ADDR(__solo) + SOLO_MP4E_EXT_SIZE(__solo))
 #define SOLO_JPEG_EXT_SIZE(__solo) \
-	max(__SOLO_JPEG_MIN_SIZE(__solo),				\
-	    min((__solo->sdram_size - SOLO_JPEG_EXT_ADDR(__solo)), 0x00ff0000))
+	clamp(__solo->sdram_size - SOLO_JPEG_EXT_ADDR(__solo),	\
+	      __SOLO_JPEG_MIN_SIZE(__solo), 0x00ff0000)
 
 #define SOLO_SDRAM_END(__solo) \
 	(SOLO_JPEG_EXT_ADDR(__solo) + SOLO_JPEG_EXT_SIZE(__solo))
-- 
2.42.0


