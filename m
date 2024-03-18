Return-Path: <linux-kernel+bounces-106796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6932287F3DC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985291C2128C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304D45D914;
	Mon, 18 Mar 2024 23:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ApfgFdHq"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4A75D8E5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710803775; cv=none; b=l/n3AgLd0w5WEnOV/kc6+BNRV0sqUr+d8BMWvKtTnsNCnS/37KDPZG9+uuJ/26j6ixztpFuMIpOUWt9An0QdrDyWt3CajNGfrPfqp5UGLTii0R8Ox8h0CH83h2d74Ls3cWUXNsdVnCjmNahNr5DKfw41ouC6kvRRD4GUG7kk4ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710803775; c=relaxed/simple;
	bh=CHxdl6kAXtZp0a3hKo/dM7poV0nO/vJGX8P8Nu3+bDA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=O6EJY6gkbVrUaUueplvUiVLBxnyzChwal3VqeXxucG8V9XbiuwtSCG12yDJbWuujd0wJ3FIqXX8Kpzzixu8pT4JtNjoWNQstq+rQcBNKunBuWlaK8EtU900xFrPMIVgtMVpWL7gVJHFfVyn/yq5Qnuxtk/Zd825FkkPgMAasi7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ApfgFdHq; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-29df49083afso2682213a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710803773; x=1711408573; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=712Uq95Ye80r9VKiZLIOk45Be4JzcIlUt71r/EgKKMo=;
        b=ApfgFdHqACTeUsaZ22yMNig5nznpsFysY53xcdyQhu+hYPv5Jwe4o8lNEoWkYB0aA4
         FEfkBsyUYGk2IZf/MAAhxrcyyla1uxnDN4X/mi+cYr1dBuW7KhIuoux0E0Bz8A0d/qAM
         +ZjPQAWETMUwk6uvlkGTU03++cPsDbTMX6xN1jx1QJukYeL17QujgcTHR4FivJvvsvr7
         4V97E4okpcz05DTVDMChkmYChWmyfL3smlVlbzmSNavBKaQ1xldqguDcKrvQOzCEXh+i
         MbsJ3CnjsYQD/Q1mXuBejRWV86EUsiKWsna2z8vcYnCh13kZz8dUExoMd8HakkYv4JbI
         t0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710803773; x=1711408573;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=712Uq95Ye80r9VKiZLIOk45Be4JzcIlUt71r/EgKKMo=;
        b=AIGi/vGKjaEuSGITqKR9PF1LlrGIXrv6UT/ZACT9QW1m1kVm9GVO0aJd++mah9aq1t
         kgD6qWXpQ6kW2wQI63lCNms1plu9jUlSJ2MFIbeJWQYWfxHaXJlqtKRK5s6Od8lg8URA
         /+SsF0EfZEW8GWCtGJ4QWpNKq3Upz+jAAuuA1YrewcuKIdBv/CaGjlye1VCqDXCppaM0
         1sUXVeQaXO8XItNQNgpxwBgJYRyYkC85cxGv0671oy1PFrHCQ8dXevgbImo9lHTkFPIi
         lEucPs/2TmGHCEEcg9oQCC9lucjTpTdxNAzb8+45303DseWPzl4WXCiT4Ug8NDA7y8K9
         Me8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYJC08z4qr8qBxjeFHA6JkXsc8RKpb1ctARkr8VJ9RrPOkDtWl5WgJ6muDdEotcRwqlyuaTNkCnczZsrDcxwKpij32W3+pCPRSc/DV
X-Gm-Message-State: AOJu0YwLxbL1wvA0SipQg1QoBUMEbXD7fqlEpuNNeSMYQJQivqd3iO1a
	Ug5OaeIr2hOM4ofdxb5Bp5lpMGdsbmNvzFbLb7Ukugcy75wgNROtrNcwy1NKySE16r7+qWy6k9f
	g/Q==
X-Google-Smtp-Source: AGHT+IEJCS4sso9+BDUHjE08Zy8XM+CBXBCA9eeN7sJX1a/RvK/k4u2k/DK1M0owQMR4EL87j5D4U3ec98c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:c582:b0:29b:f557:3ebb with SMTP id
 l2-20020a17090ac58200b0029bf5573ebbmr36131pjt.9.1710803773342; Mon, 18 Mar
 2024 16:16:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 18 Mar 2024 16:16:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240318231609.2958332-1-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: Late CPUID related fix for 6.9
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Another small series for 6.9.  In hindsight, I could have squeezed this into the
"misc" PR, but since it was from Vitaly, my mind thought "Hyper-V!" and I put in
kvm-x86/hyperv.  *sigh*

FWIW, I'm hoping to eliminate this sort of bug in KVM_SET_CPUID{2,} by swapping
the incoming CPUID with the current CPUID, and undoing the swap on failure,  But
that's firmly a future cleanup (if it even works).

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-pvunhalt-6.9

for you to fetch changes up to c2585047c8e185b070ad5c7bd887ef59cee3941f:

  KVM: selftests: Check that PV_UNHALT is cleared when HLT exiting is disabled (2024-03-06 09:59:20 -0800)

----------------------------------------------------------------
Fix a bug in KVM_SET_CPUID{2,} where KVM looks at the wrong CPUID entries (old
vs. new) and ultimately neglects to clear PV_UNHALT from vCPUs with HLT-exiting
disabled.

----------------------------------------------------------------
Vitaly Kuznetsov (3):
      KVM: x86: Introduce __kvm_get_hypervisor_cpuid() helper
      KVM: x86: Use actual kvm_cpuid.base for clearing KVM_FEATURE_PV_UNHALT
      KVM: selftests: Check that PV_UNHALT is cleared when HLT exiting is disabled

 arch/x86/kvm/cpuid.c                               | 44 +++++++++++++---------
 .../selftests/kvm/include/x86_64/processor.h       |  9 +++++
 tools/testing/selftests/kvm/x86_64/kvm_pv_test.c   | 39 +++++++++++++++++++
 3 files changed, 75 insertions(+), 17 deletions(-)

