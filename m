Return-Path: <linux-kernel+bounces-64212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7135853C03
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F740B21192
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE8B60B8C;
	Tue, 13 Feb 2024 20:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SGfjvW1/"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88140608FD
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 20:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707854978; cv=none; b=lfVWjqvWZughxb5NvvepL1Q4HdEcUKIBoVN8/3jqTYNv40ExXkexkdaCjC0f8WACPjRuyUvKvb3Ae4XMWyjPqOlSWC3MS9I2eP8FqizGgHhOv7S6YSf0n3MYfbUftzhr7D5p8Yk7Fy8kXAqdPg+D4nsFQieBkJb+lDv75aANKuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707854978; c=relaxed/simple;
	bh=tR3NgE9ir76bUwsYLYYZO/xphqnsujP3SZS+UmWN33s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BpQxJxoV2cwMCgbmnLIiUHGNoVF70xFEku1PfNMEqyAtvfZKLUhpc9t0ffWJdOfXXWx2N4Ibh8BGBzD3kRZMWN6j+ZPiS3AxMNZP1VLuNae4XWd81HkBLpJC1So1YOZPfnLnWPUWAXcpsmmDdh8sjBomCn3M8SrTQEupmezYHzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SGfjvW1/; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6077ca6e1e1so22563297b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707854975; x=1708459775; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VsrsF04rZWOWiU7r9GjRkleDZT0Ht16PcSvn8OkPl5Q=;
        b=SGfjvW1/gd3e1Oafga8mxoPO+loRcpRK72SUcbn59dSWEsmAfACwZeN1u9YoXYXAmd
         Us2t9PYclrqnMXWtGAuLNHnjwatn9FG+JdwkAACzaYnGHBeoTQnoKrffNuU+Ab6MA8eV
         7mCKtf6OEKLeRukX+g2jY1Dhg8uy7JwlAD+t5xl0BIgDHokjplwZSPCdX0syKfrqOOdd
         ksKIKH/tRqtZJdjanDYOl0YC4cIEeYyuVhjgPmcSrfbyEoVCR5XOYmxZXp0FBv8fZWAF
         Mjjh87plPhY9fVDntTPDbwAkeUvL0SM4SAHq7Off7ODC+msUxWt/YGhNbBjoF+C6xHrH
         CLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707854975; x=1708459775;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VsrsF04rZWOWiU7r9GjRkleDZT0Ht16PcSvn8OkPl5Q=;
        b=bimklq0zBGgcfkNCBAToQ4tZg5c5LuA0exGywKAgOVxwlWtMeiHp5kKZuKnUimBPDz
         41Eu/H6XOQmO54gnLnVm6VVT9xWd0qMHi7vTkfauQw2PD0/f8bUiawS6i3h30ctNjoqr
         zzUZWCvht9i6jUVI/hPTDvVhvTRohJNbFLadrKWzDgDR1hh8LppTXn0lSGLXagNb4NLJ
         qD0Ba84I1n9eU0ATNU9iyihvW4IzzHQQA/ac9Z1sWnVaG2D55VZVJcLLCqCasZr6H6Wi
         YxdaOoRod0S0jMr7KWa31q+kUAMGL0N9/iuP//ruMvEJWqMx9tkxS2gjtwkYH0O3v2/D
         Yr6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuCk730N3NgV/6ybxpFLxoL6e02uzl4kNkGU0rtOpqL9bJr//gWvtTGMtqcgHRiBqzCsN4C9MMXOeSFfHNX/dN3W2UaGua1v3WgBOd
X-Gm-Message-State: AOJu0YxMUxsDWvr/EHptow3nm3LKwLmTMCmi47m+O2bUlDe6/QFRFz17
	REVupraCXyXZbSTiU+tjWArkn/nNOg3PP76s5BoG8UppIH4Ca61TIQMxtVMoB+P5eNTHSxk7ipW
	A4n+DYLy7ogeaWQTDFA==
X-Google-Smtp-Source: AGHT+IHYJQSvG5V17xi8OnffS/v8heCb56A8nRdMQGEL32SIQ2AAcEiLmEEuizQgumtk+EffvkX2mZJfR96OSh5S
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a0d:cc4b:0:b0:607:814d:710 with SMTP id
 o72-20020a0dcc4b000000b00607814d0710mr76740ywd.4.1707854975517; Tue, 13 Feb
 2024 12:09:35 -0800 (PST)
Date: Tue, 13 Feb 2024 20:09:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213200923.2547570-1-ericchancf@google.com>
Subject: [PATCH v4 0/4] riscv/barrier: tidying up barrier-related macro
From: Eric Chan <ericchancf@google.com>
To: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ericchancf@google.com
Content-Type: text/plain; charset="UTF-8"

This series makes barrier-related macro more neat and clear.
This is a follow-up to [0](v1 and v2) and [0](v3), change to multiple patches,
for readability, create new message thread.

v3 -> v4: fix [PATCH 1/4] commit message weird line breaks and let [PATCH 3/4]
fix the form that can pass the checking of checkpatch.pl.

v2 -> v3: split the patch into multiple patches for one problem per patch.
Also review the changelog to make the description more precise.

v1 -> v2: makes compilation pass with allyesconfig instead of
defconfig only, also satisfy scripts/checkpatch.pl.
- (__asm__ __volatile__ (RISCV_FENCE_ASM(p, s) : : : "memory"))
+ ({ __asm__ __volatile__ (RISCV_FENCE_ASM(p, s) : : : "memory"); })

[0] https://lore.kernel.org/lkml/20240209125048.4078639-1-ericchancf@google.com/
[1] https://lore.kernel.org/lkml/20240213142856.2416073-1-ericchancf@google.com/

Eric Chan (4):
  riscv/barrier: Define __{mb,rmb,wmb}
  riscv/barrier: Define RISCV_FULL_BARRIER
  riscv/barrier: Consolidate fence definitions
  riscv/barrier: Resolve checkpatch.pl error

 arch/riscv/include/asm/atomic.h  | 24 ++++++++++--------------
 arch/riscv/include/asm/barrier.h | 21 ++++++++++-----------
 arch/riscv/include/asm/cmpxchg.h |  5 ++---
 arch/riscv/include/asm/fence.h   | 10 ++++++++--
 arch/riscv/include/asm/io.h      |  8 ++++----
 arch/riscv/include/asm/mmio.h    |  5 +++--
 arch/riscv/include/asm/mmiowb.h  |  2 +-
 7 files changed, 38 insertions(+), 37 deletions(-)

--
2.43.0.687.g38aa6559b0-goog

