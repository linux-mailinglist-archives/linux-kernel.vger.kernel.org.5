Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B23C78E182
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241588AbjH3VeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241574AbjH3VeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:34:14 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14748E66
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:33:35 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 37ULW2rA001118;
        Wed, 30 Aug 2023 23:32:02 +0200
Date:   Wed, 30 Aug 2023 23:32:02 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 0/5] nolibc x86-64 string functions
Message-ID: <ZO+1Ugz3TBxEAA8y@1wt.eu>
References: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ammar,

On Wed, Aug 30, 2023 at 08:57:21PM +0700, Ammar Faizi wrote:
> Hi Willy,
> 
> This is an RFC patchset for nolibc x86-64 string functions. There are 5
> patches in this series.
> 
> ## Patch 1-3: Use `rep movsb`, `rep stosb`, and `rep cmpsb` for:
>     - memcpy() and memmove()
>     - memset()
>     - memcmp()
> respectively. They can simplify the generated ASM code.
> 
> Patch 4 and 5 are not related, just a small cleanup.

So overall I'm fine with this, I think it's reasonable. As you said
we're not trying to chase the very last byte, but for such functions
it's also nice if they can remain small. Some of them might even
benefit from being inlined by the way (in this case they'd rather
move to C functions with an asm() statement), because the call
instruction and the register moves or spilling code will generally
be larger than the functions themselves. That might be worth checking.
Ah no, we cannot because some of them are called from libgcc and friends.
Or we may need to mark them inline and weak without static, I'm not sure
how well that works.

Please just let me know if you intend to change a few things based on
previous comments, and also this memcmp() stuff that's both C and asm.

Thanks!
Willy
