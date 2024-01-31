Return-Path: <linux-kernel+bounces-47403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A453E844D7E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7CEA1C239D1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467DC3F8F9;
	Wed, 31 Jan 2024 23:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jCj4pBkI"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3772C3D0A3
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706745381; cv=none; b=mjKQ8fRnw3l00MzK1XDaeznLmAB33jSSesWJogSQqwyFeXEZ1yLeyfEpcdR4YOMTV9gvs08yeYY5dK1kZqAH+KmhAMBdUe7Dn5Qd/yV1zvWIoyQg3RyX2x7c2AhsI7Yv3ycramz0+W7WWVYiOYUHrvgN8yUbBYd1Jd7BY0LClbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706745381; c=relaxed/simple;
	bh=dJzDRHZ4lvHqnCEXSzwyrLR5DGIflpjXQoxReg/o7XY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gNIDZeO7ZRETGoXlrmbC+Nx9LEVR4rr+5noUnNZsnjge4dwKd3aiTU5UkDj+wUUPS8DGtjAQOSsTylkwW07wtdPqXVQpZVFHYrE/CuKydLO5yqN0eHcFIHQPxhb9f+Fz6GxREszEhR9vFUaIzjnr6y4TrtiSPRJyBZcovkP/GfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jCj4pBkI; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5cf2714e392so232044a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706745379; x=1707350179; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yNChpOdBDlQ0ccn6PmbEc8ewiIrWgLKikwCTAZH7kF8=;
        b=jCj4pBkI9HgR+IeJsNF9dobIM76elCbTIgKk4h/ayPUdl0+FYpXwmVuUfJ5PzF8A8J
         CBoHx5a/kZTBxoVcnqcGg/G8QDOjsMQcpwPo0grIF5KUG0GjPbTgF29R6NIQbBcnKX7H
         LEK31rmIqNscZOrex+6NzOcgs+Eidca+ZTFRHdEuFaU+9uwsi7hIAUia2cUHr1R7+myb
         gEHeAQ+s9SpIiDoLRI3NBUHKMJ7Q8oD1JB1c5ju0jA2irn2jmzz3FFv4HOTvX5TRju01
         L68CkRgBJel/SnhCVkJ/MQoyoTkzxnrX/4zwgusRuArJB3Nnpigr5ZttMDLSlcE/mE19
         oDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706745379; x=1707350179;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yNChpOdBDlQ0ccn6PmbEc8ewiIrWgLKikwCTAZH7kF8=;
        b=uf3MR4ytf+nmyk6TWHcCeiP+uALFPS30R9R6/dqMDh+eJTLNOhxYo5M2f9kIzka7Ig
         dF+QZEeIKDKalYvVU1B9XnBwRAgJyLNbHvdUAtQ3UdLjiiW07RYjyjatIgpKYk1UD+H7
         gSNH4zLqvufB1XvRYdPTg6qQie5lqeiG6UoBlQkLLMJtRerJZlpzoPHpkQryvYxzoVhF
         3wBwocI/Ud07Im8/htyDDvFG3xh0qOqnN4iKZtNpr2jVy3iJQrJ3OwbKSf36rrxjOnAv
         zjt1ENoARo+mMyHU7muxW+CJ9/cmWGlJPP3gu4waSKfVDboCum5qHs681x10UsM73Gpi
         RvOg==
X-Gm-Message-State: AOJu0Yzp4c2pstcSO7ZNUhSeVLz5o/1wWn0Mb+Cis0OOU+6pQ9PayHfW
	zwwcZCryONyKpntH8PzTC2C+3DZDTUIg9tNQThJgom1vM8r3VFAGK2P4PCnDe1wXQ05jN5xwgah
	4uA==
X-Google-Smtp-Source: AGHT+IFTr/+IS+bV1DcMzvuzP3zhkalRQ/k9HG3wrh1LLkzsqwYxmu0x9I1ATz04QKIOVB1h9pFrfMHC57Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:8849:0:b0:5cd:c9af:ff21 with SMTP id
 l70-20020a638849000000b005cdc9afff21mr191194pgd.3.1706745379511; Wed, 31 Jan
 2024 15:56:19 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 31 Jan 2024 15:56:09 -0800
In-Reply-To: <20240131235609.4161407-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240131235609.4161407-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240131235609.4161407-5-seanjc@google.com>
Subject: [PATCH v4 4/4] KVM: SVM: Return -EINVAL instead of -EBUSY on attempt
 to re-init SEV/SEV-ES
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

Return -EINVAL instead of -EBUSY if userspace attempts KVM_SEV{,ES}_INIT
on a VM that already has SEV active.  Returning -EBUSY is nonsencial as
it's impossible to deactivate SEV without destroying the VM, i.e. the VM
isn't "busy" in any sane sense of the word, and the odds of any userspace
wanting exactly -EBUSY on a userspace bug are minuscule.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 38e40fbc7ea0..cb19b57e1031 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -259,9 +259,8 @@ static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (kvm->created_vcpus)
 		return -EINVAL;
 
-	ret = -EBUSY;
 	if (unlikely(sev->active))
-		return ret;
+		return -EINVAL;
 
 	sev->active = true;
 	sev->es_active = argp->id == KVM_SEV_ES_INIT;
-- 
2.43.0.429.g432eaa2c6b-goog


