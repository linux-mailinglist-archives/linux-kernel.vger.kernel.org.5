Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D23E78D881
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjH3Sak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245743AbjH3QIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:08:47 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFF4193
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 09:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693411724;
        bh=6r+T8WC3YDoyLexZcW+PJ2EpS0JPH0v/VisvIZh5zHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=rz2h+Qk0VvkK0k2pEIE2Fv5Pnu0D4WrTs4KyYFWp9irQaWfonPMsj+ByBRqt8mi8O
         eyuvE/OtGKS1dBEc5M6i68E0nYcehP6JiQAr5sUbVTDoOvwN7ObzIQj5oqhzO0T/Kq
         JtMH9S3wzAwtsYNToap93BjsCpj/SIOTtd/R6t3RXfTlEj7HFI6948J9Z/6tmx2e+9
         krKKhQNynSHxOaFYVf4sxZbrRgHLxiSG/9OKSSgrn0J3j9U8v/AeQlhXp/osg0MagY
         hzS5ViR4vLjDTuabmQwvZhTlEq9Y5p1/UWXFxEDamaXsBqrWo4hWul7c39LkyfyJoT
         ZTymd5RLMCHXw==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id 9366A24B2B0;
        Wed, 30 Aug 2023 23:08:41 +0700 (WIB)
Date:   Wed, 30 Aug 2023 23:08:36 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 2/5] tools/nolibc: x86-64: Use `rep stosb` for
 `memset()`
Message-ID: <ZO9phB2Ehukb1kab@biznet-home.integral.gnuweeb.org>
References: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
 <20230830135726.1939997-3-ammarfaizi2@gnuweeb.org>
 <CAOG64qNGdPjXHTvrpYxjizOYvMRaB9_2t2raw6DJ3kK852KUHg@mail.gmail.com>
 <ZO9bv+GvgpphtGEi@biznet-home.integral.gnuweeb.org>
 <ZO9e6h2jjVIMpBJP@1wt.eu>
 <ZO9j9WhSj7PmsM8b@biznet-home.integral.gnuweeb.org>
 <ZO9lmGoMDh10jdsk@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO9lmGoMDh10jdsk@1wt.eu>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 05:51:52PM +0200, Willy Tarreau wrote:
> Normal, that's because historically "xchg ax, regX" was a single-byte 0x9X
> on 8086, then it turned to 32-bit keeping the same encoding, like many
> instructions (note that NOP is encoded as xchg ax,ax). It remains short
> when you can sacrifice the other register, or restore it later using yet
> another xchg. For rcx/rdx a push/pop could do it as they should also be
> a single-byte 0x5X even in long mode unless I'm mistaken. Thus if you
> absolutely want to squeeze that 9th byte to end up with a 8-byte function
> you could probably do:
> 
>     xchg %eax, %esi      1
>     push %rdx            1
>     pop %rcx             1
>     push %rdi            1
>     rep movsb            2 [sic]
>     pop %rax             1
>     ret                  1
>     ------------- Total: 8 bytes :-)

Fun!

We're not doing a code golf game, though. So, I think I will leave the
"mov %rdx, %rcx" as is. Otherwise, I would be tempted to do that all
over the place.

-- 
Ammar Faizi

