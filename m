Return-Path: <linux-kernel+bounces-159359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 832528B2DA5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3882848CA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B0C156F23;
	Thu, 25 Apr 2024 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C9r6VEVA"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B3E1DFF2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 23:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714088397; cv=none; b=jJtWQSNgJpdNwI9HDnlcY+lQybb9ztx/Y5YkdBACIZHhLvVUV8XkpqxqU6niPf2ojbWS/tD5A98lmpg19vrUhx3TR1GRiT7+rTDObZXsMSChLaTgwxto2Grqhbtv6YV108gRk3PP6wTNFoueEgEDAq6S+1cSM6ISXgICVHMuRAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714088397; c=relaxed/simple;
	bh=AkCyh7cWOKmp5pK+B1CaZPZ44MY5XL4t5zGDakr0MqA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YT5tI48Lse7O/upnyHWl4yMArpmcF59Eb9lulP9twQSDtUR5FuldWFkCEFuKToENNcWAkXahUDuTYMth05g4YDVRix8ayNL7KVpm5dLluP97dqbxViEnMqaFTFHz+74EH94p6SyDXC11hRbdzeluT9Nk4D860dHWELD+QR6ChRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C9r6VEVA; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc647f65573so3698571276.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 16:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714088394; x=1714693194; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMRbfFNbJCNzsckpGMMH+pZKLS2T8rm0G9EjpmKb1aE=;
        b=C9r6VEVAdy7RzfzH6o3nRMS4N63yrvuoVNG/ao+xMWDah9Nv0BW5/cHYc6aWbR00KI
         sTNfJQ3e/kSf3M+UzEzzHSZou95kRNIYXRXgcAfpymBaMUX++LW77ZL9ScpIMrboRsqA
         hj755zowK3oXtSIuk43xEnhpNbrj2NmboY4KkXO4LUj4rV572Mxe0lXMv4Pp7DUuPG/b
         kvwKl6ILK/It8HDP+agN80+qwd+sTqqHyVm2Yj46XJHQk+DJ2C3Jw7df5WoM5eZSkwWv
         8Xnb6oGDY9Lq8qj9jk0+OEvDQRgaKAW2VtQjlRBtSc2E0l2paiI2WUxlp03rId8IfBdI
         Rldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714088394; x=1714693194;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMRbfFNbJCNzsckpGMMH+pZKLS2T8rm0G9EjpmKb1aE=;
        b=ENopSn+B+aJqulY13BSKLA4uE2nTdIEJkfUDXehRysVpApFnrh9YecYaX0e93Pyf6r
         v06igJh4s3JiqQmdw87VdynWhEVkP4/gi3rc00l+RVx7tHzlvV2nOwfHFeJVZvnxDXy6
         F3NpYfBFwwO8LbDLI/Bi8KLS5jLkzSJlNgMwcwINDzVIQX7Yzd13tdouicOVJ1o23WJb
         tBD4OjH4Y4C/4y1U5g5/pDNvJ27+p87QiT/fz7NPX/f4OljH25L8DEez7PZEPVFLtBU6
         6YEnZELJbHqHHN43fvtkyL9FFOq740rGkq3RIwKaX03K9l5o9UE80FESHHh0dYocEsxR
         DrRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnpMxHGGZwuMhqgUp+aGQLdrO6klkAh1zNnGXWovI8/1U/bjogtsLyNTtJSaQHi5cpf5TKNKXeWZZi34VjiTBdATyPUj6hXSnP1ttm
X-Gm-Message-State: AOJu0YxMj8DHi+VZ0Zp+d/isuyxPS8kYHGsB+Br7W4YorDex7EGrDQei
	HmGc/93YCyIqW0ht/yTH5W8Ke+PuivBRQn3chHvB6pwLSBJ5aoClMgrgvPxHuTsRD6gJy8HNemf
	6fA==
X-Google-Smtp-Source: AGHT+IFv/0bOPnuO/M3uRcdFnrVAA8o6Pc8//cgxoEjvcb1rTZaB9AbcU7AC0hZ6XYV2LKHdZbxX5QdY3oc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:154c:b0:dc7:7ce9:fb4d with SMTP id
 r12-20020a056902154c00b00dc77ce9fb4dmr324447ybu.12.1714088394229; Thu, 25 Apr
 2024 16:39:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Apr 2024 16:39:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240425233951.3344485-1-seanjc@google.com>
Subject: [PATCH 0/4] KVM: Register cpuhp/syscore callbacks when enabling virt
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Register KVM's cpuhp and syscore callbacks when enabling virtualization in
hardware, as the sole purpose of said callbacks is to disable and re-enable
virtualization as needed.

The primary motivation for this series is to simplify dealing with enabling
virtualization for Intel's TDX, which needs to temporarily enable virtualization
when kvm-intek.ko is loaded, i.e. long before the first VM is created.

That said, this is a nice cleanup on its own, assuming I haven't broken
something.  By registering the callbacks on-demand, the callbacks themselves
don't need to check kvm_usage_count, because their very existence implies a
non-zero count.

The meat is in patch 3, patches 1 and 2 are tangentially related x86
cleanups, patch 4 renames helpers to further pave the way for TDX.

Moderately well tested on x86, though I haven't (yet) done due dilegence on
the suspend/resume and cphup paths.  I ran selftests on arm64 and nothing
exploded.
 
Sean Christopherson (4):
  x86/reboot: Unconditionally define cpu_emergency_virt_cb typedef
  KVM: x86: Register emergency virt callback in common code, via
    kvm_x86_ops
  KVM: Register cpuhp and syscore callbacks when enabling hardware
  KVM: Rename functions related to enabling virtualization hardware

 arch/x86/include/asm/kvm_host.h |   3 +
 arch/x86/include/asm/reboot.h   |   2 +-
 arch/x86/kvm/svm/svm.c          |   5 +-
 arch/x86/kvm/vmx/main.c         |   2 +
 arch/x86/kvm/vmx/vmx.c          |   6 +-
 arch/x86/kvm/vmx/x86_ops.h      |   1 +
 arch/x86/kvm/x86.c              |   5 +
 virt/kvm/kvm_main.c             | 186 +++++++++++---------------------
 8 files changed, 78 insertions(+), 132 deletions(-)


base-commit: 7b076c6a308ec5bce9fc96e2935443ed228b9148
-- 
2.44.0.769.g3c40516874-goog


