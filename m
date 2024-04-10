Return-Path: <linux-kernel+bounces-138860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB76289FB4B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62EB81F2C5AA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD0D16F0F2;
	Wed, 10 Apr 2024 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zDPmWRZK"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B308A16F0EE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712762041; cv=none; b=SMbB4+9gtVopLfCxaq6AKniPbo5aMTTaPfrfTAzoC7UvHnodW4ncODYrkNREPvBcpEjTfSgg0dBSe1BTYIw8nCD4FE1QosISHIB0i+aiP8vvYYwW2p4wq5ky1vyxnRcH0jsgG9oZvXUO/tAOKVBTVBYIxXRN9fEVAAObHX2pwwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712762041; c=relaxed/simple;
	bh=a2pcaLR/QQ5XPgD07kIGqE9utz59xKcjVOOzGcHHBIE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oWg/hngZVybI/k6gYjUrG+ukTFjy2ZYofScZEE72ZUo9R5IPwhoBimSPOsGV64uhWz1zWGwdQvYuPrSLCxZ9ArKlSyj47Q4uiq0C+w7Xg9by81fFwFRze/zlEd8AQKbhzOPbe8QvxoA4nKsmehLmX1OM6TQGUzn3+lYJNEyeN7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zDPmWRZK; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61814249649so50834437b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712762038; x=1713366838; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gmlt/ElhyvW7sHcqfyFefAPiZnFZFP/wkeFMw4DU5h8=;
        b=zDPmWRZK2SgvDi77gDHKqyKOQaBUnLBmy1Y93eTkO3x72WGQb37FfwZEfAGOwqXstR
         c9YHqsvmu0hEdHQ3mEgpkyCXiXX9K8Yrjr9RJRLcagDqCd8a/fFcT4Vh00IuvV4BcQA4
         EVoIx/bhNxFl2MLAfmEywisU9Z0o8BgHMF0egzI2oQEXIqhSrkFcTosIXxPTYdhY/Imn
         xwOswDe8kClTOk8PA4lnJArBL+laVV/fq1taIPeGJ/NFKHKgaZHEh9VnI8WNOg4RabRH
         AWNM1HwId7a8HOlXWX4bodRbf993b8BG6qg9ufBlOqX06RlqM7101kMNe1uYTlAuEXWj
         B0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712762038; x=1713366838;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gmlt/ElhyvW7sHcqfyFefAPiZnFZFP/wkeFMw4DU5h8=;
        b=h0kQqH5UbDZZeurFuN/x6ryzYvzcrLTCxi0sz3Lo7VbSTWaKL+Ltqck+2oMsndSawi
         zyZ8oofuYlai/gX1f0phNISNioy6HKsesJ1oqgPNJQM1wvy6Y8w/qcdVL0qwdsaV3TfI
         rx5F1fgXAlUXqmU/AMBYh38Yt7WMClsGyxSWrndofT3WYnloVpN/hO4ecZwBC+MfoMbu
         n3ZjF5jXCd0N1402zXdKSh1Ym94f6//ZGCmAhiF22N83LdjRCiKhpD5U9anQeYtyj7Us
         TtP5h8pEZxgX+/0Za25asFGSMTU+dBnJ3mbAZlg9idbmp56ennn3YalsTIIoPWIMyEcm
         AaaA==
X-Gm-Message-State: AOJu0YxYLBbbcdLtafgAW197SAbAxvauaRPddnC1fED8KMTKcUS0l6eF
	5HQedDT0rJoTUd8kSDQ4GCU+Mv7FQNyawmfBKR3JTDip/hphwOIjb6jOgD2lblkI6iaSj41z9uy
	CaGkXJC29vYDGK/ZjB0lEzUz2bDbF4DXugpNs+c1xhJh5j2723IfXKq60c0/86BPdkp5qxhYwpG
	W2hyWjz185QVQJ792baLuUVxcrVrdL9w==
X-Google-Smtp-Source: AGHT+IFnz1yrcY6LkVnJyMgINY8i1bMyp3sUIlO5kSCCU+ilEg9ZvY30YcCH9u/eb+Bv1yCCGYwX82Pg
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a0d:cc10:0:b0:615:2ae1:6cd3 with SMTP id
 o16-20020a0dcc10000000b006152ae16cd3mr615900ywd.3.1712762038673; Wed, 10 Apr
 2024 08:13:58 -0700 (PDT)
Date: Wed, 10 Apr 2024 17:13:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2757; i=ardb@kernel.org;
 h=from:subject; bh=3rnbO10AbXFpyPbuqUrhtreSq83EzkOwDf3ZeCBBmsY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1szeby4hqt7C8+L6PnLq79qH8+vzlff/mFDu0E5zPzP
 gj9+yDSUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbSncvwP1xM+/uDuPnzRBUl
 EsX4Nf8eqN5k9/PREqfoQt+r0efSmxgZuj/8U7NhfC0nc+2dCM/fe+5/Uma+fC0s6MjAwTRJcus iTgA=
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240410151354.506098-2-ardb+git@google.com>
Subject: [PATCH v2] x86/boot/64: Clear CR4.PGE to disable global 1:1 mappings
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Conrad Grobler <grobler@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The early 64-bit boot code must be entered with a 1:1 mapping of the
bootable image, but it cannot operate without a 1:1 mapping of all the
assets in memory that it accesses, and therefore, it creates such
mappings for all known assets upfront, and additional ones on demand
when a page fault happens on a memory address.

These mappings are created with the global bit G set, as the flags used
to create page table descriptors are based on __PAGE_KERNEL_LARGE_EXEC
defined by the core kernel, even though the context where these mappings
are used is very different.

This means that the TLB maintenance carried out by the decompressor is
not sufficient if it is entered with CR4.PGE enabled, which has been
observed to happen with the stage0 bootloader of project Oak. While this
is a dubious practice if no global mappings are being used to begin
with, the decompressor is clearly at fault here for creating global
mappings and not performing the appropriate TLB maintenance.

Since commit

  f97b67a773cd84b ("x86/decompressor: Only call the trampoline when changing paging levels")

CR4 is no longer modified by the decompressor if no change in the number
of paging levels is needed. Before that, CR4 would always be set to a
consistent value with PGE cleared.

So let's reinstate a simplified version of the original logic to put CR4
into a known state, and preserve the PAE, MCE and LA57 bits, none of
which can be modified freely at this point (PAE and LA57 cannot be
changed while running in long mode, and MCE cannot be cleared when
running under some hypervisors)

Cc: Conrad Grobler <grobler@google.com>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Fixes: f97b67a773cd84b ("x86/decompressor: Only call the trampoline when ...")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
v2: Bring back the original logic rather than only clearing PGE. Note
    that this means that the load of CR4 cannot be elided since MCE and
    LA57 cannot be set unconditionally.

 arch/x86/boot/compressed/head_64.S | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index bf4a10a5794f..d0f2c591f730 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -398,6 +398,11 @@ SYM_CODE_START(startup_64)
 	call	sev_enable
 #endif
 
+	/* Preserve only the CR4 bits that must be preserved, and clear the rest */
+	movq	%cr4, %rax
+	andl	$(X86_CR4_PAE | X86_CR4_MCE | X86_CR4_LA57), %eax
+	movq	%rax, %cr4
+
 	/*
 	 * configure_5level_paging() updates the number of paging levels using
 	 * a trampoline in 32-bit addressable memory if the current number does
-- 
2.44.0.478.gd926399ef9-goog


