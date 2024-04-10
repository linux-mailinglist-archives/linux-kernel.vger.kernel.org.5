Return-Path: <linux-kernel+bounces-138322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75BE89EFCA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 519B8B23972
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47E7158D97;
	Wed, 10 Apr 2024 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1jS7ZVIF"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E80156C67
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712744748; cv=none; b=MljFqi4a9UJixquAdbrxOH5nIenCwkMjnL2z5p0u8w0/bNpCiHe5vgJUhf2QyaWbfNFTD/j7N8DuFN2OX4eEtZOVwrY9SyO62sGVZEwARR8PAOF8davKXrT8RdWEH6XNq6Wb9OF2sWtPl4gIpWYzrHuoEaacqrN98JwF9auXMMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712744748; c=relaxed/simple;
	bh=PCMdSvFtY3rDm3A9CAC1ALIpi8flVwwNodKyquoqCr4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EOxa85hcOJzVRCOUC3lBhKdjG6JmpqpNaBoe0POxx6SzVbIVHohIOEfSkA65g/5Lu9CBJz6ycfycshulUzQA+kOr3rzzLprJ4E8wOp2sx8WCZiA/Pz/J3d/Ucs+RGrguPmvzGya1dSMtrE6SD/t/emTL+LiqwfASrwUXbv1z9h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1jS7ZVIF; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf618042daso10041116276.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 03:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712744745; x=1713349545; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D32KlsXB0U06JQUI7KQ5Zb2EQvn1d66bt3b3ZOQhRzQ=;
        b=1jS7ZVIFSAvfIPrzGs25iH2fHqDDUBY6PBpuIuENgpm0oFi9ivOTyCoYhLf6VH0wgV
         VBPE3KXgoz6XRAtHbGLTHfhjSf6Cxvwjn+7VoXV7otiVmm86TcCc6wLcH14MOMdBxXEH
         tbLFcf2iXvTPn39+6c4vRLIladie0ANDudmcJNmIpbrLOxjzdw1Bq7CkwOVtfOaRkSg8
         ynnzd3iXKn/ecLTgoV59zjM8/mkv8CtDMcig7NwdAbE4kf7Uy1Uy4ygJrW7zh3xMSGFs
         cG2xNVm8cngrqHDH2o72JHciLhN8LEHcfMno5xI33wBICDBqXCrDJAqIsNyeB6LllvY6
         kL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712744745; x=1713349545;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D32KlsXB0U06JQUI7KQ5Zb2EQvn1d66bt3b3ZOQhRzQ=;
        b=fO7ub+pljKAoCv3a16dZBvkABVHMVhnfW+FA+/J0pJTJhHqmcsdlfJbw/MDx1jhP3k
         l8bTRpxFmZalu7mDYVOvEVRrFgkqsfzIgQ1dP/4wvTGv0dCdAgkVhO9gbLMoQHjys2d7
         5R+5lA+ejP61e3dIk4MGCt6tSnTiortyl7ajRtHEIMhyG8C6LDBfR0BL8gMmvbauGTCE
         9pNWa7n+n73e2fN2L23eA4JN2uR7EbBQAsHsFFkM+4XJgypwCEfadKDbwKxPG3cbTrVl
         Y7yHkx/32hX9uWbgAYxL35EgEjB+q/V98OB1Os705lu0481oWYzcNGEdUx3/N/2eucSK
         I1sw==
X-Gm-Message-State: AOJu0Yyp7kHmUWtG+1SZjAFk7yg9Dg01KgR+Ns5n/QpWQDYFk4A46eO/
	keG8g2MT8C8vxIIbhup9W0Woqkq5GMTDIaMBNhjClBRi69KBC2HdTZWg4jTtlXP5uCuaayhgnfk
	EcLm4kn8EuHfbn5ye8+EZg0YxwwVw8FwjCldUoqjjRcMKfDUP6I9FSau12yn2wz3WYBMW33QJ5A
	h0ir1lIXnAvPu00duSNuXUpVBz2gcSUQ==
X-Google-Smtp-Source: AGHT+IEKfTEa+K+c1PU5y7XLn/QPQCh4TW3ix8hZSJH1zsFXz4ZC0qqUbVlA2QkPx3N3+ywEFVmfyhld
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:f87:b0:dda:c565:1025 with SMTP id
 ft7-20020a0569020f8700b00ddac5651025mr235340ybb.2.1712744745486; Wed, 10 Apr
 2024 03:25:45 -0700 (PDT)
Date: Wed, 10 Apr 2024 12:25:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2254; i=ardb@kernel.org;
 h=from:subject; bh=zQsBnOz1wPB5LEkXR4ZUynLq3ciDRoPJ4laUTIEmJ8U=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU0sU1DdyfP0iinWbtM/n5FRnam/Z83uUx4Tjuj235zwv
 3B3S8+fjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjAR/xmMDM/13SPdhJ+en8Pw
 KmXbyejAVzxr9gbdKJ1dL3haPe3BLEGG/w7mFtYdOTNkRaqOvPKyr41bx/br2YtNCVtD9OKPWU+ NZQQA
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240410102520.348017-2-ardb+git@google.com>
Subject: [PATCH] x86/boot/64: Clear CR4.PGE to disable global 1:1 mappings
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
known value with PGE cleared.

So clear CR4.PGE explicitly in the decompressor before switching to the
new 1:1 mapping which uses the G bit.

Cc: Conrad Grobler <grobler@google.com>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Fixes: f97b67a773cd84b ("x86/decompressor: Only call the trampoline when ...")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/ident_map_64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index d040080d7edb..e746bf2efdf7 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -179,6 +179,9 @@ void initialize_identity_maps(void *rmode)
 
 	sev_prep_identity_maps(top_level_pgt);
 
+	/* Disable global mappings */
+	asm("mov %0, %%cr4" :: "r"(native_read_cr4() & ~X86_CR4_PGE));
+
 	/* Load the new page-table. */
 	write_cr3(top_level_pgt);
 
-- 
2.44.0.478.gd926399ef9-goog


