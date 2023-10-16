Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C08B7C9CC7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 03:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjJPB0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 21:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPB0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 21:26:25 -0400
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E490A9;
        Sun, 15 Oct 2023 18:26:20 -0700 (PDT)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
        by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4S7zs85ws4z9xg13;
        Mon, 16 Oct 2023 09:23:40 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 16 Oct
 2023 09:25:59 +0800
Date:   Mon, 16 Oct 2023 09:25:59 +0800
From:   Wang Jinchao <wangjinchao@xfusion.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
CC:     Steffen Klassert <steffen.klassert@secunet.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stone.xulei@xfusion.com>
Subject: Re: [PATCH v3] Fixes: 07928d9bfc81 ("padata: Remove broken queue
 flushing")
Message-ID: <ZSyRJx/5b8PufWwA@fedora>
References: <ZSDWAcUxXcwD4YUZ@fedora>
 <tgveetqzkm4if3kkq5mzhgfetbm4nqe5coegphdtyye3xul6r4@5cr6uvfrinow>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <tgveetqzkm4if3kkq5mzhgfetbm4nqe5coegphdtyye3xul6r4@5cr6uvfrinow>
X-Originating-IP: [10.82.147.3]
X-ClientProxiedBy: wuxshcsitd00600.xfusion.com (10.32.133.213) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 11:22:03AM -0400, Daniel Jordan wrote:
> Hi,
> 
> On Sat, Oct 07, 2023 at 11:52:33AM +0800, Wang Jinchao wrote:
> > Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
> 
> The Fixes: tag should be near your Signed-off-by:, and the subject of
> the patch should be something descriptive like
> 
>     padata: Fix refcnt handling in padata_free_shell()
> 
> Here's some documentation about this:
> 
>     https://docs.kernel.org/process/5.Posting.html#patch-formatting-and-changelogs
> 
Updated in patch v4.

> > Acked-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> > ---
> > V3: 
> >     Include Daniel's ack
> >
> > V2: https://lore.kernel.org/all/ZRTLHY5A+VqIKhA2@fedora/
> >     To satisfy Sparse, use rcu_dereference_protected.
> >     Reported-by: kernel test robot <lkp@intel.com>
> >     Closes: https://lore.kernel.org/oe-kbuild-all/202309270829.xHgTOMKw-lkp@intel.com/
> 
> These two tags can also go near your SoB.
> 
From intel kernel test robot:
    If you fix the issue in a separate patch/commit (i.e. not just a new version of
    the same patch/commit), kindly add following tags
    | Reported-by: kernel test robot <lkp@intel.com>
    | Closes: https://lore.kernel.org/oe-kbuild-all/202309270829.xHgTOMKw-lkp@intel.com/
So I updated the patch without these tags.

> > V1: https://lore.kernel.org/all/ZRE4XvOOhz4HSOgR@fedora/
> > 
> >  kernel/padata.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/padata.c b/kernel/padata.c
> > index 222d60195de6..79d04a97ded6 100644
> > --- a/kernel/padata.c
> > +++ b/kernel/padata.c
> > @@ -1102,12 +1102,16 @@ EXPORT_SYMBOL(padata_alloc_shell);
> >   */
> >  void padata_free_shell(struct padata_shell *ps)
> >  {
> > +	struct parallel_data *pd;
> > +
> >  	if (!ps)
> >  		return;
> >  
> >  	mutex_lock(&ps->pinst->lock);
> >  	list_del(&ps->list);
> > -	padata_free_pd(rcu_dereference_protected(ps->pd, 1));
> > +	pd = rcu_dereference_protected(ps->pd, 1);
> > +	if (refcount_dec_and_test(&pd->refcnt))
> > +		padata_free_pd(rcu_dereference_protected(ps->pd, 1));
> 
> As Herbert points out, this version changes the code by
> rcu-dereferencing pd twice.  Usually previous acks are dropped when
> introducing new changes, but you can have it back by only
> rcu-dereferencing once and addressing the other comments above.
Thanks for your and Herbert's acks, which were included in patch v4.

I know Herbert has acked my patch from your email; however, I have 
not received Herbert's acknowledgment email, and I do not know why.
> 
> >  	mutex_unlock(&ps->pinst->lock);
> >  
> >  	kfree(ps);
> > -- 
> > 2.40.0
> > 
