Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDEF7EFFED
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 14:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjKRNm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 08:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKRNm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 08:42:58 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8AF131;
        Sat, 18 Nov 2023 05:42:54 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1r4Lau-00038a-H1; Sat, 18 Nov 2023 14:42:44 +0100
Date:   Sat, 18 Nov 2023 14:42:44 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Kamil Duljas <kamil.duljas@gmail.com>
Cc:     Florian Westphal <fw@strlen.de>, Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
        Johannes Berg <johannes@sipsolutions.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genetlink: Prevent memory leak when krealloc fail
Message-ID: <20231118134244.GB30289@breakpoint.cc>
References: <20231118113357.1999-1-kamil.duljas@gmail.com>
 <20231118120235.GA30289@breakpoint.cc>
 <CAFR=A7nkyx_Lf=p0BS-S68_vxQL97rUoLMZpo4kxHjKykAgTRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFR=A7nkyx_Lf=p0BS-S68_vxQL97rUoLMZpo4kxHjKykAgTRw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kamil Duljas <kamil.duljas@gmail.com> wrote:
> Yes, you're right. I did not think about it. So if we have a static
> pointer that may be resued, should not restore the pointer as at the
> beginning?
> static unsigned long *mc_groups = &mc_group_start;
> 
> At this moment we don't know how much memory is allocated. What do you
> think about this?

We do: mc_groups_longs.

> >                               new_groups = krealloc(mc_groups, nlen,
> >                                                     GFP_KERNEL);
> > -                             if (!new_groups)
> > +                             if (!new_groups) {
> > +                                     kfree(mc_groups);
> > +                                     mc_groups = &mc_group_start;
> >                                       return -ENOMEM;
> > +                             }

Seems wrong to shrink when we can't grow.  Whats the point?
