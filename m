Return-Path: <linux-kernel+bounces-95633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BF8875083
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343F21F218DC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698A5133297;
	Thu,  7 Mar 2024 13:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nEruMG4m"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1687C13175E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818766; cv=none; b=rdcS8JgA6ERNJ3oji7LdUlBEKZ1Kfvf5Xl0FSVpkcVxMpcEM+6uSiW9Q19rxAbJZJLXU5mGcyTlNar5T0jrbsdUJfEgQwoNgMphzSSeAb8HPvqqQr8scsO5YBg/BnGuFrEp+nfv36fe/jdkW7tiS/MhFGn4Wb901d1Xv+KxHGPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818766; c=relaxed/simple;
	bh=YVBxuTgiADuyn/Y7BPbabvtI98g/BjA69xCsPubJDqY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y+CgIlFgIf3kQCHLn0/rTa9AU3Vmouv6u4n1XncMjOpU+1pbRwLYEpvwRnJQ7HU8Cg2Qc6e4RyDyTvLuehUQJR1B63/d+6w7mmHWR9ph7Aac9lmshjZ3p0a45xDVD2gYrE4dqUhUmqHhgYO4YaafXELo54YTx9wW4cY64d3weSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nEruMG4m; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc693399655so1648058276.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 05:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709818764; x=1710423564; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+p7lwWPK4A+HxnQYYFVMxpxfoiERHBbI1OMhXMl4tc=;
        b=nEruMG4mrvpMv4WFky5jVGfRhjXotxVhvYkH5HSjyVmStujpFpWI9u1U2DEuaLv9Ft
         TYutsK2oe0Vna7UOzOiB5xYHlU69JhOpag0cH9Fbu2VmzFRXOFf5qPKGCY5oZ3cc0T5X
         cG+TyruUh3y2xsTir1b/QqiQX/d/q8Cwm36wkkM4MMXfQqvaJaDJDU+XsQVd/myyyvgQ
         JxDqLt79dzefANxvtAQ171r3LKrusVBqzsbFYiZHf+qmkrb2vzfCbnkQ9M+E8DKI3XYi
         HNN2jjTM/+LprABkHa0GEWSh8N/y9lCnC8KY77ciq90DU7L2btdoA3pnW0ym6K3POQlt
         Wskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709818764; x=1710423564;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+p7lwWPK4A+HxnQYYFVMxpxfoiERHBbI1OMhXMl4tc=;
        b=OCleXjvJ8Odp0uJ83ERlxbpYoU/Hpikk3WHETVbpYMvTKxI3m0lJT/WgttNm2bQJdR
         zbYF6vGY9VQ6gb8I5pfISrcULrhtWS1jUlnbsubNC+rUt77Grj7hCv42ZGt5TDjKohRN
         ZLv2Lu0XLAsCeyA5AytnAz7ZGlgoPp/gCaz9lLxJfNy7mUxa+pQrQzKKLnpgx6AiX3DL
         a4CGQxpi5ebPvKBIwp0QRajIo/t61jhQVT5kCfz7Mk3/c2DywnVkoSnUGkeYOsH+HBFx
         lJnFbBEEkQCQzG3SpIxfc8nJ/gnF58LmZfrwKvsucktIZGY0TykiBPIjWcHIEL8NtKsl
         dKkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQf0se8kCyt1MuT+BRVtML+mxO1cyDrbj7xZIbCiYohIKKKN5nlt4NIHWh2ZH509V+7h1oD3IFxqwWPFrz//LDzC8Y7NBe0N2GwpTc
X-Gm-Message-State: AOJu0YzUU9JprP18bY0oMwOQLfedAYYM+obGJt4zcyM9k+vNPS+Valgd
	/x3Dsiu3Uf7DZ8Nhpu4PAFlDf506dMkF6ulTisEcOu+3tns7LjVjresIcg7/IfCNafwfoBKL4C8
	5aw6vTR38hFmF2qfFQw==
X-Google-Smtp-Source: AGHT+IERxGCOOgtmKs7Ul3o8yNM4OeKiruullY93iXEMk4G4tg4OgAxxdrUv6OMg9noyhQpJciR8PQuPntNjh18q
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:1243:b0:dcf:b5b8:f825 with
 SMTP id t3-20020a056902124300b00dcfb5b8f825mr4599717ybu.0.1709818764114; Thu,
 07 Mar 2024 05:39:24 -0800 (PST)
Date: Thu,  7 Mar 2024 13:39:16 +0000
In-Reply-To: <20240307133916.3782068-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307133916.3782068-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307133916.3782068-4-yosryahmed@google.com>
Subject: [RFC PATCH 3/3] x86/mm: cleanup prctl_enable_tagged_addr() nr_bits
 error checking
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andy Lutomirski <luto@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

In prctl_enable_tagged_addr(), we check that nr_bits is in the correct
range, but we do so in a twisted if/else block where the correct case is
sandwiched between two error cases doing exactly the same thing.

Simplify the if condition and pull the correct case outside with the
rest of the success code path.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 arch/x86/kernel/process_64.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 33b268747bb7b..3f381906bbe1d 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -771,17 +771,13 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 		return -EBUSY;
 	}
 
-	if (!nr_bits) {
-		mmap_write_unlock(mm);
-		return -EINVAL;
-	} else if (nr_bits <= LAM_U57_BITS) {
-		mm->context.lam_cr3_mask = X86_CR3_LAM_U57;
-		mm->context.untag_mask =  ~GENMASK(62, 57);
-	} else {
+	if (!nr_bits || nr_bits > LAM_U57_BITS) {
 		mmap_write_unlock(mm);
 		return -EINVAL;
 	}
 
+	mm->context.lam_cr3_mask = X86_CR3_LAM_U57;
+	mm->context.untag_mask =  ~GENMASK(62, 57);
 	write_cr3(__read_cr3() | mm->context.lam_cr3_mask);
 	set_tlbstate_lam_mode(mm);
 	set_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags);
-- 
2.44.0.278.ge034bb2e1d-goog


