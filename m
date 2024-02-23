Return-Path: <linux-kernel+bounces-79092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 376E1861D7A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FFD01C2303A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20C91474C1;
	Fri, 23 Feb 2024 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="USxebXXe"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB23823CD
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708719669; cv=none; b=ncm5GDN9RWQ1el32i6UjoXnHQKfaC4Gh8v8Ede7uMEIzQ6rNgzw6URchycVdRrYkcRLW34WbAGBdm7stp8IZLAdHYPU+UYCt77ViHgidrh/bQ4xl+qg6bZX2eBvbazi1b0rL+VzgzhdhFvbGXt6B0QL9XA7BRn/NH7vgIHgEUwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708719669; c=relaxed/simple;
	bh=1bmnyFrNrxcCLjE3S/+oXjFKsestIbMgUBvvfSSy+OA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AHdWh7fZ8lMLXaNgovUjIzM0vTS7vyOZEqEWhmxxm1b4+X/2X2kHTsx1Bhe0Pz1cxLN1qq40hUaHIIMQZi3dp3naaZZ7rJxyh9eSbREiviDk+Egiv0bfce4PZcK1zhX83ASR49ciCcn6YcqVPEaLRMcNWvJmykYCdbAAyIzRqpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=USxebXXe; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1dc758f4264so4615295ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 12:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708719666; x=1709324466; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMOKrbIKnJ6TKtSp5dRNn05/ENEXJGPDCIutix2Nmno=;
        b=USxebXXerT99qzSHcujpnpMzyGBUM8k2BxQbJd2jwZFxX+o4lcuxA9mVSpnWg0rJVY
         Kh7u8oj5ILoFJpTL+XbWBtSsYonNzWRV2qLiZPAQrxgoxLc+fcuunZqiOpzhw8Z8ZNgB
         13qvrO1s2o1WFuV+7cobjzrIwSHjv+EUKrS1IpWJZ9D+yGvCfXy86HvnQpWhWEK6xKuE
         RHftZI8TQWvxYxJkl6ZTPKLwNu0zwEJazYa03xKVda1Vh5vPqgaWzMyWlY7cY3kGrXlf
         RsywgVZpe4xgc+JgMI0RUMOfGhAD1HMeMK6+gcIqxsnFBLHBx+flFHi7d6ArGxoWxd3h
         XjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708719666; x=1709324466;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMOKrbIKnJ6TKtSp5dRNn05/ENEXJGPDCIutix2Nmno=;
        b=MqakbZo5vXoUTqLYu+Sq+080PB7WR41EZnO7p8j5V8HvKIcn6ruovc3S8ln62tYW/V
         81a4kYX+n2eztUdbDQr820LAWTGjEMDmBNXi394cX30yhILq/XBRJIHSsrfrLGGDCQ/G
         3BXrNNw/9Evfz0VRVCddThKJVJQyxBvbcbTO0Dt8/Lc/aU8rqTHW/xN1lJ01FXuyMOtA
         YORVdUuTxE/Uot6jVH1tsmKrQeBL0Ga+ztDob/GPX872nkp6m6DWXJiE42CU5SiINGy/
         swcnIUMrJOuh0iy+TGGYFTKuS8Q1vSP82T2z5jApiJGtnQLi69Z2RFGGRem2DmCSZQcK
         eI9g==
X-Forwarded-Encrypted: i=1; AJvYcCXcG6pD0tUmhvxbJJreKjZAYUsWCM9+EolRPBMl3tdvPzJcqq+zB8f9MaUEthR0efGCNVwrvbSIknzYKPPSMlDMntiqBaAFFSB7IZLS
X-Gm-Message-State: AOJu0YwLbCVg1Zzd9dlIUvA0RqQjcsnTC5ss0+fT5cSNzqEaIOHYTMX2
	cp6XzbBynjlTGrkJxV7ywU8oPmwys1X5MCYkBnPmszFQoGj90XEgPwC/h4qfu+4qXw3BKG0hqtS
	6Ug==
X-Google-Smtp-Source: AGHT+IGAiiFLABQHhdRPopaK/78IVe7JcLUV+v80lMlmvMheOafreGID10sjMpfQSo848B2ZgsL84/ldoM8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d50b:b0:1db:cf63:b87b with SMTP id
 b11-20020a170902d50b00b001dbcf63b87bmr56644plg.7.1708719666432; Fri, 23 Feb
 2024 12:21:06 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 23 Feb 2024 12:21:01 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240223202104.3330974-1-seanjc@google.com>
Subject: [PATCH v2 0/3] KVM: VMX: MSR intercept/passthrough cleanup and simplification
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Clean up VMX's MSR passthrough code, in particular the portion that deals with
userspace MSR filters (KVM needs to force interception if userspace wants to
intercept even if KVM wants to passthrough).  As pointed out by Dongli, KVM
does a linear walk twice in quick succession, which is wasteful, confuing, and
unnecessarily brittle.

Same exact idea as Dongli's v1[*], just a different approach to cleaning up the
API for dealing with MSR filters.

v2: Combine "check and get" into a single API instead of adding an out param.
 
Dongli Zhang (2):
  KVM: VMX: fix comment to add LBR to passthrough MSRs
  KVM: VMX: return early if msr_bitmap is not supported

Sean Christopherson (1):
  KVM: VMX: Combine "check" and "get" APIs for passthrough MSR lookups

 arch/x86/kvm/vmx/vmx.c | 68 ++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 39 deletions(-)


base-commit: ec1e3d33557babed2c2c2c7da6e84293c2f56f58
-- 
2.44.0.rc0.258.g7320e95886-goog


