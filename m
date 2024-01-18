Return-Path: <linux-kernel+bounces-30502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2109C831F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7B9288B55
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8E72E40A;
	Thu, 18 Jan 2024 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uhigdn+i"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2412E627
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605618; cv=none; b=qqZvafHJCJjggbOVUuwJJ09QBhpLzvnb+dcR1J9oYCaUush9TWWVPQdUbfIS/FcuB9LcE8cBLYFPNCJSWS6HhfoPxdZwjytig2/pBfwg8EDPNQUxzck7ZDO3t2QMIhP9PyFLMYH/3Aha0Rq+17SZBk6hqjnLsjugPNhWBPANO4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605618; c=relaxed/simple;
	bh=9nf9clFh0EbDats4Fa2YQ+RNXkctZPuqdS5Gbc572e8=;
	h=Subject:Date:Message-ID:MIME-Version:Cc:From:To; b=rzHsDShP3PjcLP/gMi3plnZNTWJicQ9pOZGJz7w7Avh9WTHeOcl0I+n45YAbebnH/nbNStQ8ekJ/AyKJkXyzYIRlmeqFfPVrOAYit49kxNUhTw5BzHHCK/3a64klQ8SIAdRH9M9lvZ6tFpaSsd5E6MDhbQUol6gDSBRzcHFRN1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=uhigdn+i; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d70696b6faso8878695ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705605615; x=1706210415; darn=vger.kernel.org;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=CcmZDwBIevh96PY0m3UwCbyUVvMq97xdTBzYDcc3ymc=;
        b=uhigdn+iIPaABls756LkC7gBE9iU1oKBRJ1HVHXUj/qGQQ+0wajKMgxRJab2xGW8G4
         5AH/ASuxaBmKlIe7qozDTH8kSQzLWWpoMH4DdfKy7LvFYfxvEz+7clV6FNwQxuECKgx8
         pDP/9PZjiExXG6Ag8QZZcS/8b0Bu8liF7fm4oK1Tf+hnaGazhlJEg5wuAsEOdu8r2rDK
         O9U1WtMu65rMdKIzc57vXbUwrfQGG4FwMWMPN24MXADjdBnqmhNHssIUksG3xiTFhxWa
         rTqeeWvnARzt5sdKVIbaF3V3exmiLpRgurBTRKE7YeRxYLIFxODrs/DNgjRDLND4Cwhb
         ISng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705605615; x=1706210415;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CcmZDwBIevh96PY0m3UwCbyUVvMq97xdTBzYDcc3ymc=;
        b=OnihFpl/cqn/muoIeIotq8rYyDmVfIKaR+aRH2un3OztqKth3ZaZeQRKOtakKdU02j
         sZo3Ho5tCzHxWFDZto/BPNrjOXii8cxGLVIz9t1V/LWVuFJHj6Y2ylHZ79HLwUV3MAfb
         RmX1QdIDp7xP4mq1Cuzacw5ph7obn8DpTZNViEWEEygFpg0+Kb79L/odUp75NzhxBaMw
         MgQtX+sIfehoPOVIdng4RcFTMq9kGZfecUj6JnpTML3olejpd255CuFQfAY4ug+/LCcH
         uzNExTgdxZRboh65OeFNLgOjP/UMsXEpz+72gR5QD8S6292RU5PRi4QLdP4C1aGOWQEC
         Mciw==
X-Gm-Message-State: AOJu0YxdQPqn90kRw7gD6bwcBlBhp3bV3NsANm7kWQhiB06Bu95VoLMR
	ROP8D8zSjtifKA5sRmK0fplDsSlsOibm1fNkVx7tCeopkAf/lNe3I2bL/dAdKW8=
X-Google-Smtp-Source: AGHT+IFNJL1nqkL/h0IqxGVCUNhKrNSluuke+rosWvVVfdt8F4bqjY6XaJmILmyhvNBy5s5IaQsYwA==
X-Received: by 2002:a17:902:ea12:b0:1d5:a5ba:1c49 with SMTP id s18-20020a170902ea1200b001d5a5ba1c49mr1372634plg.1.1705605614994;
        Thu, 18 Jan 2024 11:20:14 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id kz3-20020a170902f9c300b001d70c695172sm1190896plb.78.2024.01.18.11.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 11:20:14 -0800 (PST)
Subject: [PATCH] Makefile: Add HOST_GCC_SUFFIX and CROSS_GCC_SUFFIX
Date: Thu, 18 Jan 2024 11:17:27 -0800
Message-ID: <20240118191727.5547-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: nathan@kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
  Palmer Dabbelt <palmer@rivosinc.com>
From: Palmer Dabbelt <palmer@rivosinc.com>
To: masahiroy@kernel.org, nicolas@fjasle.eu

From: Palmer Dabbelt <palmer@rivosinc.com>

I was just trying to track down a build bug with an old toolchain.
Turns out Ubuntu installs old GCCs as something like
riscv64-linux-gnu-gcc-10, which is a bit clunky to point the build at
without a way to append a suffix to CC.

There's already LLVM_SUFFIX, but nothing similar for GCC.  I've split
out the host and target suffixes as users probably don't have the same
version of for both (unlike LLVM, where the cross compiler is likely to
support the host target).

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
I've only given this some very minimal testing, but it at least works
for my simple use case.
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index f1b2fd977275..36ce336cda3b 100644
--- a/Makefile
+++ b/Makefile
@@ -433,8 +433,8 @@ endif
 HOSTCC	= $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
 HOSTCXX	= $(LLVM_PREFIX)clang++$(LLVM_SUFFIX)
 else
-HOSTCC	= gcc
-HOSTCXX	= g++
+HOSTCC	= gcc$(HOST_GCC_SUFFIX)
+HOSTCXX	= g++$(HOST_GCC_SUFFIX)
 endif
 HOSTRUSTC = rustc
 HOSTPKG_CONFIG	= pkg-config
@@ -480,7 +480,7 @@ OBJDUMP		= $(LLVM_PREFIX)llvm-objdump$(LLVM_SUFFIX)
 READELF		= $(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX)
 STRIP		= $(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX)
 else
-CC		= $(CROSS_COMPILE)gcc
+CC		= $(CROSS_COMPILE)gcc$(CROSS_GCC_SUFFIX)
 LD		= $(CROSS_COMPILE)ld
 AR		= $(CROSS_COMPILE)ar
 NM		= $(CROSS_COMPILE)nm
-- 
2.43.0


