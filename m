Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9867760D91
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjGYIt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjGYIrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:47:39 -0400
Received: from frasgout11.his.huawei.com (ecs-14-137-139-23.compute.hwclouds-dns.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E5530C5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:46:06 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4R99L12xXQz9xrdf
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 16:34:01 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.48.128.235])
        by APP2 (Coremail) with SMTP id GxC2BwB3Ijlwi79kXB38BA--.63760S3;
        Tue, 25 Jul 2023 09:44:55 +0100 (CET)
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
Subject: [PATCH v1 1/3] riscv/kexec: handle R_RISCV_CALL_PLT relocation type
Date:   Tue, 25 Jul 2023 10:44:25 +0200
Message-Id: <652f652d571458522a615040f68a885f10b45ca7.1690274483.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690274483.git.petr.tesarik.ext@huawei.com>
References: <cover.1690274483.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwB3Ijlwi79kXB38BA--.63760S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr47uw13tFW5WFWfZF4ruFg_yoW8WFy3pw
        17Crn8KrWkGw1Sk3yagr48W348Ga1kurWaqa98GFW0qrsxXry0v3yvg3WUWF1jyrn5K3yS
        vFySgr1rZa15ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUQ214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCY1x0262kKe7AKxVWUtVW8ZwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
        14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUU-B_DUUUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Torsten Duwe <duwe@suse.de>

R_RISCV_CALL has been deprecated and replaced by R_RISCV_CALL_PLT. See Enum
18-19 in Table 3. Relocation types here:

https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/master/riscv-elf.adoc

It was deprecated in ("Deprecated R_RISCV_CALL, prefer R_RISCV_CALL_PLT"):

https://github.com/riscv-non-isa/riscv-elf-psabi-doc/commit/a0dced85018d7a0ec17023c9389cbd70b1dbc1b0

Recent tools (at least GNU binutils-2.40) already use R_RISCV_CALL_PLT.
Kernels built with such binutils fail kexec_load_file(2) with:

 kexec_image: Unknown rela relocation: 19
 kexec_image: Error loading purgatory ret=-8

The binary code at the call site remains the same, so tell
arch_kexec_apply_relocations_add() to handle _PLT alike.

Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
Signed-off-by: Torsten Duwe <duwe@suse.de>
Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
Cc: Li Zhengyu <lizhengyu3@huawei.com>
Cc: stable@vger.kernel.org
---
 arch/riscv/kernel/elf_kexec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index 5372b708fae2..38390d3bdcac 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -425,6 +425,7 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 		 * sym, instead of searching the whole relsec.
 		 */
 		case R_RISCV_PCREL_HI20:
+		case R_RISCV_CALL_PLT:
 		case R_RISCV_CALL:
 			*(u64 *)loc = CLEAN_IMM(UITYPE, *(u64 *)loc) |
 				 ENCODE_UJTYPE_IMM(val - addr);
-- 
2.25.1

