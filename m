Return-Path: <linux-kernel+bounces-79135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1479861DFC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F3D8284B9C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B1D14AD1C;
	Fri, 23 Feb 2024 20:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4nQsW9sa"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4346159580
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720974; cv=none; b=NHExLM+o4F+RcL81NUL1at+AFnFkV6ExiDYYRf5plk1FPwXgO1sg4s6Q6fbREHxNvyPZN/gGdPRuhBXgYvg3rKJP4tjjpmm4PetJ9e9IiBbXiCOxG4tPcuVlisf0EHWWIM7YXabAO9L/qRNfWZRxbl7ec2ZE6uGBkmYYy1665E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720974; c=relaxed/simple;
	bh=7J6KDtGQ/ff8P3w9jb/vWmofOgEnYMuO6+24o5qqEFQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r6qP4ABFkyxSFB/FFRrD1RYvsHFA/+DeM44bygU51vqMeWCosUpkpCldmo9REZpm0neQCzN24QEcE84bxTGSvvH4z96sUaGdwssoGNSUG+qsShEtTjzZc6OWdU9kqhYjsWPT86NXmZ3xdUzggDlsURViJy36nrJFFU4/iYIscTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4nQsW9sa; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608a1a2723cso19512977b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 12:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708720972; x=1709325772; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=vufYXRT9nLolRxc38rSYg/MmpkjAZM5KmaatkmS8vks=;
        b=4nQsW9sa4h4EWu7++5cltY8XMcbWe5A10jC/XMx5DneIDsQTOYtm6DkPDnd2pWH0ZK
         6UJNSmbqSwj6OUVHqhWjcM4a9FUmKhINnBmt1spcRxqkF4NRn77DAvu5orh2bbAOehVH
         WEBgkHjoia0ykJpjFKKW6mYIfnaP58TTvDwe3kz/CubNhAdoQbujUtkTeS3EpZY17Brz
         7yXExos4ZP2qSUumMeNfsc67UZ23RDMEfst2NNu+KT+BA1xMMbsJ8d/398VH2LYV1jyS
         h20rEhHK5DAnya4IICVWgo66y6A27VBqJS7glRW+qrrGJ9pfyKLyfytz8lPu3eFx1LUw
         XaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708720972; x=1709325772;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vufYXRT9nLolRxc38rSYg/MmpkjAZM5KmaatkmS8vks=;
        b=F/cYEYuM/V7WPZxFBVp0D7wxQ5PurmyveKU3hYCEo5K1A0yLjJqyKWzq0JYUoxWPhJ
         a4pSeMYSCgDhBvymxIBOAM1S95Dax04o4d48KJOEzWZmCsSBu/bDQMtn/3zdXaC8pfsU
         zyEo0zH2Vpl7JOurpC66SMtVBwR21Y2YolW7uV+E/b4EL+jQQ5fW+mjyBvvYNPrx4AUt
         KMoZhbojS3scleuUpC7d2Q+lEeFBOwYWbf/7F+UI4SlPZ6mU9PSCBhmVOARQrXjNv5do
         gLU5rMia2bQLD4zFunxhfly0WRhw+zL/ZmBEVVWJhp4Q0xP+JCOnrDNP3atnCZJ04t/R
         Ji/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdjwbXX3OTOQurOR6I6P2lsE0ayTNrFkxTK5msvMubftkXMls77v/kVq0ceZPRNc7BGNEreH0+VrllKFbAqevUNXvAwkvndTMj/zMt
X-Gm-Message-State: AOJu0YwCurU0dx85ATifLq6U83fTQdG2OaF2mNDljh2I14D8FsKczVDP
	1CNqcRm9uUf/DkXZ7nvcZzslL72WIFXf5j6kSj0OS4Wbg+EmKGcPwRHNblnYZ63fgMJiDgTSu1L
	tNw==
X-Google-Smtp-Source: AGHT+IGkwBo3XXrPKmyWtpC730sYPRHOW/RuUbF4N0xhpzdlXJuc/UO48jdXDpjR452hjzguUMHMf64EmkI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:8452:0:b0:608:cde3:107b with SMTP id
 u79-20020a818452000000b00608cde3107bmr131247ywf.2.1708720971999; Fri, 23 Feb
 2024 12:42:51 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 23 Feb 2024 12:42:33 -0800
In-Reply-To: <20240223204233.3337324-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240223204233.3337324-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240223204233.3337324-9-seanjc@google.com>
Subject: [PATCH 8/8] KVM: x86: Stop compiling vmenter.S with OBJECT_FILES_NON_STANDARD
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Alexey Kardashevskiy <aik@amd.com>
Content-Type: text/plain; charset="UTF-8"

Stop compiling vmenter.S with OBJECT_FILES_NON_STANDARD to skip objtool's
stack validation now that __svm_vcpu_run() and __svm_sev_es_vcpu_run()
create stack frames (thoughthe former's effectiveness is dubious).

Note, due to a quirk in how OBJECT_FILES_NON_STANDARD is handled by the
build system, this also affects vmx/vmenter.S.  But __vmx_vcpu_run()
already plays nice with frame pointers, i.e. it was collateral damage when
commit 7f4b5cde2409 ("kvm: Disable objtool frame pointer checking for
vmenter.S") added the OBJECT_FILES_NON_STANDARD hack-a-fix.

Link: https://lore.kernel.org/all/20240217055504.2059803-1-masahiroy@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 475b5fa917a6..addc44fc7187 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -3,10 +3,6 @@
 ccflags-y += -I $(srctree)/arch/x86/kvm
 ccflags-$(CONFIG_KVM_WERROR) += -Werror
 
-ifeq ($(CONFIG_FRAME_POINTER),y)
-OBJECT_FILES_NON_STANDARD_vmenter.o := y
-endif
-
 include $(srctree)/virt/kvm/Makefile.kvm
 
 kvm-y			+= x86.o emulate.o i8259.o irq.o lapic.o \
-- 
2.44.0.rc0.258.g7320e95886-goog


