Return-Path: <linux-kernel+bounces-97664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D25E876D40
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68081F227C4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0C8604C0;
	Fri,  8 Mar 2024 22:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BnGj5Avo"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655BE5B5DD
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 22:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709937442; cv=none; b=jDrHdqIkSxguhlyFjZDTB/wiJGDNHz0ZINmgnvKCfdRCsAfpab57YGkilzvET/Co4OewbgWebCtsmwlnqUBXPOTLwXHKuwAzg8peB/fXFTujQtad59VtRxIo3jckf0x7Hx2usZe7fHGjqlUVvW1nwejpcU2MzYNCgssysX4NWeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709937442; c=relaxed/simple;
	bh=oTLsXBJGTvQNP+F8nz36ySwkn2KtuRMCfbbJ8DJjo7c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FV+CvEw3RKW7CCF3MKQrAeTx5K58nj8+lcwQg62b2AMF6d5ENNXAddwrSv576iQtsQ55bTb0FO2NcdXxfINpGprRLToZYaLbRiC21OGgakiQJ56Q9qW3oJiFd+ZiJi1T28Stve12+BKYOdh8MD675ryhE4X9Ifovl/sRjYhYnIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BnGj5Avo; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5dcab65d604so1160839a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 14:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709937441; x=1710542241; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=lWMLAd4YRkj0/Z7k3uFBUD+qopQGspHfKAITmgx51bs=;
        b=BnGj5Avon2P3lufFihIPPONNUz+2sqeAsO97Jb4Old8BCu0dztoReaPUe6uBS5smca
         aP/2842DSi1kBVxjPnziLzPLmFttwe6uZ/XquwoypVZGpsq+j5BRrS92pDF/pGqyIZ9T
         c+o7CYeuI8MwwaEpt+e8sgHn61jkdTcYl7wAwIk3oG8Y25tTT8d+U8oHMQ5DYFPDADl0
         JQgKaRrZcSe+FCQOQE6n+JxkFq1emOMWpEOAGylsWmtuVqVEeitMQpH/h8c9JXrxZM6/
         xHLqFY/zNkvEe0GY0FbSu8ockJkzvqgRvo/F/Z3h/Zb5DIDAVwpNp3Cz/zIfVOuMyPWo
         XYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709937441; x=1710542241;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lWMLAd4YRkj0/Z7k3uFBUD+qopQGspHfKAITmgx51bs=;
        b=hqlsKgOEB1JERZe3KGOf+qeH+TIYJk7uPUJx+r9Eri2uqeqJw2WN5s8W561oUt3BmS
         AlZrwuUnSKIqYl2DaM2+MCxY1k1kv5hqFyYEntKnG+nDZNNBR0LBG8s3yyqyKlMHD/zZ
         j71Zr++32H3c9kawAdzlgJej1QBWoIjnEZ+o8wyD7aaueDkUiC+u8gMmtFb+TE8dBUts
         WjcXR8eEGsDrOB0646pFKzzWzr7og6wo1P/AUZuRBKbUvBm15unK+Yx67I1/aovgcFJH
         VlJzowmoqXk4Bl8iUh2Z38GX/m4iqhMR22VXkjq+cINGAWE3maP4XnbNc8iGlWmmaZvQ
         440g==
X-Forwarded-Encrypted: i=1; AJvYcCUpRUWEjv/5rM8d7A36cKF/Ex1dqNqDvJSuITpzQcdNAMHiCNsuxyaGGY58fFeRw5CXQfsuTdeIOeu9rGLEZfoHK4XIL/A+/LM+Bjoe
X-Gm-Message-State: AOJu0YwNqOVwqAMkQa6/JDKI6E2r8wJA+lzSL0Yx8zYu0VFy4uXFHp4h
	z4CypormplnccBexwDfyOhrBiXJcGKDChkPEGHtH9idaxA+6j9u5Qb09Bc16+ewqH5O1OAkVI9k
	xXQ==
X-Google-Smtp-Source: AGHT+IHTEuDAeIruT3PfeRAeByE5iiR+I9sZhT3PrPc6Dx/SCkZhPZ13wb0W6yoxMOnZsUHNLvIP6VFn9b8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:b0b:0:b0:5dc:555a:c9d1 with SMTP id
 11-20020a630b0b000000b005dc555ac9d1mr811pgl.3.1709937440665; Fri, 08 Mar 2024
 14:37:20 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  8 Mar 2024 14:37:00 -0800
In-Reply-To: <20240308223702.1350851-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240308223702.1350851-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240308223702.1350851-8-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: VMX changes for 6.9
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

A small series for Dongli to cleanup the passthrough MSR bitmap code, and a
handful of one-off changes.

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-vmx-6.9

for you to fetch changes up to 259720c37d51aae21f70060ef96e1f1b08df0652:

  KVM: VMX: Combine "check" and "get" APIs for passthrough MSR lookups (2024-02-27 12:29:46 -0800)

----------------------------------------------------------------
KVM VMX changes for 6.9:

 - Fix a bug where KVM would report stale/bogus exit qualification information
   when exiting to userspace due to an unexpected VM-Exit while the CPU was
   vectoring an exception.

 - Add a VMX flag in /proc/cpuinfo to report 5-level EPT support.

 - Clean up the logic for massaging the passthrough MSR bitmaps when userspace
   changes its MSR filter.

----------------------------------------------------------------
Chao Gao (1):
      KVM: VMX: Report up-to-date exit qualification to userspace

Dongli Zhang (2):
      KVM: VMX: fix comment to add LBR to passthrough MSRs
      KVM: VMX: return early if msr_bitmap is not supported

Sean Christopherson (2):
      x86/cpu: Add a VMX flag to enumerate 5-level EPT support to userspace
      KVM: VMX: Combine "check" and "get" APIs for passthrough MSR lookups

 arch/x86/include/asm/vmxfeatures.h |  1 +
 arch/x86/kernel/cpu/feat_ctl.c     |  2 ++
 arch/x86/kvm/vmx/vmx.c             | 72 ++++++++++++++++----------------------
 3 files changed, 34 insertions(+), 41 deletions(-)

