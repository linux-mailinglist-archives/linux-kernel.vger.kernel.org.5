Return-Path: <linux-kernel+bounces-6928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D4B819F70
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354A5286BAE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DC625569;
	Wed, 20 Dec 2023 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="m8RpIy0C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F8D25541;
	Wed, 20 Dec 2023 13:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 224E32B3;
	Wed, 20 Dec 2023 14:01:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1703077300;
	bh=MB0nR/heBhUV7y8E41acYk2PbnEPOOJDseKUnd5jXDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m8RpIy0C4Dt6+20MsgoWNQ5s3PlEfxdt6kKpURHb4JqmUAzLQe/7kNGydVoi9jcR/
	 vch2OgKvR5oA9p/064oXtszZa6/Vc4oltEsDAVgGdENX76ik9v3U2AkCGkEkmdW/PM
	 pM8gxcMQSSYKZxEMBJEdmKgVfmieG6jhD99/Ugmc=
Date: Wed, 20 Dec 2023 15:02:36 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tommaso Merciai <tomm.merciai@gmail.com>
Cc: linuxfancy@googlegroups.com, sakari.ailus@linux.intel.com,
	martin.hecht@avnet.eu, Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] media: i2c: alvium: fix req_fr check into
 alvium_s_frame_interval()
Message-ID: <20231220130236.GN29638@pendragon.ideasonboard.com>
References: <20231220124023.2801417-1-tomm.merciai@gmail.com>
 <20231220124023.2801417-6-tomm.merciai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231220124023.2801417-6-tomm.merciai@gmail.com>

Hi Tommaso,

Thank you for the patch.

On Wed, Dec 20, 2023 at 01:40:23PM +0100, Tommaso Merciai wrote:
> Actually req_fr check into alvium_s_frame_interval() is wrong.
> In particular req_fr can't be >=max and <= min at the same time.
> Fix this using clamp and remove dft_fr parameter from
> alvium_get_frame_interval() not more used.

The commit message should have explained why clamping is better than
picking a default value, as that's a functional change. If you propose
an updated commit message in a reply, I think Sakari can update the
patch when applying the series to his tree, there's no need for a v4.

> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/i2c/alvium-csi2.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> index 240bf991105e..01111a00902d 100644
> --- a/drivers/media/i2c/alvium-csi2.c
> +++ b/drivers/media/i2c/alvium-csi2.c
> @@ -1171,12 +1171,10 @@ static int alvium_set_bayer_pattern(struct alvium_dev *alvium,
>  }
>  
>  static int alvium_get_frame_interval(struct alvium_dev *alvium,
> -				     u64 *dft_fr, u64 *min_fr, u64 *max_fr)
> +				     u64 *min_fr, u64 *max_fr)
>  {
>  	int ret = 0;
>  
> -	alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_RW,
> -		    dft_fr, &ret);
>  	alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_MIN_R,
>  		    min_fr, &ret);
>  	alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_MAX_R,
> @@ -1647,7 +1645,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
>  {
>  	struct alvium_dev *alvium = sd_to_alvium(sd);
>  	struct device *dev = &alvium->i2c_client->dev;
> -	u64 req_fr, dft_fr, min_fr, max_fr;
> +	u64 req_fr, min_fr, max_fr;
>  	struct v4l2_fract *interval;
>  	int ret;
>  
> @@ -1657,7 +1655,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
>  	if (fi->interval.denominator == 0)
>  		return -EINVAL;
>  
> -	ret = alvium_get_frame_interval(alvium, &dft_fr, &min_fr, &max_fr);
> +	ret = alvium_get_frame_interval(alvium, &min_fr, &max_fr);
>  	if (ret) {
>  		dev_err(dev, "Fail to get frame interval\n");
>  		return ret;
> @@ -1670,9 +1668,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
>  
>  	req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
>  		       fi->interval.numerator);
> -
> -	if (req_fr >= max_fr && req_fr <= min_fr)
> -		req_fr = dft_fr;
> +	req_fr = clamp(req_fr, min_fr, max_fr);
>  
>  	interval = v4l2_subdev_state_get_interval(sd_state, 0);
>  

-- 
Regards,

Laurent Pinchart

