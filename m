Return-Path: <linux-kernel+bounces-38515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D07983C0EF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC561C236DE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6F854BE5;
	Thu, 25 Jan 2024 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XQytFWvY"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0FC51019
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182386; cv=none; b=TTS7OO5nVmwjDeTQuBqQ6KITuZ4jK2ScRzosxruiV6JnFia+QlstNuqb0akkb3nexwb8oRwGpSsM/5XNdA5v+5B8TI/3iONXZddZxSHFcuQGMXfT+n+I1dOaLuJz+lyrvSDcH7b1IDEI37IumBxe1/07U6THjJ7OqrcwQlua88A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182386; c=relaxed/simple;
	bh=ywQcTtrCDMHJcI+QkXWX2nFyJwoVE8xehI2i+Z3nGsk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m4cLuWE8vnjuNKUo7UOYMX2+P18kQdMi3PHF2NXE8eVJRdQaOF5uqqfDLJEvtLLy8TQfbeChxFBL6RVBqmuM96eS2fLC76CFxmsuYCvYoJEGW7nsZpn8gH2SBngrl/CJ+H8h11RL0okHJNKVsYrAJaBC52AHJZZIknRSXcvGLTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XQytFWvY; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-40e5f548313so56765455e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 03:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706182383; x=1706787183; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fLLl1bcVbRYtnIzLBeH2xJGti8beoepv/z/uSZlJPHo=;
        b=XQytFWvYz0bgtEjZlafmrVEl4JEGRW1LWuubtwVLI9igMlHJWWkC1YTeP1FRIfRIAx
         lucFeZl+VkbkXqEHqmtIfC2zdtOJabRsOMcySxVIGN+SWIgdiMmSzR1DV+BRVBaHM6aL
         OyKMYAceo2D2x3l7aaGlWtnDOebsXAvRPQaPrGs1Wo2QYQXt5fbBwSjlC92u+ufupZrE
         MT9Fcz1Svw4NkYbd22PQwyARrrASBQorKidt+F5+IpxYIA1yz3OJRAuHuhJMBU76Z3St
         s6YLKYzMys6U5ZrHCK7wLb/IgTwzfheETOCp3HI58mbn+MewguaWN5vOkZN9fZ7rKWM6
         quYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706182383; x=1706787183;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLLl1bcVbRYtnIzLBeH2xJGti8beoepv/z/uSZlJPHo=;
        b=tCW/sSfR2lTWyd5dtdB2PtkinaRxrtzm/kxN6pb402HoHkBHvXI9L6HQ9nnD6ZtwyK
         tavneyUPXqTGYBi6n6IM7KxqnTwEXlPJMbR1Ik4kgmfdOWCZ1bKTF/1EMWbLvlR1AWgB
         dygyoxkNyEP1QsEh4IW2ZrvIE1/qrRiTMsdvKfRv1FRxTGACmukcaft1wfuUd6YLZmSo
         M3XdPgUvb0opFNrHIAbLrEPHeKkZJZOVKwlO/4XmDXDfs1PYC4EWv97ssRPOSytKoTDF
         zUjTBuccHmg8SVHOmn2p7rkPadOwDkT81RiNQLZqrQjMA2i+9LXtrF3YAqNYVm/uR8xE
         2rVQ==
X-Gm-Message-State: AOJu0YymLKYUcRO7N7mYUycIRBhApTRXrAyKTYcDQd5zMeR+nF/whtk6
	hC6tNoCU0ayvdXpfu8AT57wAmBRDOEk7iBmVGsrRj8cBSefj1toa1MeTu1HGWqR55biOuBvdNd4
	jBdsc1PTj4kcKsSHKQJhL3fxGqsX4KFtCv1R/dXDhnmz+ZVdX3cuLJTvgZ2id0ibSr9J1zBC/cl
	nTZLiTIe3BprugU0g0Y/l6Tzo+uL9RPA==
X-Google-Smtp-Source: AGHT+IH+tHtY9FWpEc9qh8w6jVw/qndHIKRZi4Zi4jc1hJlvKLmXv0672PzSqvht8FRd715mL9u57xeg
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:4e0c:b0:40e:c720:f327 with SMTP id
 b12-20020a05600c4e0c00b0040ec720f327mr14276wmq.4.1706182383051; Thu, 25 Jan
 2024 03:33:03 -0800 (PST)
Date: Thu, 25 Jan 2024 12:28:30 +0100
In-Reply-To: <20240125112818.2016733-19-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240125112818.2016733-19-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=979; i=ardb@kernel.org;
 h=from:subject; bh=DDaOUA3J+CFMHhm3e2XXAeDqtyhjkdr8A2J8hJRp8QM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXWT6wfmH+v9haLvWOZmMFrJXOT6Yz094E3RseZ9K47vm
 /XtUvaHjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRpg5Ghm0sH1ScTbRyzT9y
 LT5+VOxYRanmRG27Jp4J++av9Zuc7sLIsLeAS7395J5HEZYJvUVbV/Nxt13WjZNdJpJ7wl/vXc1 bLgA=
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125112818.2016733-30-ardb+git@google.com>
Subject: [PATCH v2 11/17] modpost: Warn about calls from __pitext into other
 text sections
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, llvm@lists.linux.dev
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


