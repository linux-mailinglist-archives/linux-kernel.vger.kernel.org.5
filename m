Return-Path: <linux-kernel+bounces-50770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91E9847DBB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60FC1B2546F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA5C2FB6;
	Sat,  3 Feb 2024 00:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E5M0nWAW"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCA164E
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 00:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706919830; cv=none; b=QGBXXEo1a2dzQp6pgP1586vACeyaLElhnXJ3V4YFSCcoP0kxQC6OtzA3nNyOKuvikJqPei+lSTnCPlKY2vYJaexxEUn2aqQMb4T00vSpSi8qIyUfyb0nViYy9QA4m7eQZUjayBFpKpyNJ0mSBR4QxVjMlD/cTQ3g7VEGj8Mygiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706919830; c=relaxed/simple;
	bh=F3gM+mRPBb7pChqqTVYezZoTdDnp7w6wvEhOfKxw6A8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LcU6U2cCmV/Bi0605/027EkEK7E7pK3a2HRHnaO/jPsur50IY0niR0QaSwrElIovr2P9GXzDcwWB2Z0Ddq4GZffbr1B4FTXkhMu9d9aYvKLefpaWEY8dm2kxpQ54wConzSMyOSu9W8n9/I7moenUl3JsNELveyOUWb0mlFj1h0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E5M0nWAW; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-290e7a0a585so2657086a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 16:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706919828; x=1707524628; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=uDSqele7NE0OONssRlZQ9urUuntmdp88j24rPAm3SJc=;
        b=E5M0nWAW8IvkBQKGzVtATR37ylWds7zkYJd4IH6XutkuptQ0M4hYmSC3dQosiUo8+R
         HGf1LRG6sUqcCNudx7Dn77aI1u9TgHXjQHZtstHL7yF8eK2d69XMjw7h7abYnr+e0uKj
         sdBWRF/Jxo4Fux9X5yKCt7BanLpEkqNYdCvU0dENN+2dd912mych3zZoOiTKiRjqyefG
         MSNjoghukRTpA8/DWANl5E6mfJsfoKBOwU0S2QCQOwbzYQnC00U1CjL+ZKfiWRdRwVwc
         r+8XhjBBe1Ok5nJDGjpqRYFI2iAGja+ZHtci17sKzmy4sPPSxZ4iQdxisqsCigeptyeo
         sYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706919828; x=1707524628;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDSqele7NE0OONssRlZQ9urUuntmdp88j24rPAm3SJc=;
        b=WH51Qqjzao9DQoD2DLfItyYI762TUk349bFMB/bWe0RTO8iBB9u7MX+VBljE96TDvY
         pCIJ+Chx4/n26Xqsn6XhuJpjyCNbiKzzMQ/nms++jH8HgTdIf7JmB+WyRgTVW8VnNlQy
         VhQJ0y8QdhOtT7K8cxbmRpx8H691rgYpU8OgESZyWHWIQuBC0Vl+tONbidoPLm9MJ9yi
         pbIOYlKBxJCDzM6ildr0rKV/h5XrmOrfAYiuVoZqCQJnor9VnvSblr2JwmllzRsh09YN
         sxsz2+CEu+mtAOHlEKHScUSVcg0VZB44ZIizjHg8YZfZGiqSBZSqwop00vU+2NbKYQ0n
         Mx+g==
X-Gm-Message-State: AOJu0Yx1PgSTj1Rqst5QawcaoJlzfdv4FP6v6gFHF+u9oMEWZG/WSj27
	a/GPqGJhQJvNFdi6/yybHqxLnTjyLkUV4zUWXMxGg1t2RaAWrPTHtbOxg4EtfHYecMyaMwiXDFX
	WRA==
X-Google-Smtp-Source: AGHT+IGZlK5BxEG1BMmbcQ2/Jse5hoja4Dn0N5mQwD6YTOdKWTQsBPE9VCAtqp/a8VZd29eQ2VMQMSDz1Ks=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:48cd:b0:296:30e4:2c2d with SMTP id
 li13-20020a17090b48cd00b0029630e42c2dmr82613pjb.6.1706919827886; Fri, 02 Feb
 2024 16:23:47 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Feb 2024 16:23:40 -0800
In-Reply-To: <20240203002343.383056-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240203002343.383056-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240203002343.383056-2-seanjc@google.com>
Subject: [PATCH v2 1/4] KVM: x86/mmu: Don't acquire mmu_lock when using
 indirect_shadow_pages as a heuristic
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Mingwei Zhang <mizhang@google.com>

Drop KVM's completely pointless acquisition of mmu_lock when deciding
whether or not to unprotect any shadow pages residing at the gfn before
resuming the guest to let it retry an instruction that KVM failed to
emulated.  In this case, indirect_shadow_pages is used as a coarse-grained
heuristic to check if there is any chance of there being a relevant shadow
page to unprotected.  But acquiring mmu_lock largely defeats any benefit
to the heuristic, as taking mmu_lock for write is likely far more costly
to the VM as a whole than unnecessarily walking mmu_page_hash.

Furthermore, the current code is already prone to false negatives and
false positives, as it drops mmu_lock before checking the flag and
unprotecting shadow pages.  And as evidenced by the lack of bug reports,
neither false positives nor false negatives are problematic.  A false
positive simply means that KVM will try to unprotect shadow pages that
have already been zapped.  And a false negative means that KVM will
resume the guest without unprotecting the gfn, i.e. if a shadow page was
_just_ created, the vCPU will hit the same page fault and do the whole
dance all over again, and detect and unprotect the shadow page the second
time around (or not, if something else zaps it first).

Reported-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
[sean: drop READ_ONCE() and comment change, rewrite changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c339d9f95b4b..2ec3e1851f2f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8787,13 +8787,7 @@ static bool reexecute_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 
 	/* The instructions are well-emulated on direct mmu. */
 	if (vcpu->arch.mmu->root_role.direct) {
-		unsigned int indirect_shadow_pages;
-
-		write_lock(&vcpu->kvm->mmu_lock);
-		indirect_shadow_pages = vcpu->kvm->arch.indirect_shadow_pages;
-		write_unlock(&vcpu->kvm->mmu_lock);
-
-		if (indirect_shadow_pages)
+		if (vcpu->kvm->arch.indirect_shadow_pages)
 			kvm_mmu_unprotect_page(vcpu->kvm, gpa_to_gfn(gpa));
 
 		return true;
-- 
2.43.0.594.gd9cf4e227d-goog


