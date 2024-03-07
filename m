Return-Path: <linux-kernel+bounces-95628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5186875079
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A5F5B248FF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83415130ACD;
	Thu,  7 Mar 2024 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OJ+ITYrC"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C7612FF6A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818760; cv=none; b=AfqxxkHIGFEF5wdwpBR4JOF2NVPJXBs4MH6YW4rl4ltmNIo3gAMEem6mluFhbGKdKoF31QTfmFiBsV2ValEocaHqG5a/iTiAshLf44Syx3jBPB/FsWP1MytuTSkBY5sDe9kq8vkLr8/btNSwQOBCmCpj6KCxduXXqBvwfgqZf2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818760; c=relaxed/simple;
	bh=c2OKAMNZCThzabiJmv5Pi+bnNNIpP7Q6TDnNcYxjfmw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hiBqqkdpqsvNjsZ4U4aHBnBYB2X8Ro7tAs19KlPHwBwLeysvAihX/CgQw+njyDAiWrewNV9iqsL4zPFiig7s+/5gY3udHyfWnXUKFy11oR/vdHr2bkWZSEh+CwWmqm5yUOeebh3UuSedrVQe6EntexovicyRX6KmcOIn6ZvRssA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OJ+ITYrC; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e65140764bso722890b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 05:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709818758; x=1710423558; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E/SwFKeyu0Cz8CMZ9BY5anwy2e+f+qNiUH5wmPNWioQ=;
        b=OJ+ITYrCOFdA6CnMme1n85cjbcjsjbzcXLaBVXLjAQVDKPSYch08kbDbxGPbJ1gJcS
         S5zCtkbGCvzRObQYyC3nGl5MnHE1Ve5itZS6Y/Lp34Ka0gW2SPrwozJFq9FhvlHsc8E0
         BNq8oRiKBXT9LMq13sjhpzJd5mvpnAxBoCrDJIEBZSBP3PsxgFElIWr3igRSrMZZr9gF
         l+10LV5U/10MNTZlMWHRJ/teOz8ERBNYMDCMVwIjhFT8KCj8I1ngl9CiRIqDI+ANCspa
         akOiYKlle7esym9GL/78fBIUo1S48PpZJievYkRnwvlbonKPSNNrmVUsWBd7Kuqeg0sA
         Y52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709818758; x=1710423558;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E/SwFKeyu0Cz8CMZ9BY5anwy2e+f+qNiUH5wmPNWioQ=;
        b=opXYd+o0ZF67B/Aa6ZPvu9vDdBB8JTKV1uhF9BG2Hv5skRTbWag+ZZpmf6yYUsOeqG
         94a0dBNVcYcnwWrE5nfN5biocP4S95dhCYAVRVgB0qEktmp+S0orQFPZHUqq/lu4/kFo
         HlOZjOyYV1+4mZzmSKpQPdsQ6s+N9VULAiNIcjmHaR9Nz/MfoqFucZH4UokF9Wq0NwJn
         ztwRuRzBZdn/IVTSj1EmXU9ZW87FSPlnbEM4Lx6Sait43JmRs/BJTAqMBmpOR2D3ZSsm
         EkdQjdQ55a+Wy0oAePCz52/uSSQbxHttMxn3B+jVpXXu+OGJkOceznGyuekYZ7Vuq9ta
         ISCA==
X-Forwarded-Encrypted: i=1; AJvYcCUP7IErLHwG3EhCKsdT1b3jPMTwE4B1QmgS4WmsToAUv3vn1C22S7zrh0Nl4Xfy6dOm9OHTH6JmnJpu9dBcl0vFKE1byRUvqXV4WYFd
X-Gm-Message-State: AOJu0YzNCRp/s5+rbYp+a1AMxtGFAhZAGhDWNUYKTEKr10qbaQkrV7Fp
	vL9UFUMYLEL02VeeC/fAsBU81U2ztuxwI0J96YlVxd3S3y8bV14igS96lpBctdp7uBsIvXLuPnr
	AuQmCiSlKfInrgSsHHA==
X-Google-Smtp-Source: AGHT+IHz32782uRcDUcjLPEeb4P9whM7yS0F1jXCrHQfOc8Iv8MUgbMLaj0L1l7I93tNctD9q6p/q1YyXxJnzp/O
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:1796:b0:6e6:4946:93e3 with
 SMTP id s22-20020a056a00179600b006e6494693e3mr154496pfg.3.1709818758430; Thu,
 07 Mar 2024 05:39:18 -0800 (PST)
Date: Thu,  7 Mar 2024 13:39:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307133916.3782068-1-yosryahmed@google.com>
Subject: [RFC PATCH 0/3] x86/mm: LAM fixups and cleanups
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andy Lutomirski <luto@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

This series has a few fixups and cleanups for LAM code noticed through
code inspection. They are marked as RFC because I am not very familiar
with this code so I may have gotten something (or all of it) wrong.

Yosry Ahmed (3):
  x86/mm: fix LAM cr3 mask inconsistency during context switch
  x86/mm: make sure LAM is up-to-date during context switching
  x86/mm: cleanup prctl_enable_tagged_addr() nr_bits error checking

 arch/x86/include/asm/tlbflush.h | 11 ++++--
 arch/x86/kernel/process_64.c    | 10 ++---
 arch/x86/mm/tlb.c               | 67 +++++++++++++++++++--------------
 3 files changed, 48 insertions(+), 40 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


