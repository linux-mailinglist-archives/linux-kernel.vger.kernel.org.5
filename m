Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C44F790588
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 08:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351642AbjIBGLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 02:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjIBGLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 02:11:18 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D894910F5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 23:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693635075;
        bh=lCMYa3kM0Ko+YgeAa8nfhXpd5/xQ5+E68evNTg4CTvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Q2JVtYnWywreIhcjy9KjjedFJ3CSVL3+lBEOwhkOsKVPpGAouU/lFTIZH6Vh0+tV+
         3jXHcQLOsYm5W5sTLTxSoK698Ta50AGVvutU8KVMOwfI/8e1RX0iCpBWfS6bx628uc
         jCRko1UBRWGj5hrZes9x88jbEc44QqjTVDmITtAdLuIT81Ualyga5p+9rebp5eM+hg
         tnNLoWcf6MVhP1oTZ+S9/sN7uWJWBMzqGCviUjilznyi1tqhnVsy/eDBxGblM5mV4m
         sBacRJ/aDnDznl+T81fckHx9zD+rWTFXcXj9WxuGtUpeAXCZoH46FMTpKqd/UEZakz
         EH3FwW1vaTmyg==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id 022BA24B39E;
        Sat,  2 Sep 2023 13:11:11 +0700 (WIB)
Date:   Sat, 2 Sep 2023 13:11:06 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Cc:     Willy Tarreau <w@1wt.eu>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        David Laight <David.Laight@aculab.com>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/4] tools/nolibc: x86-64: Use `rep movsb` for
 `memcpy()` and `memmove()`
Message-ID: <ZPLR+mO/6/V7wjAJ@biznet-home.integral.gnuweeb.org>
References: <20230902055045.2138405-1-ammarfaizi2@gnuweeb.org>
 <20230902055045.2138405-2-ammarfaizi2@gnuweeb.org>
 <CAOG64qNw+ZovcC4+5Sqsvi-m=wyoe47eb5K4KAdbO5hcp8ipAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOG64qNw+ZovcC4+5Sqsvi-m=wyoe47eb5K4KAdbO5hcp8ipAA@mail.gmail.com>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 02, 2023 at 01:07:50PM +0700, Alviro Iskandar Setiawan wrote:
> Btw, sir, this can be simplified more by merging the forward copy
> path, only using two "rep movsb" for both memmove() and memcpy()
> should be enough?
> ```
> __asm__ (
> ".section .text.nolibc_memmove_memcpy\n"
> ".weak memmove\n"
> ".weak memcpy\n"
> "memmove:\n"
>         "movq %rdx, %rcx\n"
>         "movq %rdi, %rdx\n"
>         "movq %rdi, %rax\n"
>         "subq %rsi, %rdx\n"
>         "cmpq %rcx, %rdx\n"
>         "jnb __nolibc_forward_copy\n"
>         "leaq -1(%rdi, %rcx, 1), %rdi\n"
>         "leaq -1(%rsi, %rcx, 1), %rsi\n"
>         "std\n"
>         "rep movsb\n"
>         "cld\n"
>         "retq\n"
> 
> "memcpy:\n"
>         "movq %rdi, %rax\n"
>         "movq %rdx, %rcx\n"
> "__nolibc_forward_copy:\n"
>         "rep movsb\n"
>         "retq\n"
> );
> ```

Looks good. I'll apply that change.

-- 
Ammar Faizi

