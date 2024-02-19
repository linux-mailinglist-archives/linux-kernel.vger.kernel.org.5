Return-Path: <linux-kernel+bounces-71878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 595EA85AC26
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D47280DD7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C295250A6D;
	Mon, 19 Feb 2024 19:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="JVt1ocNF"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA1350A87
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 19:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371570; cv=none; b=rxRCA76B6PxWD+YGjWXjBNakUkzRGPWspLsY7BvW+O1V/9FtvJ7GMq05KyBiW734fToqt+kq7f+3sJv9F+OV3jZQDD5v1VfmEEHK2aayf4245nopevTk1TSfWg+q2zeoKngsE5V8jA7iJaKwpINQyIyHYWqn24W/ttyR7+B0KXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371570; c=relaxed/simple;
	bh=eYJcncYVMz2/P+8L4YuElamp9/gwH5EEjsU0YmeUEy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXB6VE108PY5QKKUump/Kr39F0flfGs5sOasDUDGukMpvWzDiJAFuHKEd+xD3NIvDrA1fJR1Qh5fDZNyrUkPK+82Q27HAS76Y8uGbYw6J61kI5USJJTgMXOnuSPN0sfF5FJ3TFTlnKjTAq7VbBGaqNpaY6/zIx6LkYTOCJPFy5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=JVt1ocNF; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708371564; bh=eYJcncYVMz2/P+8L4YuElamp9/gwH5EEjsU0YmeUEy4=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=JVt1ocNFUSrQEY5yZpav/AneRAxvrc0MRJokvqgkTVvWnzpX0EiEb1/bIAm8kdgJL
	 uPdGB9eJCG9pCCAUd4Qb3YPdsImVA5coUlQZe1Gf+3YAJv2Dm8W6DpHOh9dVd5pgux
	 9mdnhFla+wGVTifBvj3mjQfM9APNzqEgk+ZMO/DA=
Date: Mon, 19 Feb 2024 20:39:23 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Andy Yan <andy.yan@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>, 
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	"open list:DRM DRIVERS FOR ROCKCHIP" <dri-devel@lists.freedesktop.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH] drm: rockchip: Don't require MIPI DSI device when it's
 used for ISP
Message-ID: <65qkkf7baecbcnemtabzup2nupd63obz4ewrhruk5frl2t3hwv@eqxm3tzgqcv6>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Andy Yan <andy.yan@rock-chips.com>, linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>, 
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	"open list:DRM DRIVERS FOR ROCKCHIP" <dri-devel@lists.freedesktop.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240217183941.1752463-1-megi@xff.cz>
 <4c66c084-5af6-43fb-a256-4746b2e00192@rock-chips.com>
 <bsc3lpdxvhy3ss2uja4do3jwvj43zbs7zhx4bzs2tryrakn7be@pt2qsyvryk73>
 <7044f324-5a45-4a4c-a15e-86614e53acf0@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7044f324-5a45-4a4c-a15e-86614e53acf0@rock-chips.com>

On Mon, Feb 19, 2024 at 11:02:01AM +0800, Andy Yan wrote:
> Hi Ondrej:
> 
> On 2/18/24 23:17, Ondřej Jirman wrote:
> > Hi Andy,
> > 
> > On Sun, Feb 18, 2024 at 07:14:56PM +0800, Andy Yan wrote:
> > > Hi,
> > > 
> > > On 2/18/24 02:39, Ondřej Jirman wrote:
> > > > From: Ondrej Jirman <megi@xff.cz>
> > > > 
> > > > On RK3399 one MIPI DSI device can be alternatively used with the ISP1,
> > > > to provide RX DPHY. When this is the case (ISP1 is enabled in device
> > > > tree), probe success of DRM is tied to probe success of ISP1 connected
> > > > camera sensor. This can fail if the user is able to killswitch the camera
> > > > power, like on Pinephone Pro.
> > > > 
> > > > Detect use of MIPI DSI controller by ISP, and don't include it in
> > > > component match list in that case.
> > > > 
> > > 
> > > Isn't this supposed to be taken care of within the dts?
> > > Since DPHY1 should exclusively used by MIPI DSI1 and ISP1, then if
> > > a device want to use ISP1, the DSI1 should be disabled in dts.
> > 
> > DSI1 can't be disabled, because it provides PHY device for ISP1 in this
> > scenario.
> > 
> > The problem is that in this scenario DRM keeps waiting for DSI1 device,
> > despite it just being used for PHY for ISP1 and not as a component for
> > rockchip DRM driver.
> 
> 
> Oh, get it.
> With a quick look, seems that Heiko has already take this scenario into consideration
> when add PHY function in the dsi drivers[0]
> Does this mean the current drivers does not work as expected?

