Return-Path: <linux-kernel+bounces-94817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEA6874591
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 996E11C21CB8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2195221;
	Thu,  7 Mar 2024 01:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PKHGNoPu"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8064C6F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 01:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709774029; cv=none; b=cFOVqUdsAy+4Pmkng7f1WVyrE3idJ+umqs9Rk9Yle6dDaqmNHaFol9UkMN8wc2Xvy+zd+lBiHz/gC/KGG6ifJDua9/ckoPx/LY43f9BAKu1vO/YrsZByHYOVUq35z4VxGUArmoc8db8TjnsCPiz1KDDWqD+hK4wusmqovWYuno0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709774029; c=relaxed/simple;
	bh=hZ5Sn1jSz8DAkNrCHxC3gfo9H5L7otCVEGMyNOPmqyo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=X4Go5y5sqAyX66WYaolQd6+qi/AKrppqENrnqmvYlzIot7aF9DFzo5S1gctAa5Mx5I89TRc44HRm60H8owVGY/B/eKt1kQPpB1+jb40xGz+VO4OV9nNsBi8enESK/PqloNCNguzPcNIEiMg9sOYcWg67EKpdJ5c4qCs+O9LzMJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PKHGNoPu; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608e88ca078so5472357b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 17:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709774027; x=1710378827; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rt0lW+kiwJbcMwQc46VkiXalXJk5+eKabvSXhIGfvyw=;
        b=PKHGNoPumI+ZyWWTJJp1Hm9EYyJ1/44OIk65AK6xkd5m6NWOAIy/KTz13KYELFKviV
         nmYniytveXrg4Xt+VI1znvSH4EcKFEHIuzMc5pnDWeFeIlgnBpI+k7BNzqcEHAJZs83i
         CAS3CQqGp+X3Qx95rb4GKvZKvbHn/jauLZbq7a0/ohknT82EsCaYMKtbYCLG7nqkjQKR
         PnRjZ3LGWxE3VwJ0EGBg04+V07oYThqX5RVBPiR8J4A1KKBFY9PHahd0F8kGQTJ3VUBY
         Pfs9UHWDk7o7FLEwMca2rgkrOJ2dsXLVzGsUSiHlXmfEWU7aaZ8xxQd24TrpotVYiz8g
         BEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709774027; x=1710378827;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rt0lW+kiwJbcMwQc46VkiXalXJk5+eKabvSXhIGfvyw=;
        b=eOQ0YVjpgCsEUc39BIAdwgxxmqLIBuIZwhK/1/HejiDNMF2GT9f8wUQTwPTm5X081v
         AQIjSl4mCt7j24pl1RyUJX614rRH8QNxod1CdRXecqojwpoVQbD9pTwXFxj/v6PC8wh/
         Z1AgyfwFAoCbUNFdYUQxPxQFUNRd5NqqUjfmk1MOkC/0ALQiRrllVD7Vj+kaPbAHsl3V
         1IBWOIoaJ2U7/8wnUigXyvbl2TGCPGKSlxOGnGbjp8TFaLd3ElLj80XsRk4NQbRVQUeB
         5x0XHHfMlw9rbW42GRspha5WcIdQ1ZzuOeVLUa+Tpn/OiHbAU/0CQdS3Va1GPTTcA1iw
         DIRw==
X-Forwarded-Encrypted: i=1; AJvYcCVQpGnEiemHIR8ufDNrJCyX5vv0Wc6ZLZRz2V0WNYIGgnQ+l+mr+cFm3MTLtREE44MfQk+D4OJGLYeFWmY1+Nv/hyKS7WlHsDymNqqF
X-Gm-Message-State: AOJu0YxkwPrsA0g5bZxbd10nyZ61Ezt1o+2voTJBaprYXtG0NetHoVSQ
	I9odyNWW98G2EIlbTXxA1wqLGUKkbte7sHw8Tt1/ojNy3YcqXKBrobTJ19wLWMNov1RYPPzAQYF
	tIA==
X-Google-Smtp-Source: AGHT+IHf2WAdN8sJOEpl8sXRG0fsScQWF4WTan2Mj8l4gnGUdx7FojV+fNOXpKpPaex0EROrURmv1CzhYg0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:9b97:0:b0:609:38d1:2ad9 with SMTP id
 s145-20020a819b97000000b0060938d12ad9mr4120303ywg.4.1709774027042; Wed, 06
 Mar 2024 17:13:47 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Mar 2024 17:13:41 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307011344.835640-1-seanjc@google.com>
Subject: [PATCH 0/3] KVM: VMX: Disable LBRs if CPU doesn't have callstacks
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Disable LBR virtualization if the CPU (or I guess perf) doesn't support
LBR callstacks, as KVM unconditionally creates the associated perf LBR
event with PERF_SAMPLE_BRANCH_CALL_STACK.  That results in perf rejecting
the event, and cause LBR virtualization to silently fail.

This was detected by running vmx_pmu_caps_test on older hardware.  I didn't
tag it for stable because I can't imagine anyone is trying to use KVM's LBR
virtualization on pre-HSW.

Sean Christopherson (3):
  KVM: VMX: Snapshot LBR capabilities during module initialization
  perf/x86/intel: Expose existence of callback support to KVM
  KVM: VMX: Disable LBR virtualization if the CPU doesn't support LBR
    callstacks

 arch/x86/events/intel/lbr.c       |  1 +
 arch/x86/include/asm/perf_event.h |  1 +
 arch/x86/kvm/vmx/pmu_intel.c      |  2 +-
 arch/x86/kvm/vmx/vmx.c            | 17 +++++++++++++----
 arch/x86/kvm/vmx/vmx.h            |  2 ++
 5 files changed, 18 insertions(+), 5 deletions(-)


base-commit: 0c64952fec3ea01cb5b09f00134200f3e7ab40d5
-- 
2.44.0.278.ge034bb2e1d-goog


