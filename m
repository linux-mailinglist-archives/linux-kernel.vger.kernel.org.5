Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3221E757653
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjGRIMp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Jul 2023 04:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjGRIMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:12:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A426188
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:12:42 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1qLfos-0000Xm-7H; Tue, 18 Jul 2023 10:12:30 +0200
Message-ID: <ee96ed1a1ff12656f6e6542ae928fb526a9758fe.camel@pengutronix.de>
Subject: Re: [PATCH v1 3/8] drm/etnaviv: Drop the second argument of the
 etnaviv_gem_new_impl()
From:   Lucas Stach <l.stach@pengutronix.de>
To:     suijingfeng <suijingfeng@loongson.cn>,
        Sui Jingfeng <sui.jingfeng@linux.dev>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     loongson-kernel@lists.loongnix.cn, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Tue, 18 Jul 2023 10:12:25 +0200
In-Reply-To: <e3a05204-61fe-2318-5f06-fd12addfe2e9@loongson.cn>
References: <20230623100822.274706-1-sui.jingfeng@linux.dev>
         <20230623100822.274706-4-sui.jingfeng@linux.dev>
         <862358e67a6f118b11ba16fb94828e9d1635cb66.camel@pengutronix.de>
         <e3a05204-61fe-2318-5f06-fd12addfe2e9@loongson.cn>
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

Hi Jingfeng,

Am Dienstag, dem 18.07.2023 um 02:34 +0800 schrieb suijingfeng:
> Hi,  Lucas
> 
> 
> Thanks for you guidance!
> 
> 
> On 2023/7/17 17:51, Lucas Stach wrote:
> > Hi Jingfeng,
> > 
> > Am Freitag, dem 23.06.2023 um 18:08 +0800 schrieb Sui Jingfeng:
> > > From: Sui Jingfeng <suijingfeng@loongson.cn>
> > > 
> > > Because it is not used by the etnaviv_gem_new_impl() function,
> > > no functional change.
> > > 
> > I think it would make sense to move into the opposite direction: in
> > both callsites of etnaviv_gem_new_impl we immediately call
> > drm_gem_object_init with the size.
> 
> Really?
> 
> But there are multiple call path to the etnaviv_gem_new_impl() function.
> 
> 
> Code path 1 (PRIME):
> 
> > - etnaviv_gem_prime_import_sg_table()
> 
> > --  etnaviv_gem_new_private()
> 
> > --- etnaviv_gem_new_impl(dev, size, flags, ops, &obj)
> 
> > --- drm_gem_private_object_init(dev, obj, size)
> 
> 
> Code path 2 (USERPTR):
> 
> > - etnaviv_gem_new_userptr()
> 
> > --  etnaviv_gem_new_private()
> 
> > --- etnaviv_gem_new_impl(dev, size, flags, ops, &obj)
> 
> > --- drm_gem_private_object_init(dev, obj, size)
> 
> 
> Code path 3 (construct a GEM buffer object for the user-space):
> 
> > - etnaviv_ioctl_gem_new()
> 
> > -- etnaviv_gem_new_handle()
> 
> > --- etnaviv_gem_new_impl(dev, size, flags, &etnaviv_gem_shmem_ops, &obj);
> 
> > ---  drm_gem_object_init(dev, obj, size);
> 
> 
> If I understand this correctly:
> 
> 
> Code path 1 is for cross device (and cross driver) buffer-sharing,
> 
> Code path 2 is going to share the buffer the userspace,
> 
> 
> *Only* the code path 3 is to construct a GEM buffer object for the 
> user-space the userspace,
> 
> that is say, *only* the code path 3 need to do the backing memory 
> allocation work for the userspace.
> 
> thus it need to call drm_gem_object_init() function, which really the 
> shmem do the backing memory
> 
> allocation.
> 
> 
> The code path 1 and the code path 2 do not need the kernel space 
> allocate the backing memory.
> 
> Because they are going to share the buffer already allocated by others.
> 
> thus, code path 2 and code path 3 should call drm_gem_private_object_init(),
> 
> *not* the drm_gem_object_init() function.
> 
> 
> When import buffer from the a specific KMS driver,
> 
> then etnaviv_gem_prime_import_sg_table() will be called.
> 
> 
> I guess you means that drm_gem_private_object_init() (not the 
> drm_gem_object_init() function)here ?
> 
> 
> > A better cleanup would be to make
> > use of the size parameter and move this object init call into
> > etnaviv_gem_new_impl.
> 
> If I following you guidance, how do I differentiate the cases
> 
> when to call drm_gem_private_object_init() not drm_gem_object_init() ?
> 
> and when call drm_gem_object_init() not drm_gem_private_object_init()?
> 
> 
> I don't think you are right here.
> 
Yes, clearly I was not taking into account the differences between
drm_gem_private_object_init and drm_gem_object_init properly. Please
disregard my comment, this patch is good as-is.

Regards,
Lucas

> > 
> > Regards,
> > Lucas
> > 
> > > Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> > > ---
> > >   drivers/gpu/drm/etnaviv/etnaviv_gem.c | 7 +++----
> > >   1 file changed, 3 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> > > index b5f73502e3dd..be2f459c66b5 100644
> > > --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> > > +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> > > @@ -542,7 +542,7 @@ static const struct drm_gem_object_funcs etnaviv_gem_object_funcs = {
> > >   	.vm_ops = &vm_ops,
> > >   };
> > >   
> > > -static int etnaviv_gem_new_impl(struct drm_device *dev, u32 size, u32 flags,
> > > +static int etnaviv_gem_new_impl(struct drm_device *dev, u32 flags,
> > >   	const struct etnaviv_gem_ops *ops, struct drm_gem_object **obj)
> > >   {
> > >   	struct etnaviv_gem_object *etnaviv_obj;
> > > @@ -591,8 +591,7 @@ int etnaviv_gem_new_handle(struct drm_device *dev, struct drm_file *file,
> > >   
> > >   	size = PAGE_ALIGN(size);
> > >   
> > > -	ret = etnaviv_gem_new_impl(dev, size, flags,
> > > -				   &etnaviv_gem_shmem_ops, &obj);
> > > +	ret = etnaviv_gem_new_impl(dev, flags, &etnaviv_gem_shmem_ops, &obj);
> > >   	if (ret)
> > >   		goto fail;
> > >   
> > > @@ -627,7 +626,7 @@ int etnaviv_gem_new_private(struct drm_device *dev, size_t size, u32 flags,
> > >   	struct drm_gem_object *obj;
> > >   	int ret;
> > >   
> > > -	ret = etnaviv_gem_new_impl(dev, size, flags, ops, &obj);
> > > +	ret = etnaviv_gem_new_impl(dev, flags, ops, &obj);
> > >   	if (ret)
> > >   		return ret;
> > >   
> 

