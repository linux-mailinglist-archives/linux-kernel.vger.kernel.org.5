Return-Path: <linux-kernel+bounces-94819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0C9874594
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5819B1C21C26
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45352EAD5;
	Thu,  7 Mar 2024 01:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HxaFGzxn"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FDD5C89
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 01:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709774032; cv=none; b=bCGYMHVw2rRqSLx6IrTA0hQm4xK58O0BzbA/Jx5Kq+XXr0UuMMEZxUgGihrRQNvkkNSRXlkgVjXMKzDK3tRY/tvTd7Hn+YWXy0aRrm9/ahxdtQEs/GaJJW7uPkx96Qrskk4fc1wZ5MUVngYbPzqjNS7VQAs2C/2/ghhsEdXO1pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709774032; c=relaxed/simple;
	bh=pDYlO6655RQWWCS62vtsbuYOY+fbm6Nz4LPdmuV/H+M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sZnksjOT4A7PVcpRp9dYgzZD/EyHtC0jOK/cVln3xUOAm3NeL4dlaHv3RnQ0U3oKkPzUrjjQnaYqAXQcnY38bVzPPHBy1+2b0VAJUOgNsXM6LoTFeLizv2RTTAuKJPLdtfr5TLtj0JFcIAEPHr3XwsVf/6D6KMhjJPHtGAAMhmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HxaFGzxn; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5d8dd488e09so345578a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 17:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709774030; x=1710378830; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=URdnb8no/gejybKx7VpZ/WZV3Jy5gWivUnugYsUgOO8=;
        b=HxaFGzxneQWmKhHlBPb3/ZGmN8weGbFF+vRusrGdXoi+BN9wZ6aMUk6zH5avbOpg5K
         jGYyQAtvJOs0ddJUG7Shxg4LAjXU07jE1GU9JZw04SyRSCyLuxlZ8zJNsd6oareD+t5D
         9/sTof9JyzIoYm1co0jxgyg88QA17kLEAnkdd2YpmdpzEA4Iva4AwOaaJucMn+amknHA
         XVFJSH8g/mbqKQ7bw/IrPHl/bY2oe17FbqQJ+micIJGEEwrGPXv2zOtGgDmyLTOHQzcr
         UFhT5/xDAIBxCz0lzvOMQe1rHXr20XftgZ2uObJGKiCf28K48olJTweeEokfl0q6jOpe
         /sYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709774030; x=1710378830;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=URdnb8no/gejybKx7VpZ/WZV3Jy5gWivUnugYsUgOO8=;
        b=U/JFKrwcnIwgfLuABRCiecCAqw5bh65jFzajnVuOlqjEodDugJ3hT26EWFa1iSjkfV
         UCn5O7E1/CFBcD8zxWch5pn8pm3ofOsI2FbICk+FaZfnrUU99cEvc2HPxLiS5BuLGtv+
         uCfpJPfcE4hDlHpeC8yn+Ij7uoWiuyQ++7ndmYS2XsKO7Oi9d1NajqipD5zao01qWWla
         AOhY5lgkbN7ii8nz8CCOBBohE31jeXj9FBJ5jZ3ueZHr6NydS9reE7i9huwVqfCX7pYF
         +yAvMP/8yth740mpCFkO1+HyBwzIix4XeS4jwjIT+4YEsYLnw1yq5P2DnqYAMc4miZdo
         cBkw==
X-Forwarded-Encrypted: i=1; AJvYcCVEswUKroEMae1x/MJeLnxccgf9sTdjLsWYdV099PYP99ZFEG11F7boQ1KlY4A/VtJ3I6pehhVbcLG1TCNGhKPQ8JsQcgXpqCm2rTGu
X-Gm-Message-State: AOJu0YzZoPuJy/9BrSf9/8t0XAnAr3H//yFdVs5poAx0wHv6mUdC+KtB
	0fv7auARwo84kCO9gkC2GzoBTX8bDM7ge2m6bJz3IkFGrblU7Kgm1xthSN9OcEGok5SdPtWbQaU
	ZoA==
X-Google-Smtp-Source: AGHT+IHE3hLUtN9mAa6biOVT2TlEtSXabGraYG0Zvf7THAU106ApQjXZwsK1IkK5O6pSCZp8GdlGKQw1rTY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:f87:b0:5e4:292b:d0eb with SMTP id
 dq7-20020a056a020f8700b005e4292bd0ebmr39689pgb.2.1709774030473; Wed, 06 Mar
 2024 17:13:50 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Mar 2024 17:13:43 -0800
In-Reply-To: <20240307011344.835640-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307011344.835640-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307011344.835640-3-seanjc@google.com>
Subject: [PATCH 2/3] perf/x86/intel: Expose existence of callback support to KVM
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a "has_callstack" field to the x86_pmu_lbr structure used to pass
information to KVM, and set it accordingly in x86_perf_get_lbr().  KVM
will use has_callstack to avoid trying to create perf LBR events with
PERF_SAMPLE_BRANCH_CALL_STACK on CPUs that don't support callstacks.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/lbr.c       | 1 +
 arch/x86/include/asm/perf_event.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 78cd5084104e..4367aa77cb8d 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1693,6 +1693,7 @@ void x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
 	lbr->from = x86_pmu.lbr_from;
 	lbr->to = x86_pmu.lbr_to;
 	lbr->info = x86_pmu.lbr_info;
+	lbr->has_callstack = x86_pmu_has_lbr_callstack();
 }
 EXPORT_SYMBOL_GPL(x86_perf_get_lbr);
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 3736b8a46c04..7f1e17250546 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -555,6 +555,7 @@ struct x86_pmu_lbr {
 	unsigned int	from;
 	unsigned int	to;
 	unsigned int	info;
+	bool		has_callstack;
 };
 
 extern void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap);
-- 
2.44.0.278.ge034bb2e1d-goog


