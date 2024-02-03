Return-Path: <linux-kernel+bounces-51280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA058488A2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF8C01C214B3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF665FF14;
	Sat,  3 Feb 2024 19:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1UioNQA"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D163C5FDA6
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 19:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706990138; cv=none; b=UEhbelD//+Nt2j2pqLqGyELgCDLLUNEdIn1y9MfNZymTHeM0XXMvjyXxIuG8FoL5cnFs/+OIwb1S1DKjKgYNLPLqDW+9CHVJbTT9ybFw+7kQoAP6sCkAdrl/Dth4PVQbb6Rnd1SrZjjdgdTyFanmEMxo30fW6CUE6VznzJLtngY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706990138; c=relaxed/simple;
	bh=BZODnAq1TwTn0N90SerhPkdJ4wPCLDfg/01yx0cjSPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ae4DG+xcoUEhZsMrYTM9de8UO+ImxW4tup40LH4CX3qu9IUR+GErmNlT+HpYDv9oT4MO/XjDHDEzl79bxXadiymQhW20H+D2ZF+7rDqtPL9XHPc6A34423U4Q9MuCUCPQ4aWDn3zN6L2DPz6jY0dUVCQqXxe3QLZ3ZqD6e1N5VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1UioNQA; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7bb5fda069bso160578839f.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 11:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706990135; x=1707594935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiCEhAfqbNcVe9ohvNLlmHt9DRLCS4zDGnbcr3QSIe8=;
        b=E1UioNQABI2hGb+fjnMIg4qMLoyvLo0Fp3z8nJiEnXJFwVx/Yj4tX45e1K2KB6GTNW
         azQ/hTG3A5X00F9Qb9bAD61yApc3QAis2QfEdR7Vffs530oHeXjiiv6UFIQZwg+5OF6R
         YRsY7C8fx/jToD5WU5uSNoB0036uKMbqDgxBX2fL5ZCqWDv/bU79LRIFtmcrFumpv130
         SVzGaxTrtWHsqA5uiPNnFEhjd2bhidhH8KoMBYiOJyZ2x/ABTW0yEzzp29BZDLp5vRey
         OGjsrVrcIAS4b7huHce6eCCBQoR76b2TX69SQ8rZeVK6XgqPNWtDS26Et7K6yFL7aOaM
         RNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706990135; x=1707594935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiCEhAfqbNcVe9ohvNLlmHt9DRLCS4zDGnbcr3QSIe8=;
        b=StNHAhqK7Bh9BsZDuc69MIulRP+TXQ6y6gcBnzfcTjJe+I9btoMNZkoOnlpXEWF4qB
         wMNSoNxB8KbUSv+n2V5RIV8g6t32oTUNDKMnhjCrlM7N8OQHasgAvBrN4EVljfgwbyoh
         L2Q74aF7reNSLAEls3tMg8i0T56oiF3t/xDqYyPnzE32MwAdyznJrm/2SsPTMuPNLgzW
         g2Bl57VYhyPtn6PpzFu6cWd0pWjtVkKkefb9SCziN7sIiOaAC6tDziruSdiK1P4p9jEF
         vlZi2l3CbvvhfgCHCtSA0OJVA2/lwLJOdmHxb6Gcf0yLyxNWt4Bv38M4GieBAHt9W1m2
         iyDg==
X-Gm-Message-State: AOJu0YzLGd5ie16TRb0Kvn0zhsTGDYyIbcyTwtAierjWQthCWUhZwx8m
	GC8VI7RVFuAyDXsihryMT7PuYwJHm8Nbjp/I2W1gUCE14ntN0JodPSf/aU/r
X-Google-Smtp-Source: AGHT+IGVDPV4RJwRspbhuqICe9fKpam+6wS8jTW70x00iCcFIsYWRs9jPEc1E6F9+csvtz0+oSF1LQ==
X-Received: by 2002:a05:6e02:1aad:b0:363:bdf6:ea29 with SMTP id l13-20020a056e021aad00b00363bdf6ea29mr2416838ilv.21.1706990135552;
        Sat, 03 Feb 2024 11:55:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUstl2CX73FGyx9bFc6Jj2tm+PNsJgKuWcQBn/vXxQTzydaZUgc/lCAWAFkWT5Xjf3iCyJLlvfv+oisCVNT+IM12bAzcIejSeyZCBn6hD7BiwRbz3PqfTZabwtxWSwl
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id bd1-20020a056e02300100b003639075ae9asm1417232ilb.63.2024.02.03.11.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 11:55:34 -0800 (PST)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	akpm@linuxfoundation.org
Cc: joe@perches.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 2/2] checkpatch: minor whitespace changes for readability
Date: Sat,  3 Feb 2024 12:55:27 -0700
Message-ID: <20240203195527.212505-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203195527.212505-1-jim.cromie@gmail.com>
References: <20240203195527.212505-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the per-patch report format slightly, so its more paragraphic,
and easier to peruse/scan.

OLD FORM:

0001-checkpatch-report last line, looks part of 0002 has no ...
--------------------------------------------------------------
0002-checkpatch-minor-whitespace-changes-for-readability.patch
--------------------------------------------------------------
total: 0 errors, 0 warnings, 15 lines checked

0002-checkpatch-minor-whitespace-changes-for-readability.patch has no ...
--------------------------------------------------------------

NEW FORM:

--------------------------------------------------------------
0002-checkpatch-minor-whitespace-changes-for-readability.patch
--------------------------------------------------------------
total: 0 errors, 0 warnings, 15 lines checked
0002-checkpatch-minor-whitespace-changes-for-readability.patch
 has no obvious style problems and is ready for submission.

--------------------------------------------------------------

For the optimum (warning free) patchset, the new report format is a
series of single paragraphs (with the --- banners), one for each patch
in the series.  This is trivial to scan/peruse, and is also more
visually distinct from warning/error reports.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 scripts/checkpatch.pl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index dc17c6da3af2..cd249ae9abdd 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7796,12 +7796,12 @@ EOM
 	}
 
 	if ($quiet == 0) {
-		print "\n";
 		if ($clean == 1) {
-			print "$vname has no obvious style problems and is ready for submission.\n";
+			print "$vname \n has no obvious style problems and is ready for submission.\n";
 		} else {
-			print "$vname has style problems, please review.\n";
+			print "$vname \n has style problems, please review.\n";
 		}
+		print "\n";
 	}
 	return $clean;
 }
-- 
2.43.0


