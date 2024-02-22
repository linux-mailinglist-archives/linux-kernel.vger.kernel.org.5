Return-Path: <linux-kernel+bounces-77214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B829860237
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AEF41C269E8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936BA6AF9A;
	Thu, 22 Feb 2024 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K+Kfykx9"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AC72575B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708628793; cv=none; b=IQ7vuKymfPVrkZIpObS7yINzrjjdDnaEAByuNo/26nF0wnqTTvfC1+zE8qY/MwRrVSxoCaX9oeZipI6O5Mwz4fw0dLCfwt1Wd+yNxKAKAqzhfH8C74GyQlEBipDp/6JAiFRfEq5NK9n/EcfB1tYQBqKATX7em3kNnDhNN2gWXZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708628793; c=relaxed/simple;
	bh=nieUYnH4dj1j92uddbXN4kJMJyMCVisTdazPsZdBPn8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VpzpsMllXL3mXuabaFSP6z5X26tZNcIbwBcf2Z/VdiOuSlqY8YCFhLdKl1g5wYiFmF3e99LonCBH1ZDsb4FvJnG+HOK5BDK1Xeyh+braEKsYdbRFUh6+cr4E+pXuuEeeXPsfyhP5E2T/MgezL7gyflr4IHsZp/Iv9JrRmB0pS6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K+Kfykx9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6085e433063so1143317b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708628777; x=1709233577; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3ntMGhr684dTjFjW5K9N11e4M8SUGzq3A8ac/2w/QBo=;
        b=K+Kfykx9Hq+ykAkYNd4G4I85Sjt9YcnQ4siJNsHr2te3tcKrZdZllffe8rBFSIkLGd
         BDQ/C1Ay+W8/Tz91cWU6OofJ1tfDPEY5XDXXst0d/jsBYrT65Pnp5H+z4bYxI2aoaFD5
         w7d8Dcz7zTbdxZMQs5bzoVTeLyRO0dqIlL1ZsKo86ueEB9bDD2E3QFR9mlte87HADtBt
         aKzT1cX3xQN80xT53oxMNGPaDp2KDzNKfovzwIxbz9JKm1iNQfgK5GroprazRUXK2S8j
         VqBeCRPvPa2jRrfFbvA7+bW1R8O8qSUF77rm24zvjQRIwodF8TFWc0vaBXMzLoARdZ5U
         RNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708628777; x=1709233577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ntMGhr684dTjFjW5K9N11e4M8SUGzq3A8ac/2w/QBo=;
        b=Erp4FM6I2j25mWuWkQzsp5k/6K2JK7O6eYak+QXaiKI3fHTYI61LBp/7qwxL4DkG7U
         W79sLXLSn5S/cBYJSwuzk5U22WubeurA1u4TvXMiKt2fRJMLconLeqv87agNZCfjxcH9
         hZ3z13IaqLU9Y18G9bxkIwM36vfigTDxYplik5o61/snJ4iVT0LA2RZBa5yhROqlbtIT
         m86qE2v+gsiXhuZwRHVhjH5u5VGUDUtuqbz35+/Uc788nL4j22I9keoAM+1tBQPH9QcO
         y9SV0rm3P6USH/Yd3L07I27QfQrZQ4YF+znlRJ4sXKmTxmV/8bPYzIo9LjT3iS9wImGE
         OAbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWa+CsObYUvdhQ//WeBsWBOz5EbDx/2UiMTw2v/kvaEUrLryWpllGa4bNpJ3SX93z8Fov1ynyzujZ4pw0vFYK6wsrHFVFW9F61vi5e6
X-Gm-Message-State: AOJu0Yy9r5KOego5Thopr5kt6qeJ6rmvTDINgdHqanwORF0W+OjjU/bE
	p+Zg9qz1MjIRvE9r7vh2aqWPp13kYAzDP9YZkIfauARwTFpqFsDIC72RH17AgMKefHhmZtqLM2+
	Ofw==
X-Google-Smtp-Source: AGHT+IGJTwZNTDdlTJ5vrQNg9sqTJ09fKYXStOw2msJafDEAYLjbX78aWrh79pmG9gxDUQhCFn+wShlhb8g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:160b:0:b0:dc7:7ce9:fb4d with SMTP id
 11-20020a25160b000000b00dc77ce9fb4dmr5036ybw.12.1708628776828; Thu, 22 Feb
 2024 11:06:16 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 Feb 2024 11:06:08 -0800
In-Reply-To: <20240222190612.2942589-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240222190612.2942589-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240222190612.2942589-2-seanjc@google.com>
Subject: [PATCH 1/5] KVM: Make KVM_MEM_GUEST_MEMFD mutually exclusive with KVM_MEM_READONLY
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>, Michael Roth <michael.roth@amd.com>, 
	Isaku Yamahata <isaku.yamahata@gmail.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Disallow creating read-only memslots that support GUEST_MEMFD, as
GUEST_MEMFD is fundamentally incompatible with KVM's semantics for
read-only memslots.  Read-only memslots allow the userspace VMM to emulate
option ROMs by filling the backing memory with readable, executable code
and data, while triggering emulated MMIO on writes.  GUEST_MEMFD doesn't
currently support writes from userspace and KVM doesn't support emulated
MMIO on private accesses, i.e. the guest can only ever read zeros, and
writes will always be treated as errors.

Cc: Fuad Tabba <tabba@google.com>
Cc: Michael Roth <michael.roth@amd.com>
Cc: Isaku Yamahata <isaku.yamahata@gmail.com>
Cc: Yu Zhang <yu.c.zhang@linux.intel.com>
Cc: Chao Peng <chao.p.peng@linux.intel.com>
Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index eb0dfcd157f4..0f9f78f4f7cf 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1617,7 +1617,13 @@ static int check_memory_region_flags(struct kvm *kvm,
 		valid_flags &= ~KVM_MEM_LOG_DIRTY_PAGES;
 
 #ifdef CONFIG_HAVE_KVM_READONLY_MEM
-	valid_flags |= KVM_MEM_READONLY;
+	/*
+	 * GUEST_MEMFD is incompatible with read-only memslots, as writes to
+	 * read-only memslots have emulated MMIO, not page fault, semantics,
+	 * and KVM doesn't allow emulated MMIO for private memory.
+	 */
+	if (!(mem->flags & KVM_MEM_GUEST_MEMFD))
+		valid_flags |= KVM_MEM_READONLY;
 #endif
 
 	if (mem->flags & ~valid_flags)
-- 
2.44.0.rc0.258.g7320e95886-goog


