Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6346278C416
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbjH2MRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbjH2MRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:17:21 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C449F1A3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693311437;
        bh=r9JIMuVHYUbz9HrY38YzZxT2+1q5zZRjOatl2kuFGb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=UaK8zYUsG5PVrvtFPqK+5GzwGRIvsQH5rzpr756S/luk5m5Sh3wAQslRGkoCLytTx
         WjFJZHvUpv2W5lNRfyiBF0cEvD6e07uMe7KIjXRlEW6vJOdU0o3sBNubmZTFAB7/QN
         vC6GADLbC3ZuE7a4tTe8pZx+OGw8zF56It6Wqs9Rbe8D+6fcQWAEXlofj02KzVseGU
         FP4GUhOzi8UqVods3WXi26pf4wkA5a73HtZG8uUzGmG4Ce8lVLuXUzIUJMG0IhSGOi
         ZoE94Hhv47NEl1qIn8qG0yMGvcwTsWupu3YpFSjGWtoQ5eAOZ5Hz3W4c3cYSgUGAUi
         34vVFjxK5RZow==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id E417424B216;
        Tue, 29 Aug 2023 19:17:14 +0700 (WIB)
Date:   Tue, 29 Aug 2023 19:17:10 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Zhangjin Wu <falcon@tinylab.org>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] tools/nolibc: i386: Fix a stack misalign bug on
 _start
Message-ID: <ZO3hxnKlWEbT/MPd@biznet-home.integral.gnuweeb.org>
References: <20230828070240.1691921-1-ammarfaizi2@gnuweeb.org>
 <20230828070240.1691921-2-ammarfaizi2@gnuweeb.org>
 <ZO2Oey26OZ5PNPTr@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO2Oey26OZ5PNPTr@1wt.eu>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 08:21:47AM +0200, Willy Tarreau wrote:
> Indeed, good catch! However if we want to do it cleany (i.e not punch a
> 16 to 28 byes hole in the stack), we should do this instead:
> 
> 		add  $12, %esp   /* the stack must be aligned to 16 ... */
> 		and  $-16, %esp  /* ... bytes after eax is pushed and ... */
> 		sub  $12, %esp   /* ... before the call. */
> 
> This will only add 0 to 12 bytes depending on the existing alignment.
> 
> What do you think ?

Good point. I'll send a v3 revision tomorrow.

I just saw that Linus has pulled the PR from Shuah that contains this
bug. IOW, I missed this fix for the 6.6 merge window. Let's see if it
can go to 6.6-rc2. Or maybe sooner than that.

-- 
Ammar Faizi

