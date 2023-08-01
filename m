Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B260376B9C3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjHAQhP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Aug 2023 12:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjHAQhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:37:13 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B8361FD6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 09:37:09 -0700 (PDT)
Received: from loongson.cn (unknown [209.85.128.42])
        by gateway (Coremail) with SMTP id _____8DxPOuzNMlkTjcOAA--.28253S3;
        Wed, 02 Aug 2023 00:37:08 +0800 (CST)
Received: from mail-wm1-f42.google.com (unknown [209.85.128.42])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxJ82yNMlkqzREAA--.44521S3;
        Wed, 02 Aug 2023 00:37:07 +0800 (CST)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3fbc77e76abso54357765e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 09:37:07 -0700 (PDT)
X-Gm-Message-State: ABy/qLYXX2vhZLiGZXt0Hu8DUQcGbwTpIOUi08Xn1mQRHt6/wtpEPO0F
        gxZ1vlACi7rT2O8D0KLwHTrNLm2nheZf3xnkHzj/Xw==
X-Google-Smtp-Source: APBJJlEsXFVOA032jyj+Dhjdy9psDoGBoLGpotcERoVd/vis5xhG8Jrqhh+KxnT4tElWJUoX0rM/yvzkLUKc5S3mBMA=
X-Received: by 2002:a05:600c:141:b0:3fb:fca1:1965 with SMTP id
 w1-20020a05600c014100b003fbfca11965mr2677036wmm.18.1690907825594; Tue, 01 Aug
 2023 09:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230801011554.3950435-1-guoren@kernel.org> <CAHirt9ht8AsE=FC8+222JDZXH3T58uLt+o=_pq+1zBhv1MKRjg@mail.gmail.com>
 <CAJF2gTRa5erHomJzLgUFO4SGqd5zSDwn6r3WN7kM8aWpv1vesg@mail.gmail.com>
 <CAJF2gTQ1hV1vipAo3H4X4WiPO84kVVFZcdGq7u4f0bVTry_akQ@mail.gmail.com>
 <CAHirt9gVqE=9vviJEY=kY=booVRmFPHrnFsKCXPXnXiWTB8bZQ@mail.gmail.com> <CAJF2gTR2ON33wc87iV564rkDbNiE56h_t0kzKKXdJtGqgJ1sOQ@mail.gmail.com>
In-Reply-To: <CAJF2gTR2ON33wc87iV564rkDbNiE56h_t0kzKKXdJtGqgJ1sOQ@mail.gmail.com>
From:   WANG Rui <wangrui@loongson.cn>
Date:   Wed, 2 Aug 2023 00:36:54 +0800
X-Gmail-Original-Message-ID: <CAHirt9i_osW_Dy5jNAnNOKrm-+38qN7SF+8ofNHePMAYhRKHsA@mail.gmail.com>
Message-ID: <CAHirt9i_osW_Dy5jNAnNOKrm-+38qN7SF+8ofNHePMAYhRKHsA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fixup cmpxchg sematic for memory barrier
To:     Guo Ren <guoren@kernel.org>
Cc:     chenhuacai@kernel.or, kernel@xen0n.name, arnd@arndb.de,
        andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
        peterz@infradead.org, will@kernel.org, boqun.feng@gmail.com,
        mark.rutland@arm.com, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-CM-TRANSID: AQAAf8DxJ82yNMlkqzREAA--.44521S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
        BjDU0xBIdaVrnRJUUU90b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
        xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
        j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
        14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwI
        xGrwCF54CYxVAaw2AFwI0_Jrv_JF1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAF
        wI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
        CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
        xhVjvjDU0xZFpf9x07UE-erUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 6:50 PM Guo Ren <guoren@kernel.org> wrote:
>
> On Tue, Aug 1, 2023 at 5:32 PM WANG Rui <wangrui@loongson.cn> wrote:
> > No. LL and LL won't reorder because LL implies a memory barrier(though
> > not acquire semantics).
> That means we could remove __WEAK_LLSC_MB totally, right?

More precisely, __WEAK_LLSC_MB is intended to prevent reordering
between LL and normal LD used to fetch the expected value for cmpxchg.

Regards,
-- 
WANG Rui

