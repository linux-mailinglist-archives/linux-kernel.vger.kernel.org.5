Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5726A771C33
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjHGIXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjHGIXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:23:22 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C64C10EF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 01:23:18 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 3778N83c098807;
        Mon, 7 Aug 2023 16:23:08 +0800 (+08)
        (envelope-from dylan@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Mon, 7 Aug 2023
 16:23:07 +0800
From:   Dylan Jhong <dylan@andestech.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <ajones@ventanamicro.com>,
        <alexghiti@rivosinc.com>, <anup@brainfault.org>, <rppt@kernel.org>,
        <samuel@sholland.org>, <panqinglin2020@iscas.ac.cn>,
        <sergey.matyukevich@syntacore.com>, <maz@kernel.org>,
        <linux-riscv@lists.infradead.org>, <conor.dooley@microchip.com>,
        <linux-kernel@vger.kernel.org>
CC:     <ycliang@andestech.com>, <x5710999x@gmail.com>,
        <tim609@andestech.com>, Dylan Jhong <dylan@andestech.com>
Subject: [PATCH 0/1] Enhanced TLB flushing for vmap/vmalloc()
Date:   Mon, 7 Aug 2023 16:23:04 +0800
Message-ID: <20230807082305.198784-1-dylan@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 3778N83c098807
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is actually the v2 version of the this patch[1]. In the v1 version,
Alexandre suggested that I should make the patch more general, so I even changed
the title accordingly. Many thanks to Alexandre.

And Alexandre also submitted a similar patch[2] recently, in which he implemented
TLB flushing via flush_cache_vmap() instead. However, it seems that flush_cache_vmap()
does not cover every place where arch_sync_kernel_mappings() performs TLB flushing.
IMHO, arch_sync_kernel_mappings() cannot be replaced by flush_cache_vmap().
Please correct me if I'm wrong!

[1]: [PATCH] riscv: Flush stale TLB entry with VMAP_STACK enabled
     http://lists.infradead.org/pipermail/linux-riscv/2023-August/037503.html

[2]: [PATCH -fixes] riscv: Implement flush_cache_vmap()
     https://www.spinics.net/lists/kernel/msg4873712.html

Dylan Jhong (1):
  riscv: Implement arch_sync_kernel_mappings() for "preventive" TLB
    flush

 arch/riscv/include/asm/page.h |  2 ++
 arch/riscv/mm/tlbflush.c      | 12 ++++++++++++
 2 files changed, 14 insertions(+)

-- 
2.34.1

