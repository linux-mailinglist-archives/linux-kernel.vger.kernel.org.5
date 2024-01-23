Return-Path: <linux-kernel+bounces-36120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 342B1839BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C988A1F2A356
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B394F216;
	Tue, 23 Jan 2024 22:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g062aeWH"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6E61A27C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 22:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047949; cv=none; b=S6bEw1X3Xarv5v9E6JS8fZpoy9UmObR4xaGzxjRruN8gpnBljZzVgXQFaW2BHtGZFdg/gRCArhuZid1nJUkoIUNMUJfNp6ZdLPxZJ9I+6fOhkDJ0HlvSDSWc23tRHGIhXQOnIytjD51pwriMqoPiU3GX78EViS3IfaDcJanv5aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047949; c=relaxed/simple;
	bh=yQx9UthoJeKm1WZYjbBJ01OFS6LBdI2HlCCVfimdaT8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tUc1oi9uBfd5baT5kCWKUi1OtBIgBwfNZXjHzDHMt9IK9PhbYxpZkvPdSC1uMVp+T406iYxhxfWAS/p7Z6Eg7KIJbetF7h1u1/kY1bnkdJO9QOpuDlbnpbbLfdxtTuxH55/7Zu0M0oCw9mHPGiGpT10o1/DYWdGuca8Zz733kDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g062aeWH; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ff85fabbecso63897477b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 14:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706047945; x=1706652745; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxlcqEi9GPSMvEkZ9TLbFMdD/IrKZGyQ1yOZzIdu8Ao=;
        b=g062aeWHJ/f59eGp3G4MeV1vBg4sYUnRdNQAJ93h4lLiWRXdH1vzSEu17AOuBonxTC
         d4r0kIMpXea5i2beHHMH4nYudY6+MTnD0BLNEYExmycgFmEw6GQdRdPMRQWVv/YjaIhq
         /ftSu74hNYvpbjGsOJ/B8uiX8gOgTL9jRle2/WLAGsIFxn/73DYFgHvpZGnKXK53de/h
         y0L7x6Ua7HJb2E7EH3ZfbkRougIkTPV0aXM/HukB2WV6DfODT72K+RnJKpfJ6Ozw8qOT
         1vY8UeLmqihHKsTnhqnfSpLY5cOQ7mc7pQ8VHOmBx/2qdr72NkvV60Ty8EzNfSzXgUiM
         e6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706047945; x=1706652745;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxlcqEi9GPSMvEkZ9TLbFMdD/IrKZGyQ1yOZzIdu8Ao=;
        b=c/TVjc/kiYfZASsb9UyfgyxMpzlOSLxYHDhlLuGsASpQFn5UKsvDNm2d7IO4r4UzpN
         vmnTvqk6auKLdZSFeqikUqPba7/wYhT98QZXEpF/uZDY9RaV35OcXFw7SYVW+R1qW7kk
         Zn7/Q62ayaVXbYC8dxmlb7viRL87fUOS0sRgGVhKGzljLC42LaGn1gtAIkrn9VDOwWfH
         +2XXObjpTdovEiRhT8IBSglR7eyQBYfLHpUeb8BiV2h4DDhOx9Sww8vSKPGH5318j1hK
         OdVf/2+M51CP5W3JjktYQ9ajNyWL3JuZ7cYExOwbzdaaqXVdmhboWo8zr89S4zaKUt3R
         dZEg==
X-Gm-Message-State: AOJu0YxtKb76HwxSNovKRDYDmzRi0alw3H9O90CNGyaFKA10sF5qkFrV
	cDW9uDmadBcWndC3QpvDFGw/Vu9WB8imR5l35jVix1AfGa7Z2yRhnLob4p+UH9BA/ZIuJro/VPV
	t/6VR3A==
X-Google-Smtp-Source: AGHT+IGgFmgGBBNeO2m9PkEd4cL5jCRH6Usqn1jPECOTfs20TGpyuBXu86a6mZmLv1CFWTpB7sobJsKumjfr
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a81:a096:0:b0:5e6:27ee:67fb with SMTP id
 x144-20020a81a096000000b005e627ee67fbmr2249829ywg.4.1706047945575; Tue, 23
 Jan 2024 14:12:25 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Tue, 23 Jan 2024 22:12:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240123221220.3911317-1-mizhang@google.com>
Subject: [PATCH] KVM: x86/pmu: Fix type length error when reading pmu->fixed_ctr_ctrl
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix type length error since pmu->fixed_ctr_ctrl is u64 but the local
variable old_fixed_ctr_ctrl is u8. Truncating the value leads to
information loss at runtime. This leads to incorrect value in old_ctrl
retrieved from each field of old_fixed_ctr_ctrl and causes incorrect code
execution within the for loop of reprogram_fixed_counters(). So fix this
type to u64.

Fixes: 76d287b2342e ("KVM: x86/pmu: Drop "u8 ctrl, int idx" for reprogram_fixed_counter()")
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index a6216c874729..315c7c2ba89b 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -71,7 +71,7 @@ static int fixed_pmc_events[] = {
 static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
 {
 	struct kvm_pmc *pmc;
-	u8 old_fixed_ctr_ctrl = pmu->fixed_ctr_ctrl;
+	u64 old_fixed_ctr_ctrl = pmu->fixed_ctr_ctrl;
 	int i;
 
 	pmu->fixed_ctr_ctrl = data;

base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.43.0.429.g432eaa2c6b-goog