It didn't work anymore since some fw devlink changes that were added some
time after 2021. But it might have got resolved since than.

So please ignore this patch for now.

kind regards,
	o.

> [0]https://patchwork.freedesktop.org/patch/420386/
> > 
> > See:
> > 
> >          isp1: isp1@ff920000 {
> >                  compatible = "rockchip,rk3399-cif-isp";
> >                  reg = <0x0 0xff920000 0x0 0x4000>;
> >                  interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH 0>;
> >                  clocks = <&cru SCLK_ISP1>,
> >                           <&cru ACLK_ISP1_WRAPPER>,
> >                           <&cru HCLK_ISP1_WRAPPER>;
> >                  clock-names = "isp", "aclk", "hclk";
> >                  iommus = <&isp1_mmu>;
> >                  phys = <&mipi_dsi1>;  <---------
> >                  phy-names = "dphy";
> >                  power-domains = <&power RK3399_PD_ISP1>;
> >                  status = "disabled";
> > 
> > If mipi_dsi1 is disabled, isp1 will never probe.
> > 
> > It's a consequence of this special dual use of mipi_dsi1.
> > 
> > kind regards,
> > 	o.
> > 
> > > > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > > > ---
> > > >    drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 47 +++++++++++++++++++++
> > > >    1 file changed, 47 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> > > > index ab55d7132550..f47de94ad576 100644
> > > > --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> > > > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> > > > @@ -354,6 +354,43 @@ static void rockchip_drm_match_remove(struct device *dev)
> > > >    		device_link_del(link);
> > > >    }
> > > > +/*
> > > > + * Check if ISP block linked to a mipi-dsi device via phys phandle is
> > > > + * enabled in device tree.
> > > > + */
> > > > +static bool rockchip_drm_is_mipi1_and_used_by_isp(struct device *dev)
> > > > +{
> > > > +	struct device_node *np = NULL, *phy_np;
> > > > +
> > > > +	if (!of_device_is_compatible(dev->of_node, "rockchip,rk3399-mipi-dsi"))
> > > > +		return false;
> > > > +
> > > > +	while (true) {
> > > > +		np = of_find_compatible_node(np, NULL, "rockchip,rk3399-cif-isp");
> > > > +		if (!np)
> > > > +			break;
> > > > +
> > > > +		if (!of_device_is_available(np)) {
> > > > +			of_node_put(np);
> > > > +			continue;
> > > > +		}
> > > > +
> > > > +		phy_np = of_parse_phandle(np, "phys", 0);
> > > > +		if (!phy_np) {
> > > > +			of_node_put(np);
> > > > +			continue;
> > > > +		}
> > > > +
> > > > +		of_node_put(phy_np);
> > > > +		of_node_put(np);
> > > > +
> > > > +		if (phy_np == dev->of_node)
> > > > +			return true;
> > > > +	}
> > > > +
> > > > +	return false;
> > > > +}
> > > > +
> > > >    static struct component_match *rockchip_drm_match_add(struct device *dev)
> > > >    {
> > > >    	struct component_match *match = NULL;
> > > > @@ -371,6 +408,16 @@ static struct component_match *rockchip_drm_match_add(struct device *dev)
> > > >    			if (!d)
> > > >    				break;
> > > > +			/*
> > > > +			 * If mipi1 is connected to ISP, we don't want to wait for mipi1 component,
> > > > +			 * because it will not be used by DRM anyway, to not tie success of camera
> > > > +			 * driver probe to display pipeline initialization.
> > > > +			 */
> > > > +			if (rockchip_drm_is_mipi1_and_used_by_isp(d)) {
> > > > +				dev_info(d, "used by ISP1, skipping from DRM\n");
> > > > +				continue;
> > > > +			}
> > > > +
> > > >    			device_link_add(dev, d, DL_FLAG_STATELESS);
> > > >    			component_match_add(dev, &match, component_compare_dev, d);
> > > >    		} while (true);

