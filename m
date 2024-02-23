Return-Path: <linux-kernel+bounces-79131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0418861DF2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 431FD28477A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB8F157E96;
	Fri, 23 Feb 2024 20:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mfei++X/"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879CA1552FD
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 20:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720964; cv=none; b=Bzxg59Z7jGLlIE8cbMeot6T13pJbGrcv5A3JYW+3Kh48qxQm8T9/BbXPUaexK94EANONHGqrwzpBtCfLMnQHmuJ+xBAmEAMqlTg3x14wMfD49UiVbLqPuHQfi1FVRxkp8lmdiRisS4QT4+EXVueoPDsUu4dAhD1DIdruInkOKQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720964; c=relaxed/simple;
	bh=I0QVUNXtcgHX8n+zXfP8ri6kLK8vFj5GkBmrqx6hkTs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tfhJ4godpeqeXnpBxtutn8ti++eAg+NIAaIibTQxxdi0a+MGVmbnTkUJZiS/xGO8LKHxui8dM3eLXefEtWqAh5lyLvIOc72OAeHIk+lQgT2l5IfmDKkrGMFd6H88tMPbDLdntGSGZqRsA2/p5FLBWYZKtIGVrOsNrxV1ySz6YJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mfei++X/; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e356790f94so893987b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 12:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708720963; x=1709325763; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=5BA83Ml2Mr+6P5rMV7bzjFJqA1AMsjlfbBOavKz4yto=;
        b=mfei++X/8SGIFDOL2LCuIu1hXggibnEx8AZecEBJ/Vd6TkZzzqo3zsLJyKux5UUYnm
         H6hLi6WImwNgBh+GxuoebXbCMgQvolOgHTFLBqeaSIJMh22XVTE3SeqF50iY5CW3gKqH
         /nuJ7exVV/dUt/0y8axQTlobK1/vTLiT0I+bs9AqUFf1OXItxJ/AMG+exoYjzMI7WG7H
         pisiTybLZR7gFe7n2G2G1G3Uh9azthWDhLmtE3JI2DGqciFVfE6PT//zsX8ExmqUZ+nx
         qLpNsJ9u42wUFbewIr2hSLu7J/LQovikjBd0RlwFe2TkgwxOr/GgPcj/jCD68ABmlDjj
         Q6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708720963; x=1709325763;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5BA83Ml2Mr+6P5rMV7bzjFJqA1AMsjlfbBOavKz4yto=;
        b=gRduc1s+HJzLCzRXsiaVNPDiXWjwvs3g9Fkyf3zqfWTZyzguSvgvJsFSOv84s/dReT
         rS19cbFK7Ass8WuxyxlBeu0MGUQg+UgM6Dr5h+qRNukQbZYW2f8LJGrKkRVYjwzm/VBh
         laPEXizEXDUnpkiZOCYMuLyc8JYZRPMoePTFCAmFmjWnDaXq8YfoMnXeAG81lopy1OuT
         3iA0jFKcvOkztxEGLj4sTKII6qFvRWZCYWW+prGXFmiPKq3mNbdzuNPxeju6f21LhqC5
         zsMrTzkfuyW6Y9xrpTxDXew8ekZnjp3901KCFlS/8GG4plIpzXIJir/AwjUhS2XWu9y4
         HXWA==
X-Forwarded-Encrypted: i=1; AJvYcCVVwt6O8eEDUMgjQQgQDuKt2mN7rf72rt0RRvWpfyyVh7CFEGi10SwCFY063UTOkOKANXEh7C1ih4UKSJKyHOoECeo2KVo37V+rAvx2
X-Gm-Message-State: AOJu0YxlONsJYZ2J4H0Kbo+vd1u2yfNfgg9jxLLP+MIrk85DQhsn6zID
	s80D9lD1VhGa9QEltylxzXeMkq4UX0LHE1Ku3jdnZ9/bQZuBnQ7ry8nD8h0U3Uxe9u/iMBgktR7
	O9A==
X-Google-Smtp-Source: AGHT+IF6noekl4xL/9jHPYxwalCxxEyfgFoPNHuQpPMbIgWGu3MhiabwvcM3s3NwiWHJzCCpsnEGI9goKxU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:179b:b0:6e4:74d9:6a3f with SMTP id
 s27-20020a056a00179b00b006e474d96a3fmr76652pfg.1.1708720962721; Fri, 23 Feb
 2024 12:42:42 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 23 Feb 2024 12:42:29 -0800
In-Reply-To: <20240223204233.3337324-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240223204233.3337324-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240223204233.3337324-5-seanjc@google.com>
Subject: [PATCH 4/8] KVM: SVM: Clobber RAX instead of RBX when discarding spec_ctrl_intercepted
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Alexey Kardashevskiy <aik@amd.com>
Content-Type: text/plain; charset="UTF-8"

POP @spec_ctrl_intercepted into RAX instead of RBX when discarding it from
the stack so that __svm_sev_es_vcpu_run() doesn't modify any non-volatile
registers.  __svm_sev_es_vcpu_run() doesn't return a value, and RAX is
already are clobbered multiple times in the #VMEXIT path.

This will allowing using the host save area to save/restore non-volatile
registers in __svm_sev_es_vcpu_run().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/vmenter.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index 0026b4a56d25..edbaadaacba7 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -350,8 +350,8 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 	 */
 	UNTRAIN_RET_VM
 
-	/* "Pop" @spec_ctrl_intercepted.  */
-	pop %rbx
+	/* "Pop" and discard @spec_ctrl_intercepted. */
+	pop %rax
 
 	pop %rbx
 
-- 
2.44.0.rc0.258.g7320e95886-goog


