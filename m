Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDFF7E7FD8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbjKJSAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjKJR72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:59:28 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A9ACD080;
        Fri, 10 Nov 2023 01:07:58 -0800 (PST)
Received: from loongson.cn (unknown [10.2.5.213])
        by gateway (Coremail) with SMTP id _____8AxEvDq8k1lS7I4AA--.45479S3;
        Fri, 10 Nov 2023 17:07:55 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxkN3q8k1l6vU9AA--.7142S2;
        Fri, 10 Nov 2023 17:07:54 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Tianrui Zhao <zhaotianrui@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] LoongArch: KVM: Remove SW timer switch when vcpu is halt polling
Date:   Fri, 10 Nov 2023 17:05:26 +0800
Message-Id: <20231110090529.56950-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxkN3q8k1l6vU9AA--.7142S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AF4rZryDJry3Gw48Kw4xKrX_yoW8Jw47pF
        ZxCFnxXr40krWYg3W7ta1DWFn7WrW8KFy7JrnIkF1rCr17Aw1FqFW8Kr95XFy3Ja93AryI
        vryrt3W5ua4UA3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1a6r1DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
        67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUoxR6UUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches removes SW timer switch during vcpu block stage. VM uses HW
timer rather than SW PV timer on LoongArch system, it can check pending
HW timer interrupt status directly, rather than switch to SW timer and
check injected SW timer interrupt.

When SW timer is not used in vcpu halt-polling mode, the relative
SW timer handling before entering guest can be removed also. Timer
emulation is simpler than before, SW timer emuation is only used in vcpu
thread context switch.

---

Changes in v3:
  Add kvm_arch_vcpu_runnable checking before kvm_vcpu_halt.

Changes in v2:
  Add halt polling support for idle instruction emulation, using api
kvm_vcpu_halt rather than kvm_vcpu_block in function kvm_emu_idle.

---

Bibo Mao (3):
  LoongArch: KVM: Remove SW timer switch when vcpu is halt polling
  LoongArch: KVM: Allow to access HW timer CSR registers always
  LoongArch: KVM: Remove kvm_acquire_timer before entering guest

 arch/loongarch/include/asm/kvm_vcpu.h |  1 -
 arch/loongarch/kvm/exit.c             | 13 ++------
 arch/loongarch/kvm/main.c             |  1 -
 arch/loongarch/kvm/timer.c            | 47 +++++++--------------------
 arch/loongarch/kvm/vcpu.c             | 38 +++++-----------------
 5 files changed, 22 insertions(+), 78 deletions(-)


base-commit: 305230142ae0637213bf6e04f6d9f10bbcb74af8
-- 
2.39.3

