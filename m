Return-Path: <linux-kernel+bounces-104774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B9C87D370
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35BA01F21984
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DFA4E1D1;
	Fri, 15 Mar 2024 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nicKShIm"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8136B4CB3D;
	Fri, 15 Mar 2024 18:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710526464; cv=none; b=WwI+8y9UniOVB1GCSH5bACex6T/00KxF8N0SUPe1jmfDXNj8wXuHYYk7FchtCRHvIoXpg0TC4A640lS+L7lWn0/oBke7NvCoW24HxLNkRvRxjZ15D+xK0gdl7ufMMrkpFsYmd0wcmQPY0hs8vNPjQ0+b0/DZfdY/d6cD/PtoCp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710526464; c=relaxed/simple;
	bh=oaDXv1OJE51+9/GVUC/OBvla4qNIWodt+ovWJPKnDyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c8T43Fi+78I4Jo3WT8/VYenzxLdBefUB1BtJ3z/ziXOu75piHQu3tacIhPkigyJ8YAgNOlX9mhgSvqEXlvETYrA0K/3MxizHFDZ7D0npUaaeEKNe45mcnBNLzySqHChOZ82/jqmJP1Jk1VlllV2aM9Uvf8oPDVYReqX/339rk4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=nicKShIm; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512bde3d197so2389190e87.0;
        Fri, 15 Mar 2024 11:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710526458; x=1711131258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GWhQJIrlAe3Zt6yVWAsx1dDzPBZeGyd2jOUBiZHxlQs=;
        b=nicKShImym04Tk5ubOrZ2vGfPRMS7qGX+Ruuos3YthVZgGawo1zeAGhx9mrDdAQgiE
         0QZF7u2fOiJTdknfGYebcjqvhiUkWtU9qzZFX/SPmSyG9Tz3t6c1K4siSPjZaDbZUckw
         IK7eM0I++rcU3NGhD6mtzDUrsMZLpIJUEKm6+mbxfVQu29nrxG9xgji7KYsylgMukoJF
         esEVvVnf+TfJ3W2Z087ekY5mheiTcrRGnStwrM+tOeSInrvDJ1YwgOL4apIyhKEQpRW4
         3ZVwIJavviZH5AS+XPpLUHCZGn/xcaU6C7OXfWaxmMGNJ9+yv8kOXan1+KaZFCgR6u2G
         foBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710526458; x=1711131258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWhQJIrlAe3Zt6yVWAsx1dDzPBZeGyd2jOUBiZHxlQs=;
        b=v1fWAQplWnm8QlB74nCJJefW7wvtgF2Tc2Na+t6SAPHKQhSF4DxOZJD9DFLTRdHzrh
         KUZ/WtODVYMOH1R6VGctswBtm+CNQ6TYwswuSL4+NJaFmExol/OLfR/MyuwMwYJ/8yDk
         oSKmJPmSoquPS+4f58QF8TG6Q6+p/qqa7UWyXqR2paXoR6X8pFKPz2k7An+WFSpq4y58
         GRnSjkKaIkDsQJVHg04OVYu1PJin+PuYlnBT7x4qotBALQujRB9Uo1ldQ+j74v9g/QR+
         ezzhsw/JFmBXgo7i3tBQ9yk+sw1zvXqR53CbnzatjpvdJtQfuL86nVllL0oZbSmlZmat
         UKXg==
X-Forwarded-Encrypted: i=1; AJvYcCWtjoyE9VhJ8GXu/7WuM8SqTRiN9B3bvpRdi5PULyBwHMrZGo0wurwOCNji0eVdh4fIi8PNE+frvmcj1yEYzaUaFGIANeXm5jy0BULC
X-Gm-Message-State: AOJu0YxY2h5SUEco5lywkY657KO8EVhhnnWW0KrvhljMjGg+rafMc6ai
	OvgZZGW5kV5vY9SAR9WJqONqCBCavN8cIRPNh44C13UXQdPy/DgcT0+98h+bLYjbIA==
