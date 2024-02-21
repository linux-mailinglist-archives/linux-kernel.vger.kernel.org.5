Return-Path: <linux-kernel+bounces-75682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9653C85ED5E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58FF1282EA4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262A612C549;
	Wed, 21 Feb 2024 23:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUy6hCnd"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9CF12AAE2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708559400; cv=none; b=ejOcyyq3GnuGxgT/f0smzcZYlvo8qj6AGc1zydpi15em1KaA/oM1Hl8fEvtadXuibRl444VdMEthdQcieeNfDg4q7Njc3uahQ2KMEs3+XfuCXbx8jVDAaZUKm9Fn3lcTgnQtn6feASXlkqE1J0XZjBCXal0WmCKeg6oU3BmLPh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708559400; c=relaxed/simple;
	bh=8ssbREubAVv87aYETCRFT0C0nJ2IamnAxKYO3ULa64w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u3FAl87gc5Ai2EwD0SXneq49Ea270dX+5Z9lYVHE00mMWtnbrSEsP8lBAq63AuAglQt5da6+j/iE4h1K4uyTl0ucZbhB6dGzcM1hUkqambzxJavHbwLb6c1Df9jf4wuhsfk4Dti0oQSe88XdnbR9NfOUHmehe6azp4bTRejC0TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUy6hCnd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d934c8f8f7so68370505ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708559398; x=1709164198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JvioobkCVW12CjzalX+EBXJJJID4JZxUgaUQxw/lRTs=;
        b=AUy6hCndJ7coh3MQzNhOI7QTMSkXh+qJ6rDyYaRU5nwYwu+rw3ga6q2kH+OCSXB1Df
         +v1xFCfNUN9Lbn+C5u03A3etvPzvlDWYUw/L8lSlDENzQpxky8J/8LJvfss4pCAVztzC
         6GFqpfbhPCYIeGvxWiMyI+GVFKi+TRTY95IxRUHKrdeWJSYW9+BiaIVMN1Qx/i1Au9n5
         Px0pG6Y93gZo9i+Ign+RtBN6zf0ca/+DylG2NFRlB9jp4b0j3wCr/8VVhlSQ/b2tvN1f
         yZj0vrwoKnHg3cGF6vYXezgpJrRoknVJCJG4t+dXw8Tlr6LqHBvPEOIBc7Vm22Z09GLb
         OuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708559398; x=1709164198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvioobkCVW12CjzalX+EBXJJJID4JZxUgaUQxw/lRTs=;
        b=gKfMClIlC/WHBXI8GyQhsqBO3mIdmcBxbUVy1eGLk12DL73GuALIwSgwEelnugHcu6
         K5pxws6J/bFxUvcXevGi8aEYfMCvs8VGJ6SHkNmcudwl0aEfuTss1mQTlj3HmXE6JxFu
         4nUOWgX+6hE3IRCOFfF16ROlSJ7yr2zLGA+7hlpcQsW9gJVygA8hYmvYoBBYIrL6EhDQ
         C9M7U7CRC+a0ptllap6gra1Ml1ApBFr3H/YMeRvT0E2qbkbDbe1/uha6RdPBHM23cl1O
         K3Tkhe0V4w2gqv9ClCEpFOrKhH3WPpGoR7K9vDEkhnLFiADiQ1V4p6Q2vG5eoI7s0+PU
         L44Q==
X-Gm-Message-State: AOJu0Yyom3gLfwqJqQHvTnMb9ms8kFtq3dbrLmpL3GWLkLVy8cMt16jv
	mLvG0XfSTCP3gIZceGM0l2pUm1zL1p2Sum0i5eJ7+7IX4acJZU8k
X-Google-Smtp-Source: AGHT+IH2VG+9vkjpRugVYXWZ5OGglFirNFG4jzJkF84tKje3CQ5CPWnMDZZTRUKPcixFt2QSeQWvvQ==
X-Received: by 2002:a17:902:ab94:b0:1db:d843:7246 with SMTP id f20-20020a170902ab9400b001dbd8437246mr10129008plr.51.1708559398243;
        Wed, 21 Feb 2024 15:49:58 -0800 (PST)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id jx3-20020a170903138300b001d752c4f36asm8657794plb.78.2024.02.21.15.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 15:49:57 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	willy@infradead.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 0/5] Handle hugetlb faults under the VMA lock
Date: Wed, 21 Feb 2024 15:47:27 -0800
Message-ID: <20240221234732.187629-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is generally safe to handle hugetlb faults under the VMA lock. The
only time this is unsafe is when no anon_vma has been allocated to this
vma yet, so we can use vmf_anon_prepare() instead of anon_vma_prepare()
to bailout if necessary. This should only happen for the first hugetlb
page in the vma.

Additionally, this patchset begins to use struct vm_fault within
hugetlb_fault(). This works towards cleaning up hugetlb code, and should
significantly reduce the number of arguments passed to functions.

-----
The last patch in this series may cause ltp hugemmap10 to "fail". This
is because vmf_anon_prepare() may bailout with no anon_vma under the VMA
lock after allocating a folio for the hugepage. In free_huge_folio(),
this folio is completely freed on bailout iff there is a surplus of
hugetlb pages. This will remove a folio off the freelist and decrement
the number of hugepages while ltp expects these counters to remain
unchanged on failure. The rest of the ltp testcases pass.

v2:
  - Removed unnecessary variables and indentations
  - Declare struct vm_fault in hugetlb_fault and pass it down as an
  argument instead of defining it in each called function.
  - Moved vmf_anon_prepare() declaration to mm/internal.h from
  include/linux/hugetlb.h


Vishal Moola (Oracle) (5):
  mm/memory: Change vmf_anon_prepare() to be non-static
  hugetlb: Move vm_struct declaration to the top of hugetlb_fault()
  hugetlb: Pass struct vm_fault through to hugetlb_handle_userfault()
  hugetlb: Use vmf_anon_prepare() instead of anon_vma_prepare()
  hugetlb: Allow faults to be handled under the VMA lock

 mm/hugetlb.c  | 88 ++++++++++++++++++++-------------------------------
 mm/internal.h |  1 +
 mm/memory.c   |  2 +-
 3 files changed, 36 insertions(+), 55 deletions(-)

-- 
2.43.0


