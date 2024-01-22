Return-Path: <linux-kernel+bounces-32600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEA4835DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0717A1F21376
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB8139FC4;
	Mon, 22 Jan 2024 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ZnG2EjT"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F023039AE0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705914770; cv=none; b=dofZVbxo+WJ5roWPaGcoV1hSbha2YqgA5dRmWLpMeR0RN8pO9ixgPyVtk/mgQ+9b4YHU0PhYNNCE+3jrTXpKuMxiYHP1Ffo02qzw3wtp/h4CVkhxOwKZMY+h/Mw6uk64hrOeSvVC5iLyIKnZl6CFGP5yxxXw3NnATsVWxtiu8SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705914770; c=relaxed/simple;
	bh=FI1bdkhRdpG4w1m18XkG1rAosi5jGY3arzDb2dniOFM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qK+5fhDv6BDnM9EXTpOCq8ScIme4WPZTDJfRYEppVtsquABwrlmCUQPUlkrJVACUe9yJWVmsjIGbRsMzkcmb0LA8X++ALwF2aXoh6fWXruhHQp+thGqcZ/ZcxiF0Vgb2jgAR9UJTcHQcrCOm0kXYOiDhwyyABO+f+xHgIAZiHQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1ZnG2EjT; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ffc7ce3343so14576167b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 01:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705914768; x=1706519568; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6+ATsTLfC/nfRiaNDc88cmvgZOlK0W3C+DyqDLNAS68=;
        b=1ZnG2EjTI+CD842FcsXQHt+IW5QVFeTgYzgP2WWYptU4Hbc/fwy21rdskldIgg7Pq1
         Kkow+KRBA+0nR6ZkwaxxIHF+eA/xc7IErup5nNfsGOuy0uoWvM6viU5VgMjeCe40la/S
         Ldp6MpfJgupK9BDZuZJ/589iGavTh/E9+SrC2dbQNsuCOlnuRu35c00qA5ZUzubuE9yf
         ZNo6WYMT0h8imxAN+wg4OtCi3Sl+3G6CSkTIlyS5FJBSZ8XdV4hnLEk/6MyzazstSG5w
         Cid9dA/yRFrhAIvRuFPHwuzKin/bGVy0/d7JhZ48dEDajYf9hfomG8lIlrBz3AyGsSlO
         91RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705914768; x=1706519568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+ATsTLfC/nfRiaNDc88cmvgZOlK0W3C+DyqDLNAS68=;
        b=osEsYJc+bgBYMqm2pWBeNA7zymFYFkujzbXITd3x71y3R2bBDJzusNkUGQU9t/zgVV
         Y/mOEWGfKya/ff0Oh0QMXIAb71wRnAR3Bio3X3qif1dIsuue0KMSPup4BxWNiKR/F74Q
         I5ZdeynvirH0RGxN+1p8crIjpx+7V7LRS2bVeGAFCE9a2aIYudgCc55ffXEe+z6d4i98
         GvWgE0vp9KLUbTTx0lssHnMZi1mtpMsBSb/5QCyzwm8HT+W2X/5GWP2su+2nVnUaybnp
         AF/tQJJcHiKAAVGgtFBxwpjE64wngv65rOEgFfWbkpFzH4xcaSBvl150JEe/i/knEDFi
         vE2A==
X-Gm-Message-State: AOJu0YwWR6EY0DhK6f4Pa+UuG3C8m7s6HIg5G29gXI5L2jAxzbttPWer
	ZGGPwF8NN4hKVn46tYqE1Qb/XWrpzWXDeun401yInYPYYcrI6ZiijumWRkwJg3rxWVagJZSeOiU
	GjBNHDsOseav2KrZ1Bk+lTqmOQcVoxm3lgdHjPL0TMq/pGvH59//kWpMeDVnQ163exXosxhibPI
	lkHgBDJLt2Ug5Nilxwxgq7IMsGAmZFPg==
X-Google-Smtp-Source: AGHT+IHj5jP1/bPHn1fKlYTBs3hflLPsW502amseDci9rhfzPpL0hjRqnXR0+7HXx4D0UcvjnLYzNOYw
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a81:5753:0:b0:5fb:7e5b:b877 with SMTP id
 l80-20020a815753000000b005fb7e5bb877mr1288192ywb.7.1705914767726; Mon, 22 Jan
 2024 01:12:47 -0800 (PST)
Date: Mon, 22 Jan 2024 10:08:54 +0100
In-Reply-To: <20240122090851.851120-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240122090851.851120-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1618; i=ardb@kernel.org;
 h=from:subject; bh=A4glY9lFGh3ZCS2BolwbxkiHAY08LMb32QJUAkFZOD4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXWdwbIambt6UbumlW3o3fUnes5Ggxs7A9m5dyfPXsn/d
 JVi3k3njlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjAR7l2MDFurHzxqXGW4W4t3
 ia3/+5v/H5kWi8SUzC64/r7UO4X93XqGX8w7t6fEqAq8Lsi/1jt580dBlTI521k3p5SKLZda6x5 VwAcA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122090851.851120-9-ardb+git@google.com>
Subject: [RFC PATCH 2/5] vmlinux: Avoid weak reference to notes section
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Weak references are references that are permitted to remain unsatisfied
in the final link. This means they cannot be implemented using place
relative relocations, resulting in GOT entries when using position
independent code generation.

The notes section should always exist, so the weak annotations can be
omitted.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 kernel/ksysfs.c | 4 ++--
 lib/buildid.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 1d4bc493b2f4..347beb763c59 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -226,8 +226,8 @@ KERNEL_ATTR_RW(rcu_normal);
 /*
  * Make /sys/kernel/notes give the raw contents of our kernel .notes section.
  */
-extern const void __start_notes __weak;
-extern const void __stop_notes __weak;
+extern const void __start_notes;
+extern const void __stop_notes;
 #define	notes_size (&__stop_notes - &__start_notes)
 
 static ssize_t notes_read(struct file *filp, struct kobject *kobj,
diff --git a/lib/buildid.c b/lib/buildid.c
index e3a7acdeef0e..15109fe191ae 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -182,8 +182,8 @@ unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX] __ro_after_init;
  */
 void __init init_vmlinux_build_id(void)
 {
-	extern const void __start_notes __weak;
-	extern const void __stop_notes __weak;
+	extern const void __start_notes;
+	extern const void __stop_notes;
 	unsigned int size = &__stop_notes - &__start_notes;
 
 	build_id_parse_buf(&__start_notes, vmlinux_build_id, size);
-- 
2.43.0.429.g432eaa2c6b-goog


