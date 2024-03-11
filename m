Return-Path: <linux-kernel+bounces-99257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C098785AB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9247EB20DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAD0481C7;
	Mon, 11 Mar 2024 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="G5xoUH9D"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BC54594B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710175606; cv=none; b=RPMUqNhSUpB4j17aFQ25aYeLE8q3vzS6verD4T5Sw2cjfqG/4I/c2T4pqozkGJwNHkk/2ggdXSdQXuJNhwVkCj4T28GgxQA4/Ksir1mVpjjQrYj6s9nRstaNvqnDGA6rCTfZ1uS+FinYU1EWBBcSXRwwYtCNHeh2joptFq2euAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710175606; c=relaxed/simple;
	bh=AakKpXi6oEnbZWS74OzKYeEGVjsY+mcu+WdaNyzi59I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZJzrDglEcOHWSAQZZreY/F6Biq+jiSSvUI+aF7o75Bw8YMQVExS3BVyQTQegedHaowjdfuJCu+eiIfBuAGYVFpDlB1Cgwur0YwlI0c5rDupnwYKP/LgfknXSxS/L5gy757SBVPIMCcYgefitOB/hVMd2eIaqoaRMulpaZHt4Eb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=G5xoUH9D; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a142375987so1666348eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710175603; x=1710780403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jKDy5XLn4MxCpgW/wos6NfCyYowjlJJBXq+4EzKDJes=;
        b=G5xoUH9DTjCgPIDtksxft3sspFyc5Lw+EHyXFZ1URyr7qU4uOEPSJEC5W4AV7A02Us
         ggj1WfBIpsdjsfLK2frDegdpVnun3lymvUzSg1Yf8rkATadDXOHCWKLVc02vA6RcTytU
         BfqC7HzCmAg/iM4CLEgZoPQmuQ55PlFZTOXbQfGGc98/ucI5OEPP5BWERKszIdS/0Alg
         O+bEWayyMiavB0a3zY2A6P5yidM56qw+9io+zxl/LmKv5LnMQFZAg1SDAItNLjcFky7j
         EUKRWYRXpGup/yh5jovv/ojX3qkyrsd3hYTNw8TXBhNv56ZpUeU85VovvM2WtqNzKj8Q
         ujNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710175603; x=1710780403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jKDy5XLn4MxCpgW/wos6NfCyYowjlJJBXq+4EzKDJes=;
        b=V3JLwgyRSbAnMf8u0HTqbHMgQzZKJnAyDncwDWUBPXJBodEXIW3W5GDFCUIjYmEMLE
         l/d9JF58eVQHoXVggHL9BlmE+nfq0DaaHUgYHWubm3mWjsqifybQM5EYT3ZTVvXh1Opk
         KQdIjZNamJ9UayHGXvX5jRbq1dueJ+7Ue0rFk7doqjGAZXraN3b/E41jbPTwLncBfeWm
         Vk6mVEWtMWK2oO61ssioQdVltMzBBNVZ03vcJYNvjRhO4C9JtykrcTb6iVOrBbNxTUce
         rrr5Ztmagt0UBcYIQR7CrrZlra9JPlaxdaHCoPFANox5Y0oL6CihHt3stoNU/LBZe3wx
         9s7Q==
X-Gm-Message-State: AOJu0Yz1bYLZs9tdi8DccFrPWdoxHXUiwBTAn7puIJz9sbPhytEZCmOL
	Ijl0XUplWMFhOjIfnaK6z2T3wLTWofBIBtinNzVV/t9vORQ/J/jVUp0iFWJHkdotcEtnMfKZzLD
	3vGE=
X-Google-Smtp-Source: AGHT+IHCf3gSyDwpxMQqAwcZOEE99Um3U9jb5cEHcYXAVoTC005pLQoY23vpn4Os61gkSYgimn/PHg==
X-Received: by 2002:a05:6870:65a4:b0:221:ced3:4748 with SMTP id fp36-20020a05687065a400b00221ced34748mr6602625oab.24.1710175603623;
        Mon, 11 Mar 2024 09:46:43 -0700 (PDT)
