Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13195760D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjGYItO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjGYIr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:47:29 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876DF10F4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:45:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4R99Hd5P9wz9xtSH
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 16:31:57 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.48.128.235])
        by APP2 (Coremail) with SMTP id GxC2BwB3Ijlwi79kXB38BA--.63760S2;
        Tue, 25 Jul 2023 09:44:43 +0100 (CET)
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Liao Chang <liaochang1@huawei.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alyssa Ross <hi@alyssa.is>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
Subject: [PATCH v1 0/3] RISC-V: Fix a few kexec_file_load(2) failures
Date:   Tue, 25 Jul 2023 10:44:24 +0200
Message-Id: <cover.1690274483.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwB3Ijlwi79kXB38BA--.63760S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw1fGr48Cw17uFW3XFWrKrg_yoW3AFbEgF
        W8trZYqr1UtFn8XFZrKw4FqFW0krs5tFyjgwn8trW7t34UWry5Z3ZY9Fn2vr1UZrZ3W3sx
        ZrZ8Zr95Jr17tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbh8FF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F
        4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
        Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUnF4iUUUUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

The kexec_file_load(2) syscall does not work at least in some kernel
builds. For details see the relevant section in this blog post:

https://sigillatum.tesarici.cz/2023-07-21-state-of-riscv64-kdump.html

This patch series handles additional relocation types and removes the need
to implement a Global Offset Table (GOT) for the purgatory.

Petr Tesarik (2):
  riscv/kexec: handle R_RISCV_ADD16 and R_RISCV_SUB16 relocation types
  riscv/purgatory: do not link with string.o

Torsten Duwe (1):
  riscv/kexec: handle R_RISCV_CALL_PLT relocation type

 arch/riscv/kernel/elf_kexec.c | 7 +++++++
 arch/riscv/purgatory/Makefile | 9 +--------
 2 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.25.1

