Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862E878DF28
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242858AbjH3TMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245625AbjH3PpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:45:04 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E205B122
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693410301;
        bh=C+m0B3MqZ+rrcZQO51wczW2Uy/Wthx7qnrlmeTa0W9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ieGNKi2w+gVGTboyK8clI32Zwfk7Yfv129ChX6HCXNl1SQ7vZ0QjpcI8c3rp+nfyy
         /JaZlnOd28sUbs2+ZdhSKIXk20mtdefMlRRblElXfHQNKIKgCT9DMKbuc/JVf3+KF1
         2uFurtuAAa2em17tpIpelP5pZMqECR6z+czXacSW4QQb0QduMNi1U9fvs27Linhh73
         n/7EfgbNQ6RY/Hf6bA4acGAJSWRHve6wt5EaOZ/zLbVgNYbuSQttFGr+V735W2pZoF
         vWWsqs9JMP0WOkpWtihYK/EoApJQydW+qzJeji3YosfuQPS2SUYmtOHH3q8tF1BuvQ
         HFX+zZLZ711nA==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id 7148C24B32D;
        Wed, 30 Aug 2023 22:44:58 +0700 (WIB)
Date:   Wed, 30 Aug 2023 22:44:53 +0700
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
Message-ID: <ZO9j9WhSj7PmsM8b@biznet-home.integral.gnuweeb.org>
References: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
 <20230830135726.1939997-3-ammarfaizi2@gnuweeb.org>
 <CAOG64qNGdPjXHTvrpYxjizOYvMRaB9_2t2raw6DJ3kK852KUHg@mail.gmail.com>
 <ZO9bv+GvgpphtGEi@biznet-home.integral.gnuweeb.org>
 <ZO9e6h2jjVIMpBJP@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO9e6h2jjVIMpBJP@1wt.eu>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 05:23:22PM +0200, Willy Tarreau wrote:
> Then "xchg %esi, %eax" is just one byte with no memory access ;-)

Perfect!

Now I got this, shorter than "movl %esi, %eax":
```
0000000000001500 <memset>:
    1500: 96          xchg   %eax,%esi
    1501: 48 89 d1    mov    %rdx,%rcx
    1504: 57          push   %rdi
    1505: f3 aa       rep stos %al,%es:(%rdi)
    1507: 58          pop    %rax
    1508: c3          ret
```

Unfortunately, the xchg trick doesn't yield smaller machine code for
%rdx, %rcx. Lol.

-- 
Ammar Faizi

