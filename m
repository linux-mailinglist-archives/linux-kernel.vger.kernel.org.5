Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F230C76C2D5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjHBCXj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Aug 2023 22:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjHBCXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:23:36 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1B6E213E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:23:34 -0700 (PDT)
Received: from loongson.cn (unknown [209.85.221.50])
        by gateway (Coremail) with SMTP id _____8AxEvAlvslk5osOAA--.33118S3;
        Wed, 02 Aug 2023 10:23:33 +0800 (CST)
Received: from mail-wr1-f50.google.com (unknown [209.85.221.50])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxDc8ivslkYNdEAA--.47852S3;
        Wed, 02 Aug 2023 10:23:32 +0800 (CST)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-31792ac0fefso3300303f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 19:23:32 -0700 (PDT)
X-Gm-Message-State: ABy/qLbR4I2Y9xu14JEkQvrrT7w0v2+IhRfEVpSbx9Ze2iXQC7+fRqK5
        yCRzVGucmGjF4/bAgqBQVnVKOhiNsbZqzHTYRgxVug==
X-Google-Smtp-Source: APBJJlF1uWj6wIOqIFlfDDRCiTD78Qq9g6nbp+t0la6vtmj1Gk53kAMeZOdghLi9R93+HK/Wj4Dz9sqyDT30UvH5UyU=
X-Received: by 2002:a05:6000:11c5:b0:317:594a:dbde with SMTP id
 i5-20020a05600011c500b00317594adbdemr3350887wrx.20.1690943009317; Tue, 01 Aug
 2023 19:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230801011554.3950435-1-guoren@kernel.org> <CAHirt9ht8AsE=FC8+222JDZXH3T58uLt+o=_pq+1zBhv1MKRjg@mail.gmail.com>
 <CAJF2gTRa5erHomJzLgUFO4SGqd5zSDwn6r3WN7kM8aWpv1vesg@mail.gmail.com>
 <CAJF2gTQ1hV1vipAo3H4X4WiPO84kVVFZcdGq7u4f0bVTry_akQ@mail.gmail.com>
 <CAHirt9gVqE=9vviJEY=kY=booVRmFPHrnFsKCXPXnXiWTB8bZQ@mail.gmail.com>
 <CAJF2gTR2ON33wc87iV564rkDbNiE56h_t0kzKKXdJtGqgJ1sOQ@mail.gmail.com>
 <CAHirt9i_osW_Dy5jNAnNOKrm-+38qN7SF+8ofNHePMAYhRKHsA@mail.gmail.com> <CAJF2gTSLD3jwzV59dGj_RENCvE0zMOAkLHqmT55bxL-4vA1wkA@mail.gmail.com>
In-Reply-To: <CAJF2gTSLD3jwzV59dGj_RENCvE0zMOAkLHqmT55bxL-4vA1wkA@mail.gmail.com>
From:   WANG Rui <wangrui@loongson.cn>
Date:   Wed, 2 Aug 2023 10:23:18 +0800
X-Gmail-Original-Message-ID: <CAHirt9iiA_zdBbmnmMNAEmvKBU-1imRxD7wG-0OmnPTsG2RJMA@mail.gmail.com>
Message-ID: <CAHirt9iiA_zdBbmnmMNAEmvKBU-1imRxD7wG-0OmnPTsG2RJMA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fixup cmpxchg sematic for memory barrier
To:     Guo Ren <guoren@kernel.org>
Cc:     chenhuacai@kernel.or, kernel@xen0n.name, arnd@arndb.de,
        andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
        peterz@infradead.org, will@kernel.org, boqun.feng@gmail.com,
        mark.rutland@arm.com, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-CM-TRANSID: AQAAf8DxDc8ivslkYNdEAA--.47852S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWrtw4xtrW3tr1UKFWrKFyDArc_yoW8JrWDpr
        WIyFs0gFZ7Xw40ywsakw48ZFyrtwnaqF17X3sa9rZFyFyav343trW7Gry3XrsxZr93Gw1Y
        v3yq934FvFyDZFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
        02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
        wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI4
        8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
        wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
        v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
        Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267
        AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 7:17 AM Guo Ren <guoren@kernel.org> wrote:
>
> On Tue, Aug 1, 2023 at 12:37 PM WANG Rui <wangrui@loongson.cn> wrote:
> >
> > On Tue, Aug 1, 2023 at 6:50 PM Guo Ren <guoren@kernel.org> wrote:
> > >
> > > On Tue, Aug 1, 2023 at 5:32 PM WANG Rui <wangrui@loongson.cn> wrote:
> > > > No. LL and LL won't reorder because LL implies a memory barrier(though
> > > > not acquire semantics).
> > > That means we could remove __WEAK_LLSC_MB totally, right?
> >
> > More precisely, __WEAK_LLSC_MB is intended to prevent reordering
> > between LL and normal LD used to fetch the expected value for cmpxchg.
> Oh, that's unnecessary when cmpxchg fails.
>
> Maybe you treat cmpxchg as a CoRR antidote in coincidence. Please
> solve the CoRR problem by READ_ONCE.
>
> See alpha architecture.

Unfortunately, the LL instruction has no acquire semantics. Even if
our kernel team improves READ_ONCE, it cannot prevent reordering
between LL and READ_ONCE after cmpxchg fails.

LL (<memory-barrier> + <load-exclusive>); WEAK_LLSC_MB; READ_ONCE
(<normal-load>); ...

vs

LL (<memory-barrier> + <load-exclusive>); READ_ONCE (<normal-load> +
<memory-barrier>); ...

Improving READ_ONCE is really important.

Regards,
-- 
WANG Rui

