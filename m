Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CE38122F9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 00:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442670AbjLMXgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 18:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbjLMXge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 18:36:34 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC7EE3;
        Wed, 13 Dec 2023 15:36:40 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDKbIKL023765;
        Wed, 13 Dec 2023 23:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=1sqwURtrRmpH1GSUKQpPj5IkE7uQ5w4CTeMN57eEciQ=;
 b=N6W1XFpH1CdMGB1QqczvQWaiuOzf0K1xcXrMTUQhbmDFrG0OIOEd5On5BgA2XHHMVyXz
 Fx9haEPF8ilkkZqHxCT1oUA60HBLbn1NK3h9n4fJGskw2qvQPE9AKLekaLdcNZi4q43Z
 EXeXYHnHeRp6NH2zYoVVLrA06wRGkjecTdk79FxuWbeBRG27Lf1/pAZCKp5vEHyf0iyi
 /r1yaXtZSunv4c9mNqtkJwVTnXDgYkPSVuSt+KJn6WLS9NGaYszoynajhy/EIoL1s8og
 RJFpyE7iLndQ3uSeorzNp2b8j2g8DXymaJIjlyJFcYLwdZHkZzYwehayR6tbl3ww2Omu uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uyktbv0q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 23:36:17 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BDNCtRu028993;
        Wed, 13 Dec 2023 23:36:16 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uyktbv0pc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 23:36:16 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDGkI3H014819;
        Wed, 13 Dec 2023 23:36:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw42kg1x2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 23:36:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BDNaAMr44237472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Dec 2023 23:36:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18DFE2004B;
        Wed, 13 Dec 2023 23:36:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A01C320040;
        Wed, 13 Dec 2023 23:36:08 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.70.156])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 13 Dec 2023 23:36:08 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 00/34] kmsan: Enable on s390
Date:   Thu, 14 Dec 2023 00:24:20 +0100
Message-ID: <20231213233605.661251-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 561mDTmsINwMN72Ah6BOtZlL15AzLfxe
X-Proofpoint-ORIG-GUID: Ogx47gAVtFngw5Il2WLfvhq0DJQYKCB0
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_14,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130167
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: https://lore.kernel.org/lkml/20231121220155.1217090-1-iii@linux.ibm.com/
v2 -> v3: Drop kmsan_memmove_metadata() and strlcpy() patches;
          Remove kmsan_get_metadata() stub;
          Move kmsan_enable_current() and kmsan_disable_current() to
          include/linux/kmsan.h, explain why a counter is needed;
          Drop the memset_no_sanitize_memory() patch;
          Use __memset() in the SLAB_POISON patch;
          Add kmsan-checks.h to the DFLTCC patch;
          Add recursion check to the arch_kmsan_get_meta_or_null()
          patch (Alexander P.).

          Fix inline + __no_kmsan_checks issues.
          New patch for s390/irqflags, that resolves a lockdep warning.
          New patch for s390/diag, that resolves a false positive when
          running on an LPAR.
          New patch for STCCTM, same as above.
          New patch for check_bytes_and_report() that resolves a false
          positive that occurs even on Intel.

v1: https://lore.kernel.org/lkml/20231115203401.2495875-1-iii@linux.ibm.com/
v1 -> v2: Add comments, sort #includes, introduce
          memset_no_sanitize_memory() and use it to avoid unpoisoning
          of redzones, change vmalloc alignment to _REGION3_SIZE, add
          R-bs (Alexander P.).

          Fix building
          [PATCH 28/33] s390/string: Add KMSAN support
          with FORTIFY_SOURCE.
          Reported-by: kernel test robot <lkp@intel.com>
          Closes: https://lore.kernel.org/oe-kbuild-all/202311170550.bSBo44ix-lkp@intel.com/

Hi,

This series provides the minimal support for Kernel Memory Sanitizer on
s390. Kernel Memory Sanitizer is clang-only instrumentation for finding
accesses to uninitialized memory. The clang support for s390 has already
been merged [1].

With this series, I can successfully boot s390 defconfig and
debug_defconfig with kmsan.panic=1. The tool found one real
s390-specific bug (fixed in master).

Best regards,
Ilya

[1] https://reviews.llvm.org/D148596

