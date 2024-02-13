Return-Path: <linux-kernel+bounces-64467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7758B853EDD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2CC328633E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54107627F2;
	Tue, 13 Feb 2024 22:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NkWdNEBm"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF5E12E59
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707863899; cv=none; b=QfJZe524UILatJCrdmrz+tKHwQLL8+CUSKDCuOloGa58bbrq4V0OA+EQuuG3rW8H7SAtJY8jAxYPdx12dJd9qg/oU2JTFXQLg/jSAX5AHyJF09QvnSKQExfS4EIb+fZTGvBctfnOwLDq3iBD4g4iLMdVL9/in54kEYtiAFp57Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707863899; c=relaxed/simple;
	bh=oETUawuU8yy1VJ9yIj8p2lHOiphBiJDo5LBjLpJt1UY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JJwICBhNMdtvEH/G02rTPpfogyh2MuWDAo4kzFOh/39pGyZtkQ0sUPGYYAchvXtK9V42oqFTG0zWN39vNScYwS17P6D9thPfoMTVcbGpZQmZbJunJmDZcdO2099adXlwQ2ArKlkQVvXx7rGqlQMGu45kStqqtXqZgKbBEaLOeEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NkWdNEBm; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so3920889276.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707863897; x=1708468697; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CfHqPDKZSILy8wF93jY+PBQlYR8jUuDqYcw6uvluZVk=;
        b=NkWdNEBmy7OYy/QwFHIc8dAJn3I96dcGV6I7JCvl359xNNpUDKFxliZ90yklDS2CM8
         tfeAbG6pK3YwW45vloipkKJEGV1ifmkDzozwr7H5rTIpMm639aSuNKLd+/KpwA7yfW3X
         cy4LrAybGUjee0ZxUo9nKgZ8IuRYIWa3g+OconjwG03LY4rzO28APtStyJafilJWyJum
         pRu6ZbXPeDpxE6xLrh9dyg3whyS3S+9+gk5glQCtpFEUwtsi76O6My+ivBXEcwYTijl2
         SWCdE57LLXiZk64K3n3UFEzhZdAd0VyoftWG8NWoaEQLh5v2zWlATBFHzqpiN1RTw/Uq
         v1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707863897; x=1708468697;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CfHqPDKZSILy8wF93jY+PBQlYR8jUuDqYcw6uvluZVk=;
        b=WKbzuWB411H0/3OLyDhXO70gXaJc2FZ+5DXhfEOn16xRa0YggjSr70sGAHO9DrXW7c
         UA1tlkjIcEr1RIEO1CIxov2fOVSUVqX8x3HZ00R6dViccEPM326a1ubwD3CsSc57bibN
         bFyEF8eoh0uJ4PsIpC1p7jlC7ax3fQGgzuaSwhuZG9As9OJ1cfY7cr6jzaHbseXyjW1x
         yYIBC7HBPpdtOCFOndIR01YE5i8yzYllCo6KDvvgH7cMu9n74TWoCviKrjipHrCVDGjf
         8qE62ooI0CKuz+1ubzceu0GKXX8ejpUcP1s8iT2Fy7ZPiLDVtCi3GQGAPBotLfWglc+/
         Y2Xw==
X-Forwarded-Encrypted: i=1; AJvYcCV+JNDIEqIo4wyyZ1wqvmIxjpERpksYhD6CfxU4UEqn7EK3I2l8ms76p1SH3Uj3XjO96kjqQpqexHPXiKcJIH33mhMuxBCKFyxnP7Um
X-Gm-Message-State: AOJu0YxlFhYN/QRjUfJP1DDFPiCfs6o5J1Hi3r23vzFuz5t4onDqIRTE
	n0yjXMzNpPTuzSpme/rGyUkRsMb2PNB3niFIHWERPQTsOdvupWs5cCBeWlzKJz3hdQiaTfgwG6I
	qDouM3ttm1Bf494e7Ng==
X-Google-Smtp-Source: AGHT+IGYHWVD+M6IZDD5yA/7KbHciMkZjoVTii4uO+v/Mq8hqyWAFUVfE50fvfODJp7k/KiJOvBIsrCx/lHz03WK
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a05:6902:1007:b0:dc9:5ef8:2b2d with
 SMTP id w7-20020a056902100700b00dc95ef82b2dmr175464ybt.4.1707863897101; Tue,
 13 Feb 2024 14:38:17 -0800 (PST)
Date: Tue, 13 Feb 2024 22:38:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213223810.2595804-1-ericchancf@google.com>
Subject: [PATCH v5 0/4] riscv/barrier: tidying up barrier-related macro
From: Eric Chan <ericchancf@google.com>
To: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ericchancf@google.com
Content-Type: text/plain; charset="UTF-8"

This series makes barrier-related macro more neat and clear.
This is a follow-up to [0-2], change to multiple patches,
for readability, create new message thread.

v4 -> v5: [PATCH 3/4] __atomic_acquire_fence and __atomic_release_fence
omit-the-fence-on-uniprocessor optimization, and fix the typo of RISCV_RELEASE_BARRIER
when spliting the patch in v3.

v3 -> v4: fix [PATCH 1/4] commit message weird line breaks and let [PATCH 3/4]
fix the form that can pass the checking of checkpatch.pl.

v2 -> v3: split the patch into multiple patches for one problem per patch.
Also review the changelog to make the description more precise.

v1 -> v2: makes compilation pass with allyesconfig instead of
defconfig only, also satisfy scripts/checkpatch.pl.
- (__asm__ __volatile__ (RISCV_FENCE_ASM(p, s) : : : "memory"))
+ ({ __asm__ __volatile__ (RISCV_FENCE_ASM(p, s) : : : "memory"); })

[0](v1/v2) https://lore.kernel.org/lkml/20240209125048.4078639-1-ericchancf@google.com/
[1] (v3) https://lore.kernel.org/lkml/20240213142856.2416073-1-ericchancf@google.com/
[2] (v4) https://lore.kernel.org/lkml/20240213200923.2547570-1-ericchancf@google.com/

Eric Chan (4):
  riscv/barrier: Define __{mb,rmb,wmb}
  riscv/barrier: Define RISCV_FULL_BARRIER
  riscv/barrier: Consolidate fence definitions
  riscv/barrier: Resolve checkpatch.pl error

 arch/riscv/include/asm/atomic.h  | 17 ++++++++---------
 arch/riscv/include/asm/barrier.h | 21 ++++++++++-----------
 arch/riscv/include/asm/cmpxchg.h |  5 ++---
 arch/riscv/include/asm/fence.h   | 10 ++++++++--
 arch/riscv/include/asm/io.h      |  8 ++++----
 arch/riscv/include/asm/mmio.h    |  5 +++--
 arch/riscv/include/asm/mmiowb.h  |  2 +-
 7 files changed, 36 insertions(+), 32 deletions(-)

--
2.43.0.687.g38aa6559b0-goog

