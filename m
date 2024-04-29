Return-Path: <linux-kernel+bounces-163058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F138B6458
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378072813F2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDDA17967F;
	Mon, 29 Apr 2024 21:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gO87ImgM"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EED8179663
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 21:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714424847; cv=none; b=bRxD6HN14cgGDqGNZJ9Shef1+nfqv7wSzJj+qdNJJTkbUuy663OqRe5NYmCsKnNPuC6x21WKg+x+c5bn/Nd9EnbThXpsb5Dv+aK+Q9KiT1B9GKlSJargYrbU8IBotzGW4ZkChdwXCckVZUZfgGCGmKJUM9L2s7jQDvWo3scAXbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714424847; c=relaxed/simple;
	bh=bNW6HU81cGIeHe9Ew2GlDP3sf80i3dmA2+w1AJ4g7lk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IssT7iClE+SutIS8wpe2TCwUDcd5lxkcoEtHmrJUbXix/lDyWh2DtUeaxgnH/k7aA1BrkiX0uAaH72iba9kCZbOgsXngJzqUnBYG4cpMY7SMMD2nsHX5myhHJ34TivUrZMFc9BjKYWoodLNbnSfwpRYz1T2pxOoBLx/XwkbL56A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gO87ImgM; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-613dbdf5c27so1277119a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714424845; x=1715029645; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZPemufr3xn60MlET/JappNLxVr0lGO242Dr5arYhPmM=;
        b=gO87ImgMHEUXjJlcbbaVLWck9RgOr3l/doEKOOrbJjjAZPEXzYiFr7U9w6DVM7HESs
         SgqRZRCoibrF5XbQxxKY7EknypGdJoFazl97dlOv/7rWJIm7J0P8JrHqk4La6MW0DtgH
         2IZnrcojFx1qyED4/dOO3MPhR8V9MtbPG0FLKDyvPikIv/FIKa/r+sm0uVs7wQ2xGcGw
         zcQvDNERusYF34wSE6r1/LzXHOB1aHtlGnJCBIWP9/IcvZADJfByj+m6P2EmOmb4qy48
         +CniB48164GemrWTdQiBmB9jKj/6S2MlwE5Dljcx9+6S5QJlglXkE7ulK9ipehaFM2jD
         r6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714424845; x=1715029645;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZPemufr3xn60MlET/JappNLxVr0lGO242Dr5arYhPmM=;
        b=OzkZSahG6zh9of0BbZOx8evrN8CpSjo+oqYKnBUPTl2+uGIfx8uSTqOggPDAXCSkdO
         tTSI5ltDzgcubzPwwRD+itHPJByglYlUarygZqv17xhkkVXanW/n4kD11Vc6jmscEGsn
         ZJcecohbGYbvzkNExQ+rWnNVNWAUBSHJXcMCIEDLJ3nTSV10Qi9u3v0j2A00cvAp98f0
         N25K37057wESsXsTey7g/arhBE5pZ3p1484hLh/mUAUqWWIoux1qa+npsZvWoLMn5uLk
         AKvImYaQf8q9fQ9w54tefglQclNJlth74jWH7+CrSwTsB6PNZpNHcYJ9RB1nbUSqPk14
         +/JA==
X-Gm-Message-State: AOJu0Yxg4Hp/37pcIp7Tj7USH8czvB48yHydTRfXmbgKnpQB2NDrkunU
	H/HD980Lgvr3JZmA1XSs2jxJYbk9GlHkw7ofTKI2DU+GGCZgcgzEB28UvZ+8FQDbDIaZQgh7TQ8
	AxcFZdfwuZi5l4LaJQH7OZBEEC1MaYOZ9yZG14PfCqv+j6H9/KSqBscTcqbRkJaDfBkm55zyYtQ
	fNhJdZip9xy+GJBuSzvEj04OyKb32gXNwG9OSI1wty
X-Google-Smtp-Source: AGHT+IFBGD7QB6vVNyyUyCjXOcacflWPyo+Z5Ud65lcVUKG1pidH8vesc6pbfjFPwGiC0U3xDqjPEOYjXtU=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:e88b:b0:1e3:e092:53b9 with SMTP id
 w11-20020a170902e88b00b001e3e09253b9mr33232plg.4.1714424844307; Mon, 29 Apr
 2024 14:07:24 -0700 (PDT)
Date: Mon, 29 Apr 2024 21:07:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429210722.154156-1-edliaw@google.com>
Subject: [PATCH v2] selftests/vDSO: Explicit unsigned char conversion for elf_hash
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andy Lutomirski <luto@mit.edu>, "H. Peter Anvin" <hpa@linux.intel.com>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Fixes clang compilation warnings by adding explicit unsigned conversion:

parse_vdso.c:206:22: warning: passing 'const char *' to parameter of type 'const unsigned char *' converts between pointers to integer types where one is of the unique plain 'char' type and the other is not [-Wpointer-sign]
        ver_hash = elf_hash(version);
                            ^~~~~~~
parse_vdso.c:59:52: note: passing argument to parameter 'name' here
static unsigned long elf_hash(const unsigned char *name)
                                                   ^
parse_vdso.c:207:46: warning: passing 'const char *' to parameter of type 'const unsigned char *' converts between pointers to integer types where one is of the unique plain 'char' type and the other is not [-Wpointer-sign]
        ELF(Word) chain = vdso_info.bucket[elf_hash(name) % vdso_info.nbucket];
                                                    ^~~~
parse_vdso.c:59:52: note: passing argument to parameter 'name' here
static unsigned long elf_hash(const unsigned char *name)

Fixes: 98eedc3a9dbf ("Document the vDSO and add a reference parser")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
v2: update commit message with correct compiler warning
---
 tools/testing/selftests/vDSO/parse_vdso.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 413f75620a35..7e2ea9bea394 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -203,8 +203,8 @@ void *vdso_sym(const char *version, const char *name)
 	if (!vdso_info.valid)
 		return 0;

-	ver_hash = elf_hash(version);
-	ELF(Word) chain = vdso_info.bucket[elf_hash(name) % vdso_info.nbucket];
+	ver_hash = elf_hash((const unsigned char *)version);
+	ELF(Word) chain = vdso_info.bucket[elf_hash((const unsigned char *)name) % vdso_info.nbucket];

 	for (; chain != STN_UNDEF; chain = vdso_info.chain[chain]) {
 		ELF(Sym) *sym = &vdso_info.symtab[chain];
--
2.44.0.769.g3c40516874-goog


