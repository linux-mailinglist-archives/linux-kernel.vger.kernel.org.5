Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B4B78E243
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343785AbjH3WV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343792AbjH3WVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:21:13 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7625CFC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:20:49 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 37ULQvnh001046;
        Wed, 30 Aug 2023 23:26:57 +0200
Date:   Wed, 30 Aug 2023 23:26:57 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 3/5] tools/nolibc: x86-64: Use `rep cmpsb` for
 `memcmp()`
Message-ID: <ZO+0IW1zS9QNpP4y@1wt.eu>
References: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
 <20230830135726.1939997-4-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830135726.1939997-4-ammarfaizi2@gnuweeb.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 08:57:24PM +0700, Ammar Faizi wrote:
> Simplify memcmp() on the x86-64 arch.
> 
> The x86-64 arch has a 'rep cmpsb' instruction, which can be used to
> implement the memcmp() function.
> 
>     %rdi = source 1
>     %rsi = source 2
>     %rcx = length
> 
> Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> ---
>  tools/include/nolibc/arch-x86_64.h | 19 +++++++++++++++++++
>  tools/include/nolibc/string.h      |  2 ++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
> index 42f2674ad1ecdd64..6c1b54ba9f774e7b 100644
> --- a/tools/include/nolibc/arch-x86_64.h
> +++ b/tools/include/nolibc/arch-x86_64.h
> @@ -214,4 +214,23 @@ __asm__ (
>  	"retq\n"
>  );
>  
> +#define NOLIBC_ARCH_HAS_MEMCMP
> +static int memcmp(const void *s1, const void *s2, size_t n)
> +{
> +	const unsigned char *p1 = s1;
> +	const unsigned char *p2 = s2;
> +
> +	if (!n)
> +		return 0;
> +
> +	__asm__ volatile (
> +		"rep cmpsb"
> +		: "+D"(p2), "+S"(p1), "+c"(n)
> +		: "m"(*(const unsigned char (*)[n])s1),
> +		  "m"(*(const unsigned char (*)[n])s2)
> +	);
> +
> +	return p1[-1] - p2[-1];
> +}

Out of curiosity, given that you implemented the 3 other ones directly
in an asm statement, is there a particular reason this one mixes a bit
of C and asm ? It would probably be something around this, in the same
vein:

  memcmp:
    xchg  %esi,%eax   // source1
    mov   %rdx,%rcx   // count
    rep   cmpsb       // source2 in rdi; sets ZF on equal, CF if src1<src2
    seta  %al         // 0 if src2 <= src1, 1 if src2 > src1
    sbb   $0, %al     // 0 if src2 == src1, -1 if src2 < src1, 1 if src2 > src1
    movsx %al, %eax   // sign extend to %eax
    ret

Note that the output logic could have to be revisited, I'm not certain but
at first glance it looks valid.

Regards,
Willy
