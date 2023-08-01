Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6746776AB1A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjHAIcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjHAIcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:32:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070811FD5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 01:32:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26F40614B0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 08:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A4FC433C7;
        Tue,  1 Aug 2023 08:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690878728;
        bh=iZGZK3Q0OU2nHxrf6A9XxGLtvvmQD2q0xRwNAp6LqtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uzaEGkj4vdv1kPHN4VKD33S2lWcjHg6YUUZQMWugr6l57bVhMPHPuQbgXoZZM2KRy
         bHJmvPMiOCCZhgzV7J/SkfXt2HaV3WRTFcFbLfxCFAYUuegGnnMSnyyFyrz5nsu9xA
         Wb8jYvdvfDiXMI95bmNi8fQZw2Ds2/zPBTXLSGU4todXYS6vvlalsT+2bJIoeM3uVw
         H6lAeVG4gWNrjAGqP57+zfrB3RQUs1diEErJMbgs53llmeXanEP2qOzLLXnKLVizt9
         lR+8WTljUrnXre2fJ7M1xbitG9V632wx3lfOElPraWmqQwUTPqZRQSy+99VJ+qSkTy
         rQxBnDcAQKxfQ==
Date:   Tue, 1 Aug 2023 09:32:02 +0100
From:   Will Deacon <will@kernel.org>
To:     WANG Rui <wangrui@loongson.cn>
Cc:     guoren@kernel.org, chenhuacai@kernel.or, kernel@xen0n.name,
        arnd@arndb.de, andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
        peterz@infradead.org, boqun.feng@gmail.com, mark.rutland@arm.com,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] LoongArch: Fixup cmpxchg sematic for memory barrier
Message-ID: <20230801083201.GB26036@willie-the-truck>
References: <20230801011554.3950435-1-guoren@kernel.org>
 <CAHirt9ht8AsE=FC8+222JDZXH3T58uLt+o=_pq+1zBhv1MKRjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHirt9ht8AsE=FC8+222JDZXH3T58uLt+o=_pq+1zBhv1MKRjg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 10:29:31AM +0800, WANG Rui wrote:
> On Tue, Aug 1, 2023 at 9:16 AM <guoren@kernel.org> wrote:
> > diff --git a/arch/loongarch/include/asm/cmpxchg.h b/arch/loongarch/include/asm/cmpxchg.h
> > index 979fde61bba8..6a05b92814b6 100644
> > --- a/arch/loongarch/include/asm/cmpxchg.h
> > +++ b/arch/loongarch/include/asm/cmpxchg.h
> > @@ -102,8 +102,8 @@ __arch_xchg(volatile void *ptr, unsigned long x, int size)
> >         "       move    $t0, %z4                        \n"             \
> >         "       " st "  $t0, %1                         \n"             \
> >         "       beqz    $t0, 1b                         \n"             \
> > -       "2:                                             \n"             \
> >         __WEAK_LLSC_MB                                                  \
> > +       "2:                                             \n"             \
> 
> Thanks for the patch.
> 
> This would look pretty good if it weren't for the special memory
> barrier semantics of the LoongArch's LL and SC instructions.
> 
> The LL/SC memory barrier behavior of LoongArch:
> 
> * LL: <memory-barrier> + <load-exclusive>
> * SC: <store-conditional> + <memory-barrier>
> 
> and the LoongArch's weak memory model allows load/load reorder for the
> same address.

Hmm, somehow this one passed me by, but I think that puts you in the naughty
corner with Itanium. It probably also means your READ_ONCE() is broken,
unless the compiler emits barriers for volatile reads (like ia64)?

Will
