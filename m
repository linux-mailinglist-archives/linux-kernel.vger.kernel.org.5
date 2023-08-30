Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DD278DA5F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbjH3SgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245507AbjH3PXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:23:46 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E92783
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:23:40 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 37UFNMms027896;
        Wed, 30 Aug 2023 17:23:22 +0200
Date:   Wed, 30 Aug 2023 17:23:22 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 2/5] tools/nolibc: x86-64: Use `rep stosb` for
 `memset()`
Message-ID: <ZO9e6h2jjVIMpBJP@1wt.eu>
References: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
 <20230830135726.1939997-3-ammarfaizi2@gnuweeb.org>
 <CAOG64qNGdPjXHTvrpYxjizOYvMRaB9_2t2raw6DJ3kK852KUHg@mail.gmail.com>
 <ZO9bv+GvgpphtGEi@biznet-home.integral.gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO9bv+GvgpphtGEi@biznet-home.integral.gnuweeb.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 10:09:51PM +0700, Ammar Faizi wrote:
> On Wed, Aug 30, 2023 at 09:24:45PM +0700, Alviro Iskandar Setiawan wrote:
> > Just a small idea to shrink this more, "mov %rdi, %rdx" and "mov %rdx,
> > %rax" can be replaced with "push %rdi" and "pop %rax" (they are just a
> > byte). So we can save 4 bytes more.
> > 
> > 0000000000001500 <memset>:
> >     1500: 48 89 f0     mov    %rsi,%rax
> >     1503: 48 89 d1     mov    %rdx,%rcx
> >     1506: 57           push   %rdi
> >     1507: f3 aa        rep stos %al,%es:(%rdi)
> >     1509: 58           pop    %rax
> >     150a: c3           ret
> > 
> > But I know you don't like it because it costs extra memory access.
> 
> Yes, that's an extra memory access. But I believe it doesn't hurt
> someone targetting -Os. In many cases, the compilers use push/pop to
> align the stack before a 'call' instruction. If they want to avoid extra
> memory access, they could have used "subq $8, %rsp" and "addq $8, %rsp".

Then "xchg %esi, %eax" is just one byte with no memory access ;-)

Willy
