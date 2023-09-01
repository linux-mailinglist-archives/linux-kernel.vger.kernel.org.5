Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDB878FF5F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 16:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350058AbjIAOmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 10:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238002AbjIAOl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 10:41:56 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8D8E7E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 07:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693579307;
        bh=sq64ylhYJhB0oPolcBbALSl3i0XxeEcOBjof0caz+7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=m0An2Q67aNbxrTBFvv3Or9QfxtN+fX6U9l2Jpx7fqekriqZX8p6T5/0w0wDupZOvn
         ++hP9XBIUdUEelTOxD6P6V0iRDSDQXbUDMJU2DxrrDsRu/GusEqbb+ri3KnsOs6yjL
         3mayMJFKa4YSfoAORZKovczhdCQbWkJGS0RT2BBp9VgY0D9/1dodpubjufARV61aGa
         F+imDY3BNhDQnfnt8rPc1wsOvS4/BnkeJJzAcjFLzBWCYeP+ejeoCgHdb6Pya0ycy2
         WIsVLDT/z0t2cKpStHD9WDalxoEhixQPCspcCGcydIcc5wvIvEsrqDjBbGmcqocdpE
         VevmdDA/ieUEA==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id 3748024B385;
        Fri,  1 Sep 2023 21:41:43 +0700 (WIB)
Date:   Fri, 1 Sep 2023 21:41:39 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Willy Tarreau <w@1wt.eu>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 0/5] nolibc x86-64 string functions
Message-ID: <ZPH4I2W+zvhK93U/@biznet-home.integral.gnuweeb.org>
References: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
 <5a821292d96a4dbc84c96ccdc6b5b666@AcuMS.aculab.com>
 <ZPHPJDXIkFfP5Eux@1wt.eu>
 <ZPHh0duonHnyAX6C@biznet-home.integral.gnuweeb.org>
 <b6a33f1c9c0544c29904e29b06a7cff8@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6a33f1c9c0544c29904e29b06a7cff8@AcuMS.aculab.com>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 02:23:28PM +0000, David Laight wrote:
> From: Ammar Faizi
> > Sent: 01 September 2023 14:06
...
> > __asm__ (
> > ".section .text.nolibc_memmove\n"
> > ".weak memmove\n"
> > "memmove:\n"
> > "    movq    %rdx, %rcx\n"
> > "    movq    %rdi, %rdx\n"
> > "    movq    %rdi, %rax\n"
> 
> You seem to have confused yourself about whether you are using %eax or %edx.

What do you mean? They're all 64-bit pointers.

What I know is that the %rdx will be clobbered by "subq %rsi, %rdx"
below and the %rax should be return value. That's why I copy the %rdi
twice. memmove() returns the dst pointer. Did I miss something?

> > "    subq    %rsi, %rdx\n"
> > "    cmpq    %rcx, %rdx\n"
> > "    jnb     .Lforward_copy\n"
> 
> I think I'd fall through to the forwards copy
> and not worry about replicating the 'reps movsb' and 'ret'.
> IIRC 'cld' can be slow as well.

Alright, I will avoid cld for the forward copy.

> > "    leaq    -1(%rdi, %rcx, 1), %rdi\n"
> > "    leaq    -1(%rsi, %rcx, 1), %rsi\n"
> > "    std\n"
> > ".Lforward_copy:\n"
> > "    rep movsb\n"
> > "    cld\n"
> > "    ret\n"
> > );

-- 
Ammar Faizi

