Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9596E7560A2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjGQKi0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 06:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjGQKiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:38:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7CC132
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:38:21 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1qLLcK-0004T1-LC; Mon, 17 Jul 2023 12:38:12 +0200
Message-ID: <8b0d82d48ff24f578e7a1c7433e56ddaadc3188b.camel@pengutronix.de>
Subject: Re: [PATCH v1 1/8] drm/etnaviv: Using the size_t variable to store
 the number of pages
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Sui Jingfeng <sui.jingfeng@linux.dev>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     loongson-kernel@lists.loongnix.cn,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 17 Jul 2023 12:38:10 +0200
In-Reply-To: <4484c007-132c-ce47-fa71-87f33c87fe07@linux.dev>
References: <20230623100822.274706-1-sui.jingfeng@linux.dev>
         <20230623100822.274706-2-sui.jingfeng@linux.dev>
         <4f80b175f94eaf386354d1f3425208ca6cf20482.camel@pengutronix.de>
         <4484c007-132c-ce47-fa71-87f33c87fe07@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, dem 17.07.2023 um 18:12 +0800 schrieb Sui Jingfeng:
> Hi
> 
> On 2023/7/17 17:43, Lucas Stach wrote:
> > Hi Jingfeng,
> > 
> > Am Freitag, dem 23.06.2023 um 18:08 +0800 schrieb Sui Jingfeng:
> > > From: Sui Jingfeng <suijingfeng@loongson.cn>
> > > 
> > > Because the etnaviv_gem_new_private() function receives the size_t argument
> > > for the number of pages. And the number of pages should be unsigned.
> > > 
> > > Note that Most 32-bit architectures use "unsigned int" size_t,
> > > and all 64-bit architectures use "unsigned long" size_t.
> > > So, let's keep the argument and parameter consistent.
> > > 
> > This explanation doesn't add up. npages is just that: a number of
> > pages. Why would it make sense to use size_t here?
> 
> Because the 'size' variable in the etnaviv_gem_prime_import_sg_table() 
> function is declared
> 
> as size_t type. On 64-bit machine, size_t is actually is 64-bit wide and 
> it is *unsigned*.
> 
> While 'int' is actually 32-bit wide(at both 32-bit system and 64-bit 
> system) and it is *signed*,
> 
> So, my point (argument) is that
> 
> 
> 1) This patch help to avoid the unnecessary 64 bit to 32 bit conversion.
> 
> 2) The kvmalloc_array() function also accept  size_t type (see the 
> prototype of  kvmalloc_array function include/linux/slab.h)
> 
> 
> So my patch do helps to keep the code style consistent.
> 
But then we go on to call drm_prime_sq_to_page_array(), which takes a
integer as the number of pages parameter, so the parameter types are
inconsistent before and after your patch, it just switches which
function call has to do some conversion.

> 
> > If you want to be consistent I would have expected this change to
> > switch things to unsigned int,
> 
> This may introduce a truncate operation (from a 64-bit to 32-bit), which 
> is necessary.
> 
If this truncation happens in the real world then something else is
already badly broken. All Vivante GPUs to date can only deal with 32bit
virtual addresses, so a buffer exhausting 31 bits of pages is way
larger than we could ever fit into the GPU VM.

Regards,
Lucas

> And when you pass the 'npages' parameter to kvmalloc_array() function,
> 
> The compiler probably has to do the integer promotion (from a 32-bit to 
> 64-bit) for you.
> 
> 
> > as you did in the second patch of this
> > series.
> > 
> > Regards,
> > Lucas
> > 
> > > Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> > > ---
> > >   drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c | 5 ++---
> > >   1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> > > index 3524b5811682..b003481adc2b 100644
> > > --- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> > > +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> > > @@ -114,7 +114,8 @@ struct drm_gem_object *etnaviv_gem_prime_import_sg_table(struct drm_device *dev,
> > >   {
> > >   	struct etnaviv_gem_object *etnaviv_obj;
> > >   	size_t size = PAGE_ALIGN(attach->dmabuf->size);
> > > -	int ret, npages;
> > > +	size_t npages = size / PAGE_SIZE;
> > > +	int ret;
> > >   
> > >   	ret = etnaviv_gem_new_private(dev, size, ETNA_BO_WC,
> > >   				      &etnaviv_gem_prime_ops, &etnaviv_obj);
> > > @@ -123,8 +124,6 @@ struct drm_gem_object *etnaviv_gem_prime_import_sg_table(struct drm_device *dev,
> > >   
> > >   	lockdep_set_class(&etnaviv_obj->lock, &etnaviv_prime_lock_class);
> > >   
> > > -	npages = size / PAGE_SIZE;
> > > -
> > >   	etnaviv_obj->sgt = sgt;
> > >   	etnaviv_obj->pages = kvmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
> > >   	if (!etnaviv_obj->pages) {