Ilya Leoshkevich (34):
  ftrace: Unpoison ftrace_regs in ftrace_ops_list_func()
  kmsan: Make the tests compatible with kmsan.panic=1
  kmsan: Disable KMSAN when DEFERRED_STRUCT_PAGE_INIT is enabled
  kmsan: Increase the maximum store size to 4096
  kmsan: Fix is_bad_asm_addr() on arches with overlapping address spaces
  kmsan: Fix kmsan_copy_to_user() on arches with overlapping address
    spaces
  kmsan: Remove a useless assignment from
    kmsan_vmap_pages_range_noflush()
  kmsan: Remove an x86-specific #include from kmsan.h
  kmsan: Expose kmsan_get_metadata()
  kmsan: Export panic_on_kmsan
  kmsan: Allow disabling KMSAN checks for the current task
  kmsan: Support SLAB_POISON
  kmsan: Use ALIGN_DOWN() in kmsan_get_metadata()
  mm: slub: Let KMSAN access metadata
  mm: slub: Unpoison the memchr_inv() return value
  mm: kfence: Disable KMSAN when checking the canary
  lib/zlib: Unpoison DFLTCC output buffers
  kmsan: Accept ranges starting with 0 on s390
  s390: Turn off KMSAN for boot, vdso and purgatory
  s390: Use a larger stack for KMSAN
  s390/boot: Add the KMSAN runtime stub
  s390/checksum: Add a KMSAN check
  s390/cpacf: Unpoison the results of cpacf_trng()
  s390/cpumf: Unpoison STCCTM output buffer
  s390/diag: Unpoison diag224() output buffer
  s390/ftrace: Unpoison ftrace_regs in kprobe_ftrace_handler()
  s390/irqflags: Do not instrument arch_local_irq_*() with KMSAN
  s390/mm: Define KMSAN metadata for vmalloc and modules
  s390/string: Add KMSAN support
  s390/traps: Unpoison the kernel_stack_overflow()'s pt_regs
  s390/uaccess: Add KMSAN support to put_user() and get_user()
  s390/unwind: Disable KMSAN checks
  s390: Implement the architecture-specific kmsan functions
  kmsan: Enable on s390

 Documentation/dev-tools/kmsan.rst   |   4 +-
 arch/s390/Kconfig                   |   1 +
 arch/s390/Makefile                  |   2 +-
 arch/s390/boot/Makefile             |   3 +
 arch/s390/boot/kmsan.c              |   6 ++
 arch/s390/boot/startup.c            |   8 ++
 arch/s390/boot/string.c             |  16 ++++
 arch/s390/include/asm/checksum.h    |   2 +
 arch/s390/include/asm/cpacf.h       |   3 +
 arch/s390/include/asm/cpu_mf.h      |   6 ++
 arch/s390/include/asm/irqflags.h    |  18 ++++-
 arch/s390/include/asm/kmsan.h       |  43 +++++++++++
 arch/s390/include/asm/pgtable.h     |  10 +++
 arch/s390/include/asm/string.h      |  20 +++--
 arch/s390/include/asm/thread_info.h |   2 +-
 arch/s390/include/asm/uaccess.h     | 111 ++++++++++++++++++++--------
 arch/s390/kernel/diag.c             |   2 +
 arch/s390/kernel/ftrace.c           |   2 +
 arch/s390/kernel/traps.c            |   6 ++
 arch/s390/kernel/unwind_bc.c        |   4 +
 arch/s390/kernel/vdso32/Makefile    |   3 +-
 arch/s390/kernel/vdso64/Makefile    |   3 +-
 arch/s390/purgatory/Makefile        |   2 +
 drivers/s390/char/sclp.c            |   2 +-
 include/linux/kmsan.h               |  33 +++++++++
 include/linux/kmsan_types.h         |   2 +-
 kernel/trace/ftrace.c               |   1 +
 lib/zlib_dfltcc/dfltcc.h            |   1 +
 lib/zlib_dfltcc/dfltcc_util.h       |  24 ++++++
 mm/Kconfig                          |   1 +
 mm/kfence/core.c                    |  11 ++-
 mm/kmsan/core.c                     |   1 -
 mm/kmsan/hooks.c                    |  23 ++++--
 mm/kmsan/init.c                     |   5 +-
 mm/kmsan/instrumentation.c          |  11 +--
 mm/kmsan/kmsan.h                    |   9 +--
 mm/kmsan/kmsan_test.c               |   5 ++
 mm/kmsan/report.c                   |   8 +-
 mm/kmsan/shadow.c                   |   9 +--
 mm/slub.c                           |  17 ++++-
 40 files changed, 360 insertions(+), 80 deletions(-)
 create mode 100644 arch/s390/boot/kmsan.c
 create mode 100644 arch/s390/include/asm/kmsan.h

-- 
2.43.0

