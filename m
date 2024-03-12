Return-Path: <linux-kernel+bounces-100482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE5387986F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ACDB28175A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F0B58AD4;
	Tue, 12 Mar 2024 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JeIpaxEn"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E46E7E585
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710259017; cv=none; b=oSQDRC/Atk8lCLtAsQKHt1Byp5mUopMEKHTTP3Ph2Y6sSXpg6MM2+TaB9De+o7xEKjST6mCWIhUoWhS1YOvvqR2TAgbwwRjH8fNN+vqZ6ntnYs4tH3e98tAwr+IJ0X3bJnN8Rmjs/otnGpj0oRwS1rrG7ndncJOyp+KGV1YefYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710259017; c=relaxed/simple;
	bh=PCK/pcEqWjp1zm23P5QkoicRhg3NmpAig6IjG/pvtZ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mJ0BFvfuwJyc8TuEnqMkr0nYsnkxAlB0GWrkpbhjlzJnO8Rv1B9vHPlaGt9A5BbK8lpXUT4S5vP+EOH+v3a3Ajv2uhdY81i8oSLsItWLHXPpdAF8d11pfwQkF8tBg9jhSh0RdcoY7+P3MRscOpiDei1sEaLDHi/RwNFInOnGoPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JeIpaxEn; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a04bc559fso67376567b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710259014; x=1710863814; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zlk+aNCie6HXTjVy40lS6l4zYMw7smybyoWxAq6T2Xk=;
        b=JeIpaxEnTxuGNAd9BKmpepNbk8aZRNTcsneU8+m/pPjWvnWGIzjPjzfFNWfjkdklCN
         EqVNELviZYrDy8NTaXUk7TQEtCg4ZFSkbh2l+Bh2Na1L7q9/83m/j1Z4LUiMFeA0UM9+
         2FIDsRuth4zElcVtnDJA046uRHKnK4LcKftotVvxnHU+2CRTSsxzZUyMLB/UI2RcA1Z0
         adPX4PAfInf3dUGNIMPSGwqLZ5gylvcd5ovLPrdh4zK0Y3XAEozn0h8z01mjOYBnvB8l
         Km0XotJE6+vEYkp7QVNCivSnrCuXQfI98taCTMgqAHwRzq6gCHrDMUuV+WqHJdaRoVNb
         179A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710259014; x=1710863814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zlk+aNCie6HXTjVy40lS6l4zYMw7smybyoWxAq6T2Xk=;
        b=sjuBM5uwbVXRHLddpJ7GZUkNDo0dTPZ5T/XPWHMEEN8caGhsxccOd/7rbANWjAd4Ue
         S62FsXP2sWu44yD07SPJVRJO75ahBHzrk3rsKgqEcuCsZauxTlBT6NZ+8UGS0f4erRbA
         H1WbiCY+yM8vjp+jwJE6r6C5+I+8V4fB2p5rCtIPXIcb1wf2jZ2gcWkWoHnXiLr5DyIU
         m0kVHgOO18h2fAgTbzPZy83LB61+LjgSVmnazPo3PvI6477dB+hFCeP8lHpk5CyZCDqJ
         hlwrkL++5BvxdiwkycOFHppRBzy/jR1v533cEiHw1IY5FUIkH8L3eQpVWsEhymSyI3qk
         V1yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvBMBV+PRdAR3jv9GH1w0GsMrwc6hBeYOY78LO95bHSB9gGPvZIJm1N/pqyV0/J1w7kjFDPzzfqHARSUkY4t7BagajwHvgRnB4zdhU
X-Gm-Message-State: AOJu0Yx6+kTuFzBkDe3d+XKmqkUR9nSj6Cfnpo40vJDvFYgglvRApkmr
	1Uw9HXSP6dh+9hIj8B9bilKe+MqJSlF5V2yqKOK4l8g6AZBYMxRGsse4BLRtSDuI+WqPv329CaO
	hWkChVsdyR05F2de+TA==
X-Google-Smtp-Source: AGHT+IHyJoqCC0NaihyP5D4D/Ot3zHwDly5rqaMSbNaNRucYa8YyWEm+aw8zRYzIK3OVa86EMuwxIXsQ2czaLmfd
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:110a:b0:dcc:50ca:e153 with
 SMTP id o10-20020a056902110a00b00dcc50cae153mr2676138ybu.7.1710259014520;
 Tue, 12 Mar 2024 08:56:54 -0700 (PDT)
Date: Tue, 12 Mar 2024 15:56:41 +0000
In-Reply-To: <20240312155641.4003683-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240312155641.4003683-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240312155641.4003683-3-yosryahmed@google.com>
Subject: [PATCH v2 3/3] x86/mm: Cleanup prctl_enable_tagged_addr() nr_bits
 error checking
From: Yosry Ahmed <yosryahmed@google.com>
To: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

There are two separate checks in prctl_enable_tagged_addr() that nr_bits
is in the correct range. The checks are arranged such the correct case
is sandwiched between both error cases, which do exactly the same thing.

Simplify the if condition and pull the correct case outside with the
rest of the success code path.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/process_64.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 3dd8c1f51e45c..8349431136530 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -783,17 +783,13 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
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
 	on_each_cpu_mask(mm_cpumask(mm), enable_lam_func, mm, true);
 	set_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags);
 
-- 
2.44.0.278.ge034bb2e1d-goog


