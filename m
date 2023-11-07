Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945037E3B6A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjKGME0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKGMEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:04:24 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B84A5113;
        Tue,  7 Nov 2023 04:04:19 -0800 (PST)
Received: from loongson.cn (unknown [10.2.5.213])
        by gateway (Coremail) with SMTP id _____8CxruvAJ0pl2qw3AA--.40974S3;
        Tue, 07 Nov 2023 20:04:16 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axji+_J0plPBo7AA--.63299S2;
        Tue, 07 Nov 2023 20:04:15 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Tianrui Zhao <zhaotianrui@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] LoongArch: KVM: Remove SW timer switch when vcpu is halt polling
Date:   Tue,  7 Nov 2023 20:04:11 +0800
Message-Id: <20231107120414.1927261-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axji+_J0plPBo7AA--.63299S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7JF1xtr45WFWfAryDCry7CFX_yoW8JrWUpF
        ZxCFnxXr4FkrWFq3W7ta1DXrnrX34fKFy7XwnFkFyrCr47Aw1FvFW8Kr95XFy3J393ArWI
        vryrt3W5uFyUAacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
        14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches removes SW timer switch during vcpu block stage. VM uses HW
timer rather than SW PV timer on LoongArch system, it can check HW timer
pending interrupt status directly, rather than switch to SW timer and
check injected SW timer interrupt.

When SW timer is not used in vcpu block polling status, the relative
SW timer handling before entering guest can be removed also. Timer
emulation is simpler than before, SW timer emuation is only used in vcpu
thread context switch.

---
Changes in v2:
  Add halt polling support for idle instruction emulation, using api
kvm_vcpu_halt rather than kvm_vcpu_block in function kvm_emu_idle.

---
Bibo Mao (3):
  LoongArch: KVM: Remove SW timer switch when vcpu is halt polling
  LoongArch: KVM: Allow to access HW timer CSR registers always
  LoongArch: KVM: Remove kvm_acquire_timer before entering guest

 arch/loongarch/include/asm/kvm_vcpu.h |  1 -
 arch/loongarch/kvm/exit.c             | 13 +-------
 arch/loongarch/kvm/main.c             |  1 -
 arch/loongarch/kvm/timer.c            | 48 ++++++++-------------------
 arch/loongarch/kvm/vcpu.c             | 38 +++++----------------
 5 files changed, 22 insertions(+), 79 deletions(-)


base-commit: d2f51b3516dade79269ff45eae2a7668ae711b25
-- 
2.39.3

