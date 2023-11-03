Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D927A7E0168
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbjKCHfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 03:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbjKCHfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 03:35:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36413CE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 00:35:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0629CC433C8;
        Fri,  3 Nov 2023 07:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698996911;
        bh=OwYraiWkRGh713mFuBYUkMG66+APMALaM2UA9/OPM4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MpQvfuD64rLyAZYkNj6bZGqNDUHXaBufxMYO7HTTllrrdXkiY5fSmEKrzDlJtpMJ+
         TG1it3u/4YTXqyVqHba3o/03rXvIiokvctVSUrIGRSf96MBWBvF+msAvFoznrhdkGF
         E4mIRx3hAru3EaujSHaWm+Fk3A+OuzouKtd3TBn2vKqQ/9h0fZlBrYPNA4Kj97kpyT
         0tLQlqje7tlZCTHJPaGtgN4CC0KJo6W8FncdU0Hwea2w1zGXrZdMOgpmx75YvKeUDD
         +EF+jkYlw+t0BI+zLRgcsjk+O3CmBcbwkWnShoG108n0UQ8VY+bgX71sYj61uTS737
         lh1CSEprMLS2A==
Date:   Fri, 3 Nov 2023 09:34:59 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     =?utf-8?B?6buE5Lqu5Lqu?= <huanglllzu@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, Liangliang Huang <huangll@lemote.com>
Subject: Re: [PATCH] mm/memblock.c: using judgment statement can reduce loop
 and enhance readability.
Message-ID: <20231103073459.GN2824@kernel.org>
References: <20231102023710.13023-1-huanglllzu@gmail.com>
 <20231102085418.GM2824@kernel.org>
 <CAOneMZVWkUMR5B_RA=J=o+xo5vAAWNPmDRyHQXH_ztpx_K3fNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOneMZVWkUMR5B_RA=J=o+xo5vAAWNPmDRyHQXH_ztpx_K3fNw@mail.gmail.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 01:30:21PM +0800, 黄亮亮 wrote:
> Hi,this patch can less loop once in this situation:
> base more than rbase and end less than rend.
>                 base           end
>     rbase-----|--------------|-------rend
>       |            |                 |           |
> -------------------------------------------------------->

The loop won't be executed anyway because there's similar condition in the
beginning of the loop. 

Next time when you reply to the kernel mailing lists, please don't top post
and make sure your reply is text-only.

And there is no need to send 4 badly formatted replies.
 
> Mike Rapoport <rppt@kernel.org> 于2023年11月2日周四 16:54写道：
> 
>     Hi,
> 
>     > Subject: [PATCH] mm/memblock.c: using judgment statement can reduce loop
>     and enhance readability.
> 
>     I disagree.
> 
>     On Thu, Nov 02, 2023 at 10:37:10AM +0800, huanglllzu@gmail.com wrote:
>     > From: Liangliang Huang <huangll@lemote.com>
>     >
>     > Signed-off-by: Liangliang Huang <huangll@lemote.com>
>     > ---
>     >  mm/memblock.c | 6 +++++-
>     >  1 file changed, 5 insertions(+), 1 deletion(-)
>     >
>     > diff --git a/mm/memblock.c b/mm/memblock.c
>     > index 913b2520a9a0..e48dea7144bb 100644
>     > --- a/mm/memblock.c
>     > +++ b/mm/memblock.c
>     > @@ -655,7 +655,11 @@ static int __init_memblock memblock_add_range(struct
>     memblock_type *type,
>     >                       }
>     >               }
>     >               /* area below @rend is dealt with, forget about it */
>     > -             base = min(rend, end);
>     > +             if (end < rend) {
>     > +                     base = end;
>     > +                     break;
>     > +             } else
>     > +                     base = rend;
> 
>     min() is perfectly clear and there no change in number of iterations of the
>     loop.
> 
>     >       }
>     > 
>     >       /* insert the remaining portion */
>     > --
>     > 2.25.1
>     >
> 
>     --
>     Sincerely yours,
>     Mike.
> 

-- 
Sincerely yours,
Mike.
