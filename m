Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451A175C160
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjGUIVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjGUIVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:21:25 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF5A273C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:21:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R6jF468SDz4f44St
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:21:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgAHoZT2P7pkhprcOQ--.24672S4;
        Fri, 21 Jul 2023 16:21:13 +0800 (CST)
From:   thunder.leizhen@huaweicloud.com
To:     Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 0/3] arm64: kdump: Restore the write protection for the crashkernel memory region
Date:   Fri, 21 Jul 2023 16:17:23 +0800
Message-Id: <20230721081726.882-1-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHoZT2P7pkhprcOQ--.24672S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFyDGrykWr4UAw4rtF1kZrb_yoW8Xw47pa
        yUu343Gr1DJFs7Jwn3Zws7uw15Cw48Gry5XwsIkwn09rnxur1vyrnIqFnFgFW8GrySvay7
        XFW5trnIg3W8AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r106r1rM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lw4CEc2x0
        rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8
        04iUUUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

Unlike in the past, the low memory allocation direction of the crashkernel is
changed from top-down to bottom-up. As long as the DMA zone has sufficient
continuous free memory, the allocated crashkernel low memory must meet the
requirements. The allocation direction of crashkernel high memory remains
unchanged, that is, top-down. As long as the high memory(above DMA zone) has
sufficient continuous free memory, the allocated crashkernel high memory must
meet the requirements. In this way, with the restoration of the original
page-level mapping and the implementation of the arch_kexec_protect_crashkres()
function, write protection for the crashkernel memory region can be supported.

Of course, if the high memory or low memory cannot meet the initial requirements,
that is, fall back is required. In this case, write protection is not supported
because the newly allocated memory is not page-level mapped.

Because the original retry process is eliminated, the new process looks clearer
and is a simple sequential flow.


Zhen Lei (3):
  arm64: kdump: Allocate crash low memory in the bottom-up direction
  arm64: kdump: use page-level mapping for crashkernel region
  arm64: kdump: add support access protection for crashkernel region

 arch/arm64/include/asm/kexec.h    |   8 ++
 arch/arm64/kernel/machine_kexec.c |  26 ++++
 arch/arm64/mm/init.c              | 216 +++++++++++++++++++++++-------
 arch/arm64/mm/mmu.c               |  21 +++
 4 files changed, 219 insertions(+), 52 deletions(-)

-- 
2.25.1

