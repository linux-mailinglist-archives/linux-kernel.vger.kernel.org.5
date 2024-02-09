Return-Path: <linux-kernel+bounces-60096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CD984FFC4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4659281DEA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BBE39863;
	Fri,  9 Feb 2024 22:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XUqWp6W/"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AF036AF6
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 22:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517251; cv=none; b=Inz9B+eY5XpQjb70dE5b4dIPXbc9u5ZVfpmZtbibC6AFIFY1cj1gCorapUTNoE8yLwhUA1oaDMA++nPX9vZbcQHNXQmAALwpgB0dlZYo52Q7jFVajtKw91KhXIs/TU6XwUcjkmcbhd0Zq3vpfvZkqxVJf0GKA9X7MMzcMUzNcSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517251; c=relaxed/simple;
	bh=lZYnzgAV5rx778pfz79UIcdx//13/9FmDoyFZzDnVhk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nX+1paEzvs0o+2GWqhJHYiJkxWHiU00KmH9MOt6f7b/W7TtUxXPQD2qcLqQcdOy4A2pI8OOEl8Ntn5/CIzr5wR2YYMCwUqHRQP63ZKsNexYtmjz6znNYXrMzVIw8Utg64QHW5tTQvI+bbNiFkSnSyfPmoAj+z/JE2yPX8l/KY2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XUqWp6W/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2963a56416dso1003775a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 14:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707517249; x=1708122049; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzfdPcYYQcVv15Q1COLpo+SFtGTau77kfvfYtZRIgv0=;
        b=XUqWp6W/UX3tSKk0yIxfbclCZK38qUBhW8Dd7TYKBUVVg2QXQkhNwwItjG12RS4/wV
         2OrNdhXb/V5rsy2TbuQirm/EbVDP6BWmcsPJxoZbmx7GPzrLJHyQwhauCnf4ZWs2LSBB
         TdDbmiQlUGevAJWQEQkb6pCBBB/XNLa274JszV+QT8X227EVZ1Hl4NoVCJT3L/TwPryF
         y8XFMmPqG2GiR6+pcpep9SMfabbDn01KLk+XpXfwSKgiHicmbb/y7jUB2hRLSib2YaX4
         P2oYzLcJkjvu34nalcWDGtfknckGOmA4r5i+qw2MVavHBXlLsLhKG6t9JOGVadSljkiZ
         3ntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707517249; x=1708122049;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AzfdPcYYQcVv15Q1COLpo+SFtGTau77kfvfYtZRIgv0=;
        b=UQi41AkvO0ZpK0PAKArfxBkZwyH6nORCqVTUH4Ntf1plSPgkUSnKehCeTfuBBTD7zw
         j4J9n6btaSkE9aczkzHce/KydG6f53qn2F3v0i6sq7bAeasqX7bblBx52CnqaB5oZqj+
         89nULUCYUUhfegKel2TNEXiQdfuiNQhJBFUBhjJq5InmY8yJZr/q2zMT6mA4X18BbcVx
         bQMNLzDdrCA8RHQ4IwRbhTmLz6PbXp99YvPxbTzSIAeCIV8/7ZudmrOJ0jjgcdaXqnT6
         78Nkkp2mcMl58SIxnVkVOfP5Y89UpoTSSt7t2LxPtQZJB8JjVqhlmZ5oAbrqTrMtRxXV
         OSfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaXCyQtvLd5T1TIdN9QBNDaKLvhxY27iOGqy53b/KsgWPRp2v2adqQl5WdJaGRmm7dWccja5wdQGCB70kfxPIu9liXuHwd82/Neblf
X-Gm-Message-State: AOJu0YwF1OHNYk23gbTqm6vocYzhSUy2/xJX0neHq0SXSBPW8reyONBS
	40CN6uM3nHcoWedbA1bccCLbvzPutd5QaCDfGflbmftHm3INav3rAVv8Xkfuk7rw5DlUkyfHtt+
	rZQ==
X-Google-Smtp-Source: AGHT+IGIrypl49k+UeTHuPL7iRNAQJ9FUAu3GCrP5bn1Q2qsJQWzW33Jfk4E5btAookSRHH6YVh3soa6az0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:2d82:b0:296:c55b:273c with SMTP id
 sj2-20020a17090b2d8200b00296c55b273cmr18091pjb.2.1707517249389; Fri, 09 Feb
 2024 14:20:49 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Feb 2024 14:20:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209222047.394389-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: x86: kvm_has_noapic_vcpu fix/cleanup
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Li RongQing <lirongqing@baidu.com>, Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Fix a longstanding bug where KVM fails to decrement kvm_has_noapic_vcpu
if vCPU creation ultimately fails.  This is obviously way more than just
a fix, but (a) in all likelihood no real users are affected by this, (b)
the absolutely worst case scenario is minor performance degredation, and
(c) I'm not at all convinced that kvm_has_noapic_vcpu provides any
performance benefits.

Sean Christopherson (2):
  KVM: x86: Move "KVM no-APIC vCPU" key management into local APIC code
  KVM: x86: Sanity check that kvm_has_noapic_vcpu is zero at
    module_exit()

 arch/x86/kvm/lapic.c | 27 ++++++++++++++++++++++++++-
 arch/x86/kvm/x86.c   | 34 ++++------------------------------
 2 files changed, 30 insertions(+), 31 deletions(-)


base-commit: 7455665a3521aa7b56245c0a2810f748adc5fdd4
-- 
2.43.0.687.g38aa6559b0-goog


