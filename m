Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AE579F8E9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 05:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbjINDcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 23:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjINDcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 23:32:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 183331BDA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 20:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694662316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hudU0FKKSfKGoT5NXgs2s+9GzsdTCr22QtjS8oAgCWE=;
        b=jKcJGG6u2F+3bvAtcRmyAyHpYT/6p111/i/sfAlkdefmi/N0BWqmDAQS23JRt8+5DoMeA4
        AByq8N6cUdycVZDhJUJropJv36KsjL9BgC/QGNHPsvK4NZAfadoL0YS1mKi0AftpZA9gS5
        ELB7vg/WbISXL5DCtNNRYtnsmO27VBk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-_icoECdnMROGvFx-gn-GJA-1; Wed, 13 Sep 2023 23:31:50 -0400
X-MC-Unique: _icoECdnMROGvFx-gn-GJA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC9EC857A9D;
        Thu, 14 Sep 2023 03:31:49 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98D0F10085C0;
        Thu, 14 Sep 2023 03:31:45 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, thunder.leizhen@huawei.com,
        catalin.marinas@arm.com, chenjiahao16@huawei.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 0/9] kdump: use generic functions to simplify crashkernel reservation in arch
Date:   Thu, 14 Sep 2023 11:31:33 +0800
Message-ID: <20230914033142.676708-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current arm64, crashkernel=,high support has been finished after
several rounds of posting and careful reviewing. The code in arm64 which
parses crashkernel kernel parameters firstly, then reserve memory can be
a good example for other ARCH to refer to.

Whereas in x86_64, the code mixing crashkernel parameter parsing and
memory reserving is twisted, and looks messy. Refactoring the code to
make it more readable maintainable is necessary.

Here, firstly abstract the crashkernel parameter parsing code into
parse_crashkernel() to make it be able to parse crashkernel=,high|low.
Then abstract the crashkernel memory reserving code into a generic
function reserve_crashkernel_generic(). Finally, in ARCH which
crashkernel=,high support is needed, a simple arch_reserve_crashkernel()
can be added to call above two functions. This can remove the duplicated
implmentation code in each ARCH, like arm64, x86_64 and riscv.

I only did testing on x86_64 and arm64 for below cases, haven't tested
riscv. If riscv people can help apply the patchset and give it a shot,
it would be great.

crashkernel=512M,high
crashkernel=512M,high crashkernel=256M,low
crashkernel=512M,high crashkernel=0M,low
crashkernel=0M,high crashkernel=256M,low
crashkernel=512M
crashkernel=512M@0x4f000000
crashkernel=1G-4G:256M,4G-64G:320M,64G-:576M
crashkernel=0M

History:
v2->v3:
- Move crashk_res and crashk_low_res codes into crash_core.c, and add
  <asm/crash_core.h> including in <linux/crash_core.h>. These two fix
  compiling error reported by LKP when CONFIG_CRASH_CORE=on while
  CONFIG_KEXEC_CORE is unset.
- Adjust the if-else and return logic in parse_crashkernel() according
  to Lei's suggestion.
- Make riscv use the generic interface to simplify crahskernel
  reservation code too since crashkernel=,high support has been added
  into riscv.
- Some minor changes suggested by Lei.

v1->v2:
- Change to add asm/crash_core.h into x86 and arm64 to contain those
  arch specific macro definitions for generic reservaton. This fixes the
  compiling error reported by LKP in v1.
  https://lore.kernel.org/all/202308272150.p3kRkMoF-lkp@intel.com/T/#u
- Fix a log typo in patch 8, thanks to Samuel.

- RFC->v1:
  https://lore.kernel.org/all/20230619055951.45620-1-bhe@redhat.com/T/#u
  [RFC PATCH 0/4] kdump: add generic functions to simplify crashkernel crashkernel in architecture
  Dave and Philipp commented the old parse_crashkernel_common() and
  parse_crashkernel_generic() are quite confusing. In this formal post,
  I made change to address the concern by unifying all crashkernel
  parsing into parse_crashkernel().


Baoquan He (9):
  crash_core.c: remove unnecessary parameter of function
  crash_core: change the prototype of function parse_crashkernel()
  crash_core: change parse_crashkernel() to support
    crashkernel=,high|low parsing
  crash_core: add generic function to do reservation
  crash_core: move crashk_*res definition into crash_core.c
  x86: kdump: use generic interface to simplify crashkernel reservation
    code
  arm64: kdump: use generic interface to simplify crashkernel
    reservation
  riscv: kdump: use generic interface to simplify crashkernel
    reservation
  crash_core.c: remove unneeded functions

 arch/arm/kernel/setup.c              |   3 +-
 arch/arm64/Kconfig                   |   3 +
 arch/arm64/include/asm/crash_core.h  |  10 ++
 arch/arm64/mm/init.c                 | 140 ++------------------
 arch/ia64/kernel/setup.c             |   2 +-
 arch/loongarch/kernel/setup.c        |   4 +-
 arch/mips/kernel/setup.c             |   3 +-
 arch/powerpc/kernel/fadump.c         |   2 +-
 arch/powerpc/kexec/core.c            |   2 +-
 arch/powerpc/mm/nohash/kaslr_booke.c |   2 +-
 arch/riscv/Kconfig                   |   3 +
 arch/riscv/include/asm/crash_core.h  |  11 ++
 arch/riscv/include/asm/processor.h   |   2 +
 arch/riscv/mm/init.c                 | 141 ++------------------
 arch/s390/kernel/setup.c             |   4 +-
 arch/sh/kernel/machine_kexec.c       |   2 +-
 arch/x86/Kconfig                     |   3 +
 arch/x86/include/asm/crash_core.h    |  34 +++++
 arch/x86/kernel/setup.c              | 143 +++------------------
 include/linux/crash_core.h           |  49 ++++++-
 include/linux/kexec.h                |   4 -
 kernel/crash_core.c                  | 184 ++++++++++++++++++++++++---
 kernel/kexec_core.c                  |  17 ---
 23 files changed, 321 insertions(+), 447 deletions(-)
 create mode 100644 arch/arm64/include/asm/crash_core.h
 create mode 100644 arch/riscv/include/asm/crash_core.h
 create mode 100644 arch/x86/include/asm/crash_core.h

-- 
2.41.0

