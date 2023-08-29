Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42BB78BE59
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjH2GW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjH2GWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:22:25 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A441718D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:22:21 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 37T6Lloe011605;
        Tue, 29 Aug 2023 08:21:47 +0200
Date:   Tue, 29 Aug 2023 08:21:47 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Zhangjin Wu <falcon@tinylab.org>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] tools/nolibc: i386: Fix a stack misalign bug on
 _start
Message-ID: <ZO2Oey26OZ5PNPTr@1wt.eu>
References: <20230828070240.1691921-1-ammarfaizi2@gnuweeb.org>
 <20230828070240.1691921-2-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828070240.1691921-2-ammarfaizi2@gnuweeb.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ammar,

On Mon, Aug 28, 2023 at 02:02:40PM +0700, Ammar Faizi wrote:
> The ABI mandates that the %esp register must be a multiple of 16 when
> executing a 'call' instruction.
> 
> Commit 2ab446336b17 ("tools/nolibc: i386: shrink _start with _start_c")
> simplified the _start function, but it didn't take care of the %esp
> alignment, causing SIGSEGV on SSE and AVX programs that use aligned move
> instruction (e.g., movdqa, movaps, and vmovdqa).
> 
> The 'and $-16, %esp' aligns the %esp at a multiple of 16. Then 'push
> %eax' will subtract the %esp by 4; thus, it breaks the 16-byte
> alignment. Make sure the %esp is correctly aligned after the push by
> subtracting 12 before the push.

Indeed, good catch! However if we want to do it cleany (i.e not punch a
16 to 28 byes hole in the stack), we should do this instead:

		add  $12, %esp   /* the stack must be aligned to 16 ... */
		and  $-16, %esp  /* ... bytes after eax is pushed and ... */
		sub  $12, %esp   /* ... before the call. */

This will only add 0 to 12 bytes depending on the existing alignment.

What do you think ?

thanks,
Willy
