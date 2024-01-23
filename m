Return-Path: <linux-kernel+bounces-34548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD190837ECA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3C3299A91
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBC1482ED;
	Tue, 23 Jan 2024 00:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jW92VdGh"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0F013D4E6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970767; cv=none; b=RTt2qV3ExOPDmd7Qv00lSXe9z7e2hjFU6GHoduIx+Nua80wcCNN/OWkCQ56a7Ue0C/msMoOVDpcMZWufxitqpdxnvaYend06Jqi1KIud+9XtY2fYjm95CphwaQrZ4/k+ARQKzMI16XrpEfDeyZXxtEELCZ0lovUHoKeITB+77PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970767; c=relaxed/simple;
	bh=afM5LZaCnX07Bbe5JWJGuHF/X6uWMNRJXTDiQd0kjMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vAPOg1fq1jxPkWPvxxW30ZzJF9fxGe1BHOzCJPN3iVidipPtjX7HxnCyyfEAFbyxeBqwbcHdAcmelpVUzPm9d59XqLOvh+WpByM+jWPKPawlQzyRu//w+56vroI2iLp8WZRJGxAno8MTcOITMmP8RRNWtEkb+I2vQ+74fYHZAZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jW92VdGh; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d5f252411aso19715905ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970765; x=1706575565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjQQp3oKjiEkOLCQDWessloRW+CFQ/3ZLbNW3sGQwoY=;
        b=jW92VdGhT4caKnDMyIhsaxucrNHYt9LjcAw/8KVrjruAHX65uI6ruijP6uJyHPQsUe
         b6Rsq2lDl/nN8XvHu9FcgLUH5T8BLKnMLPiuwrJl8HPIVdn/hORWx4ZDIQe7vp7In31b
         O0AGDMLqbzknsMA8pyezUvOqy2P/hYTF4KQSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970765; x=1706575565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QjQQp3oKjiEkOLCQDWessloRW+CFQ/3ZLbNW3sGQwoY=;
        b=BMZBK6rxeVefGJVvcmXTSRz59Es57b5sokyeDTVWCHhYy/A+V8HX7WexUzGrA7e0Ib
         uK+HAM0R3Q7R0Wfsd0dyqcI4NzDmeMMwRpXug/0rqRrAElS78ECZdjnNy11zm9BGiylx
         lxsMWZgCB7nPG/TxC35JJ7lOQTazs/7E6CsLbyVHb2kcSxTxtIba1OwfFlWMwcl4BywZ
         u5NPWc2MV02/fmj5EDsyk3iG9HSYjJfwbJmUBFqXxSTzG1isNPyOopV5y/i4yGsrHi4t
         Xfnn5i1jei65iP2luHBxwDRhmRgfDh28t3Tl76njGEoIqs2z7oY7c10vdJaij/+X1os3
         XrYw==
X-Gm-Message-State: AOJu0YyzkY06MAF2ryCDgVo8wlN4nHjIBLgzEQ6xC1mCDMed+4Ps0A4z
	gggoPhK2JvW5JiqZ79OuPRnGiq1t4qLN+pWGweIZP6CmQKzgtDQWOlmebzpsrQ==
X-Google-Smtp-Source: AGHT+IHpYaDysANltMGaEwTo/0xTnoHF5sbNHXDT5Y5X6O/UQ28VSp8hWvJrAfNwlsSYZ4fWkc2uug==
X-Received: by 2002:a17:902:e5d2:b0:1d7:3238:b2bb with SMTP id u18-20020a170902e5d200b001d73238b2bbmr2471371plf.75.1705970765640;
        Mon, 22 Jan 2024 16:46:05 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ji14-20020a170903324e00b001d72d3f9f3fsm4430426plb.104.2024.01.22.16.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:46:03 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	kvm@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 25/82] KVM: SVM: Refactor intentional wrap-around calculation
Date: Mon, 22 Jan 2024 16:27:00 -0800
Message-Id: <20240123002814.1396804-25-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2478; i=keescook@chromium.org;
 h=from:subject; bh=afM5LZaCnX07Bbe5JWJGuHF/X6uWMNRJXTDiQd0kjMs=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgGUJoQyo2htNqioa5FWNemKH9GelxjiONaI
 nFBVYcw2o6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBgAKCRCJcvTf3G3A
 JqgLEACGR9pBif5bfE/Fp9APHiLwK4tCsaxVu9HuOM4LqZcBVK9RT4sWkLw1sa7ZA399NQJ7xqO
 qNf67b0E3MBPRFRC0wFggz5dAloMTDb19z7jhsHWDnefmrxf3KKjsEqVe6xhhWIAvfAzGdgi+nc
 FzQZ1niID+l1yb9LaTvZZHot9lrk5PajrODBYmdYRrMq77eQP5Pb4BHFIZyOHp2UtegxLXzbUC6
 0y4bH6GFEO917ps0m47gmJOfX4BMZyrhuzuA11o+q7yKJMTDTgO1aKwWRiTUw+wBGHUExa56zVU
 CtdNUJy7igPhmA4odmyr620vUPAoSbAf6iIQKgBlro1AWkWuNO02eBJh4nYzFZ+8Ppm8iI+ofqf
 MIOuQIr6O4nLXLcO9zTWJF/7c3IWPeH1GQF1DcYdSRrmvlpw7k2Yun3kJg4Al6otIViYBTb3Yp8
 q8qYZwfcAIjOV3blL0+F494sbI1QpB8KsAaawy2q9I036/tRKMiLFIVnOkUyj838HE6oxhuFgvN
 njQcjbhVq11/o+7hWYjpCYp7Tk16HpJDJ+BTxbC/RQc/ZTpIHfC6DiItv4snrcHLLzrMKdNGEST
 uYlkr5Nsq0zN5LBNZDWgRjFbaz2Vq3+EIoxmRJrLfBXZkOXXu0pt15SZhxscXnE7+qDusGqsliB rmYY5X++4rNj3Sw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded unsigned wrap-around addition test to use
check_add_overflow(), retaining the result for later usage (which removes
the redundant open-coded addition). This paves the way to enabling the
wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: kvm@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kvm/svm/sev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index f760106c31f8..12a6a2b1ac81 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -400,16 +400,17 @@ static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
 	unsigned long locked, lock_limit;
 	struct page **pages;
 	unsigned long first, last;
+	unsigned long sum;
 	int ret;
 
 	lockdep_assert_held(&kvm->lock);
 
-	if (ulen == 0 || uaddr + ulen < uaddr)
+	if (ulen == 0 || check_add_overflow(uaddr, ulen, &sum))
 		return ERR_PTR(-EINVAL);
 
 	/* Calculate number of pages. */
 	first = (uaddr & PAGE_MASK) >> PAGE_SHIFT;
-	last = ((uaddr + ulen - 1) & PAGE_MASK) >> PAGE_SHIFT;
+	last = ((sum - 1) & PAGE_MASK) >> PAGE_SHIFT;
 	npages = (last - first + 1);
 
 	locked = sev->pages_locked + npages;
-- 
2.34.1


