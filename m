Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEFD7599F9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjGSPjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjGSPjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:39:47 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D35C19B9;
        Wed, 19 Jul 2023 08:39:42 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 1441E92009C; Wed, 19 Jul 2023 17:39:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 0D43E92009B;
        Wed, 19 Jul 2023 16:39:40 +0100 (BST)
Date:   Wed, 19 Jul 2023 16:39:39 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Huacai Chen <chenhuacai@kernel.org>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jan-Benedict Glaw <jbglaw@lug-owl.de>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] MIPS: Fix build issues from the introduction of
 `need-compiler'
In-Reply-To: <CAAhV-H4ewzWuZRe0RX+j2x2R_fROVExHuogWNaWBmFA=Tgb=Og@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2307191621450.58367@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2307180025120.62448@angie.orcam.me.uk> <CAAhV-H4ewzWuZRe0RX+j2x2R_fROVExHuogWNaWBmFA=Tgb=Og@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023, Huacai Chen wrote:

> Even if patch-2 resolves the problem, I don't think patch-3 is
> necessary because the original patch makes code simpler and more
> compact.

 Please don't top-post on a public mailing list.

 If you're referring to this part:

+ifdef CONFIG_CPU_LOONGSON64
+cflags-$(CONFIG_CPU_LOONGSON64)	+= -Wa,--trap
+cflags-$(CONFIG_CC_IS_GCC) += -march=loongson3a
+cflags-$(CONFIG_CC_IS_CLANG) += -march=mips64r2
+endif

then it can be done with a separate clean-up.  Otherwise it'll have been 
lost in the noise.

 Firstly:

cflags-$(CONFIG_CPU_LOONGSON64)	+= -Wa,--trap

doesn't have to be wrapped in `ifdef CONFIG_CPU_LOONGSON64'.

 Secondly:

cflags-$(CONFIG_CC_IS_GCC) += -march=loongson3a
cflags-$(CONFIG_CC_IS_CLANG) += -march=mips64r2

document compiler peculiarities.  Does Clang support, or intend to, 
`-march=loongson3a'?  If so, what version can we expect this stuff in?  
GCC has had it since 4.6 or Y2010, which is pretty long ago.

 Last but not least there are formatting anomalies there, which may have 
to be dealt with in a separate change.

  Maciej
