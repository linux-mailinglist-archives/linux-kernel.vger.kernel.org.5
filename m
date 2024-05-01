Return-Path: <linux-kernel+bounces-165678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A26918B8F61
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDAC7B234D1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501C31474BA;
	Wed,  1 May 2024 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AZN53Ooe"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D09C1474A7
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 18:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714586796; cv=none; b=LtSody2ycXAWa/b/nWikEzc1o14CJweeUFzqR2Qvjt5Kjz6sFqoDXiyCpK+/9U6Rtmp0Kezww8pU8tdxdjWNdpT6e/qx4E4JPPS3U2f8yrGgDuASQw6SDm+OJUnNFjU6oRyUWBoN6gCCRiKOPkQT2QalwPm0D7pgY0N1FR4kk3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714586796; c=relaxed/simple;
	bh=z08x5qjd5V1B4JjVHfgs6lzO4CUiyLKjxSvmFLnvq3c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tI1KAma1wTKn0JSlSXWMEu51Q2Dk1V5ik99uLggn2R0HbybwI8vtTTHFf2WycQaBnhaL14WR5yMAYiRUpmqwmViWGgN8Z1SgUHxmlB6FyEivaCwJxY0ChAfJyYRU5BL/2YCJIs1W90MRDW5zxRawrBVl1Cyn8ZlcNg2cIjLj7cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AZN53Ooe; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de615257412so4353286276.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 11:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714586794; x=1715191594; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WCQ4ai1VSnRrtyOto1ox1rCCN6vQbsE1tY52jHJBoxo=;
        b=AZN53OoewvD3EfOif1W9JD7rPsQAZxU3Z43BOefD9H72/D15/D3EZF38TK2vX2kOaQ
         ttY284FzOZYD/eg5e62I/y2ykzqgV28K0ODMzTATPve/qNVz8rz4MfjGOKNLwLWx+nSD
         1RSaTslInYgZ/INmJfTdpWTgNvgl4FwKbjCJU1MmzDXij9dfvBsMEY/JgY1qWwVUVwfO
         KghuLZ2J4QGiLWNwjGBO4tB6znW0UM4GehCqY/Buu9sVsCftITk8dqhwVzqXYZVy1W4k
         Q1kgGHDiY++Sm8/mrnfVbbWUhgGJQbNo6aa2qPh3jy4a8bRGc0rIZU6AHaw9pkOjowyb
         GZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714586794; x=1715191594;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WCQ4ai1VSnRrtyOto1ox1rCCN6vQbsE1tY52jHJBoxo=;
        b=WMiH2c3Xp5pvCPPWrOZrtTVDnZHzoabHBMhMeB27ag0I6620yWIMuE3d6ptMhCzNu0
         Bd/w2lZpurJTS7t9NZcWB2+w2rMXGAHtEnrj5Qw3HqNwJnpGqJTUC7I0etTyI4As/ORo
         k5mAK8AkwA+zZy5p/GsZnLIrfkUWm45/8WkJ8Ofe7GxzwUHrHladyrAuq+LGG5aSQlJR
         R8IzwsCuF4/FyEWOLZxJnngNSYE9AEuzXuyLzCuRZaaAMj62dM7+Dsc1qkPkO22PeUmK
         EyCViI4UmM9qzhyymqmguF4lECUoMfWxVqWjThoqKKhLXj11WXnJ0yVUJJdQwMtbDtlp
         Eljg==
X-Gm-Message-State: AOJu0YwNcpSHDhF8hJ+hGwkzeSPDr9wH1Nw7QhQZDZrtok/5NxpI8cMc
	55QaFVX2jVO2UvMwZCoIvbDmxEO+FoO3150SugGrkpiIPxzhXTK1NEmMZ8ZqsK9SjaZhImic55l
	hapV584TmksuzJxb3qtEtkiQNQJXENF3dCsYwGxaFSoZ0P87Tg/HAwBCRm8I1MM2dpvcBwtzrl+
	+DpkxyqkVg2EW4lECHDdUCUCJEwm9HfLrSkwHCPp+0
X-Google-Smtp-Source: AGHT+IHLJVHdkDpnZk/5+ui/KLYFczURc1pdUu54ubS7wHaSw0Y99fUuvk4v7GXL1YRdvuExXi+ubxEYAnA=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:c11:b0:de6:166f:3250 with SMTP id
 fs17-20020a0569020c1100b00de6166f3250mr1029481ybb.2.1714586794180; Wed, 01
 May 2024 11:06:34 -0700 (PDT)
Date: Wed,  1 May 2024 18:06:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240501180622.1676340-1-edliaw@google.com>
Subject: [PATCH v3] selftests/vDSO: Explicit unsigned char conversion for elf_hash
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	"H. Peter Anvin" <hpa@linux.intel.com>, Andy Lutomirski <luto@mit.edu>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Fixes clang compilation warnings by adding explicit unsigned conversion:

parse_vdso.c:206:22: warning: passing 'const char *' to parameter of
 type 'const unsigned char *' converts between pointers to integer types
 where one is of the unique plain 'char' type and the other is not
 [-Wpointer-sign]
        ver_hash = elf_hash(version);
                            ^~~~~~~
parse_vdso.c:59:52: note: passing argument to parameter 'name' here
static unsigned long elf_hash(const unsigned char *name)
                                                   ^
parse_vdso.c:207:46: warning: passing 'const char *' to parameter of
 type 'const unsigned char *' converts between pointers to integer types
 where one is of the unique plain 'char' type and the other is not
 [-Wpointer-sign]
        ELF(Word) chain = vdso_info.bucket[elf_hash(name) % vdso_info.nbucket];
                                                    ^~~~
parse_vdso.c:59:52: note: passing argument to parameter 'name' here
static unsigned long elf_hash(const unsigned char *name)

Fixes: 98eedc3a9dbf ("Document the vDSO and add a reference parser")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
v2: update commit message with correct compiler warning
v3: fix checkpatch errors and indentation
---
 tools/testing/selftests/vDSO/parse_vdso.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 413f75620a35..9e29ff0657ea 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -203,8 +203,9 @@ void *vdso_sym(const char *version, const char *name)
 	if (!vdso_info.valid)
 		return 0;

-	ver_hash = elf_hash(version);
-	ELF(Word) chain = vdso_info.bucket[elf_hash(name) % vdso_info.nbucket];
+	ver_hash = elf_hash((const unsigned char *)version);
+	ELF(Word) chain = vdso_info.bucket[
+		elf_hash((const unsigned char *)name) % vdso_info.nbucket];

 	for (; chain != STN_UNDEF; chain = vdso_info.chain[chain]) {
 		ELF(Sym) *sym = &vdso_info.symtab[chain];
--
2.45.0.rc0.197.gbae5840b3b-goog


