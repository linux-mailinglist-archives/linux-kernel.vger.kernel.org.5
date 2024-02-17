Return-Path: <linux-kernel+bounces-69863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 937A9858F99
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4C6282771
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B30E7AE40;
	Sat, 17 Feb 2024 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Atn1h4Tg"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8997A727
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 13:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708175537; cv=none; b=P0YWVgc2NoTpCGayWRcYIlVTVm/F36zhprQNMBXqjC899sQPUIaQpbkDlK6rGASe1+8cZrzRQhIIcjmhCUnuwZJWJEEWVTmnTSQvHBO8YWAarH+GyDV78K+Ol49tap7NlOQiTNo3FSMbDQXLk9VWOSLWOPaTj99aUbBAfAxWGkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708175537; c=relaxed/simple;
	bh=e8YtcTkiR22ARuwvhZBlvLvdaQ6We5XuoB+1j3JQdew=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=d3KglJ9f7cgbKsMmpKFrdEaQJOcfpwe9K751PoQydFwUfcTFe7AznwVyo7FsAo829MPNevoSoMRdMhSwzQsdGsLBZw7conS3SnmfGWwGbwyPlGvWC6DBfSF9hp0LMax47nXWea/d3dy9q9aU7u3TYCG7xzDftwc1SGmHe8GEy7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Atn1h4Tg; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6047f0741e2so45225477b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 05:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708175535; x=1708780335; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7Y1uJckyCc74lkL+D8dqAJTUMUo19CtOARoN2IZ1m/k=;
        b=Atn1h4Tgaa73v6Wg6XR2Ncfz39GKLXlIr+WQzo7OmItDeuu75KFFS3nEbGnpRWfDQP
         faYbw6Vb4UFWA+Fa0mwLjDpQeLVFzQtLhaQAAEIB3zB0jLNOup0qbRuEDaTiQAuO3IhH
         QLeoNRIe6u+Kq8WYpSeramFFatKgldEliseaWhkQ4g/NUhv+CHmqSj4oP4ZSuZXCO8eB
         AeVgMALCj2blm/heb6bKUDtknWEx7LPu8R2KPvdZpzlmHpnSU8V3mgYaC1vz+PEJ9VqX
         YuYS15dlZDzzkISo/mjZMyediGgnDkbDBTJ7CdtrUDCiS40j46r3U7BH3N2AhIa80fXA
         dFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708175535; x=1708780335;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Y1uJckyCc74lkL+D8dqAJTUMUo19CtOARoN2IZ1m/k=;
        b=HRgr86hyL5o2ntmlk0qTKwk+7b7OkoUI9s5k1Xem03jJoxOuBHDGe/M6cezlRU+fiz
         /QYOLH9BQUZpky7S9vsh4pSFb3Hu7CtvXaDb+CfcCuLHLIlKfgRu6cmOGZd1p27YQ2Nj
         sXlEBWrs4w+NuH3xWM/dSPpsYRZe414UBr5nYhne+NjJUIWCEC+TzzNq3y2Befr6Vkta
         vFcnAOKIOCOKwtYpF9aWAYs1WvUbpAziov5awqrNd/flgWQQzZ2bnbkFffAJZlNyNcV7
         3Xcdv9vBlhqNLCwDS+I0yyYEQ4aoSNs3l8FuQrtApvJFqimQbSO8Wef7z/X2rbIZH6k2
         jprw==
X-Forwarded-Encrypted: i=1; AJvYcCUFAmydzdHVopXU4+m0b8XfQM2MXNPODWzTlia3hWv3P0ncABT2ywoOkaLQsi1UwBLWMMuijUd4IGiPFBXWR9WLzus8rKJplTRLmm3V
X-Gm-Message-State: AOJu0Yw81+8wE1LwQA5N4VDlEX8M1u2IfaplQWUyg2RYNkBASkNIzwk2
	cWfOoYk6wvSkyrzxVTiXKrk/DJP3gdEwCOSw4lo5RhN5IQnpdiKR3qLhb+IshTgmG98tm/aWPRT
	tFDKiJNFevD88Kmxiag==
X-Google-Smtp-Source: AGHT+IFG1QKXCRYE3QDVEhwJ1Zd5YdQyq+jmIVuddElh5JrY0hnwshQTWnUXE95EiHw44yO6XBfa8LkHcb1X3Gs3
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a81:6c88:0:b0:607:8358:1a3d with SMTP
 id h130-20020a816c88000000b0060783581a3dmr1158404ywc.6.1708175534909; Sat, 17
 Feb 2024 05:12:14 -0800 (PST)
Date: Sat, 17 Feb 2024 13:12:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240217131206.3667544-1-ericchancf@google.com>
Subject: [PATCH v6 0/4] riscv/barrier: tidying up barrier-related macro
From: Eric Chan <ericchancf@google.com>
To: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ericchancf@google.com, conor.dooley@microchip.com, parri.andrea@gmail.com, 
	emil.renner.berthing@canonical.com, samuel.holland@sifive.com
Content-Type: text/plain; charset="UTF-8"

This series makes barrier-related macro more neat and clear.
This is a follow-up to [0-3], change to multiple patches,
for readability, create new message thread.

v5 -> v6: [PATCH 1/4] let this change to pass review by checkpatch.pl
instead of overwriting again in [PATCH 4/4]. for [PATCH 4/4] change
the error message example in commit message to make it more relevant

v4 -> v5: [PATCH 3/4] __atomic_acquire_fence and __atomic_release_fence
omit-the-fence-on-uniprocessor optimization, and fix the typo of
RISCV_RELEASE_BARRIER when spliting the patch in v3.

v3 -> v4: fix [PATCH 1/4] commit message weird line breaks and let
[PATCH 3/4] fix the form that can pass the checking of checkpatch.pl.

v2 -> v3: split the patch into multiple patches for one problem per patch.
Also review the changelog to make the description more precise.

v1 -> v2: makes compilation pass with allyesconfig instead of
defconfig only, also satisfy scripts/checkpatch.pl.
- (__asm__ __volatile__ (RISCV_FENCE_ASM(p, s) : : : "memory"))
+ ({ __asm__ __volatile__ (RISCV_FENCE_ASM(p, s) : : : "memory"); })

[0](v1/v2) https://lore.kernel.org/lkml/20240209125048.4078639-1-ericchancf@google.com/
[1] (v3) https://lore.kernel.org/lkml/20240213142856.2416073-1-ericchancf@google.com/
[2] (v4) https://lore.kernel.org/lkml/20240213200923.2547570-1-ericchancf@google.com/
[4] (v5) https://lore.kernel.org/lkml/20240213223810.2595804-1-ericchancf@google.com/

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
2.44.0.rc0.258.g7320e95886-goog

