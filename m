Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7462E76A6F7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 04:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjHAC3t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 31 Jul 2023 22:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjHAC3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 22:29:48 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44E23E65
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 19:29:47 -0700 (PDT)
Received: from loongson.cn (unknown [209.85.128.41])
        by gateway (Coremail) with SMTP id _____8CxrusZbshkHswNAA--.29829S3;
        Tue, 01 Aug 2023 10:29:46 +0800 (CST)
Received: from mail-wm1-f41.google.com (unknown [209.85.128.41])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxWM0WbshkwXdDAA--.46292S3;
        Tue, 01 Aug 2023 10:29:44 +0800 (CST)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so47910175e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 19:29:43 -0700 (PDT)
X-Gm-Message-State: ABy/qLZmP1nYE/bQjWjFoYZDzJ5REARD0bqRZY06u4YQKgLQxNAfDUva
        f+YdQ3GmMk5Mr+YVDR2TzscaZrflhEelPRDUhy7NIg==
X-Google-Smtp-Source: APBJJlGR2xCzEbR0KfLvULAvj4Q/rRacHyeQ3FRpG/PeA9oezM1aq7UPOCn9hCun1wnjhnQ09KzsW9iG/Ng+J4KnFBA=
X-Received: by 2002:a1c:ed0f:0:b0:3fe:1c05:3c8f with SMTP id
 l15-20020a1ced0f000000b003fe1c053c8fmr1260964wmh.35.1690856982158; Mon, 31
 Jul 2023 19:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230801011554.3950435-1-guoren@kernel.org>
In-Reply-To: <20230801011554.3950435-1-guoren@kernel.org>
From:   WANG Rui <wangrui@loongson.cn>
Date:   Tue, 1 Aug 2023 10:29:31 +0800
X-Gmail-Original-Message-ID: <CAHirt9ht8AsE=FC8+222JDZXH3T58uLt+o=_pq+1zBhv1MKRjg@mail.gmail.com>
Message-ID: <CAHirt9ht8AsE=FC8+222JDZXH3T58uLt+o=_pq+1zBhv1MKRjg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fixup cmpxchg sematic for memory barrier
To:     guoren@kernel.org
Cc:     chenhuacai@kernel.or, kernel@xen0n.name, arnd@arndb.de,
        andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
        peterz@infradead.org, will@kernel.org, boqun.feng@gmail.com,
        mark.rutland@arm.com, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-CM-TRANSID: AQAAf8CxWM0WbshkwXdDAA--.46292S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7XFWxJry7Kw1kur13tr4fJFc_yoWkArg_Wa
        17Cw4Uuw4xXa13tanxKryfJr1qqa1xAFn3uaySqr1fAFn8Jw43Z397X3W3Zr17K3y8Xrs8
        u3ySqr90kr1j9osvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
        02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
        wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI4
        8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
        wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
        v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
        Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
        AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Aug 1, 2023 at 9:16 AM <guoren@kernel.org> wrote:
> diff --git a/arch/loongarch/include/asm/cmpxchg.h b/arch/loongarch/include/asm/cmpxchg.h
> index 979fde61bba8..6a05b92814b6 100644
> --- a/arch/loongarch/include/asm/cmpxchg.h
> +++ b/arch/loongarch/include/asm/cmpxchg.h
> @@ -102,8 +102,8 @@ __arch_xchg(volatile void *ptr, unsigned long x, int size)
>         "       move    $t0, %z4                        \n"             \
>         "       " st "  $t0, %1                         \n"             \
>         "       beqz    $t0, 1b                         \n"             \
> -       "2:                                             \n"             \
>         __WEAK_LLSC_MB                                                  \
> +       "2:                                             \n"             \

Thanks for the patch.

This would look pretty good if it weren't for the special memory
barrier semantics of the LoongArch's LL and SC instructions.

The LL/SC memory barrier behavior of LoongArch:

* LL: <memory-barrier> + <load-exclusive>
* SC: <store-conditional> + <memory-barrier>

and the LoongArch's weak memory model allows load/load reorder for the
same address.

So, the __WEAK_LLSC_MB[1] is used to prevent load/load reorder and no
explicit barrier instruction is required after SC.

[1] https://lore.kernel.org/loongarch/20230516124536.535343-1-chenhuacai@loongson.cn/

Regards,
--
WANG Rui