Received: from soleen.c.googlers.com.com (150.254.86.34.bc.googleusercontent.com. [34.86.254.150])
        by smtp.gmail.com with ESMTPSA id d27-20020a05620a137b00b00788228fbe05sm2851589qkl.17.2024.03.11.09.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:46:43 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	x86@kernel.org,
	bp@alien8.de,
	brauner@kernel.org,
	bristot@redhat.com,
	bsegall@google.com,
	dave.hansen@linux.intel.com,
	dianders@chromium.org,
	dietmar.eggemann@arm.com,
	eric.devolder@oracle.com,
	hca@linux.ibm.com,
	hch@infradead.org,
	hpa@zytor.com,
	jacob.jun.pan@linux.intel.com,
	jgg@ziepe.ca,
	jpoimboe@kernel.org,
	jroedel@suse.de,
	juri.lelli@redhat.com,
	kent.overstreet@linux.dev,
	kinseyho@google.com,
	kirill.shutemov@linux.intel.com,
	lstoakes@gmail.com,
	luto@kernel.org,
	mgorman@suse.de,
	mic@digikod.net,
	michael.christie@oracle.com,
	mingo@redhat.com,
	mjguzik@gmail.com,
	mst@redhat.com,
	npiggin@gmail.com,
	peterz@infradead.org,
	pmladek@suse.com,
	rick.p.edgecombe@intel.com,
	rostedt@goodmis.org,
	surenb@google.com,
	tglx@linutronix.de,
	urezki@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	pasha.tatashin@soleen.com
Subject: [RFC 00/14] Dynamic Kernel Stacks
Date: Mon, 11 Mar 2024 16:46:24 +0000
Message-ID: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is follow-up to the LSF/MM proposal [1]. Please provide your
thoughts and comments about dynamic kernel stacks feature. This is a WIP
has not been tested beside booting on some machines, and running LKDTM
thread exhaust tests. The series also lacks selftests, and
documentations.

This feature allows to grow kernel stack dynamically, from 4KiB and up
to the THREAD_SIZE. The intend is to save memory on fleet machines. From
the initial experiments it shows to save on average 70-75% of the kernel
stack memory.

The average depth of a kernel thread depends on the workload, profiling,
virtualization, compiler optimizations, and driver implementations.
However, the table below shows the amount of kernel stack memory before
vs. after on idling freshly booted machines:

CPU           #Cores #Stacks  BASE(kb) Dynamic(kb)   Saving
AMD Genoa        384    5786    92576       23388    74.74%
Intel Skylake    112    3182    50912       12860    74.74%
AMD Rome         128    3401    54416       14784    72.83%
AMD Rome         256    4908    78528       20876    73.42%
Intel Haswell     72    2644    42304       10624    74.89%

Some workloads with that have millions of threads would can benefit
significantly from this feature.

[1] https://lore.kernel.org/all/CA+CK2bBYt9RAVqASB2eLyRQxYT5aiL0fGhUu3TumQCyJCNTWvw@mail.gmail.com

Pasha Tatashin (14):
  task_stack.h: remove obsolete __HAVE_ARCH_KSTACK_END check
  fork: Clean-up ifdef logic around stack allocation
  fork: Clean-up naming of vm_strack/vm_struct variables in vmap stacks
    code
  fork: Remove assumption that vm_area->nr_pages equals to THREAD_SIZE
  fork: check charging success before zeroing stack
  fork: zero vmap stack using clear_page() instead of memset()
  fork: use the first page in stack to store vm_stack in cached_stacks
  fork: separate vmap stack alloction and free calls
  mm/vmalloc: Add a get_vm_area_node() and vmap_pages_range_noflush()
    public functions
  fork: Dynamic Kernel Stacks
  x86: add support for Dynamic Kernel Stacks
  task_stack.h: Clean-up stack_not_used() implementation
  task_stack.h: Add stack_not_used() support for dynamic stack
  fork: Dynamic Kernel Stack accounting

 arch/Kconfig                     |  33 +++
 arch/x86/Kconfig                 |   1 +
 arch/x86/kernel/traps.c          |   3 +
 arch/x86/mm/fault.c              |   3 +
 include/linux/mmzone.h           |   3 +
 include/linux/sched.h            |   2 +-
 include/linux/sched/task_stack.h |  94 ++++++--
 include/linux/vmalloc.h          |  15 ++
 kernel/fork.c                    | 388 ++++++++++++++++++++++++++-----
 kernel/sched/core.c              |   1 +
 mm/internal.h                    |   9 -
 mm/vmalloc.c                     |  24 ++
 mm/vmstat.c                      |   3 +
 13 files changed, 487 insertions(+), 92 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