X-Google-Smtp-Source: AGHT+IHyYt6hSv3pFERpzItO8fZsQiuY5C6FoawT6+NaqEMW96OtRoSCcROYt+Xr/NzFYSYg16HdfQ==
X-Received: by 2002:a19:8c01:0:b0:513:25c6:e98e with SMTP id o1-20020a198c01000000b0051325c6e98emr3720302lfd.1.1710526457609;
        Fri, 15 Mar 2024 11:14:17 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-095-119-217-226.95.119.pool.telefonica.de. [95.119.217.226])
        by smtp.gmail.com with ESMTPSA id u20-20020a1709060b1400b00a449076d0dbsm1915682ejg.53.2024.03.15.11.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 11:14:17 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] selinux: improve symtab string hashing
Date: Fri, 15 Mar 2024 19:14:04 +0100
Message-ID: <20240315181414.649045-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The number of buckets is calculated by performing a binary AND against
the mask of the hash table, which is one less than its size (which is a
power of two).  This leads to all top bits being discarded, requiring
for short or similar inputs a hash function with a good avalanche
effect.

Use djb2a:

    # current
    common prefixes:  7 entries and 5/8 buckets used, longest chain length 2, sum of chain length^2 11
    classes:  134 entries and 100/256 buckets used, longest chain length 5, sum of chain length^2 234
    roles:  15 entries and 6/16 buckets used, longest chain length 5, sum of chain length^2 57
    types:  4448 entries and 3016/8192 buckets used, longest chain length 41, sum of chain length^2 14922
    users:  7 entries and 3/8 buckets used, longest chain length 3, sum of chain length^2 17
    bools:  306 entries and 221/512 buckets used, longest chain length 4, sum of chain length^2 524
    levels:  1 entries and 1/1 buckets used, longest chain length 1, sum of chain length^2 1
    categories:  1024 entries and 400/1024 buckets used, longest chain length 4, sum of chain length^2 2740

    # patch
    common prefixes:  7 entries and 5/8 buckets used, longest chain length 2, sum of chain length^2 11
    classes:  134 entries and 101/256 buckets used, longest chain length 3, sum of chain length^2 210
    roles:  15 entries and 9/16 buckets used, longest chain length 3, sum of chain length^2 31
    types:  4448 entries and 3459/8192 buckets used, longest chain length 5, sum of chain length^2 6778
    users:  7 entries and 5/8 buckets used, longest chain length 3, sum of chain length^2 13
    bools:  306 entries and 236/512 buckets used, longest chain length 5, sum of chain length^2 470
    levels:  1 entries and 1/1 buckets used, longest chain length 1, sum of chain length^2 1
    categories:  1024 entries and 518/1024 buckets used, longest chain length 7, sum of chain length^2 2992

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
   add licensing note
---
 security/selinux/ss/symtab.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/security/selinux/ss/symtab.c b/security/selinux/ss/symtab.c
index c04f8d447873..832660fd84a9 100644
--- a/security/selinux/ss/symtab.c
+++ b/security/selinux/ss/symtab.c
@@ -12,17 +12,17 @@
 
 static unsigned int symhash(const void *key)
 {
-	const char *p, *keyp;
-	unsigned int size;
-	unsigned int val;
-
-	val = 0;
-	keyp = key;
-	size = strlen(keyp);
-	for (p = keyp; (p - keyp) < size; p++)
-		val = (val << 4 | (val >> (8 * sizeof(unsigned int) - 4))) ^
-		      (*p);
-	return val;
+	/*
+	 * djb2a
+	 * Public domain from cdb v0.75
+	 */
+	unsigned int hash = 5381;
+	unsigned char c;
+
+	while ((c = *(const unsigned char *)key++))
+		hash = ((hash << 5) + hash) ^ c;
+
+	return hash;
 }
 
 static int symcmp(const void *key1, const void *key2)
-- 
2.43.0


