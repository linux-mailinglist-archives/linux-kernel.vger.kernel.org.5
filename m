Return-Path: <linux-kernel+bounces-3982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A89F6817650
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480DE1F26AAE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3634236F;
	Mon, 18 Dec 2023 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="E+eaknYD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D313D545;
	Mon, 18 Dec 2023 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 24B6757E;
	Mon, 18 Dec 2023 16:47:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1702914462;
	bh=2sOFBL109jjVIul3F+6t0mZTRAhvxnQtgcLNIu0TqOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E+eaknYD0yp0U7kSb+ri0GDGITk+JMNKvwxxoCzsQAkn7n4k+JrNDZD/+k7PVajqC
	 k5db1V+5k6xL1Ipe5FjVJiLg5ATaQKbOsLwI6FXl9lsn8/DZE0oWP1SnPS0Uy+Wa31
	 hVVGSh2gpgbr7y2Bk+YrSYDri/Wb60eNOrXKZplk=
Date: Mon, 18 Dec 2023 17:48:38 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Paul Elder <paul.elder@ideasonboard.com>, linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	kieran.bingham@ideasonboard.com, umang.jain@ideasonboard.com,
	aford173@gmail.com, Dafna Hirschfeld <dafna@fastmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/11] media: rkisp1: Fix RSZ_CTRL bits for i.MX8MP
Message-ID: <20231218154838.GR5290@pendragon.ideasonboard.com>
References: <20231129092759.242641-1-paul.elder@ideasonboard.com>
 <20231129092759.242641-6-paul.elder@ideasonboard.com>
 <03b98b67-e88c-4bb0-a01d-5a90f78e04a3@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <03b98b67-e88c-4bb0-a01d-5a90f78e04a3@ideasonboard.com>

On Mon, Dec 18, 2023 at 05:31:18PM +0200, Tomi Valkeinen wrote:
> Hi Paul,
> 
> On 29/11/2023 11:27, Paul Elder wrote:
> > The ISP8000Nano, found in the i.MX8MP, has a different architecture to
> > crop at the resizer input. Instead of the "dual crop" block between the
> > ISP and the resizers found in the RK3399, cropping has been moved to the
> > input of the resizer blocks. As a result, the resizer CFG_UPD and
> > CFG_UPD_AUTO bits have been moved to make space for a new CROP_ENABLE
> > bit.
> > 
> > Fix the resizer shadow update accordingly, using the DUAL_CROP feature
> > to infer whether or not the resizer implements cropping. Support for
> > resizer cropping itself will be added in a subsequent commit.
> > 
> > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> I don't think this one is correct.
> 
> The above is perhaps true for ISP8000, but ISP8000Nano does not have 
> CROP_ENABLE bit, and the CFG_UPD and CFG_UPD_AUTO are at the same 
> locations as on RK3399.
> 
> I don't have documentation to prove this, but experimentation shows that 
> this is the case.

I agree with you. The missing CROP_ENABLE bit matches the missing
resizer input crop capability in the i.MX8MP. I don't know if that's
specific to the i.MX8MP, specific to the ISP8000Nano, or common to all
ISP8000 versions when the instance is synthesized with a single path
(which may be what ISP8000Nano is).

> > ---
> > Changes since v3:
> > 
> > - Condition on RKISP1_FEATURE_DUAL_CROP feature
> > - Update commit message
> > 
> > Changes since v2:
> > 
> > - Condition on RKISP1_FEATURE_RSZ_CROP feature
> > - Rename bits
> > - Use the rkisp1_has_feature() macro
> > 
> >   .../media/platform/rockchip/rkisp1/rkisp1-regs.h  |  5 +++++
> >   .../platform/rockchip/rkisp1/rkisp1-resizer.c     | 15 +++++++++++----
> >   2 files changed, 16 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
> > index 3b19c8411360..95646b45f28b 100644
> > --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
> > +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
> > @@ -168,6 +168,11 @@
> >   #define RKISP1_CIF_RSZ_CTRL_CFG_UPD_AUTO		BIT(9)
> >   #define RKISP1_CIF_RSZ_SCALER_FACTOR			BIT(16)
> >   
> > +/* For resizer instances that support cropping */
> > +#define RKISP1_CIF_RSZ_CTRL_CROP_ENABLE			BIT(8)
> > +#define RKISP1_CIF_RSZ_CTRL_CROP_CFG_UPD		BIT(9)
> > +#define RKISP1_CIF_RSZ_CTRL_CROP_CFG_UPD_AUTO		BIT(10)
> > +
> >   /* MI_IMSC - MI_MIS - MI_RIS - MI_ICR - MI_ISR */
> >   #define RKISP1_CIF_MI_FRAME(stream)			BIT((stream)->id)
> >   #define RKISP1_CIF_MI_MBLK_LINE				BIT(2)
> > diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
> > index c1aaeed58acc..6d6ebc53c6e5 100644
> > --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
> > +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
> > @@ -178,10 +178,17 @@ static void rkisp1_rsz_update_shadow(struct rkisp1_resizer *rsz,
> >   {
> >   	u32 ctrl_cfg = rkisp1_rsz_read(rsz, RKISP1_CIF_RSZ_CTRL);
> >   
> > -	if (when == RKISP1_SHADOW_REGS_ASYNC)
> > -		ctrl_cfg |= RKISP1_CIF_RSZ_CTRL_CFG_UPD_AUTO;
> > -	else
> > -		ctrl_cfg |= RKISP1_CIF_RSZ_CTRL_CFG_UPD;
> > +	if (when == RKISP1_SHADOW_REGS_ASYNC) {
> > +		if (rkisp1_has_feature(rsz->rkisp1, DUAL_CROP))
> > +			ctrl_cfg |= RKISP1_CIF_RSZ_CTRL_CFG_UPD_AUTO;
> > +		else
> > +			ctrl_cfg |= RKISP1_CIF_RSZ_CTRL_CROP_CFG_UPD_AUTO;
> > +	} else {
> > +		if (rkisp1_has_feature(rsz->rkisp1, DUAL_CROP))
> > +			ctrl_cfg |= RKISP1_CIF_RSZ_CTRL_CFG_UPD;
> > +		else
> > +			ctrl_cfg |= RKISP1_CIF_RSZ_CTRL_CROP_CFG_UPD;
> > +	}
> >   
> >   	rkisp1_rsz_write(rsz, RKISP1_CIF_RSZ_CTRL, ctrl_cfg);
> >   }

-- 
Regards,

Laurent Pinchart

