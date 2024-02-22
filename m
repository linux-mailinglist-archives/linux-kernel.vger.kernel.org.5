Return-Path: <linux-kernel+bounces-77213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 418FA860235
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBBFA28B3EA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7DF6AFB9;
	Thu, 22 Feb 2024 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wZn7f9Ul"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1B214B826
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 19:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708628790; cv=none; b=ZpzNttRv0XlkCIhsD5nZ2cSnrka9krGyu8uZtSHvuXs8PtM72IFjMaEWy5bq18+ZRGzvBZmoBmobMKStqGslk67b210xrRAKLgKKeZf2e/C8bNXjUSLOnzebMKghwZ7TpmTl7CPE8XCnLweMaeBblx7KGfPXo4DHqZJ3y5P2jVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708628790; c=relaxed/simple;
	bh=odNY7brJIrKGXbB0NYiJ5L+h7CgQvY8SV9Jl9b0OOjY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XAsFj6ibnsBGaahMFFOpZk55jfiNNEF/OzFlnJwVdJjdsbbFc5pzlPwEOHc2WyoEUt6HNX6AozJrzY9EQFhKL+cr0hhmLrY57A43hbiPzrOZAcFXj12qd2NZnqD9Jt7t1m/5NZkFN9TYdjofHCW/Di4LyLj0sAyG5SwaTdCLWDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wZn7f9Ul; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608835a1febso1122397b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708628775; x=1709233575; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gezQaNgBY+02TfMTErrgdnbl2WvP4PLw6JtipxuzYjc=;
        b=wZn7f9Ulwa8lz+F9+JLUaDfFrwei/yIwTBvuUvoMq0d7YuJPdppEu9SwwJPVZI+Hhq
         na4d9CdagPsmZjkuOkCgcBj1jGBrfKN5T6PlCXmc8Nz8+gB0jGaCVzBDydhgkWFwHaBp
         qjeTmxyOtpfQ/XKXCFSXbmQH8KCjjQO8FGZZOfplVJIzOVOWpISJEnT3GBDpNS6bg6Fp
         vfe/8sbKlyfhMHUi1nzQbXxhW4uFusdUFySsbgpibajamP3O0vqcIk2eCRN6DV91PJt0
         OgmURNpREm6RujMWlWR354cLHCsXxPCB6Hx5UQqJtNX7QioyeJdBp6f7iEi9AdkFpPUW
         x/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708628775; x=1709233575;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gezQaNgBY+02TfMTErrgdnbl2WvP4PLw6JtipxuzYjc=;
        b=kYGUt0w1MXobsdJn8MRfYpQ+X334rBRV/9/QbSufAhPBQXFgejJ1Inn4xFOU6kvadY
         FV2+h3IzyB1MBwskxzMrAPHn7qIZ6aVoc9nXS7KVibE4axdWDrWi2HtGDoa7a9AwnbPz
         w8aSrtSmxBzOMaJQsp88dgLJXR/iQ6/lIckHf83zPOauuPj8scfbqfvcmmPCC5khiTDT
         Ig+ep0lZYqFT9XPmor0A/bQEAPf2uukmWs3v3Bn24NhV6AdlC0BivL4SFAwWoa25jiHw
         3M2GOX3ZJpfqtmUdvvoDLr7T52AwasRxyxwp8jvKZmL8P1mJfJ8NRpLX0Cf7QCkumIOC
         KpUg==
X-Forwarded-Encrypted: i=1; AJvYcCXVhixsuPtALJx4K93ghFGcEY6nSLBGU5h0HpB3/My2mbZUZod3eIX461J+IO5CmZ4R3T/TsgZ10HGnayRwl1wpG2Y6Gzw/qpX+N2uR
X-Gm-Message-State: AOJu0Yx+Hy6TtzPrg9a+JrrNuozgRqV7OZPC9qsSa/4M5hrFixEV0sGy
	egEpXz1bhu5zHhZXaX7mDILEJgvYVZKzdWRASpAx6zWvLFd0mCicjP0KlgP81IuLcBa0TcTIOh9
	ECQ==
X-Google-Smtp-Source: AGHT+IGCEmm+bR6WbX74vZG4JukfcdEsqNN2Vrq+SSgVOGsL202tIGvg4gu4PSMs3fYUVbQ0dpd+lDjh9PA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:eb44:0:b0:608:4e77:9397 with SMTP id
 u65-20020a0deb44000000b006084e779397mr10627ywe.2.1708628774709; Thu, 22 Feb
 2024 11:06:14 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 Feb 2024 11:06:07 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240222190612.2942589-1-seanjc@google.com>
Subject: [PATCH 0/5] KVM: GUEST_MEMFD fixes/restrictions
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>, Michael Roth <michael.roth@amd.com>, 
	Isaku Yamahata <isaku.yamahata@gmail.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

A few minor-ish fixes related to GUEST_MEMFD that I am hoping to squeeze
into 6.8 as the they affect KVM's ABI (especially patch 1).

Sean Christopherson (5):
  KVM: Make KVM_MEM_GUEST_MEMFD mutually exclusive with KVM_MEM_READONLY
  KVM: x86: Update KVM_SW_PROTECTED_VM docs to make it clear they're a
    WIP
  KVM: x86/mmu: Restrict KVM_SW_PROTECTED_VM to the TDP MMU
  KVM: selftests: Create GUEST_MEMFD for relevant invalid flags
    testcases
  KVM: selftests: Add a testcase to verify GUEST_MEMFD and READONLY are
    exclusive

 Documentation/virt/kvm/api.rst                       |  5 +++++
 arch/x86/kvm/Kconfig                                 |  7 ++++---
 arch/x86/kvm/x86.c                                   |  2 +-
 tools/testing/selftests/kvm/set_memory_region_test.c | 12 +++++++++++-
 virt/kvm/kvm_main.c                                  |  8 +++++++-
 5 files changed, 28 insertions(+), 6 deletions(-)


base-commit: 21dbc438dde69ff630b3264c54b94923ee9fcdcf
-- 
2.44.0.rc0.258.g7320e95886-goog


