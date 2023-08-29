Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C2878C437
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbjH2MZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbjH2MZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:25:04 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0BBDCD2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:24:47 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 37TCORUW015361;
        Tue, 29 Aug 2023 14:24:27 +0200
Date:   Tue, 29 Aug 2023 14:24:27 +0200
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
Message-ID: <ZO3je2rNChZwp6Ay@1wt.eu>
References: <20230828070240.1691921-1-ammarfaizi2@gnuweeb.org>
 <20230828070240.1691921-2-ammarfaizi2@gnuweeb.org>
 <ZO2Oey26OZ5PNPTr@1wt.eu>
 <ZO3hxnKlWEbT/MPd@biznet-home.integral.gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO3hxnKlWEbT/MPd@biznet-home.integral.gnuweeb.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 07:17:10PM +0700, Ammar Faizi wrote:
> On Tue, Aug 29, 2023 at 08:21:47AM +0200, Willy Tarreau wrote:
> > Indeed, good catch! However if we want to do it cleany (i.e not punch a
> > 16 to 28 byes hole in the stack), we should do this instead:
> > 
> > 		add  $12, %esp   /* the stack must be aligned to 16 ... */
> > 		and  $-16, %esp  /* ... bytes after eax is pushed and ... */
> > 		sub  $12, %esp   /* ... before the call. */
> > 
> > This will only add 0 to 12 bytes depending on the existing alignment.
> > 
> > What do you think ?
> 
> Good point. I'll send a v3 revision tomorrow.

OK thanks!

> I just saw that Linus has pulled the PR from Shuah that contains this
> bug. IOW, I missed this fix for the 6.6 merge window. Let's see if it
> can go to 6.6-rc2. Or maybe sooner than that.

No worries, we all know that -rc1 gets more exposure than individual
branches and raises bugs like this one.

Cheers,
Willy
