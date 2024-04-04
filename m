Return-Path: <linux-kernel+bounces-132267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7685689923A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CBCD1F230E3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4CC13C808;
	Thu,  4 Apr 2024 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K5Pp/35f"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568B813C687
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 23:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712274013; cv=none; b=Ws9pWNGh2Ver8Mvqr2vOEzfQBflh5FNYiGLlW/8amE1zLTblSsaPKXCYCV/XZ4BS2O7AJC/8upeV00FYfxBd3ZytyXN0baHFkQfKZJj5BiWEcYwtU0V7aJ07RYjttkZwsW4gRW2a7qnICp+N8mlYlZDdAklPsrrVyxIFCUffv8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712274013; c=relaxed/simple;
	bh=AyWExNtliCMnaIPa31T8OjLJgx0gMQ33cU60bHVKOSw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iChVLZKv82AyRyNqv3vMMa7sCCDovVGLn6nqwg+nvBrlEcM6w71+sqQiwsS6ThV/GyqR04P/3/vuPvnFzdALeSzBlpvPs2PY+HsLYb0jv1utvQLcikdS048VTG4Rf18NvFOS58OoJhxfUtxySqx2GoK01BYfDLhmT/dtp5Gx5LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K5Pp/35f; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e0b5e79a57so14701545ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 16:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712274012; x=1712878812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRcmM7eAhmDISD6HIjOIg1nkLVAakLm4fAvyEdY+QHM=;
        b=K5Pp/35fX3s43YaZljYzeJR2qljX6VC2V0z1iKPqlOGjZkVGbGaoSlwbFOG5Z4s8sP
         jTOnbodPalR/EcWilFpugSxsBk8TZOgKuwFm7FRponMEJsKBou7PPGtOicwD/2bBTlJu
         nNjGI9tygSWFVGqJnkm7GtSv1JrV2C+SpNfGzaAi17lweU4pr+d0rbwt9pK1jSDH2kCO
         aVZBUS5UdPHYdhQ5T2CVZqnxLEWDbpVU4aSo4LB20rSOxXt1y1GLDbSHMoVwx6eRUHyp
         2q1wbEMacWZA7ulOq/VrFjSMw6p79DlgvtIol6+nCkrIUX1yuI90j51h+4CDIglf5jbL
         9fCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712274012; x=1712878812;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hRcmM7eAhmDISD6HIjOIg1nkLVAakLm4fAvyEdY+QHM=;
        b=jwY+JLERvt0viwT7L61fhTAL+lmD9Itxazx5q9RKUvAaE3TQGRMezgnDxQ1IR5NJ58
         SzLJKRmb5EoHL3zCDsGz5yyF54HGkJ6FrLvGjbV7xHSr0/54timMc9u/kGHrzuO4S2QJ
         uiiRlSluyPjJ6nR1qTzAT6lQIjBhF+xOaRinn39+hI2KRYPPkd4rjlf+u+XewTA7aUYB
         t2tCmXBYw1czDoZZvqRgziEhJEUvS6jzyKmNSiJ5xJEOS2K+SJSLJf60PcC0b9gXUaOQ
         vB7bq822rWDS7T3SlGukUeEKW7ZIqnZY+8iIAxYggCGm/VXpZA/6ry1Jw2gJ7qO+dGUm
         pfCw==
X-Forwarded-Encrypted: i=1; AJvYcCWXnjxFtdNodifXrZtldAwzJYsX446jbiIGvVcqnKEHhuxpHHmS3ojTM29xOsQd5dRHvIDiilgRz2PDD9xCtoASJ4yv1JY0XCLkDMOu
X-Gm-Message-State: AOJu0YxCOoutIQ2/X+zJA4amOdLAOSkgp4fWXyefvSXIWE98etaw1LIH
	HnDiTGRu2vEoNi3hd453siaxGebCLOwI4u0szZRgSHsV6R81XId1+Jhol8hHggd+RV3Kewqc/T/
	qKA==
X-Google-Smtp-Source: AGHT+IH9o8PgyZzQ8XSZQFyH+zK8kCLfWAtScsql9lRTz+nALM/WUpMPa6Y4oIh2MHxiiDJiPwpBejlrOEI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:6b06:b0:1e3:bfed:74b2 with SMTP id
 o6-20020a1709026b0600b001e3bfed74b2mr8787plk.1.1712274011683; Thu, 04 Apr
 2024 16:40:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  4 Apr 2024 16:40:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240404234004.911293-1-seanjc@google.com>
Subject: [PATCH 5.15 0/2] KVM: x86: Fix for dirty logging emulated atomics
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Michael Krebs <mkrebs@google.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Two KVM x86 backports for 5.15.  Patch 2 is the primary motivation (fix
for potential guest data corruption after live migration).

Patch 1 is a (very) soft dependency to resolve a conflict.  It's not strictly
necessary (manually resolving the conflict wouldn't be difficult), but it
is a fix that has been in upstream for a long time.  The only reason I didn't
tag it for stable from the get-go is that the bug it fixes is very
theoretical.  At this point, the odds of the patch causing problems are
lower than the odds of me botching a manual backport.

Sean Christopherson (2):
  KVM: x86: Bail to userspace if emulation of atomic user access faults
  KVM: x86: Mark target gfn of emulated atomic instruction as dirty

 arch/x86/kvm/x86.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)


base-commit: 9465fef4ae351749f7068da8c78af4ca27e61928
-- 
2.44.0.478.gd926399ef9-goog


