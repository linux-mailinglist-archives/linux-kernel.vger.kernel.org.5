Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2C27D1C01
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 11:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjJUJOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 05:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJUJOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 05:14:09 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2243B0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 02:14:06 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 39L9DcfV028421;
        Sat, 21 Oct 2023 11:13:38 +0200
Date:   Sat, 21 Oct 2023 11:13:38 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: Add Linux specific waitpid() flags
Message-ID: <ZTOWQnFwrQufHUyw@1wt.eu>
References: <20231020-nolibc-waitpid-flags-v1-1-8137072dae14@kernel.org>
 <633402b0-7167-465f-99c6-d959b5f48073@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <633402b0-7167-465f-99c6-d959b5f48073@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Sat, Oct 21, 2023 at 11:00:20AM +0200, Thomas Weißschuh  wrote:
> Hi,
> 
> Oct 20, 2023 23:57:01 Mark Brown <broonie@kernel.org>:
> 
> > Linux defines a few custom flags for waitpid(), make them available to
> > nolibc based programs.
> >
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > ---
> > tools/include/nolibc/types.h | 5 ++++-
> > 1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
> > index 8cfc4c860fa4..801ea0bb186e 100644
> > --- a/tools/include/nolibc/types.h
> > +++ b/tools/include/nolibc/types.h
> > @@ -109,7 +109,10 @@
> > #define WIFSIGNALED(status) ((status) - 1 < 0xff)
> >
> > /* waitpid() flags */
> > -#define WNOHANG      1
> > +#define WNOHANG      0x00000001
> > +#define __WNOTHREAD  0x20000000
> > +#define __WALL       0x40000000
> > +#define __WCLONE     0x80000000
> 
> Wouldn't it be easier to include linux/wait.h instead?

That's indeed the trend we should follow whenever possible. We've got
caught a few times in the past with build errors depending on the
includes ordering due to such redefinitions. I don't know if that's the
case for these ones (nor if including linux/wait.h would cause other
breakage) but it's worth considering at least.

The difficulty here is that originally nolibc did not *explicitly* depend
on UAPI headers, and was supposed to be self-sufficient (that was the
main point). Adapting to multiple archs caused the addition of ifdefs
all around, then trying to standardize the include file names instead
of just "nolibc.h" caused conflicts with programs already including
linux/anything.h. Anyway now we depend on linux/lots-of-stuff so I
think it's worth continuing in that direction so that we don't replicate
the UAPI maintenance effort.

Cheers,
Willy
