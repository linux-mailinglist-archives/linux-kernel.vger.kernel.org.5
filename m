Return-Path: <linux-kernel+bounces-107422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1CE87FC4A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD957B21F92
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9867E588;
	Tue, 19 Mar 2024 10:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Q7tT/TcJ"
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5C85BAF0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710845715; cv=none; b=rTfGXLZyVKGaZHGxGBfu7BsmeVaV+A6Z9V2y9BEfixYI/OdddtJsXyVfyt7Lj/eoOFJmGj2r9nR6nkog2JBLdjDBW9IJ7jHG7qlr+dJv0k9UQgo9ROxh8NKq0lhPUa8xlbdxd2jbOPMg8ESygA8TWLMro7+OWvl/JDSXdOKJeNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710845715; c=relaxed/simple;
	bh=titjicsS13zyLYpwVbjFKzsdWlMZsZ9iAVihS7vtrRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ghkx6RZmLE2SUfzn7KXeJY5zVkJEg/24SqpHT4et7WClcM0bb8YJHobIHGQ4rsKWtvPn5NDOUWqiI39uMBdFC2myiidUUc9f8Sf9GKTet+8JzHFRNrqXkr0P3W8Ko9wXD7ktx5mnSbZYxKUEi/SyMGW83WLMOYjQ+z1mdS9RHiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Q7tT/TcJ; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TzT4G1GLBzMq3Gc;
	Tue, 19 Mar 2024 11:49:18 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4TzT4D5thVzvGg;
	Tue, 19 Mar 2024 11:49:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1710845358;
	bh=titjicsS13zyLYpwVbjFKzsdWlMZsZ9iAVihS7vtrRU=;
	h=From:To:Cc:Subject:Date:From;
	b=Q7tT/TcJvK7xnZ0yNnH8RKseTWW7HMLg8r+H4B7xE+inCtDOxMj/yIS0gmUAS574p
	 d1VT8nzN0WuOf/YgPmyMQPrKaMGUA+ZhjzVHME00J/VthdkIqwsIZEFZc80GJoFmyR
	 cBePVO0WziY1W198OVLF5Mx5uDP8hjU07byNStJ4=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Kees Cook <keescook@chromium.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Marco Pagani <marpagan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Thara Gopinath <tgopinath@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Zahra Tarkhani <ztarkhani@microsoft.com>,
	kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH v3 0/7] Handle faults in KUnit tests
Date: Tue, 19 Mar 2024 11:48:50 +0100
Message-ID: <20240319104857.70783-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

This patch series teaches KUnit to handle kthread faults as errors, and
it brings a few related fixes and improvements.

Shuah, everything should be OK now, could you please merge this series?

All these tests pass (on top of v6.8):
/tools/testing/kunit/kunit.py run --alltests
/tools/testing/kunit/kunit.py run --alltests --arch x86_64
/tools/testing/kunit/kunit.py run --alltests --arch arm64 \
  --cross_compile=aarch64-linux-gnu-

I added Reviewed-by, Tested-by and Fixes tags according to previous
review.  I improved a commit message and added a comment.

A new test case check NULL pointer dereference, which wasn't possible
before.

This is useful to test current kernel self-protection mechanisms or
future ones such as Heki: https://github.com/heki-linux

Previous version:
v2: https://lore.kernel.org/r/20240301194037.532117-1-mic@digikod.net
v1: https://lore.kernel.org/r/20240229170409.365386-1-mic@digikod.net

Regards,

Mickaël Salaün (7):
  kunit: Handle thread creation error
  kunit: Fix kthread reference
  kunit: Fix timeout message
  kunit: Handle test faults
  kunit: Fix KUNIT_SUCCESS() calls in iov_iter tests
  kunit: Print last test location on fault
  kunit: Add tests for fault

 include/kunit/test.h      | 24 ++++++++++++++++++---
 include/kunit/try-catch.h |  3 ---
 lib/kunit/kunit-test.c    | 45 ++++++++++++++++++++++++++++++++++++++-
 lib/kunit/try-catch.c     | 38 ++++++++++++++++++++++-----------
 lib/kunit_iov_iter.c      | 18 ++++++++--------
 5 files changed, 100 insertions(+), 28 deletions(-)


base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
-- 
2.44.0


