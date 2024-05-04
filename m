Return-Path: <linux-kernel+bounces-168482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9B78BB90A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 03:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59BE41C22B0C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B7A17F0;
	Sat,  4 May 2024 01:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zZeRAZ11"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9B0139B
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 01:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714784525; cv=none; b=pwAejNtMDGAyKZUMyK5GUicq4V2k3Yo52wcQmTH8z8VtdE/ydny6UwDMwuwwkzFCWaXlXqWHZ58trddNM9zp2cvywORtNgXuCnTYX4JTRddx8KcXr63twJJAGizrXvLCZPmxCT7gTP8e173mpcd6cal4/+lYT1T9zKRxYfd6FqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714784525; c=relaxed/simple;
	bh=7NGC8jsHT+YqDipa7xRv+Mcx3S6Osc3Ll6Mvx6lwgIE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mrv12Zik+wXbU5qalOqRHdfDO1M2Bxw0nARoh5YefU4nh6NWFAAoZUX4S4mBitkKiOE1+kkotc7kgllAOff6DhbFgYgLf3jznKxwbcrjNzdj5lfCGPc7SkllKpHS4Ynxe/6C+Oib4r89Q9NR+LrR1jKY7sm/ROWhlBW4gYHhwZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zZeRAZ11; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41a428374b9so12995e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 18:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714784522; x=1715389322; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aclV86EaSgEFELqsaFfOs1OLWHSbf908uEmsgFdeq3U=;
        b=zZeRAZ11nSZBgViS525FBqolpb3Z6W0B2KDo2b4EZyoDwjONBhZLFPAoUACMLba3WM
         U+QGdnWns+XRf6Q97FDDtko+wMNbdv3JlNXxRrTbosTj/qkfuRwUWH2Zt6+jqk4iAA1g
         yp3Z744+LHhpiacSvgcJb01LGJKiK2s+/C6jcRt6JrFJNz9oZEKW7U3frX3gFGP2i5FP
         RBRdJxDToNNgxPFIzR+n6iUqXiyBDhk808oIfQkC3qC2eAw0C8pES+/iYoMTyZa4GL3z
         gGveE+m0dQfpmiIpMxn3ZOvlxuIpQX92CE7z2YuEFkGRxi3tZMnN+My8TJMMyOX/GJ4I
         0fWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714784522; x=1715389322;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aclV86EaSgEFELqsaFfOs1OLWHSbf908uEmsgFdeq3U=;
        b=aw3msuA+LNVRwMcshSaPPXP77DxrnUAKtl4dtPRFj0sXg6l6S5irNgrQw7NUtDMjw/
         n7mWITjbW5Me0+c6HrGW3hMxiTNMi0bW1rwIK9cFkYpQ7O7CIKzG15zPJ2VsQgQusijH
         c5sakBJydzcSl7WvxDHoTcirFypy57AwtxAgUwTryBfDTSva7FNjaF6pL+XNxcw9p81A
         q57kskogNKM/YMP7FjDDJl8JnC7/UAjTdI3XuvmDQDda9RXRbLuhMI2UrIisKCRuxGdf
         xAiwI/tA9eMDccRquTLHobimn2zFEdT+7F5qG9zwGje8OvqcyDV7JBo2HnzIpcbO9DW+
         BVxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBn2fzCKv36uvAutObNBici2dNf4SvmMZMlr80xLEAE0CpqfByfYCek4YNAx7kK0bgeuW7fnscYrdTh+YmtXScouj9VckD74h5uo83
X-Gm-Message-State: AOJu0YwB7EvhDqDOhGFGbP3rL/UJmBMg8GCLWsiHuJP0/726GBHy9j3u
	Vbm3bIOHEAuPgTbONpHN60ZO4tam7DEqJ03qv2wBDSeMOk0ftBA9UngF1vB4ENkbKHTX2iYmGqA
	cqJlqjMDO57UNdJDVQ57CKwhi97JHOBihG58=
X-Google-Smtp-Source: AGHT+IH6FchxPanJhLoHd6da0gYqQw9bpE77KakmSl4+oCLrzq6McpVxNuCg4ennl9IZ6z3/9KKoD+5oKzUGlPmMC5E=
X-Received: by 2002:a05:600c:3b26:b0:41b:ff4e:c8a4 with SMTP id
 5b1f17b1804b1-41e5961f75fmr861765e9.0.1714784521740; Fri, 03 May 2024
 18:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John Stultz <jstultz@google.com>
Date: Fri, 3 May 2024 18:01:49 -0700
Message-ID: <CANDhNCq2n2HVUnVi0K+cw_7MUd1h49BzTxLEk6V3G2c=BBUYBw@mail.gmail.com>
Subject: WW_MUTEX_SELFTEST hangs w/ 6.9-rc workqueue changes
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Hey All,
   In doing some local testing, I noticed I've started to see boot
stalls with CONFIG_WW_MUTEX_SELFTEST with 6.9-rc on a 64cpu qemu
environment.

I've bisected the problem down to:
  5797b1c18919 (workqueue: Implement system-wide nr_active enforcement
for unbound workqueues)
+ the fix needed for that change:
  15930da42f89 (workqueue: Don't call cpumask_test_cpu() with -1 CPU
in wq_update_node_max_active())

I've seen problems in the past with the ww_mutex selftest code, so
it's likely a problem in the test itself, but I wanted to raise the
issue so folks were aware and see if there were suggestions for a
solution.

It seems to get stuck in __test_cycle() after a few runs when it hits
flush_workqueue()
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/locking/test-ww_mutex.c#n344

That seems to be because when the various work functions get queued,
they all don't seem to get a chance to run (they use a circular chain
of completions, so the 0th workfunc won't finish until after the
nrthreads-th workfunc runs).
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/locking/test-ww_mutex.c#n295

I'm noticing this happens when the test gets to nrthreads=9 (the test
usually goes up to NR_CPUS), so we queue work for 0->8 but the 9th
worker function never seems to run.  Looking at __queue_work() I do
see pwq_tryinc_nr_active() fails for that 9th work struct and we end
up inserting the work as inactive.

I notice the change that uncovers this issue(5797b1c18919), both
tweaks pwq_tryinc_nr_active() and sets the WQ_DFL_MIN_ACTIVE to 8, so
maybe that's a hint as to if the test is abusing the number of queueud
work functions? Though that seems odd because that's the min not the
max (which seems to be 512).

Anyway, let me know if there's anything further I can help share to
debug this. I'll continue digging here as well.

thanks
-john

