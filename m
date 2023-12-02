Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1906D801C7A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 12:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjLBLkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 06:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBLki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 06:40:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B82218C
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 03:40:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E4CC433C9;
        Sat,  2 Dec 2023 11:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701517241;
        bh=DaUNBnJudQtx/0ecN0kp9sHu1Y4tp3r/amh8XiErTXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XxP7NmO7pW5CZG2wIqTdiWAbz/p7Cb69Elg+6qaP8cxRpDnbg7ygo36gqVDhTE1K/
         9ky2d7U5rmERCih5gsM/OV7/Euy7yG9zru8jDb1Wo8AaCAmx16YQ8OWUrgYiZbRZU2
         j3+lowrobiVTpvQ2b6+uTV66aCyeHH+QBwj9f/5P350NydZGYMw+Zqj8RrAblu9VK9
         5QbS1cVL3ev75+j1EMolBAA/CKFvjCSTTpRLmXILv7TSu/sdW4GQJdCU2fgWr+hTQd
         frwOzSl7jv2TwAURI820vGSlC+0FQ9hxApvrrEHa/s+BsP9WMC1YSfh+TShW4XOF4M
         ZdQ7qFC8qFLAw==
Date:   Sat, 2 Dec 2023 19:28:10 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] riscv: enable EFFICIENT_UNALIGNED_ACCESS and
 DCACHE_WORD_ACCESS
Message-ID: <ZWsUyjEx1fmXQEfW@xhacker>
References: <20231202111822.3569-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231202111822.3569-1-jszhang@kernel.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_BTC_ID,
        PDS_BTC_MSGID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2023 at 07:18:20PM +0800, Jisheng Zhang wrote:
> Some riscv implementations such as T-HEAD's C906, C908, C910 and C920
> supports efficient unaligned access, for performance reason we want
> to enable HAVE_EFFICIENT_UNALIGNED_ACCESS on these platforms. To
> avoid performance regressions on other non efficient unaligned access
> platforms, HAVE_EFFICIENT_UNALIGNED_ACCESS can't be globaly selected.
> 
> To solve this problem, runtime code patching based on the detected
> speed is a good solution. But that's not easy, it involves lots of
> work to modify vairous subsystems such as net, mm, lib and so on.
> This can be done step by step.

Adding something as below here can make the series more clear:
So let's take an easier solution: add support to efficient unaligned
access and hide the support under NONPORTABLE.

> 
> patch1 introduces RISCV_EFFICIENT_UNALIGNED_ACCESS which depends on
> NONPORTABLE, if users know during config time that the kernel will be
> only run on those efficient unaligned access hw platforms, they can
> enable it. Obviously, generic unified kernel Image should enable it.

typo: s/should/shouldn't

> 
> patch2 adds support DCACHE_WORD_ACCESS when MMU and
> RISCV_EFFICIENT_UNALIGNED_ACCESS.
> 
> Below test program and step shows how much performance can be improved:
> 
>  $ cat tt.c
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <unistd.h>
> 
>  #define ITERATIONS 1000000
> 
>  #define PATH "123456781234567812345678123456781"
> 
>  int main(void)
>  {
>          unsigned long i;
>          struct stat buf;
> 
>          for (i = 0; i < ITERATIONS; i++)
>                  stat(PATH, &buf);
> 
>          return 0;
>  }
> 
>  $ gcc -O2 tt.c
>  $ touch 123456781234567812345678123456781
>  $ time ./a.out
> 
> Per my test on T-HEAD C910 platforms, the above test performance is
> improved by about 7.5%.
> 
> 
> Jisheng Zhang (2):
>   riscv: introduce RISCV_EFFICIENT_UNALIGNED_ACCESS
>   riscv: select DCACHE_WORD_ACCESS for efficient unaligned access HW
> 
>  arch/riscv/Kconfig                      | 13 +++++++++++
>  arch/riscv/include/asm/asm-extable.h    | 15 ++++++++++++
>  arch/riscv/include/asm/word-at-a-time.h | 23 ++++++++++++++++++
>  arch/riscv/mm/extable.c                 | 31 +++++++++++++++++++++++++
>  4 files changed, 82 insertions(+)
> 
> -- 
> 2.42.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
