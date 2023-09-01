Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1415678F773
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 05:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348219AbjIADY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 23:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjIADYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 23:24:55 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D2A12D
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 20:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693538690;
        bh=lvnF0NOioC9hcEBmjIlB6eZdb2DagR47ohWj1HFUj7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=IuSjWtWzsN8PDqYm+quJR1KNOlhrCoHO/XB+ubKd+1mV6PDy4ZxfR6176TKztawxn
         IhEpEFiyORLVW7e5BNku4jWx0xW0h93lUuTKFyzUqcGbwu3CVOy87dYItgcreQHFDO
         oKctO3THuzBmoJVhWiNnhnQPkITLtKNc/rw9Df6lL0d9RqSTwieccDupZyEmSl6rh1
         wkcb0SEiBIn39qo9jmN7CZNL4DBc9jm2nPU4iUVuGhTUyh0NIcga6sFjpNa5LzOsD8
         iHIKBM8H20r+MYCjlBsUgFwU36o260C87vJO5zgyLebW19a51rOkxyCwInpDwnecUR
         A/lSi2oLl1Phg==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id 872EC24B372;
        Fri,  1 Sep 2023 10:24:47 +0700 (WIB)
Date:   Fri, 1 Sep 2023 10:24:42 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 3/5] tools/nolibc: x86-64: Use `rep cmpsb` for
 `memcmp()`
Message-ID: <ZPFZejgd0h7ErwLL@biznet-home.integral.gnuweeb.org>
References: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
 <20230830135726.1939997-4-ammarfaizi2@gnuweeb.org>
 <ZO+0IW1zS9QNpP4y@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO+0IW1zS9QNpP4y@1wt.eu>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 11:26:57PM +0200, Willy Tarreau wrote:
> Out of curiosity, given that you implemented the 3 other ones directly
> in an asm statement, is there a particular reason this one mixes a bit
> of C and asm ?

Because this one maybe unused. The other are explicitly exported.

> It would probably be something around this, in the same vein:
> 
>   memcmp:
>     xchg  %esi,%eax   // source1
>     mov   %rdx,%rcx   // count
>     rep   cmpsb       // source2 in rdi; sets ZF on equal, CF if src1<src2
>     seta  %al         // 0 if src2 <= src1, 1 if src2 > src1
>     sbb   $0, %al     // 0 if src2 == src1, -1 if src2 < src1, 1 if src2 > src1
>     movsx %al, %eax   // sign extend to %eax
>     ret
> 
> Note that the output logic could have to be revisited, I'm not certain but
> at first glance it looks valid.

After thinking about this more, I think I'll drop the memcmp() patch
because it will prevent optimization when comparing a small value.

For example, without __asm__:

    memcmp(var, "abcd", 4);

may compile to:

    cmpl $0x64636261, %reg
    ...something...

But with __asm__, the compiler can't do that. Thus, it's not worth
optimizing the memcmp() in this case.

-- 
Ammar Faizi

