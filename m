Return-Path: <linux-kernel+bounces-77223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FB6860252
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BCA21F27E99
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FE0548FB;
	Thu, 22 Feb 2024 19:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YnvXnOuw"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE13D14B815
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 19:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708628956; cv=none; b=ULwnxjfGAxT9ckcDKNwRmA/IoHphzewyBCA0D3H086iY5akxzXpms2AMy3QyNUoO7I9dsRNBWpZ1ZIXpNXHc0kWbJLwGKv4r2+LR8hbjpobQWI8yjDFK3/yw1IyIQt6OQTNPVCwwl1mqgLu2sOjdHwh4KYevVf0eBokz7Ac0pbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708628956; c=relaxed/simple;
	bh=qMCWVXQCkH7/OsVC8XV8wlWhGBfIObVlwCTkLB6YOOE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PaQ7sLHgeLqz90xkEfIU1e9MQgTbrRF2lX4xDQTRrKIxsN8J2xLA29fIwLg31cjI56VSGq6oEgKakNAMXP1/MX+EJdO9AxkKywOcIgjb1IElvGaJPkFbEAVIc7WkihizRGgYfBgb5OGVK2MUJaWx5vp5aZI1VSfdBwi/0lCH0r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YnvXnOuw; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6ade10cb8so303776276.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708628953; x=1709233753; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nIzMjlB25RgjrxXtl1pB1geOeDMH3Njm73h3nfH079U=;
        b=YnvXnOuws707cMoTDh+7wSc7NDDp47PM2vWtPE6A9K9+oWNJ0YlBbcnUqBpKE6ej7U
         t+mGJeecc2iCJYT0Kh83xvl77zm8khaKraP0jntNSCpt1TkPORv70uwthyGwbUlwgwGJ
         yAyW5rvcPnqikmjJh4AF2vNN/8jkPDNVk7Yp+DoSeY2eumbSmPi6QcclG6yM/NEv7h33
         w6+SLa4BbP66USwmlEWcbOqS8AL7zlZsQhJyUMB2xqenwFOcDe/LnI8+bLLVGoXnazJr
         r7WAeUrHIHF8L5BvEonoVQk1LuKG1RcXMlf7VDTmOXUVr0FP5GJ874jRagaXJMURzwou
         Ux9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708628953; x=1709233753;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nIzMjlB25RgjrxXtl1pB1geOeDMH3Njm73h3nfH079U=;
        b=F5YjSowNb/8srVc8BIcXoT5pvN/a9VdTzA4uOLPqe+mveZz34eNsNXI90AQ0+xAGxv
         GpI1Ojien4rerC/3bd3y0VFEJl84hCwSrFYfQ0RB3DBt1cS2LUg4BKLixF2VN1WT9Rz+
         7dTYw2mjmhhkJY3Dmn4XK3xU3ZZrkbBf9DA4LezQoVt1b9VCLsAV/ZVs8woGLiSp9pvo
         9h01t8otcrxfB67YGpoNtBR+emXchCGPzshwA97Nbi0+ybYzfrt7PXvxSNCfZfn7mBzN
         M3KpZmlIo60f/OkrvKpGHmQlDhj3x4DWmq5YalRZQdZNR8iphtLsab1nBTEIpiA7s4f+
         5Kxg==
X-Forwarded-Encrypted: i=1; AJvYcCXhGMc+AreF0q3/6VgvBzrf3rm6sxEaKc80YzA0k+UIi2y3leCYlc25eNAWqS1UnJ6lyeAviUomfoODHt3hva1P8u1MD5tl9veiKgJ+
X-Gm-Message-State: AOJu0YyRnXFAOx5u2bvg/o5kzDdqX/CNCQcU+qOzwqAl38gHqWIoDFvY
	inHnD6y6rQr6NrJUcJqqGC9XyFc+FGTaAe+Y8ttgontKYdQUM8bnVfOmrhUuFFve93zKc7y3UED
	oGx/fX4uPk/l4Ppa76Q==
X-Google-Smtp-Source: AGHT+IFhLOIIoOxOJTeZtK8v5l/nxmb62wdg4S32WZNNAZyEiVU1cXXF13e3K+xCwfoSZI1v2GPL5kT56V9ooklX
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:7496:0:b0:dcc:5463:49a8 with SMTP
 id p144-20020a257496000000b00dcc546349a8mr657549ybc.6.1708628953740; Thu, 22
 Feb 2024 11:09:13 -0800 (PST)
Date: Thu, 22 Feb 2024 19:09:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240222190911.1903054-1-yosryahmed@google.com>
Subject: [PATCH mm-stable 1/2] x86/mm: further clarify switch_mm_irqs_off() documentation
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit accf6b23d1e5a ("x86/mm: clarify "prev" usage in
switch_mm_irqs_off()") attempted to clarify x86's usage of the arguments
passed by generic code, specifically the "prev" argument the is unused
by x86. However, it could have done a better job with the comment above
switch_mm_irqs_off(). Rewrite this comment according to Dave Hansen's
suggestion.

Fixes: accf6b23d1e5 ("x86/mm: clarify "prev" usage in switch_mm_irqs_off()")
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 arch/x86/mm/tlb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index bf9605caf24f7..b67545baf6973 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -493,10 +493,10 @@ static inline void cr4_update_pce_mm(struct mm_struct *mm) { }
 #endif
 
 /*
- * The "prev" argument passed by the caller does not always match CR3. For
- * example, the scheduler passes in active_mm when switching from lazy TLB mode
- * to normal mode, but switch_mm_irqs_off() can be called from x86 code without
- * updating active_mm. Use cpu_tlbstate.loaded_mm instead.
+ * This optimizes when not actually switching mm's.  Some architectures use the
+ * 'unused' argument for this optimization, but x86 must use
+ * 'cpu_tlbstate.loaded_mm' instead because it does not always keep
+ * 'current->active_mm' up to date.
  */
 void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 			struct task_struct *tsk)
-- 
2.44.0.rc1.240.g4c46232300-goog


