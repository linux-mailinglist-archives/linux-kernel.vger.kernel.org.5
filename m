Return-Path: <linux-kernel+bounces-159788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D2F8B340A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31B5DB214B9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7732613F00B;
	Fri, 26 Apr 2024 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MN6p59/z"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE2B13EFF4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123868; cv=none; b=ZHg1wNcDG9D5a4fBboxKYJxiqSIBcHX+dffE5/v7XK3ggrJGn2X/3lJWEILlg1n2lI7zmBGEC+4+5vG5SoxcJaKIxOhPVKhdi5Af2CGOqa4HDhqiaKgGQhtYK7R/Hu3m60KbjkUjq/MU0X24TsyYR03ZwtNKNqKrYEeKGndIa9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123868; c=relaxed/simple;
	bh=gX6ea/DL3JX3y/Prq+oh9EV/8KjABequtXJpx05mLLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGn/ypWY0DzQ2wnJxj0euA1slFdIR8m+w3xEnaxaS+Xs+cFOSol3pa2/axVkWbHwJWYsIuK1gBsF3HTP222g5emd7f3byOY5s9fqVrF2tvpA9tYvrMv26pvrCyQ8OZAxiRdZi/B1pMgNOb44LS0km0d4eCxCwyXFDJqZrfQXJFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=MN6p59/z; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 90E3366B;
	Fri, 26 Apr 2024 11:30:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1714123809;
	bh=gX6ea/DL3JX3y/Prq+oh9EV/8KjABequtXJpx05mLLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MN6p59/zeYwcLR+EbRPnzWBVXPx0wiusejHNikK/yqM3bClvQcJCGlJyQ6q2TB6rh
	 q432bUMQdaOqthrPmsCxsrRXsnFVVJ0sFC2EpZ1K3qxMjGDhjBkEgl9Ong9p/UWGr8
	 g6Hv3D/TmJAsoO42hb4EldVFthGPD6m4gysv8AJ8=
Date: Fri, 26 Apr 2024 12:30:53 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Sean Anderson <sean.anderson@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] drm: zynqmp_dpsub: Always register bridge
Message-ID: <20240426093053.GB4524@pendragon.ideasonboard.com>
References: <20240308204741.3631919-1-sean.anderson@linux.dev>
 <222c0245-b8bc-48d8-b4e1-a9fb276774ae@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <222c0245-b8bc-48d8-b4e1-a9fb276774ae@ideasonboard.com>

