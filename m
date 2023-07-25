Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8786A761A52
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjGYNpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjGYNpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:45:39 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F782129;
        Tue, 25 Jul 2023 06:45:12 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R9J970C40zCrLk;
        Tue, 25 Jul 2023 21:41:47 +0800 (CST)
Received: from huawei.com (10.67.174.205) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 21:45:09 +0800
From:   Chen Jiahao <chenjiahao16@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <conor.dooley@microchip.com>, <guoren@kernel.org>,
        <heiko@sntech.de>, <bjorn@rivosinc.com>, <alex@ghiti.fr>,
        <akpm@linux-foundation.org>, <atishp@rivosinc.com>,
        <bhe@redhat.com>, <thunder.leizhen@huawei.com>, <horms@kernel.org>
CC:     <chenjiahao16@huawei.com>
Subject: [PATCH -next v8 0/2] support allocating crashkernel above 4G explicitly on riscv
Date:   Tue, 25 Jul 2023 21:44:10 +0000
Message-ID: <20230725214413.2488159-1-chenjiahao16@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.205]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On riscv, the current crash kernel allocation logic is trying to
allocate within 32bit addressible memory region by default, if
failed, try to allocate without 4G restriction.

In need of saving DMA zone memory while allocating a relatively large
crash kernel region, allocating the reserved memory top down in
high memory, without overlapping the DMA zone, is a mature solution.
Hence this patchset introduces the parameter option crashkernel=X,[high,low].

One can reserve the crash kernel from high memory above DMA zone range
by explicitly passing "crashkernel=X,high"; or reserve a memory range
below 4G with "crashkernel=X,low". Besides, there are few rules need
to take notice:
1. "crashkernel=X,[high,low]" will be ignored if "crashkernel=size"
   is specified.
2. "crashkernel=X,low" is valid only when "crashkernel=X,high" is passed
   and there is enough memory to be allocated under 4G.
3. When allocating crashkernel above 4G and no "crashkernel=X,low" is
   specified, a 128M low memory will be allocated automatically for
   swiotlb bounce buffer.
See Documentation/admin-guide/kernel-parameters.txt for more information.

To verify loading the crashkernel, adapted kexec-tools is attached below:
https://github.com/chenjh005/kexec-tools/tree/build-test-riscv-v2

Following test cases have been performed as expected:
1) crashkernel=256M                          //low=256M
2) crashkernel=1G                            //low=1G
3) crashkernel=4G                            //high=4G, low=128M(default)
4) crashkernel=4G crashkernel=256M,high      //high=4G, low=128M(default), high is ignored
5) crashkernel=4G crashkernel=256M,low       //high=4G, low=128M(default), low is ignored
6) crashkernel=4G,high                       //high=4G, low=128M(default)
7) crashkernel=256M,low                      //low=0M, invalid
8) crashkernel=4G,high crashkernel=256M,low  //high=4G, low=256M
9) crashkernel=4G,high crashkernel=4G,low    //high=0M, low=0M, invalid
10) crashkernel=512M@0xd0000000              //low=512M
11) crashkernel=1G,high crashkernel=0M,low   //high=1G, low=0M

Changes since [v8]:
1. Rebase to newest mainline head, not modifying any code logic.

Changes since [v7]:
1. Minor refactor: move crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE
   into the !high branch when the first allocation fails. Not changing
   the result but further align with Arm64 logic, refer to Baoquan's
   comment.
2. Add test case "crashkernel=1G,high crashkernel=0M,low", the result
   also matches our expectation.

Changes since [v6]:
1. Introduce the "high" flag to mark whether "crashkernel=X,high"
   is passed. Fix the retrying logic between "crashkernel=X,high"
   case and others when the first allocation attempt fails.

Changes since [v5]:
1. Update the crashkernel allocation logic when crashkernel=X,high
   is specified. In this case, region above 4G will directly get
   reserved as crashkernel, rather than trying lower 32bit allocation
   first.

Changes since [v4]:
1. Update some imprecise code comments for cmdline parsing.

Changes since [v3]:
1. Update to print warning and return explicitly on failure when
   crashkernel=size@offset is specified. Not changing the result
   in this case but making the logic more straightforward.
2. Some minor cleanup.

Changes since [v2]:
1. Update the allocation logic to ensure the high crashkernel
   region is reserved strictly above dma32_phys_limit.
2. Clean up some minor format problems.

Chen Jiahao (2):
  riscv: kdump: Implement crashkernel=X,[high,low]
  docs: kdump: Update the crashkernel description for riscv

 .../admin-guide/kernel-parameters.txt         | 15 +--
 arch/riscv/kernel/setup.c                     |  5 +
 arch/riscv/mm/init.c                          | 93 +++++++++++++++++--
 3 files changed, 99 insertions(+), 14 deletions(-)

-- 
2.34.1

