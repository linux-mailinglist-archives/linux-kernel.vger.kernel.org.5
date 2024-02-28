Return-Path: <linux-kernel+bounces-84441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA8586A6CF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6B51C23120
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8CA2E62A;
	Wed, 28 Feb 2024 02:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SV3xcdt8"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A34D2C6BB
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 02:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709088141; cv=none; b=pWzCjtJsZunn1sMRfheVD7GEQsxBOGsq527a5h416WeM4rsr4yk/vdAgvz94haRLUrX8oZRbyqZ1OxPox/9MC825+MC3wqVLYKxyBVuCdJtl5wJ1CetYczTUODsSadbhIHxWOz96VXuqFVqCcA7mVPqm8L00c80VXJeetnC46XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709088141; c=relaxed/simple;
	bh=ixgVj0KGrSU4gTjyAiHEvZBk3jB06YOVx+ihjzW4I4g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WTvGO4PUpAQ3sY9HGkQuLzSl/1917k6K9YSQqllrRsDo9A/YmlNV8b55+swEqvt0GfWtRO/6dT4pBIbma8uRnFVI9oiEI77AtHGVIA+4OSkFmNf7SFS6l76nrvasL00OJDs0TzMFsD7OaYtdkLpstUltJWcw+w01vVsFRAuGE5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SV3xcdt8; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-29ad35a8650so385893a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709088138; x=1709692938; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=rtApIkKLSvdOXgbJmewj1zhLCz1lTULYuVLD/orXMmk=;
        b=SV3xcdt82+EU0XYkzm0TXdWcoFNN0pTij3VezjKwKwBoZpD4MP6Mp0kgJYA+lofPVO
         VFwFUzPt6pss/3YVmtc9cSRifd2El2If1O8h8rhhYQw9BOagtfntoxFuHF61YCc2PxIK
         M4/CeJegY2PrgfNmD2opHJn6WsKz2WvEPxopleQzdv4GQfDpgTawirY96olqYzRgkTgD
         fZs1WRev+q+L8k5m260El8BjflnMltpOkFWuNTfZaqJT9Aam5Mb/x34F4d18bVO8WZ2n
         Aag4ZsYZFdPOWO7TZpv8VJAEsxf7x+wLVk7nJ+0G4hVAUNmvyS7zBMsYLmq49d1iGo14
         vxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709088138; x=1709692938;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rtApIkKLSvdOXgbJmewj1zhLCz1lTULYuVLD/orXMmk=;
        b=wFkGfOaQbhx1j3/sgK6jXHcsasnwbPABbvpbBPV4ASaeDyCQIawnr/M5WqQUH1yYTP
         EwL/x12DfroJBZF/KPumcqz4G/SaphRvdPG660d4csYkW0sww+MHJI7iZwYFmstKs2Fv
         gli8tl05wAutPS/F9VfPPlmhk+TJbluOMbbSA15ZoRMFDTuhAlyyK+LNjvcwsLcnIyF0
         5DDl6JLHl1B+B+z5SHGh4pdHiTUWvL4fb3gdAJSjJhWSGRIcctC1tcb7KVoXe+uSFggs
         UJXcI4teZ3NqwcmCFmL1lNXbL05haz0d2zURUWdT6IC2B84dijuH5cMrNuOV7lcMCzZC
         xrHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWplM/YWW9+Z15GSsimw9WhSxShmRNrIkPiNYtUktNbpiCZNxRHG0OFYo85ib/afW6edM1/YfWSomdtaZ3qg4qp3CGQpVQwu+YSR0Zx
X-Gm-Message-State: AOJu0YwcaZvfvnLATSmpJZ95a8TeBgdPE7JMIAmWfGufjCyhDoF6YgnI
	aIE9FYUPX815UKICaIeJ4xIHRuaqB5SnjA/tp5obZosMo3ruwyF3cI7JNaDKOHy8vn8RFaRh34l
	ZnA==
X-Google-Smtp-Source: AGHT+IH9tXof/kR1AMzV1Lra2XibmJjG90HRu0dfNOBX/JbDNMXAO+L+Avq5RMTgEZhP13UN3jO7pyoCH3E=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:17cc:b0:29a:61fa:e3fc with SMTP id
 q70-20020a17090a17cc00b0029a61fae3fcmr5365pja.2.1709088138588; Tue, 27 Feb
 2024 18:42:18 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Feb 2024 18:41:46 -0800
In-Reply-To: <20240228024147.41573-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228024147.41573-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240228024147.41573-16-seanjc@google.com>
Subject: [PATCH 15/16] KVM: x86/mmu: Initialize kvm_page_fault's pfn and hva
 to error values
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Explicitly set "pfn" and "hva" to error values in kvm_mmu_do_page_fault()
to harden KVM against using "uninitialized" values.  In quotes because the
fields are actually zero-initialized, and zero is a legal value for both
page frame numbers and virtual addresses.  E.g. failure to set "pfn" prior
to creating an SPTE could result in KVM pointing at physical address '0',
which is far less desirable than KVM generating a SPTE with reserved PA
bits set and thus effectively killing the VM.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu_internal.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 74736d517e74..67e32dec9424 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -307,6 +307,9 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		.req_level = PG_LEVEL_4K,
 		.goal_level = PG_LEVEL_4K,
 		.is_private = err & PFERR_PRIVATE_ACCESS,
+
+		.pfn = KVM_PFN_ERR_FAULT,
+		.hva = KVM_HVA_ERR_BAD,
 	};
 	int r;
 
-- 
2.44.0.278.ge034bb2e1d-goog


