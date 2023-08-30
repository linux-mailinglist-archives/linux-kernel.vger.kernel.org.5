Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0DA78D287
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 05:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241889AbjH3D0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 23:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241573AbjH3DZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 23:25:58 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D5ACAB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 20:25:55 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.128.250])
        by gateway (Coremail) with SMTP id _____8CxNvHCtu5kXfkcAA--.59008S3;
        Wed, 30 Aug 2023 11:25:54 +0800 (CST)
Received: from crazy.crazy.loongson.org (unknown [10.180.128.250])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxriPBtu5k9+5mAA--.12310S4;
        Wed, 30 Aug 2023 11:25:53 +0800 (CST)
From:   liweihao <liweihao@loongson.cn>
To:     wangrui@loongson.cn
Cc:     chenhuacai@kernel.org, kernel@xen0n.name,
        linux-kernel@vger.kernel.org, liweihao@loongson.cn,
        loongarch@lists.linux.dev, masahiroy@kernel.org, yijun@loongson.cn
Subject: Re: [PATCH 1/1] LoongArch: adjust copy/clear_user exception handler behavior
Date:   Wed, 30 Aug 2023 11:25:53 +0800
Message-Id: <20230830032553.2974884-1-liweihao@loongson.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAHirt9i0tcUCuQ5ZL657MOZ4CUg0bpfiNbo01WLhPAwsLjgM+g@mail.gmail.com>
References: <CAHirt9i0tcUCuQ5ZL657MOZ4CUg0bpfiNbo01WLhPAwsLjgM+g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxriPBtu5k9+5mAA--.12310S4
X-CM-SenderInfo: 5olzvxhkdrqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
        BjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
        xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
        j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxV
        AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
        67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E
        87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
        Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8yCJUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello WANG Rui,

> > +.Lsmall_fixup:
> > +29:    st.b    zero, a0, 0
> > +       addi.d  a0, a0, 1
> > +       addi.d  a1, a1, -1
> > +       bgt     a1, zero, 1b
> 
> I'm sure the jump target here is 29b.

You are right, this is a mistake.

I'll correct it later. Thanks.

