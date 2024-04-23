Return-Path: <linux-kernel+bounces-155949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9358AFB99
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC7E1C22204
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AB21448D4;
	Tue, 23 Apr 2024 22:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k1SmxXEo"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F03143C7A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713910530; cv=none; b=dJd7XDmgInYBzkkqqstRqfCQ6al4ozSBbcWavyAXCHM9j8EBBrW3mN5oCJif1ubwZtH9AB9RQRgB4FbL4tRM8G9RovMGgAeAfvohSxW7To82EZlnFNTKJcKf+DeWDG6sLGGmLolaXvtalXIukz5xaMuGYPaoZvWYsOGPKfH0JgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713910530; c=relaxed/simple;
	bh=aYUpste86lV3fyte7buFltqmDR1r1cQd4prVxaJtRf4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tFjXViOlVncFjlTJBnlU0fDUShQrpIF8ZdC+QQS0P10urjmeIonra/WxpsQB1SUn0D/VA1MsT9bwS27OnPJFwICZxWSc35/4QrR/0ag+YEvtuWAGOnOl0jAydJrSMbhVZkUgcWHSLoCwS+oTSbhcj3BoHvzZpYih1DauR0hddyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k1SmxXEo; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1e2bbb6049eso67752445ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713910529; x=1714515329; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3uqpWugoSDsDMOmVhUpk5dOwz/VU9DZaD5dJgZGIky0=;
        b=k1SmxXEo08A3+JFP+GjRflbC3VWnVArSumwUC8ybs5Sdj7DlSqvqAjcmuv6ZVteQ/q
         wvJx6f19lqzlk1swSdTlDagAwD+2igqEzr4w+kfS/8so2TI2jTt1+5qoAt+szmQqmDPH
         dpkPJmLdfYAQsAykvOv0wAGcKyzSDWsKxPMS8Jmwx31FTVLFf8F+hUtIffGjbKB5vb0s
         phJcHzYOn4GcuRCYZzOn5Q9Z10jNmpJ2rXrThHytN4FJHFee243mtPPlAcRINuuUdyQ3
         rhJiPGQdIjVSPcFaX6ql6ekmglLwjZuWKyXuYK6+VLK4xp4F8sazl9wepBuJ0kbc3fhk
         8Z+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713910529; x=1714515329;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3uqpWugoSDsDMOmVhUpk5dOwz/VU9DZaD5dJgZGIky0=;
        b=vmU4kPcrvvTR/OqXMw4pEOgTLLnRj3zkqV8YMCv0ry/jOoHh2wAxVp+sZpzhIXq+Px
         p9TRyN7x/zXJNyoqo8u5JpY1eQ7I8nvdI2w4MQ/h7ttJP09bqNx73fSx/ye5zaC2jUjc
         fqEZiZokaCpbe3DhF/dO5fYolTJwViGuPgwIku7rSAh8904nk6+ZsUEXSB1FMnIzx4t0
         vHE3Yw7TQBOgoia3L+7JbzfhDQOfz+d8NVNAMhcOg5oGQDzwbfFWwKrf+JMF/L8cC14w
         EyfLQ5dcDdDw5q6oqJfGpRQtzyaRZ3HbY+xH8N1A8xex5H7VObjG5nyifN46JqTT1sV8
         vhsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4VsnKqNMAuHdb5qwnfj0D/4fTr8nVOA/Ejui7q9zr1sDH3A+4oCbqCmM7lB/Y1wG/F+yKmtCVasEGpBD/hcf/Rpjseo3U9gahHCrn
X-Gm-Message-State: AOJu0YzbylCMK2UhQ/zSLfPjhFTLerRtwx1zaFiV9owzqUmNqneV7qzY
	RVxFb9XucDCNnT/iDvg6LkZggoqOhvhbp6Q4h2t3bITnIrkvtSyGUfD9qIevHAFHeGnvh//Zpsv
	kIw==
X-Google-Smtp-Source: AGHT+IEJ5UGqVKfLfGgTKDpJHf9w8q0xghsT3k6p5hJZ2VzCpe5sdsP0SAi+hGIQuL4nfqzRjVq1Jkhwn4I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2346:b0:1ea:2838:e5b2 with SMTP id
 c6-20020a170903234600b001ea2838e5b2mr3159plh.7.1713910528618; Tue, 23 Apr
 2024 15:15:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 23 Apr 2024 15:15:19 -0700
In-Reply-To: <20240423221521.2923759-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240423221521.2923759-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240423221521.2923759-3-seanjc@google.com>
Subject: [PATCH 2/4] KVM: SVM: Use KVM's snapshot of the host's XCR0 for
 SEV-ES host state
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Use KVM's snapshot of the host's XCR0 when stuffing SEV-ES host state
instead of reading XCR0 from hardware.  XCR0 is only written during
boot, i.e. won't change while KVM is running (and KVM at large is hosed
if that doesn't hold true).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 71f1518f0ca1..c56070991a58 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3249,7 +3249,7 @@ void sev_es_prepare_switch_to_guest(struct vcpu_svm *svm, struct sev_es_save_are
 	 * isn't saved by VMRUN, that isn't already saved by VMSAVE (performed
 	 * by common SVM code).
 	 */
-	hostsa->xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
+	hostsa->xcr0 = kvm_host.xcr0;
 	hostsa->pkru = read_pkru();
 	hostsa->xss = kvm_host.xss;
 
-- 
2.44.0.769.g3c40516874-goog


