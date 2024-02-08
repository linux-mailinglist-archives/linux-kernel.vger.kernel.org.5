Return-Path: <linux-kernel+bounces-58287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A584C84E413
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59FA61F25D44
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD927B3E1;
	Thu,  8 Feb 2024 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhJ3c66F"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705ED7BAEF
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707406220; cv=none; b=krhOyjB6LvIkLNxXk+9Vf0zbMtMCVpBVC6J+44/HdM0ev9LTZkTmkO5iewsxPgaABUNkz5uWfZNIjnolpvgvfLcdQPZj0mLr3vQvpsgeksNwwi93xI+hS6uTRFaQS5nkgTsGL90or8BN761NTTjCVBzb7EjS1rFiq/FrquaKyC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707406220; c=relaxed/simple;
	bh=Uw6v9teNOlmTQaJ+SOpCCCmzIR/d9Hd70yb4ZBTWEvI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h+dOgbtBQS2CfgqVWx2TNglOts0Uv64BkWVBx40e327IL5btm+wzwxJREh218TUZUxlhmU7qc3g1pF7x0SrMwtEfUzyW/cHqBOE4dZnRRIclt7YQa7taBY3pMkLfWeA1DEGleCStN4eXNczB2Bp0q55IK6jwZHGUKQwD+EoCBJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhJ3c66F; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so1511581a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 07:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707406217; x=1708011017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8Cxoi4edloYR4jDiaES+gZQe/wedirE41v8EAHIn1yM=;
        b=NhJ3c66Fbce0DbQlQnvMu84dxUFARH1IcAvV81SGXB/Eya2qCZ68gYTrmbLveV5bLN
         8ygDmXmjAuyuIn8ibxSZSmZk3jrIfF7XTw7B0FMy8Rkf16DjfP83bxLlz1MhVs+fzoJg
         TyWwlFk2iALvJnLNAoi0MC/ynTRcCA0Y/UuZbrb0QegT2PhLkiE5jo5oCoUt29lfjrQM
         6rPADJkU4CkxOX/d/PQZ20ExoWG2O22i9xT2MQ2N31BaM+40bNd5tSAOZYOkGkv7fwSL
         QI8hPfAEch0CaXcy2I157xghTZgijIyMKGJCYbI/QVKC4Sifxn2rCE0ARhJF1ItgYDWf
         J3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707406217; x=1708011017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Cxoi4edloYR4jDiaES+gZQe/wedirE41v8EAHIn1yM=;
        b=ZWPDtQUzA0IgVKAyaYlol6ezfh0BAg6PG1BnADAEYsj5Dcu2YmS3NJV/jl9gi7pZ1T
         uxVVA9Wgc6Yi60QicqL6EtpJHsytw7zki6IMBRzVlDpU0H34DUYHI63zFzYatGAP0cFN
         DbIA4+ZCu1+HD1xWJzHqDW6feLdkTAPlvuU/As8M6hIEAwC+KFhZwOWsLYIERtwLfRno
         vlXMxNv9DPTdJsNQJai2gDBqxQQpC7WeGDc7m0/y+oVE9ITngxy6LFc9l7vHHYV/GsL/
         Kfa7CzG03yUkBBwzigZ8zN6RirkiOwikeE84j81SRZMvH4wbEvVKB4SC7wLwW1d+15v1
         r27A==
X-Gm-Message-State: AOJu0YwVYSSe7G4/BGc9B6qmA3hF83lw4CLHo0WqJhr7sb50XIxXBEV0
	N2LVNJu4+mOEghip4fCGguk2AKPIFHo6QazINNcBgNYotEkkT5O5
X-Google-Smtp-Source: AGHT+IGaELdrYTZPl1a/cK9//UND6nJfN3tEU4QdT7Cq1YxQZu04wacD2Vh0mZqNTxgtOeWlFGwnbA==
X-Received: by 2002:a05:6a20:2d0d:b0:19e:9959:35e with SMTP id g13-20020a056a202d0d00b0019e9959035emr10164133pzl.12.1707406217347;
        Thu, 08 Feb 2024 07:30:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVHIVOpNcnFHKdJTRqcf29jKTKfnB3foOrFzpFXo2pmuij7fKpELEG8w3QP9KhHQiDwX+E2kj2Wq0XYJjVVzA+jy0XStK68SRVUaMvmkCSr+b2hrshuBH8=
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v3-20020a170902d08300b001d76f1e8a18sm3483109plv.181.2024.02.08.07.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 07:30:16 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	David Howells <dhowells@redhat.com>
Subject: [PATCH] lib/Kconfig.debug: TEST_IOV_ITER depends on MMU
Date: Thu,  8 Feb 2024 07:30:10 -0800
Message-Id: <20240208153010.1439753-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trying to run the iov_iter unit test on a nommu system such as the qemu
kc705-nommu emulation results in a crash.

    KTAP version 1
    # Subtest: iov_iter
    # module: kunit_iov_iter
    1..9
BUG: failure at mm/nommu.c:318/vmap()!
Kernel panic - not syncing: BUG!

The test calls vmap() directly, but vmap() is not supported on nommu
systems, causing the crash. TEST_IOV_ITER therefore needs to depend
on MMU.

Fixes: 2d71340ff1d4 ("iov_iter: Kunit tests for copying to/from an iterator")
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 lib/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 975a07f9f1cc..ef36b829ae1f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2235,6 +2235,7 @@ config TEST_DIV64
 config TEST_IOV_ITER
 	tristate "Test iov_iter operation" if !KUNIT_ALL_TESTS
 	depends on KUNIT
+	depends on MMU
 	default KUNIT_ALL_TESTS
 	help
 	  Enable this to turn on testing of the operation of the I/O iterator
-- 
2.39.2


