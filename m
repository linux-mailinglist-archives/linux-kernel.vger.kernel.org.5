Return-Path: <linux-kernel+bounces-155598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596808AF4A7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B51D1C22AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0A913D635;
	Tue, 23 Apr 2024 16:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cb9+jKNs"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450241332AC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891212; cv=none; b=WMRhULLAZGsc7X+pPGJ4bIHKJlNlBsFsbBmz9P+yOpC1vOpj3jPzl3LiCelx3qpAZanQPZ1zzJ5tvAxZok+i1fXHCkUzXEqhvnbQq4EwkSEXRtX+jqr2Ddz+HrLTDlc7G1A94ub6DH9jlwpcc0j251mVFFznZ103SY5l1ZbB9Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891212; c=relaxed/simple;
	bh=VV2P3DvxsTFjbP6O9idsUsljoX1RNExhaHDA1IIjccY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=k9BDafdetH9rabGIVqF7LWYkW46paeXzbtfeYN8eNPzTEdtW4amtYcX1x2TcUUgx5mnjJ1zpEwQM7wEfgl70ENsdI05gxA2fcO5zHVikV2nmGmSAZ9F7w/m3my6PdNVzJ3lxjtmg82JHvvoIc+b89FZ4ZfagELpZI+Dd6fEI3w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cb9+jKNs; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ecea48eb37so7065041b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713891210; x=1714496010; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qrP9nBCRHnbapRwTWmq1c8aapUPVM5pIy3QZe5z3ugg=;
        b=Cb9+jKNsK/7uYGpt+bl4m2uUHIIehpIOkNhKS3LfWp006LLDP8Xe7hE+T9i/qNxsMK
         ntgkfVx5d62egu7OazFNsMQPOPhqaJ+INttM7u1iUFcmfyGp7Ffk0wvyN21R1NICk0HZ
         s41Gcrm1q1dekKRTMMmVsIVEVhWpkXgYNnNQaCe7ROfraVStY2mIpieILAOpQoTM7gol
         yFfsfEe4Jc5TwgCVKdL/Fh0eXT27wDQ170F9cGc9o/CoVJ/qDa2ozvtUzmbRYVkupNH1
         wETKUFYucKlHoihJPPtf0VcanoTfDgh/Uo7404OyC7Z4bP1AzAyo0+X1zDWeZYTb7Vs/
         KUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713891210; x=1714496010;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qrP9nBCRHnbapRwTWmq1c8aapUPVM5pIy3QZe5z3ugg=;
        b=NWUIhy73PiMBM7BCX/m3MFEW71w3YeDFQVWZdM5lfJ53ES+HU4Rb/bz47FZGHdbEBE
         TSXkIiS6zLBgr9PrmCl1VwOa9G/vO34qoIyp5YMhpaLvBjgC1rVFS//tBye6t265Ins+
         y0AfZweaf4iVflpsYxF+ruKBcYGrtbjPdFPgiUUK4c11PcZO/gBuZZh92PBdAWKJB92s
         cGhqzBv2jeLnnEFewuaMnAE89t4O8GixIM/hqFXlr7SQ3antVwSeZEbNWYPkCANZ9PDm
         vmXGjqwTN4JH6FanesUpiQeFEfgwfwglabtWzrW2Oja+98ukY4rp+GYjhe7Dh0QdUStg
         OkJg==
X-Forwarded-Encrypted: i=1; AJvYcCVQewrk3Hp7qRJhAqs4Wvlqnpuxpofs5Sswx2zDt7wqzK1YyuJWqOC/ysWWuTt4TpiQMkP6N4CloF9w+nkTe37ffsSG4+kfQAOwDuH5
X-Gm-Message-State: AOJu0YxxOiWJ7uPfPumkJIBi5noq9etUA15TY0CTab9gVqlZlNEbkYNL
	lmXD18XWZgKg3IQutt29VPOf+4FxCJgxPauaHvE3yhQXWXvtLFvIuW/ZZG1YGsFZb5OhZDKVx75
	AfA==
X-Google-Smtp-Source: AGHT+IFaN1CuPXI3B8Rhg+Xhqpmqst+ublsId9xbadbWxeos0nk8YaYA/Gmjmo3WDsBjEwz4ae18B6BgWSY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1888:b0:6ea:ad01:358f with SMTP id
 x8-20020a056a00188800b006eaad01358fmr888pfh.6.1713891210464; Tue, 23 Apr 2024
 09:53:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 23 Apr 2024 09:53:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240423165328.2853870-1-seanjc@google.com>
Subject: [PATCH 0/3] KVM: x86: Fix supported VM_TYPES caps
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fix a goof where KVM fails to re-initialize the set of supported VM types,
resulting in KVM overreporting the set of supported types when a vendor
module is reloaded with incompatible settings.  E.g. unload kvm-intel.ko,
reload with ept=0, and KVM will incorrectly treat SW_PROTECTED_VM as
supported.

Fix a similar long-standing bug with supported_mce_cap that is much less
benign, and then harden against us making the same mistake in the future.

Sean Christopherson (3):
  KVM: x86: Fully re-initialize supported_vm_types on vendor module load
  KVM: x86: Fully re-initialize supported_mce_cap on vendor module load
  KVM: x86: Explicitly zero kvm_caps during vendor module load

 arch/x86/kvm/x86.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)


base-commit: a96cb3bf390eebfead5fc7a2092f8452a7997d1b
-- 
2.44.0.769.g3c40516874-goog


