Return-Path: <linux-kernel+bounces-155947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A18F68AFB95
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55842284E24
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72087143C45;
	Tue, 23 Apr 2024 22:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="US/SX9Z8"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3CA13E8AC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 22:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713910526; cv=none; b=YjmMtT93MAGUW3g6nxpzvdSRDA6l+qdj9WZVulFmuu4kFwTaHFNwVw7aHGPDDevpI33Ygdw6VJxBZz5URN9fvCmMEv1WYR61TA/V5E8sUveiV10RM9e55q6x4FMaLOdzmPQCxIJBLqPqil3WMMXzur6wAh10Ml7m9Rq1rZ18oaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713910526; c=relaxed/simple;
	bh=8Eq5YKT0ineBQwTUtfAzoRLg5ZlwavRsVat6yCoQTV8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tcogQQle3JSUT+ODI3NI3jlT7ofBkyA7cZyJDOsF8AGdLbfV1x0rNK/QLUdVFRe5ICv2zWve9o8ojWYe81UEMCOt/kugyY8jdvifbQayUiL0DbMBQzraiwhnO8cpbX+XjH5O+pSeau+am2pKpRcewW0Tti0yCqMAj4eu9aNwgCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=US/SX9Z8; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6029e614eeeso1901314a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713910525; x=1714515325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgdE9sJRcNfrGi4MDoA1mGaoGQKbgmrjBJBbxfscz1Q=;
        b=US/SX9Z8IjPGD4vu94vAXCpf57sIooDk9LrUkLRLIZwV0D6D68Zmn4cihf6Vtn3W+7
         GDYKswM0Ner4RjN5oMzIQI+VGK7rwgs2AQ6xnV7eqi0FJqWn9PMI8//hPx8i8Jfsa9uj
         uvLnqwH/hbxhNEMf65ZBQPT8j1uPSwLZpgnL+PutzleNyDCUgwkw78I/5l8AMC3DxvrF
         bODnLCn/bmG5LLdxGHip1iKGgbYCFkYJaQVSO6BrTBCXgaj0eMaDU7L7fC+R2JTCJhI5
         rMlCWPdtwsLtAYOqwPI15O9dkZ4z+2q16jSCWkPa7zraVSHdwhcl4O4OSAwvu2gp4y9H
         u33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713910525; x=1714515325;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BgdE9sJRcNfrGi4MDoA1mGaoGQKbgmrjBJBbxfscz1Q=;
        b=o7GnhU4D9VcHLYSPxWAK2HDON5RWdUAst+PElelq+vJitdAvUKoaArGtzaTOvaxNe5
         YOq8avw8Kn7DT5qTYdnqh2nDJV+MP0DW1sr0FQjoUcCq8Yob0KIeVuHujKDKj1ZVzpiR
         /60nSzpVqSO4JCZtz3LwgDl/28o5cfNLm73W0LPb7rsUWVSyxtemWvn2sjFLz23v42LH
         8EkIw/pAh/qUJpfRgguWuHEqCxxf9KGXKMLA9AAdIGOlWVMwE9Gs1YLauTBunEyj3uMs
         Cpx6WvceHLFV9kigBVtg1opN7mzt7OTgtGdgYN1/uMo0jToXPayiCOlG91gOjOtgbX9j
         qYgA==
X-Forwarded-Encrypted: i=1; AJvYcCU2BNTOIG4dO5KVZ6n2IcM/IrLgu1qZEoLXV7+VH4MMnlsu8vX4Xif5ixwcMtGWlMUIIiYUurTgcmsozcuC2JFUfJzFH+eP9TernNbZ
X-Gm-Message-State: AOJu0YwkhlZ61snKDGfDbhgV/Q+PxsBLwR4c7tW2mZ2MZUYt5K93CQOl
	LoJnFECpBdMEq3Q4i9u+c5ohPVkfn0TN399QSt6VwgYL8Z4KVE51gQ+sbU79f4PxFjBNevFH7gm
	JEg==
X-Google-Smtp-Source: AGHT+IHcXc5BV0OJJOe91o+RJ3MgPTGpeYaTPpVvtxm4NQpRQ1M9e4fCIDJau5uDCa8tVOaMZDvToKSCKyc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:3f0b:0:b0:5cd:9b41:99f8 with SMTP id
 m11-20020a633f0b000000b005cd9b4199f8mr3055pga.8.1713910524652; Tue, 23 Apr
 2024 15:15:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 23 Apr 2024 15:15:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240423221521.2923759-1-seanjc@google.com>
Subject: [PATCH 0/4] KVM: x86: Collect host state snapshots into a struct
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a global "kvm_host" structure to hold various host values, e.g. for
EFER, XCR0, raw MAXPHYADDR etc., instead of having a bunch of one-off
variables that inevitably need to be exported, or in the case of
shadow_phys_bits, are buried in a random location and are awkward to use,
leading to duplicate code.

Sean Christopherson (4):
  KVM: x86: Add a struct to consolidate host values, e.g. EFER, XCR0,
    etc...
  KVM: SVM: Use KVM's snapshot of the host's XCR0 for SEV-ES host state
  KVM: x86/mmu: Snapshot shadow_phys_bits when kvm.ko is loaded
  KVM: x86: Move shadow_phys_bits into "kvm_host", as "maxphyaddr"

 arch/x86/include/asm/kvm_host.h |  1 -
 arch/x86/kvm/mmu.h              | 27 +----------------------
 arch/x86/kvm/mmu/mmu.c          |  2 +-
 arch/x86/kvm/mmu/spte.c         | 26 ++++++++++++++++++----
 arch/x86/kvm/svm/sev.c          |  4 ++--
 arch/x86/kvm/vmx/nested.c       |  8 +++----
 arch/x86/kvm/vmx/vmx.c          | 28 +++++++++++-------------
 arch/x86/kvm/vmx/vmx.h          |  2 +-
 arch/x86/kvm/x86.c              | 38 +++++++++++++--------------------
 arch/x86/kvm/x86.h              | 19 +++++++++++++----
 10 files changed, 74 insertions(+), 81 deletions(-)


base-commit: 7b076c6a308ec5bce9fc96e2935443ed228b9148
-- 
2.44.0.769.g3c40516874-goog


