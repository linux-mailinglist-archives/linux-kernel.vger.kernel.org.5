Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7913176ADC7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjHAJdn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Aug 2023 05:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbjHAJdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:33:02 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E87E330F7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:31:00 -0700 (PDT)
Received: from loongson.cn (unknown [209.85.128.45])
        by gateway (Coremail) with SMTP id _____8BxnuvH0MhkagEOAA--.30785S3;
        Tue, 01 Aug 2023 17:30:48 +0800 (CST)
Received: from mail-wm1-f45.google.com (unknown [209.85.128.45])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxviPF0MhkCMpDAA--.4638S3;
        Tue, 01 Aug 2023 17:30:46 +0800 (CST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3fe2bc2701bso1395505e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 02:30:46 -0700 (PDT)
X-Gm-Message-State: ABy/qLYXbBfSUqbvyTk0Rz+7e7Xu021HMKtNdggxpVpTwvCx7CdqiOrH
        TQnyvwZJ4br1e7paWpAmhJyrNkYUJvgcgrGAGe/E6A==
X-Google-Smtp-Source: APBJJlFL0f5c65vH+FERRq95p4j8qrALvRiIHJcQv3dFHYZmyAKStT05me5UsGMEKTgrx/mqaZFFQzGRUPUduCg+Vuk=
X-Received: by 2002:adf:edcd:0:b0:314:8d:7eb5 with SMTP id v13-20020adfedcd000000b00314008d7eb5mr1919533wro.29.1690882244713;
 Tue, 01 Aug 2023 02:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230801011554.3950435-1-guoren@kernel.org> <CAHirt9ht8AsE=FC8+222JDZXH3T58uLt+o=_pq+1zBhv1MKRjg@mail.gmail.com>
 <20230801083201.GB26036@willie-the-truck>
In-Reply-To: <20230801083201.GB26036@willie-the-truck>
From:   WANG Rui <wangrui@loongson.cn>
Date:   Tue, 1 Aug 2023 17:30:33 +0800
X-Gmail-Original-Message-ID: <CAHirt9ggujWPw7KV7qSGjk=-nX16U+u1MwNGSLEkoogcJjOHFA@mail.gmail.com>
Message-ID: <CAHirt9ggujWPw7KV7qSGjk=-nX16U+u1MwNGSLEkoogcJjOHFA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fixup cmpxchg sematic for memory barrier
To:     Will Deacon <will@kernel.org>
Cc:     guoren@kernel.org, chenhuacai@kernel.or, kernel@xen0n.name,
        arnd@arndb.de, andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
        peterz@infradead.org, boqun.feng@gmail.com, mark.rutland@arm.com,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-CM-TRANSID: AQAAf8DxviPF0MhkCMpDAA--.4638S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
        BjDU0xBIdaVrnRJUUUBKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
        xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
        j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxV
        AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
        67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E
        87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2
        Ij64vIr41l4c8EcI0En4kS14v26r1q6r43MxAqzxv26xkF7I0En4kS14v26r1q6r43MxC2
        0s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Aug 1, 2023 at 4:32 PM Will Deacon <will@kernel.org> wrote:
>
> Hmm, somehow this one passed me by, but I think that puts you in the naughty
> corner with Itanium. It probably also means your READ_ONCE() is broken,
> unless the compiler emits barriers for volatile reads (like ia64)?

Hmm, I agree with your perspective. Allowing out-of-order loads for
the same address in the memory model provides certain performance
benefits, but it also poses challenges to software. Fortunately,
hardware supports software to disable this feature when needed.

Regards,
-- 
WANG Rui

