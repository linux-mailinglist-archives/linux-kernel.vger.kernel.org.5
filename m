Return-Path: <linux-kernel+bounces-135997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EA989CEB6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB6A28152D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC39143890;
	Mon,  8 Apr 2024 23:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="azWKao1g"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995CD381DF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 23:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712617880; cv=none; b=PFqDqP8EGOHqfIqQWA6e+uAcGCgcvscWRtCpMVwrmaUmbuzEAG5x1GF6kKWKhktK/0rA+xr+TUT4za8zOFvw7Zn20fqh2xZo3/DA5Yo2JkUf1QUKrsuCiNjMBY78ytpzHGgM0i+LA6+D2q0b3bN6g3HO8EyaueuCM3nCwfQDsO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712617880; c=relaxed/simple;
	bh=MouoRf9cDb+jze0FcL2+No7fkAOuE5yIsddcce9/p5Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T7ieX/uF6RtIxdUr2oa3uQAabBRAcwAb9icKkZaQX7Fq7RuLWvw+zIstWfGgi91zScKv43uB+Srx6V3DvPakdcJetKfezMg/kZDhGHTZvi9XlhX/MzvxWH5jQnaLVFcZIhmwWXcJAp/lVO88oiBKJESGgvvg6A6ER4jayokkqf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=azWKao1g; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-615110c3472so92922027b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 16:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712617877; x=1713222677; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jI+tCmAD3FcBQOw71QJrfrrIzm9ZgxUOk5vaoaRODf0=;
        b=azWKao1g8Q9/HqYGdP1JT+pwJHhjiXKNBCTWCY8mxOxsSHyawyyESljB3RpKP1Ky4V
         IErJoptZ4XZRbV+FwnjaYwBINtquWqPrtmbzAOz/TObaRdih9FcajOTHCe0p+xYsQfzD
         mJwVLZwFSkJenvKc/7AGmUG9Br6lBi4Xg59dKUXQM/A85egbebuofK293TXEQcf7xBfA
         vKsbLmk6PpDo4hHA8non6ycsDcbGeBvZ+Mh6eeLvRsy9upMJ5/vc4RX0CiRTVDgt9KMy
         uv4Vq5jb8Zn1p1dE1siGmKg9AxmyjNPxJmuRcAo6RRJxBDdwGP0s/kmbHD6wORyhiSh2
         x/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712617877; x=1713222677;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jI+tCmAD3FcBQOw71QJrfrrIzm9ZgxUOk5vaoaRODf0=;
        b=K2DRsbkV4SEwCppCuXJhi5wuvqqRNPcapv3ICbVFYq9CiIwiCO2BPpHWRyy2VKKXP5
         a+a1iyEzeE28jW0jS9n/+Qel3pk1SaIOT7r17zmDq4lX8XFiQ5dayjbgukLMiNvHfL6l
         t4OTrNva2xucxUR73TTESlGyYBUBeRj9tjSe/gx6ZIxCjVVQIC+bEFBU/IeFf5bx15SV
         627vN+kCPl644jKbwX2Fxks+SiANho7bws/evNZHRry9xY3Kt+gECtBaJHJcM9i5r36O
         G/lHVasIzyoPleV/Ayf7FQvuxDAdtj1xGOSlJ6Pv5T1owTBBf4u5+dhY+4kXwn4la1Tq
         JViw==
X-Forwarded-Encrypted: i=1; AJvYcCV7Doy8bZg+9ivI2iq/OodyJ8jToxVfkvzABETkjhZfKiRXjGMMY3RAZ+aKLKfVEvdyjGhzF46sMYH96c8sS356KbCK5DLUKv0GRDvx
X-Gm-Message-State: AOJu0Yyi4T15yhH2jDSYibyl04lJz3ooIUKSwVrP9E1ef0P6dzLL7GAN
	En+rvun879nUbHvNGxSGZQmy3Wjba2QyMBPUXeP4s71cRaFV9aXXheDb4inTd4ZSpk6VhCVunF6
	W0Q==
X-Google-Smtp-Source: AGHT+IE7/5eP4ikm/t8kd6/QNZgsT4Ba2Vxw1bSp/FKJt4MSfFmlehjcjJQ9X1yIn5Edr2YcqVSNsGmy++c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:6003:b0:617:da81:e9fd with SMTP id
 hf3-20020a05690c600300b00617da81e9fdmr2697584ywb.0.1712617877704; Mon, 08 Apr
 2024 16:11:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon,  8 Apr 2024 16:11:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408231115.1387279-1-seanjc@google.com>
Subject: [PATCH] KVM: x86/mmu: Precisely invalidate MMU root_role during CPUID update
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+dc308fcfcd53f987de73@syzkaller.appspotmail.com, 
	Phi Nguyen <phind.uet@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Set kvm_mmu_page_role.invalid to mark the various MMU root_roles invalid
during CPUID update in order to force a refresh, instead of zeroing out
the entire role.  This fixes a bug where kvm_mmu_free_roots() incorrectly
thinks a root is indirect, i.e. not a TDP MMU, due to "direct" being
zeroed, which in turn causes KVM to take mmu_lock for write instead of
read.

Note, paving over the entire role was largely unintentional, commit
7a458f0e1ba1 ("KVM: x86/mmu: remove extended bits from mmu_role, rename
field") simply missed that "invalid" could be set.

Fixes: 576a15de8d29 ("KVM: x86/mmu: Free TDP MMU roots while holding mmy_lock for read")
Reported-by: syzbot+dc308fcfcd53f987de73@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/0000000000009b38080614c49bdb@google.com
Cc: Phi Nguyen <phind.uet@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 992e651540e8..1eadefdb4bf2 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5576,9 +5576,9 @@ void kvm_mmu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 * that problem is swept under the rug; KVM's CPUID API is horrific and
 	 * it's all but impossible to solve it without introducing a new API.
 	 */
-	vcpu->arch.root_mmu.root_role.word = 0;
-	vcpu->arch.guest_mmu.root_role.word = 0;
-	vcpu->arch.nested_mmu.root_role.word = 0;
+	vcpu->arch.root_mmu.root_role.invalid = 1;
+	vcpu->arch.guest_mmu.root_role.invalid = 1;
+	vcpu->arch.nested_mmu.root_role.invalid = 1;
 	vcpu->arch.root_mmu.cpu_role.ext.valid = 0;
 	vcpu->arch.guest_mmu.cpu_role.ext.valid = 0;
 	vcpu->arch.nested_mmu.cpu_role.ext.valid = 0;

base-commit: 8cb4a9a82b21623dbb4b3051dd30d98356cf95bc
-- 
2.44.0.478.gd926399ef9-goog


