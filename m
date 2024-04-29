Return-Path: <linux-kernel+bounces-163022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F7D8B63C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18509284EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13661779B1;
	Mon, 29 Apr 2024 20:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0uG6Xav4"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD471177990
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423425; cv=none; b=FTXJW+bUbYTrgWGPy39NzijsUtPP8pkqO898/uGfsUmUIiWKtjxICv4hI7pTLy4fx0JO7CsvbaUicJ+uky7qJVbImytsSlSjh871WpuW9UrXZAsW8HgUzwCP5P8rm7pyD5bu/CJa40uLNdUXGKf2kuWerj2OH2ue/CwtcVn3JFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423425; c=relaxed/simple;
	bh=Dqvvv5k/2rBndxGB8WRqT0FWAmJL3N2QMXq8c8tcCZ8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V2XQmuaEkWw+pl5E8VifJiIveo4GvhLu55aka0fq8+Gjcv1jytHYAyn95PkyhzQPweGHQVdgyBU1sWXrzlYkqzcDMD3UicILBECj39esLy+Cm6QUrT9TJrR+1dsy3WXPgI4evsEJn9aLTrbsD/x/vnHcgy+PoUIrr7+rja7GKp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0uG6Xav4; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be8f7ed6eso946847b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714423423; x=1715028223; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kP5D9/l/449dTy3r209IVThrMxV6+RNO48E3tZy87Nw=;
        b=0uG6Xav4C1nN6NI1YtOUFkaM91zcSo+UClspuHPvbxczGOJLHoeJ0z/Gl+ulDRBjk1
         4aq+t6X4VtnQpgliE2Wbudu7kXvT6MQ3GwfnwqkCiOjSjb5QhPMlbhOZujLCejv2dCb5
         cysvepC3FSsgsX4UWHGMKBeAg9CdH8UGFDMOYBvlnTiYkS3xvyMmVUUbuEv3IXH8Haeh
         OtaREcKgtSoH63QKGitYpMydNK0K79nZhNU8Gd4RhiJZPBYmfWdn7alI/SMQKo4For3p
         OBKG40PnsuIagQmRaWbMcyNczMxTR8uA0y58EHwxEsoC5zO3OFzX+ayYHwXSzlN5L9Md
         vYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714423423; x=1715028223;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kP5D9/l/449dTy3r209IVThrMxV6+RNO48E3tZy87Nw=;
        b=kcfB8+YOxgaoFyxfGLR0NLnjJbCdSbMSSOR23XRG2zMn384fXjOnc5i3tZjl9VojiH
         VZgxlMp8y8o14IK4OdCpZRi555G6qc1/n2DnsJc85Y/LnFyF3lAXig5DzT3s+ixMgEfY
         EkLVB+n/SbG61TDuBrcdmC1JosTHvi65euNLoaSTEKQnoKtXcnhR6OCyKUqaIUb06YcD
         M6JsDwYXmmh9rf1q3jc6uyzMhOPZ2pogUZMvtxI3mCd4rv7asoVDVu+s634+Vm7vOyUB
         eKJVIe8e7EhSn3KgEcCAPmCMnvMlU8H/XPUvEs97eESy70D/K0CIFdEpnKlJz4Ju4J22
         y01w==
X-Gm-Message-State: AOJu0YwDUM+4BrId/K41l3Cq3MLHRh8tmuk5RqErKxRlOlPlxkO40B/g
	qUXi0QU2q0DEwYW7pRFNU4maW5AWaV34QZfEa5DG+2WZc+ptClTJFP5rwbL4mIdVl19k7wtc5v/
	o+vdCsAZJKTSPMkG9fbt5p6ERTT/E2ivC5dCUQReRBmKsrqVgB7k7oPZeBcrRKmlX8QZ8J5Sbvl
	R8xMrxEkx1jPAnvJKCISdgunbFqnpka5sUULy17caW
X-Google-Smtp-Source: AGHT+IHcpzk6wYZrqzhB/+Lz7lRSuqPg6576nmgHC5Ed8jKuAp3HkexHCZB1xdt3BUA02fkvb59KkOzh1vc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:250f:b0:618:2ad1:a46f with SMTP id
 dt15-20020a05690c250f00b006182ad1a46fmr136239ywb.2.1714423422592; Mon, 29 Apr
 2024 13:43:42 -0700 (PDT)
Date: Mon, 29 Apr 2024 20:43:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429204333.146063-1-edliaw@google.com>
Subject: [PATCH] selftests/vDSO: Explicit unsigned char conversion for elf_hash
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	"H. Peter Anvin" <hpa@linux.intel.com>, Andy Lutomirski <luto@mit.edu>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Fixes clang compilation warnings by adding explicit unsigned conversion:

parse_vdso.c:206:22: warning: passing 'const char *' to parameter of type 'const unsigned char *' converts between pointers to integer types where one is of the unique plain 'char' type and the other is not [-Wpointer-sign]
        ver_hash = elf_hash((const char *)version);
                            ^~~~~~~~~~~~~~~~~~~~~
parse_vdso.c:59:52: note: passing argument to parameter 'name' here
static unsigned long elf_hash(const unsigned char *name)
                                                   ^
parse_vdso.c:207:46: warning: passing 'const char *' to parameter of type 'const unsigned char *' converts between pointers to integer types where one is of the unique plain 'char' type and the other is not [-Wpointer-sign]
        ELF(Word) chain = vdso_info.bucket[elf_hash((const char *)name) % vdso_info.nbucket];
                                                    ^~~~~~~~~~~~~~~~~~
parse_vdso.c:59:52: note: passing argument to parameter 'name' here
static unsigned long elf_hash(const unsigned char *name)

Fixes: 98eedc3a9dbf ("Document the vDSO and add a reference parser")
Signed-off-by: Edward Liaw <edliaw@google.com>
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


