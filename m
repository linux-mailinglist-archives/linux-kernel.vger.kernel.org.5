Return-Path: <linux-kernel+bounces-21626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E32D782920E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C321F2627A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C27B3D71;
	Wed, 10 Jan 2024 01:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xzu5YXqt"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E8828EA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 01:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1d4966f020dso21000295ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 17:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704850028; x=1705454828; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6w363icKNKqhEvrbPXdZyhOPYeC1XcMC/VyRfjkT0w=;
        b=Xzu5YXqt4hwzHeuanO6gNOdRAtU407RXVA/KCoapNa45RRXH2lFTuyLnc+q2mUYblh
         Vyj1dE5go+/m9I7I6LuX1qtkQ5i/VlujjEvZjsz4hKqo5garLoX1rHlGZHVVLKkgGH4Q
         8n6DUC36xw3u7j+EiLtSfRJkA9raOF4XYdtSHVdciWxAlLVP9R+YLtsrKw7RvHM3HIJO
         GYSMx242P2kSeaYnVTv6Gogo+mTko6T+NiejsD32qWcWj9AzYUgDmTbs4Q2UxBOigmka
         9b5Bdp2T0QD3/dtLSHObZ55W9Uptn0oqutoWq8317W22FXhEyH803vGOS9gW8V9vZ050
         M/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704850028; x=1705454828;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h6w363icKNKqhEvrbPXdZyhOPYeC1XcMC/VyRfjkT0w=;
        b=UhD7w9aMPtLLO/N/9rGzL+sXPct7lT75PJB7ao4VpDQqeakRdPFiowTS8yuBgE0ut1
         +A6K5TDgcpyKM0lHL46j5MHWhKbkf4SD+jUAsxbw98YcG76yl+D/ONGwrrF8W5I1++D6
         xZtUdUsBeUv23BuwPVMQ9L8ggoEwikfGGap0JwwG6UM1ebq5/69LrKQZaXX628oM5JOH
         xWvbBKqjZKz7U90AEWss9qqdixBuENY22rZf0481PxbMX/vypV+Qi8+HDusKnRVNKWKJ
         kmWfJKqEnaRJE+LUlug2YBaKe3FAit+d8UpuarMFMwDaZNxdWNvj96fE/QGSvYf/6SXQ
         HTgQ==
X-Gm-Message-State: AOJu0YzHOZ7AHGWY2cqczuJsrI1F801nnP21X2RYKHguuZZYtcW8W5lQ
	Wp5PeRx+Bb5Ngn5k98cdOOdax4R99UtILEayng==
X-Google-Smtp-Source: AGHT+IF+qgk30gHAynG24GncMt3bTSJdUq4PWyW2JAr7K680Sczv/++SAJGg7cxWbcYbgQizNvvkAw12PLg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:245:b0:1d4:ca30:874d with SMTP id
 j5-20020a170903024500b001d4ca30874dmr1365plh.9.1704850027825; Tue, 09 Jan
 2024 17:27:07 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jan 2024 17:26:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240110012705.506918-1-seanjc@google.com>
Subject: [PATCH 0/6] KVM: x86: Clean up "force immediate exit" code
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Plumb "force_immediate_exit" into the kvm_entry() tracepoint, as
suggested by Maxim, and then follow that up with cleanups that are made
possible by having force_immediate_exit made available to .vcpu_run(),
e.g. VMX can use the on-stack param instead of what is effectively a
temporary field in vcpu_vmx.

Sean Christopherson (6):
  KVM: x86: Plumb "force_immediate_exit" into kvm_entry() tracepoint
  KVM: VMX: Re-enter guest in fastpath for "spurious" preemption timer
    exits
  KVM: VMX: Handle forced exit due to preemption timer in fastpath
  KVM: x86: Move handling of is_guest_mode() into fastpath exit handlers
  KVM: VMX: Handle KVM-induced preemption timer exits in fastpath for L2
  KVM: x86: Fully defer to vendor code to decide how to force immediate
    exit

 arch/x86/include/asm/kvm-x86-ops.h |  1 -
 arch/x86/include/asm/kvm_host.h    |  6 +--
 arch/x86/kvm/svm/svm.c             | 18 ++++---
 arch/x86/kvm/trace.h               |  9 ++--
 arch/x86/kvm/vmx/vmx.c             | 80 +++++++++++++++++++-----------
 arch/x86/kvm/vmx/vmx.h             |  2 -
 arch/x86/kvm/x86.c                 | 12 +----
 7 files changed, 72 insertions(+), 56 deletions(-)


base-commit: 1c6d984f523f67ecfad1083bb04c55d91977bb15
-- 
2.43.0.472.g3155946c3a-goog