On Fri, Mar 22, 2024 at 08:01:44AM +0200, Tomi Valkeinen wrote:
> On 08/03/2024 22:47, Sean Anderson wrote:
> > We must always register the DRM bridge, since zynqmp_dp_hpd_work_func
> > calls drm_bridge_hpd_notify, which in turn expects hpd_mutex to be
> > initialized. We do this before zynqmp_dpsub_drm_init since that calls
> > drm_bridge_attach. This fixes the following lockdep warning:
> > 
> > [   19.217084] ------------[ cut here ]------------
> > [   19.227530] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
> > [   19.227768] WARNING: CPU: 0 PID: 140 at kernel/locking/mutex.c:582 __mutex_lock+0x4bc/0x550
> > [   19.241696] Modules linked in:
> > [   19.244937] CPU: 0 PID: 140 Comm: kworker/0:4 Not tainted 6.6.20+ #96
> > [   19.252046] Hardware name: xlnx,zynqmp (DT)
> > [   19.256421] Workqueue: events zynqmp_dp_hpd_work_func
> > [   19.261795] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [   19.269104] pc : __mutex_lock+0x4bc/0x550
> > [   19.273364] lr : __mutex_lock+0x4bc/0x550
> > [   19.277592] sp : ffffffc085c5bbe0
> > [   19.281066] x29: ffffffc085c5bbe0 x28: 0000000000000000 x27: ffffff88009417f8
> > [   19.288624] x26: ffffff8800941788 x25: ffffff8800020008 x24: ffffffc082aa3000
> > [   19.296227] x23: ffffffc080d90e3c x22: 0000000000000002 x21: 0000000000000000
> > [   19.303744] x20: 0000000000000000 x19: ffffff88002f5210 x18: 0000000000000000
> > [   19.311295] x17: 6c707369642e3030 x16: 3030613464662072 x15: 0720072007200720
> > [   19.318922] x14: 0000000000000000 x13: 284e4f5f4e524157 x12: 0000000000000001
> > [   19.326442] x11: 0001ffc085c5b940 x10: 0001ff88003f388b x9 : 0001ff88003f3888
> > [   19.334003] x8 : 0001ff88003f3888 x7 : 0000000000000000 x6 : 0000000000000000
> > [   19.341537] x5 : 0000000000000000 x4 : 0000000000001668 x3 : 0000000000000000
> > [   19.349054] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffff88003f3880
> > [   19.356581] Call trace:
> > [   19.359160]  __mutex_lock+0x4bc/0x550
> > [   19.363032]  mutex_lock_nested+0x24/0x30
> > [   19.367187]  drm_bridge_hpd_notify+0x2c/0x6c
> > [   19.371698]  zynqmp_dp_hpd_work_func+0x44/0x54
> > [   19.376364]  process_one_work+0x3ac/0x988
> > [   19.380660]  worker_thread+0x398/0x694
> > [   19.384736]  kthread+0x1bc/0x1c0
> > [   19.388241]  ret_from_fork+0x10/0x20
> > [   19.392031] irq event stamp: 183
> > [   19.395450] hardirqs last  enabled at (183): [<ffffffc0800b9278>] finish_task_switch.isra.0+0xa8/0x2d4
> > [   19.405140] hardirqs last disabled at (182): [<ffffffc081ad3754>] __schedule+0x714/0xd04
> > [   19.413612] softirqs last  enabled at (114): [<ffffffc080133de8>] srcu_invoke_callbacks+0x158/0x23c
> > [   19.423128] softirqs last disabled at (110): [<ffffffc080133de8>] srcu_invoke_callbacks+0x158/0x23c
> > [   19.432614] ---[ end trace 0000000000000000 ]---
> > 
> > Fixes: eb2d64bfcc17 ("drm: xlnx: zynqmp_dpsub: Report HPD through the bridge")
> > Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> > ---
> > 
> >   drivers/gpu/drm/xlnx/zynqmp_dpsub.c | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> > index 88eb33acd5f0..639fff2c693f 100644
> > --- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> > +++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> > @@ -256,12 +256,11 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
> >   	if (ret)
> >   		goto err_dp;
> >   
> > +	drm_bridge_add(dpsub->bridge);

A blank line here would be nice.

> >   	if (dpsub->dma_enabled) {
> >   		ret = zynqmp_dpsub_drm_init(dpsub);
> >   		if (ret)
> >   			goto err_disp;
> > -	} else {
> > -		drm_bridge_add(dpsub->bridge);
> >   	}
> >   
> >   	dev_info(&pdev->dev, "ZynqMP DisplayPort Subsystem driver probed");
> > @@ -288,9 +287,8 @@ static void zynqmp_dpsub_remove(struct platform_device *pdev)
> >   
> >   	if (dpsub->drm)
> >   		zynqmp_dpsub_drm_cleanup(dpsub);
> > -	else
> > -		drm_bridge_remove(dpsub->bridge);
> >   
> > +	drm_bridge_remove(dpsub->bridge);
> >   	zynqmp_disp_remove(dpsub);
> >   	zynqmp_dp_remove(dpsub);
> >   
> 
> I sent a similar patch:
> 
> https://lore.kernel.org/all/20240312-xilinx-dp-lock-fix-v1-1-1698f9f03bac@ideasonboard.com/
> 
> I have the drm_bridge_add() call in zynqmp_dp_probe(), as that's where 
> the bridge is set up, so it felt like a logical place. You add it later, 
> just before the bridge is used the first time.
> 
> I like mine a bit more as it has all the bridge code in the same place, 
> but I also wonder if there might be some risks in adding the bridge 
> early (before zynqmp_disp_probe()), although I can't see any issue right 
> away...

Seems we have the same concerns :-) I've reviewed your patch and wrote
pretty much the same. I would be more comfortable with this version,
even if I like gathering all bridge code in the same location.

> In any case, as this works for me too:
> 
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart

