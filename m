Return-Path: <linux-kernel+bounces-48281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFFB845992
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61C51F21FD2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712055D486;
	Thu,  1 Feb 2024 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="v0U0ZSsX"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95115D49C;
	Thu,  1 Feb 2024 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796234; cv=none; b=KgtIjryibujcyWjE5Tef0a65yK69fiiwjnfLJidds7EZdzVRusbb/eYr9ZuLakr7nybPHGIOyKmHLcD8l5CtjahzwdqPlKskpaGSqX87MbS1MdNkll/ayggWT+eY1eFRwgEbvlVh8SxeppaKj/nRJAO8tACeKuzlsd1/dU+y6ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796234; c=relaxed/simple;
	bh=SPor+BRybJNTG/X/2Jv8gio6ivJbNRgJCw57UzfkgN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lExqRA8nk6ckD8iC0+GNR2b8SeaEPc4zeoLXOXVx0d6c+q3DVZ5TMan/VMuIG3x5lsCJ64IfRr2Yb7UtA92BFvhfT7lEt+fCj+GJFS1Q4qaHLBcVz2e8sQyiWrv3HdjfPqH2RoO2jo5u64w/rflpFQswW0kxqplg8syg4GF8EQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=v0U0ZSsX; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (unknown [94.107.229.70])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5CB38605C;
	Thu,  1 Feb 2024 15:02:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1706796149;
	bh=SPor+BRybJNTG/X/2Jv8gio6ivJbNRgJCw57UzfkgN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v0U0ZSsXzy03U5EWnj+lB+ZBvU3CHUmg3+SLxP2x7fKH5clUj054JzDA6p9i8SZsG
	 PhS7Q8MlbRpfMmNX3zRvxWdfrlXSSTooCnxKh7iWvW1ctzxw90B/vQubO2fwg8qzXV
	 mkst9xWRw+P0RKNKqjguEtE71lOuTQa0e6Dfl2KQ=
Date: Thu, 1 Feb 2024 16:03:48 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Paul Elder <paul.elder@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, kieran.bingham@ideasonboard.com,
	tomi.valkeinen@ideasonboard.com, umang.jain@ideasonboard.com,
	aford173@gmail.com, Dafna Hirschfeld <dafna@fastmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 11/11] media: rkisp1: Fix endianness on raw streams on
 i.MX8MP
Message-ID: <20240201140348.GD5344@pendragon.ideasonboard.com>
References: <20240111114831.656736-1-paul.elder@ideasonboard.com>
 <20240111114831.656736-12-paul.elder@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240111114831.656736-12-paul.elder@ideasonboard.com>

Hi Paul,

Thank you for the patch.

On Thu, Jan 11, 2024 at 08:48:31PM +0900, Paul Elder wrote:
> The i.MX8MP has extra register fields in the memory interface control
> register for setting the output format, which work with the output
> alignment format register for byte-swapping and LSB/MSB alignment.
> 
> With processed and 8-bit raw streams, it doesn't cause any problems to
> not set these, but with raw streams of higher bit depth the endianness
> is swapped and the data is not aligned properly.
> 
> Add support for setting these registers and plumb them in to fix this.
> 
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> ---
> New in v6
> ---
>  .../platform/rockchip/rkisp1/rkisp1-capture.c | 95 ++++++++++++++-----
>  .../platform/rockchip/rkisp1/rkisp1-common.h  |  2 +
>  .../platform/rockchip/rkisp1/rkisp1-dev.c     |  3 +-
>  .../platform/rockchip/rkisp1/rkisp1-regs.h    |  8 ++
>  4 files changed, 83 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> index 813d4274f118..8067b5c003a6 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> @@ -48,16 +48,20 @@ enum rkisp1_plane {
>   * @fmt_type: helper filed for pixel format
>   * @uv_swap: if cb cr swapped, for yuv
>   * @yc_swap: if y and cb/cr swapped, for yuv
> + * @byte_swap: if byte pairs are swapped, for raw
>   * @write_format: defines how YCbCr self picture data is written to memory
> - * @output_format: defines sp output format
> + * @output_format_mp: defines mp output format
> + * @output_format_sp: defines sp output format
>   * @mbus: the mbus code on the src resizer pad that matches the pixel format
>   */
>  struct rkisp1_capture_fmt_cfg {
>  	u32 fourcc;
>  	u32 uv_swap : 1;
>  	u32 yc_swap : 1;
> +	u32 byte_swap : 1;
>  	u32 write_format;
> -	u32 output_format;
> +	u32 output_format_mp;
> +	u32 output_format_sp;
>  	u32 mbus;
>  };
>  
> @@ -96,42 +100,50 @@ static const struct rkisp1_capture_fmt_cfg rkisp1_mp_fmts[] = {
>  		.fourcc = V4L2_PIX_FMT_YUYV,
>  		.uv_swap = 0,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUVINT,
> +		.output_format_mp = RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV422,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_UYVY,
>  		.uv_swap = 0,
>  		.yc_swap = 1,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUVINT,
> +		.output_format_mp = RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV422,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_YUV422P,
>  		.uv_swap = 0,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8,
> +		.output_format_mp = RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV422,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_NV16,
>  		.uv_swap = 0,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUV_SPLA,
> +		.output_format_mp = RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV422,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_NV61,
>  		.uv_swap = 1,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUV_SPLA,
> +		.output_format_mp = RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV422,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_NV16M,
>  		.uv_swap = 0,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUV_SPLA,
> +		.output_format_mp = RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV422,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_NV61M,
>  		.uv_swap = 1,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUV_SPLA,
> +		.output_format_mp = RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV422,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_YVU422M,
>  		.uv_swap = 1,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8,
> +		.output_format_mp = RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV422,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
>  	},
>  	/* yuv400 */
> @@ -139,6 +151,7 @@ static const struct rkisp1_capture_fmt_cfg rkisp1_mp_fmts[] = {
>  		.fourcc = V4L2_PIX_FMT_GREY,
>  		.uv_swap = 0,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8,
> +		.output_format_mp = RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV400,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
>  	},
>  	/* yuv420 */
> @@ -146,81 +159,107 @@ static const struct rkisp1_capture_fmt_cfg rkisp1_mp_fmts[] = {
>  		.fourcc = V4L2_PIX_FMT_NV21,
>  		.uv_swap = 1,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUV_SPLA,
> +		.output_format_mp = RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV420,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_1_5X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_NV12,
>  		.uv_swap = 0,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUV_SPLA,
> +		.output_format_mp = RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV420,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_1_5X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_NV21M,
>  		.uv_swap = 1,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUV_SPLA,
> +		.output_format_mp = RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV420,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_1_5X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_NV12M,
>  		.uv_swap = 0,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUV_SPLA,
> +		.output_format_mp = RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV420,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_1_5X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_YUV420,
>  		.uv_swap = 0,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8,
> +		.output_format_mp = RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV420,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_1_5X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_YVU420,
>  		.uv_swap = 1,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8,
> +		.output_format_mp = RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV420,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_1_5X8,
>  	},
>  	/* raw */
>  	{
>  		.fourcc = V4L2_PIX_FMT_SRGGB8,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8,
> +		.output_format_mp = RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW8,
>  		.mbus = MEDIA_BUS_FMT_SRGGB8_1X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_SGRBG8,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8,
> +		.output_format_mp = RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW8,
>  		.mbus = MEDIA_BUS_FMT_SGRBG8_1X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_SGBRG8,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8,
> +		.output_format_mp = RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW8,
>  		.mbus = MEDIA_BUS_FMT_SGBRG8_1X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_SBGGR8,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8,
> +		.output_format_mp = RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW8,
>  		.mbus = MEDIA_BUS_FMT_SBGGR8_1X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_SRGGB10,
> +		.byte_swap = 1,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_RAW12,
> +		.output_format_mp = RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW10,
>  		.mbus = MEDIA_BUS_FMT_SRGGB10_1X10,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_SGRBG10,
> +		.byte_swap = 1,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_RAW12,
> +		.output_format_mp = RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW10,
>  		.mbus = MEDIA_BUS_FMT_SGRBG10_1X10,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_SGBRG10,
> +		.byte_swap = 1,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_RAW12,
> +		.output_format_mp = RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW10,
>  		.mbus = MEDIA_BUS_FMT_SGBRG10_1X10,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_SBGGR10,
> +		.byte_swap = 1,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_RAW12,
> +		.output_format_mp = RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW10,
>  		.mbus = MEDIA_BUS_FMT_SBGGR10_1X10,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_SRGGB12,
> +		.byte_swap = 1,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_RAW12,
> +		.output_format_mp = RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW12,
>  		.mbus = MEDIA_BUS_FMT_SRGGB12_1X12,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_SGRBG12,
> +		.byte_swap = 1,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_RAW12,
> +		.output_format_mp = RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW12,
>  		.mbus = MEDIA_BUS_FMT_SGRBG12_1X12,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_SGBRG12,
> +		.byte_swap = 1,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_RAW12,
> +		.output_format_mp = RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW12,
>  		.mbus = MEDIA_BUS_FMT_SGBRG12_1X12,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_SBGGR12,
> +		.byte_swap = 1,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_RAW12,
> +		.output_format_mp = RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW12,
>  		.mbus = MEDIA_BUS_FMT_SBGGR12_1X12,
>  	},
>  };
> @@ -235,50 +274,50 @@ static const struct rkisp1_capture_fmt_cfg rkisp1_sp_fmts[] = {
>  		.fourcc = V4L2_PIX_FMT_YUYV,
>  		.uv_swap = 0,
>  		.write_format = RKISP1_MI_CTRL_SP_WRITE_INT,
> -		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
> +		.output_format_sp = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_UYVY,
>  		.uv_swap = 0,
>  		.yc_swap = 1,
>  		.write_format = RKISP1_MI_CTRL_SP_WRITE_INT,
> -		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
> +		.output_format_sp = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_YUV422P,
>  		.uv_swap = 0,
>  		.write_format = RKISP1_MI_CTRL_SP_WRITE_PLA,
> -		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
> +		.output_format_sp = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_NV16,
>  		.uv_swap = 0,
>  		.write_format = RKISP1_MI_CTRL_SP_WRITE_SPLA,
> -		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
> +		.output_format_sp = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_NV61,
>  		.uv_swap = 1,
>  		.write_format = RKISP1_MI_CTRL_SP_WRITE_SPLA,
> -		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
> +		.output_format_sp = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_NV16M,
>  		.uv_swap = 0,
>  		.write_format = RKISP1_MI_CTRL_SP_WRITE_SPLA,
> -		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
> +		.output_format_sp = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_NV61M,
>  		.uv_swap = 1,
>  		.write_format = RKISP1_MI_CTRL_SP_WRITE_SPLA,
> -		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
> +		.output_format_sp = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_YVU422M,
>  		.uv_swap = 1,
>  		.write_format = RKISP1_MI_CTRL_SP_WRITE_PLA,
> -		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
> +		.output_format_sp = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
>  	},
>  	/* yuv400 */
> @@ -286,19 +325,19 @@ static const struct rkisp1_capture_fmt_cfg rkisp1_sp_fmts[] = {
>  		.fourcc = V4L2_PIX_FMT_GREY,
>  		.uv_swap = 0,
>  		.write_format = RKISP1_MI_CTRL_SP_WRITE_PLA,
> -		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
> +		.output_format_sp = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
>  	},
>  	/* rgb */
>  	{
>  		.fourcc = V4L2_PIX_FMT_XBGR32,
>  		.write_format = RKISP1_MI_CTRL_SP_WRITE_PLA,
> -		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_RGB888,
> +		.output_format_sp = RKISP1_MI_CTRL_SP_OUTPUT_RGB888,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_RGB565,
>  		.write_format = RKISP1_MI_CTRL_SP_WRITE_PLA,
> -		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_RGB565,
> +		.output_format_sp = RKISP1_MI_CTRL_SP_OUTPUT_RGB565,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
>  	},
>  	/* yuv420 */
> @@ -306,37 +345,37 @@ static const struct rkisp1_capture_fmt_cfg rkisp1_sp_fmts[] = {
>  		.fourcc = V4L2_PIX_FMT_NV21,
>  		.uv_swap = 1,
>  		.write_format = RKISP1_MI_CTRL_SP_WRITE_SPLA,
> -		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV420,
> +		.output_format_sp = RKISP1_MI_CTRL_SP_OUTPUT_YUV420,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_1_5X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_NV12,
>  		.uv_swap = 0,
>  		.write_format = RKISP1_MI_CTRL_SP_WRITE_SPLA,
> -		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV420,
> +		.output_format_sp = RKISP1_MI_CTRL_SP_OUTPUT_YUV420,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_1_5X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_NV21M,
>  		.uv_swap = 1,
>  		.write_format = RKISP1_MI_CTRL_SP_WRITE_SPLA,
> -		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV420,
> +		.output_format_sp = RKISP1_MI_CTRL_SP_OUTPUT_YUV420,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_1_5X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_NV12M,
>  		.uv_swap = 0,
>  		.write_format = RKISP1_MI_CTRL_SP_WRITE_SPLA,
> -		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV420,
> +		.output_format_sp = RKISP1_MI_CTRL_SP_OUTPUT_YUV420,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_1_5X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_YUV420,
>  		.uv_swap = 0,
>  		.write_format = RKISP1_MI_CTRL_SP_WRITE_PLA,
> -		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV420,
> +		.output_format_sp = RKISP1_MI_CTRL_SP_OUTPUT_YUV420,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_1_5X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_YVU420,
>  		.uv_swap = 1,
>  		.write_format = RKISP1_MI_CTRL_SP_WRITE_PLA,
> -		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV420,
> +		.output_format_sp = RKISP1_MI_CTRL_SP_OUTPUT_YUV420,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_1_5X8,
>  	},
>  };
> @@ -482,12 +521,14 @@ static void rkisp1_mp_config(struct rkisp1_capture *cap)
>  	 * NV12/NV21 and NV16/NV61, so instead use byte swap to support UYVY.
>  	 * YVYU and VYUY cannot be supported with this method.
>  	 */
> -	if (rkisp1->info->features & RKISP1_FEATURE_MI_OUTPUT_ALIGN) {
> +	if (rkisp1_has_feature(rkisp1, MI_OUTPUT_ALIGN)) {
>  		reg = rkisp1_read(rkisp1, RKISP1_CIF_MI_OUTPUT_ALIGN_FORMAT);
> -		if (cap->pix.cfg->yc_swap)
> +		if (cap->pix.cfg->yc_swap || cap->pix.cfg->byte_swap)
>  			reg |= RKISP1_CIF_OUTPUT_ALIGN_FORMAT_MP_BYTE_SWAP_BYTES;
>  		else
>  			reg &= ~RKISP1_CIF_OUTPUT_ALIGN_FORMAT_MP_BYTE_SWAP_BYTES;
> +
> +		reg |= RKISP1_CIF_OUTPUT_ALIGN_FORMAT_MP_LSB_ALIGNMENT;
>  		rkisp1_write(rkisp1, RKISP1_CIF_MI_OUTPUT_ALIGN_FORMAT, reg);
>  	}
>  
> @@ -554,7 +595,7 @@ static void rkisp1_sp_config(struct rkisp1_capture *cap)
>  	mi_ctrl &= ~RKISP1_MI_CTRL_SP_FMT_MASK;
>  	mi_ctrl |= cap->pix.cfg->write_format |
>  		   RKISP1_MI_CTRL_SP_INPUT_YUV422 |
> -		   cap->pix.cfg->output_format |
> +		   cap->pix.cfg->output_format_sp |
>  		   RKISP1_CIF_MI_SP_AUTOUPDATE_ENABLE;
>  	rkisp1_write(rkisp1, RKISP1_CIF_MI_CTRL, mi_ctrl);
>  }
> @@ -946,6 +987,7 @@ static void rkisp1_cap_stream_enable(struct rkisp1_capture *cap)
>  	struct rkisp1_device *rkisp1 = cap->rkisp1;
>  	struct rkisp1_capture *other = &rkisp1->capture_devs[cap->id ^ 1];
>  	bool has_self_path = rkisp1_has_feature(rkisp1, SELF_PATH);
> +	u32 reg;
>  
>  	cap->ops->set_data_path(cap);
>  	cap->ops->config(cap);
> @@ -965,8 +1007,13 @@ static void rkisp1_cap_stream_enable(struct rkisp1_capture *cap)
>  	 */
>  	if (!has_self_path || !other->is_streaming) {
>  		/* force cfg update */
> -		rkisp1_write(rkisp1, RKISP1_CIF_MI_INIT,
> -			     RKISP1_CIF_MI_INIT_SOFT_UPD);
> +		reg = rkisp1_read(rkisp1, RKISP1_CIF_MI_INIT);
> +
> +		if (rkisp1_has_feature(rkisp1, MP_OUTPUT_FORMAT))
> +			reg |= cap->pix.cfg->output_format_mp;
> +
> +		reg |= RKISP1_CIF_MI_INIT_SOFT_UPD;
> +		rkisp1_write(rkisp1, RKISP1_CIF_MI_INIT, reg);
>  		rkisp1_set_next_buf(cap);
>  	}
>  	spin_unlock_irq(&cap->buf.lock);
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> index 8e2a63ab2cdd..7167257ecde2 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> @@ -116,6 +116,7 @@ enum rkisp1_isp_pad {
>   * @RKISP1_FEATURE_DUAL_CROP: The ISP has the dual crop block at the resizer input
>   * @RKISP1_FEATURE_DMA_34BIT: The ISP uses 34-bit DMA addresses
>   * @RKISP1_FEATURE_MI_OUTPUT_ALIGN: The ISP has the MI_OUTPUT_ALIGN_FORMAT register
> + * @RKISP1_FEATURE_MP_OUTPUT_FORMAT: The ISP has mp_output_format field in the MI_INIT register

Do you foresee ISP versions that will support one and only one of the
two features ? If not I would prefer merging them in a single feature.
They could also be merged with the RKISP1_FEATURE_MAIN_STRIDE feature if
desired I think. A ISP8000 feature flag is tempted, but we don't know if
that's accurate :-S

>   *
>   * The ISP features are stored in a bitmask in &rkisp1_info.features and allow
>   * the driver to implement support for features present in some ISP versions
> @@ -128,6 +129,7 @@ enum rkisp1_feature {
>  	RKISP1_FEATURE_DUAL_CROP = BIT(3),
>  	RKISP1_FEATURE_DMA_34BIT = BIT(4),
>  	RKISP1_FEATURE_MI_OUTPUT_ALIGN = BIT(5),
> +	RKISP1_FEATURE_MP_OUTPUT_FORMAT = BIT(6),
>  };
>  
>  #define rkisp1_has_feature(rkisp1, feature) \
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> index 307bfe9030f2..43fc2c728cea 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> @@ -551,7 +551,8 @@ static const struct rkisp1_info imx8mp_isp_info = {
>  	.isp_ver = IMX8MP_V10,
>  	.features = RKISP1_FEATURE_MAIN_STRIDE
>  		  | RKISP1_FEATURE_DMA_34BIT
> -		  | RKISP1_FEATURE_MI_OUTPUT_ALIGN,
> +		  | RKISP1_FEATURE_MI_OUTPUT_ALIGN
> +		  | RKISP1_FEATURE_MP_OUTPUT_FORMAT,
>  };
>  
>  static const struct of_device_id rkisp1_of_match[] = {
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
> index 3b19c8411360..762243016f05 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
> @@ -144,6 +144,14 @@
>  /* MI_INIT */
>  #define RKISP1_CIF_MI_INIT_SKIP				BIT(2)
>  #define RKISP1_CIF_MI_INIT_SOFT_UPD			BIT(4)
> +#define RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV400		(0 << 5)
> +#define RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV420		(1 << 5)
> +#define RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV422		(2 << 5)
> +#define RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV444		(3 << 5)
> +#define RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW12		(4 << 5)
> +#define RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW8		(5 << 5)
> +#define RKISP1_CIF_MI_INIT_MP_OUTPUT_JPEG		(6 << 5)
> +#define RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW10		(7 << 5)
>  
>  /* MI_CTRL_SHD */
>  #define RKISP1_CIF_MI_CTRL_SHD_MP_IN_ENABLED		BIT(0)

-- 
Regards,

Laurent Pinchart

