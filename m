Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B787907D0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 14:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352137AbjIBM2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 08:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbjIBM2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 08:28:35 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A1F10E0
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 05:28:28 -0700 (PDT)
Received: from dggpemm500013.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RdDcj0cQvzQjL0;
        Sat,  2 Sep 2023 20:25:09 +0800 (CST)
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 2 Sep
 2023 20:28:24 +0800
Message-ID: <0992af32-adc6-a1eb-1b15-d8880b79d61f@huawei.com>
Date:   Sat, 2 Sep 2023 20:28:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Content-Language: en-US
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <peterz@infradead.org>, <jpoimboe@kernel.org>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
Subject: [BUG] x86/entry: ORC stack unwinding error on error_entry
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My KASAN reported a stack-out-of-bounds BUG in unwind_next_frame
I found there was a wrong stack unwinding on error_entry and the
stack was like:

<NMI>
...
exc_nmi
end_repeat_nmi
RIP: 0010:error_entry+0x17
RSP: 0018:ffff88de81889928 EFLAGS: 00000082
RAX: 0000000000000000 RBX: ffff88de81889a98 RCX: ffffffff9cec64a9
RDX: dffffc0000000000 RSI: ffffffff9e400cfa RDI: ffffffff9e400d01
RBP: 1ffff11bd031133c R08: ffffffff9cec6406 R09: ffff88de81889acc
R10: fffffbfff40bb517 R11: 0000000000000001 R12: 0000000000000001
R13: ffff88de81889ae0 R14: ffffffff9f2ee640 R15: 0000000000000000
</NMI>
<IRQ>
asm_sysvec_apic_timer_interrupt+0x11
RIP: 9e2d0a66:unwind_next_frame+0x0
RSP: 81889ab8:ffff88de81889ab8 EFLAGS: ffff88b11727fd48 ORIG_RAX: 
ffffffff9eecdff0
RAX: ffff88b11727fd48 RBX: 0000000000000018 RCX: ffff88de81889acd
RDX: ffffffff9e400d02 RSI: ffff88b11727fd40 RDI: 0000000041b58ab3
RBP: ffff88de818899a0 R08: ffffffff9e400d02 R09: ffff88de81889ae8
R10: ffff88de81889ad0 R11: ffffffff9cec64bf R12: 0000000000000282
R13: 0000000000000010 R14: ffffffff9cec6150 R15: ffffffffffffffff
(orc unwinding stopped here)

It's because in error_entry the return address is changed. When 
asm_sysvec_apic_timer_interrupt calls error_entry, the stack looks like:

     asm_sysvec_apic_timer_interrupt+0xa
     ffffffffffffffff
     (IRET_REGS) <- idtentry unwind stack by IRET_REGS

Then error_entry enters PUSH_AND_CLEAR_REGS save_ret=1, which will
change the return address:

     pushq	%rsi
     movq	8(%rsp), %rsi
     movq	%rdi, 8(%rsp)
     (push other regs)
     UNWIND_HINT_REGS

And the stack is changed to:

     (other regs)
     %rsi
     %rdi (asm_sysvec_apic_timer_interrupt+0x11, in this case)
     ffffffffffffffff
     (IRET_REGS)

If there is a NMI happens before all regs are pushed and unwinding hint
changed to UNWIND_HINT_REGS, the unwinding in error_entry is wrong.
It find %rdi as the return address and search the next orc_entry,
which makes unwinding fail.

I guess this can be fixed if it keeps the pt_regs->di slot as return 
address until all regs are pushed to stack and unwind hint changed to 
UNWIND_HINT_REGS, then overwrite the return address to %rdi.

     UNWIND_HINT_REGS

     .if \save_ret
     movq	0x70(%rsp), %rsi
     movq	%rdi, 0x70(%rsp)
     pushq	%rsi
     .endif

However I'm not sure if it works or there is any side affect (at lease 
it looks not so graceful). Does anyone has some advise for this bug or 
this fix?
I'll test this after I can reproduce the bug stably.

Thanks.
