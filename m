Return-Path: <linux-kernel+bounces-167665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FEF8BACF8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB2F283A6E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1D5153832;
	Fri,  3 May 2024 13:02:10 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585A614267
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741329; cv=none; b=j8p/vOA0uL4gtt7VPv5eZWo4+UXWx1QiZHe7Y9rjMHJjENBvBxfdYvSA+9xzIIJ5a1dPjHmo4h8zaXZMwoDzbuWgO7gGfPEmtuyLypS0m4+8sdBKTmNlTU8kyKXZedqPsjK3eTJeUGmQBOvPcVUrr2ZtCCpmqCVanKrH7cqQtpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741329; c=relaxed/simple;
	bh=b3qbE/w6bO7OGRolrMjXe2DRKXc4y4+CHo4Ddy4n8Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Unxv6wQP6kaL9q8ZDZAQ8OVD4pEq5I2mjdOOpPoD12e5E3jK9J7SBEVtpws+hY3Y4yUHFORVlzGPAWn5+++XvHWm43LVXztkqKdsl5b6znOnAIETiROjPm38OCAU9s3XFjBjElt4/pq8g4FaMstM6/Dskdx3/hk20r6GMY6XYtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b01.versanet.de ([83.135.91.1] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1s2sY6-0000wj-1A; Fri, 03 May 2024 15:02:02 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: hjc@rock-chips.com, andy.yan@rock-chips.com,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Subject:
 Re: [PATCH 2/2] drm/rockchip: vop2: configure layers for vp3 on rk3588
Date: Fri, 03 May 2024 15:02:01 +0200
Message-ID: <9626238.rMLUfLXkoz@diego>
In-Reply-To: <062d86ab-1518-4160-870c-3cd36228d055@cherry.de>
References:
 <20240425195506.2935955-1-heiko@sntech.de>
 <20240425195506.2935955-3-heiko@sntech.de>
 <062d86ab-1518-4160-870c-3cd36228d055@cherry.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 3. Mai 2024, 14:57:03 CEST schrieb Quentin Schulz:
> Hi Heiko,
> 
> On 4/25/24 9:55 PM, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@cherry.de>
> > 
> > The rk3588 VOP2 has 4 video-ports, yet the driver currently only
> > configures the first 3, as used on the rk3568.
> > 
> 
> I'm wondering whether we should update the drawing at the top of the 
> driver then?
> 
> > Add another block to configure the vp3 as well, if applicable.
> > 
> > Fixes: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> > ---
> >   drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 12 ++++++++++++
> >   drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  1 +
> >   2 files changed, 13 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> > index 523880a4e8e74..1a327a9ed7ee4 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> > @@ -2303,6 +2303,7 @@ static void vop2_setup_alpha(struct vop2_video_port *vp)
> >   static void vop2_setup_layer_mixer(struct vop2_video_port *vp)
> >   {
> >   	struct vop2 *vop2 = vp->vop2;
> > +	const struct vop2_data *vop2_data = vop2->data;
> >   	struct drm_plane *plane;
> >   	u32 layer_sel = 0;
> >   	u32 port_sel;
> > @@ -2344,6 +2345,17 @@ static void vop2_setup_layer_mixer(struct vop2_video_port *vp)
> >   	else
> >   		port_sel |= FIELD_PREP(RK3568_OVL_PORT_SET__PORT2_MUX, 8);
> >   
> > +	/* configure vp3 */
> > +	if (vop2_data->soc_id == 3588) {
> 
> I think it'd be smarter to check against vop2->data->nr_vps >= 4; so 
> that we don't need to maintain a list of SoCs that support a specific 
> number of video ports.

probably ;-)

> 
> > +		struct vop2_video_port *vp3 = &vop2->vps[3];
> 
> This is always possible because vps is statically allocated for 4 items, 
> c.f. struct vop2_video_port vps[ROCKCHIP_MAX_CRTC]; so we don't 
> necessarily need it in this specific location and can group it with the 
> others. Cosmetic suggestion though.
> 
> Otherwise, the change itself makes sense to me, so:
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

though comments from Andy from Rockchip in another thread suggest that
this is not necessary at all, as the "last" vp somehow has a hardware lock
to take the remaining layers or so.

And while tracking down dsi issues I had a "binary" state of
"gray display" without this patch and working DSI with it, in the last days
I haven't been able to reproduce this anymore.

So I guess I'll fix up the first patch according to your comment and keep
this change here for later.


Heiko



