Return-Path: <linux-kernel+bounces-43280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514368411B4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A3B1F25056
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414B815AAC7;
	Mon, 29 Jan 2024 18:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PePKihMI"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA946F090
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551563; cv=none; b=JQYcdQJYzLVE9zu8+EjT6xAFgAerpRtrrbHNsKii6Bs1RO+XBusbvbBfBFI5LIdhIBkb0dfgpFIG0KA8OdhaQYSHIzcONGcC9q+yXt23lm59sfhF10xPQJcHKcUIAjmp4tuP46P8AORl7V9IQt7s8niVxJr8XwdAtlFtW2fXRpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551563; c=relaxed/simple;
	bh=ywQcTtrCDMHJcI+QkXWX2nFyJwoVE8xehI2i+Z3nGsk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d8G1Yg2a6LhI1C2hqO0uQxCP4f2uMxB8+X1U2DVD4dy8+uYUH6dSS8+lsBAwbREfVD3UrQjwcU3iIsMjVXMFBF51Ln9Bhfd1zKr9SJSV2gVd+u39mzs+34ge6qoXHtHWqhXEm36z4iGW69xa9XZjiEdbsfyI0XirdKQK3AbJ4Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PePKihMI; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-40e478693bcso20448755e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706551560; x=1707156360; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fLLl1bcVbRYtnIzLBeH2xJGti8beoepv/z/uSZlJPHo=;
        b=PePKihMIIMoDRiafr8/B5H0JSooV6zBWN12mgzsMtuezB4BxjNtZqUuUwJ0AX7Jo1X
         LTg84Ia83obzKLG+p06g835IqPxjaUAKnuOAyRCW+dSe2tDftB5D4lpvIi9oUgVDMAfA
         upbEeHjGTvTxNgCeGTYe1kYJ1f0pB4gdN9AgmDBul4vNOGGv221vJmK6BeQkqs2wl155
         pGy8ltGR0DTI01dlvkwIcEPlAwAC7pYA5ILDkBklmYCpkh1EG7xhbzDCkmadwkBWDg0n
         fzyEBI18fOPI89duJF+eQ+wnTJVV4XDHXp6/xAZm3Q2x13N2V1iYeMp86YnevNLWM/4a
         TfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551560; x=1707156360;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLLl1bcVbRYtnIzLBeH2xJGti8beoepv/z/uSZlJPHo=;
        b=NiUJRFcLdkwdILrmVRo8COPXeb+8HG+Kgz3G1BYYdgIkROXW8XbN40b7NDa3L3XZme
         YQU2iChlh0nD5mTVw3OaARVmig7mclxOiwg5XZiNt5p6fyNs27VwMJ8Uzg5/ONm+Jn65
         J4pTdZxstYMrlSwrZkqfSpSlMqd/IbeiRQz2uNIRsB40rh903YTS+gNcvE9750xVhsGz
         pDxdW7jZZBkepmh0xEDloKygqq2YEcigIDn3QRbARbrtAhlnpqBOTvHHBKOgvPIxSk43
         jYJR3pT3tvIPqGLn/TWaj2q8O5ysg1ywMajAW0B7ACBEayrT+1/esYkkj/Oiyk6G80vX
         8H6g==
X-Gm-Message-State: AOJu0YwAl1WEuxV0GsL1T5nIolDWPLek/UDfOfp2GSDN+fVAsmom6rdS
	oORUtxwnxmpzD9Iw0GAo3ek8+1aPJ6LTYWw2cC75/lXjbFVdUxs3zvSjDwlDGB7y4jNyo3qolse
	Y7PPFWJRK9UzFzhD1lXVmlMyQtzFmjEM7jec1ix91eWSnUC27StfQUHzqYWMPL3j+4+MC60Cduo
	M4Gy1iGKqkNv9PFcFwFcdKIo1lSQCv2g==
X-Google-Smtp-Source: AGHT+IFRYaQgWgn7lS/fBsOiZY67lNa50V8yvvYuuoCz5vPDJOnfUaUEOPLRn1IO8EMDt34AydE5rmRl
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6000:1e06:b0:33a:e517:57f1 with SMTP id
 bj6-20020a0560001e0600b0033ae51757f1mr89123wrb.0.1706551560216; Mon, 29 Jan
 2024 10:06:00 -0800 (PST)
Date: Mon, 29 Jan 2024 19:05:16 +0100
In-Reply-To: <20240129180502.4069817-21-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=979; i=ardb@kernel.org;
 h=from:subject; bh=DDaOUA3J+CFMHhm3e2XXAeDqtyhjkdr8A2J8hJRp8QM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXX7i7vMP9b7C0XfsczNYLSSucj1x3p6wJuiY837VhzfN
 +vbpewPHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiakcYGVby7QyTU6idwMOc
 J38qUmJ1p+F91buzM3Z8Xzphas7LJ+sZGZYqnkl8ycjtbnKv6+ovZ1E/e8uaWONjpw6xe+z87Cp rxgYA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129180502.4069817-34-ardb+git@google.com>
Subject: [PATCH v3 13/19] modpost: Warn about calls from __pitext into other
 text sections
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Ensure that code that is marked as being able to safely run from a 1:1
mapping does not call into other code which might lack that property.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 scripts/mod/modpost.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 962d00df47ab..33b56d6b4e7b 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -825,6 +825,7 @@ enum mismatch {
 	ANY_INIT_TO_ANY_EXIT,
 	ANY_EXIT_TO_ANY_INIT,
 	EXTABLE_TO_NON_TEXT,
+	PI_TEXT_TO_NON_PI_TEXT,
 };
 
 /**
@@ -887,6 +888,11 @@ static const struct sectioncheck sectioncheck[] = {
 	.bad_tosec = { ".altinstr_replacement", NULL },
 	.good_tosec = {ALL_TEXT_SECTIONS , NULL},
 	.mismatch = EXTABLE_TO_NON_TEXT,
+},
+{
+	.fromsec = { ALL_PI_TEXT_SECTIONS, NULL },
+	.bad_tosec = { ALL_NON_PI_TEXT_SECTIONS, NULL },
+	.mismatch = PI_TEXT_TO_NON_PI_TEXT,
 }
 };
 
-- 
2.43.0.429.g432eaa2c6b-goog


