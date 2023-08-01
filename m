Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A1B76AD87
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjHAJaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbjHAJ3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:29:41 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB3F2128
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:28:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4RFTvx2Tm4z9xFbF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 17:14:53 +0800 (CST)
Received: from [10.81.220.249] (unknown [10.81.220.249])
        by APP1 (Coremail) with SMTP id LxC2BwC3abkK0Mhkbs4ZAA--.15467S2;
        Tue, 01 Aug 2023 10:27:51 +0100 (CET)
Message-ID: <c1b125d6-7031-d0aa-bcaa-8fb3875ac64f@huaweicloud.com>
Date:   Tue, 1 Aug 2023 11:27:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] RISC-V: Fix a few kexec_file_load(2) failures
Content-Language: en-US
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Liao Chang <liaochang1@huawei.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Alyssa Ross <hi@alyssa.is>, Li Zhengyu <lizhengyu3@huawei.com>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        kexec@lists.infradead.org, open list <linux-kernel@vger.kernel.org>
Cc:     Torsten Duwe <duwe@suse.de>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
References: <cover.1690365011.git.petr.tesarik.ext@huawei.com>
In-Reply-To: <cover.1690365011.git.petr.tesarik.ext@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwC3abkK0Mhkbs4ZAA--.15467S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ury7CFyUKw1fWF1ktF45GFg_yoW8Jw4rpr
        WfC3ZrG348G3409r1xtw1Du34fGa17Cw15Jr4qvw1rAr1YvrW5AF1Igw40yFyDGryI93s0
        qryFgr98Zw1kArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
        W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Gr0_
        Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7VUbQVy7
        UUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/26/2023 11:53 AM, Petr Tesarik wrote:
> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> 
> The kexec_file_load(2) syscall does not work at least in some kernel
> builds. For details see the relevant section in this blog post:
> 
> https://sigillatum.tesarici.cz/2023-07-21-state-of-riscv64-kdump.html
> 
> This patch series handles an additional relocation types, removes the need
> to implement a Global Offset Table (GOT) for the purgatory and fixes the
> placement of initrd.

It seems there are no objections, but what is the plan here? Take it
into 6.5 as a fix, or let it go through for-next?

Petr T

> Changelog
> =========
> 
> Changes from v1:
> - Replace memcmp() with a for loop.
> - Drop handling of 16-bit add/subtract relocations. They were used only
>   by alternatives in strcmp(), which was referenced only by string.o.
> - Add the initrd placement fix.
> 
> Petr Tesarik (1):
>   riscv/purgatory: do not link with string.o and its dependencies
> 
> Torsten Duwe (2):
>   riscv/kexec: handle R_RISCV_CALL_PLT relocation type
>   riscv/kexec: load initrd high in available memory
> 
>  arch/riscv/kernel/elf_kexec.c    |  3 ++-
>  arch/riscv/purgatory/Makefile    | 26 +-------------------------
>  arch/riscv/purgatory/purgatory.c |  6 ++++--
>  3 files changed, 7 insertions(+), 28 deletions(-)
> 

