Return-Path: <linux-kernel+bounces-157254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1348B0F3D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F69EB2708E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182D1161322;
	Wed, 24 Apr 2024 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XPguIrMb"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA5615E1EA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974018; cv=none; b=Lb/Un0FI8Xpn36Wv5k6Sz9MdltHFJ1zSk4D7BA8Rum7n0GVoXbquYL2sTmGjorrL42ayBtldqeo8O4TlkayTAVll1acxVVOU+xqV8vKawvU2uOJtKG/OBCQrDjCe7RoC20G+awdpyDe1USsoww/vjifH/vQG5fl8VbL7qeYo/3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974018; c=relaxed/simple;
	bh=uqgRUeoT8Dt0QTqrZ1vm+Oa6LVzoCfM28rp4ZncQSu8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q0uzomohs5HnWN4LYr4n2+s8frblaLliILac8+ftrO7uVXzDoP7Jkc73XS9FStc6Txw2UOrrI+91q9VgCbHwAG5OOptJ9aGspSbgFjlk6VNjf+0HSbjardt7r19eqA0YtG1+WE21+UU5XEg/ODEzkAQ0M3f4Kdr6dQ5k7xrSKAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XPguIrMb; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-418a673c191so20435e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713974015; x=1714578815; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jlS0+cvMo5zMRt+lvNzaEDG8xl2twGLOFdcuQLafjaw=;
        b=XPguIrMbARamZbbQ3IV2pYwV/+0jn5h6Kxo8Rs9CdutRTErNriYsDmFjsdyyBx8tIP
         54xkVDuq6AqTHz+vTLbdrH0f0b+dnqHyKgY+eORX5753cz7E85fgySISt2vyz87MRL+m
         mZMhZGiYHd3tFhuRH+2spEkINOUDZgfcWof2q25WxYjs8t1SlfvKnKPC+QPpbZeCzq8s
         5Cj17AVir9LFuwX6ifID5Wm6BUThI1mK/zadPbOXG5wrKQLZBEOrg9awIGIepyQzfF3/
         x2bTN141aWtSuCI8j2gR09Ze17AQzt744JHXJMI7kwa5by6I12kg27mORl2sBGoffbuf
         sjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974015; x=1714578815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jlS0+cvMo5zMRt+lvNzaEDG8xl2twGLOFdcuQLafjaw=;
        b=R3dLIuiDEVgblOG2EpqU5tdLEw+RqEbO6Y+nCxLYAZVIZ0tupRtZcMnzVBSJc+VkLW
         aoWf7Se5hdwxZpookzuPrDGRiCefT6F4kq4B16gtncf05Inn13BaxKiPxdisfHL42CiX
         IBM/NPyM4mU3LZCG/lvaktpuSHcXgPZO1t2xSxDmDgodjuBEsVuWjxs2o0JzaTrg0E4f
         TB+th1GqGpFAuTbxYiUVFsHfUwIWDsei4wIfcpu8Z1ZoXLEK0CWTsbXoCekAkSBu+68t
         CUULdByT+LOgPM6B3YTjagm9M/rfQO268qvVPytZfUumSRhFa+w4Nis9kJorOgOziNrF
         amJw==
X-Gm-Message-State: AOJu0YxDFPq5Djbrz1lv9IB6nlOCoCkBJ2gV3Nj4ae7aUYdwC6Dwebww
	xxPx/xwXvQGRPFkKWN1w7r3L/XeV4mRrcHQkffuK+Nwtdnpwt3sJ58l1SPlDab0y5e8XNzkzgq7
	m+enXh3tEYqu0QtnOkR5mS//3yWX6kQa9pTG7YAlJNocL6vlol5mrU8CaAdIr8ZrX85lyDCtOpH
	FF7O3B//XadnvOPt8mwZLuKrc4VQqxVQ==
X-Google-Smtp-Source: AGHT+IGdReIKcVqTmsjuDAVslzZAccKtLHNzyXx0qgTd2rLJHThwDcZZRtw1DQYovTmom98A66XiByap
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6000:781:b0:34b:dc21:68ec with SMTP id
 bu1-20020a056000078100b0034bdc2168ecmr4901wrb.9.1713974015005; Wed, 24 Apr
 2024 08:53:35 -0700 (PDT)
Date: Wed, 24 Apr 2024 17:53:11 +0200
In-Reply-To: <20240424155309.1719454-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240424155309.1719454-11-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1200; i=ardb@kernel.org;
 h=from:subject; bh=2ikJfd8f4pAURymCVR9go150qMtXp0OQeEdxwp9Wypg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1T65ntYp8TdyL5pxwV/ZH44NfCqh3aAYlC7p0TOo/Zr
 3Htk2XuKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNJjGD4796iLXfp1vWmuawZ
 nVd9znufiuq/0XBxdihjRND1SpWLhxgZLvifCrg22y3+17RYH94fXbuTQtMSwr5/F7jEnxZ9z/k aMwA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240424155309.1719454-12-ardb+git@google.com>
Subject: [RFC PATCH 1/9] x86/purgatory: Drop function entry padding from purgatory
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The purgatory is a completely separate ELF executable carried inside the
kernel as an opaque binary blob. This means that function entry padding
and the associated ELF metadata are not exposed to the branch tracking
and code patching machinery, and can there be dropped from the purgatory
binary.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/purgatory/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index a18591f6e6d9..2df4a4b70ff5 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -23,6 +23,9 @@ KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CF
 # by kexec. Remove -flto=* flags.
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS))
 
+# Drop the function entry padding, which is not needed here
+KBUILD_CFLAGS := $(filter-out $(PADDING_CFLAGS),$(KBUILD_CFLAGS))
+
 # When linking purgatory.ro with -r unresolved symbols are not checked,
 # also link a purgatory.chk binary without -r to check for unresolved symbols.
 PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib
-- 
2.44.0.769.g3c40516874-goog


