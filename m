Return-Path: <linux-kernel+bounces-137426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2181689E1DE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49331F23A60
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9E5156C78;
	Tue,  9 Apr 2024 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CuBDkDVy"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DD3156C60
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712685078; cv=none; b=V5ks8TN9A1v5pI1uqCWXWnMpgmJvVg3cvd6WT6nFMIqRgckgzDgiGHCoZ6AsBztmmob4RI8kg2+ev/M1QHtllJcD5Qzam93yL40lIVLX7a/cC6au+nRcpo/qEI4GenKimEanNLKL6u10LJHJzbNxdypSF2cF9casn+Rhd12IK68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712685078; c=relaxed/simple;
	bh=4Mv4JnaamEMFtqjppXQOdNnTp12kg+C/D7qGCSJVY+U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m9ELzIP6FS8STgriN4QHptKRGRlXc8Xp8Gk7L5A1yuTOFgYAA54wbI+Gjv+aE2AA1Db8+pULcW6OskdP1WTV8hI6+boiQ6L58Ng435VngYDKGGvErlUmr/QY1rqj77wv9T5wyJt9+oKaOAPoFTNF0onS+CvpLcs4Q9JZwVWLWS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CuBDkDVy; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ece02cfbf2so5407642b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 10:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712685077; x=1713289877; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qSb1EMKIyurI6CZqrBQhbOzp5bKMnooWMDlfmCQHkvY=;
        b=CuBDkDVyvnYV65R62JtrzAncdWzBNd+OxfSnfDLeunsyaH6WMcuplmieKR0/UEffl4
         6lTZIdzqMKz5tyuniZAp7seVDIS+lmOwQWdMCRrLZJGHC56HoyT5+zTZvD41+uvEG02Q
         IYLSEnRUS7DUDSdzTDyo3vLFPeoSD0oPEBQ+MVIUbTnaeC2xneSK+38kJlDsp4tlI5jQ
         bS4zNOL6dgouOw8ybh0gSWPZm4gd5aeYyITBgvizoxRO3epFUtB/8Ay3miWILAQq0JHL
         dfUTFLBH3qbjp18Wgd7UU+jvLpv8QMjcuVgpxeAWlIdAWrBkA8KaGx5cCC6EoKhM1xo9
         JE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712685077; x=1713289877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qSb1EMKIyurI6CZqrBQhbOzp5bKMnooWMDlfmCQHkvY=;
        b=KRu1NsDtmCcl9ITlNLanDmDZu8D+YFA57oaOdWJHU9ML/QW/6ZdGwjZAHhJ0v8esQ2
         /IbZup8C3xtLOThTjszCmEJUT5lMW9xMUIoFSbcHmdJfr5R7byWu0mhQFuegFHc7oh0p
         lJ4Mgrm0lV/tLAkDcHfPHW7dNWZm4sxMC+R0aoDFbHK5bANIOad/tyN9F3R6FZqX6DJf
         BAFDwev+K6fLHDxzbkRXAVqpCa2K5woGd5zi4ikW98L8Wweua1i6OqmgqP7sX3b1+gv1
         Ekgk8UYGwUJ4cY9DtWd8OauHI0HV3RSWnbo4TRIju9q4yHh58Jbmp9giiKj2AxrIWUAe
         qqeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU33ZmCBW4h2ar9/YnVCxN3HqfZHIA3HJjtsQmsnCHBzMyvFKxZs/DL/B7t8R1VkmMj4znX+Gmw/az3rmxT2LuD7qpP2KUoTGpmJn8z
X-Gm-Message-State: AOJu0YxK01epqxi86d7WmzfS9oZYry7pCKuSHVzsrKL2x7kR/1kBH3BZ
	Is3fbTU/msfMP0WQFxuZ2MSWtc51A5uckXkffEKyJB8533IuYACzrcHSOvpZfDotntFUBp7rkzM
	a5g==
X-Google-Smtp-Source: AGHT+IFBk9SVlkSEc4xukn3nQNTD/u4a73A5Zc/qt1mZJNwu/MInQ+Oti0Aw/jqgBed6aGrOn/f0orNgOzQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:4fca:b0:6ea:baf6:57a3 with SMTP id
 le10-20020a056a004fca00b006eabaf657a3mr4590pfb.6.1712685076626; Tue, 09 Apr
 2024 10:51:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Apr 2024 10:51:07 -0700
In-Reply-To: <20240409175108.1512861-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409175108.1512861-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240409175108.1512861-4-seanjc@google.com>
Subject: [PATCH 3/3] x86/cpu: Ignore "mitigations" kernel parameter if SPECULATION_MITIGATIONS=n
From: Sean Christopherson <seanjc@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Explicitly disallow enabling mitigations at runtime for kernels that were
built with CONFIG_SPECULATION_MITIGATIONS=n.  Because more Kconfigs are
buried behind SPECULATION_MITIGATIONS, trying to provide sane behavior for
retroactively enabling mitigations is extremely difficult, bordering on
impossible.  E.g. page table isolation and call depth tracking requrie
build-time support, BHI mitigations will still be off without additional
kernel parameters, etc.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 arch/x86/Kconfig                                | 10 +++++++---
 kernel/cpu.c                                    |  2 ++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 70046a019d42..7d623df11a1a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3423,6 +3423,9 @@
 			arch-independent options, each of which is an
 			aggregation of existing arch-specific options.
 
+			Note, "mitigations" is supported on x86 if and only if
+			the kernel was built with SPECULATION_MITIGATIONS=y.
+
 			off
 				Disable all optional CPU mitigations.  This
 				improves system performance, but it may also
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 10a6251f58f3..f4e4dd360636 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2493,10 +2493,14 @@ menuconfig SPECULATION_MITIGATIONS
 	default y
 	help
 	  Say Y here to enable options which enable mitigations for
-	  speculative execution hardware vulnerabilities.
+	  speculative execution hardware vulnerabilities.  Mitigations can
+	  be disabled or restricted to SMT systems at runtime via the
+	  "mitigations" kernel parameter.
 
-	  If you say N, all mitigations will be disabled. You really
-	  should know what you are doing to say so.
+	  If you say N, all mitigations will be disabled.  This CANNOT be
+	  overridden at runtime.
+
+	  Say 'Y', unless you really know what you are doing.
 
 if SPECULATION_MITIGATIONS
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 07ad53b7f119..d445763d8047 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3214,6 +3214,8 @@ static int __init mitigations_parse_cmdline(char *arg)
 {
 	if (!strcmp(arg, "off"))
 		cpu_mitigations = CPU_MITIGATIONS_OFF;
+	else if (!IS_ENABLED(CONFIG_SPECULATION_MITIGATIONS))
+		pr_crit("Kernel compiled without mitigations, system may still be vulnerable\n");
 	else if (!strcmp(arg, "auto"))
 		cpu_mitigations = CPU_MITIGATIONS_AUTO;
 	else if (!strcmp(arg, "auto,nosmt"))
-- 
2.44.0.478.gd926399ef9-goog


