Return-Path: <linux-kernel+bounces-749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 149CC814580
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C211C2306A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDA11A705;
	Fri, 15 Dec 2023 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qy+klrRS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09E6199D7;
	Fri, 15 Dec 2023 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B98259A8;
	Fri, 15 Dec 2023 11:23:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1702635823;
	bh=wlGP+LQUU4uXxRIbuQWhogr+FvSQEySgnF5tFYQLuXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qy+klrRSPCyZ3M3ErwsGy3PRbzPKFDzA3twhfUZ2EB4FEHqHqI5rBaxdW3u/WTZ5G
	 45bzSNd+Lg2EW/kCEHP+6mb1/8JDdn+w+2c5N7xgVR5NjUe1Iw03bx7/0vV0EbBsxI
	 /5t0KkKV1QuSIURXnfliwNPjvEoTaTnwOIg0vjD4=
Date: Fri, 15 Dec 2023 12:24:38 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Marvin Lin <milkfafa@gmail.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Ming Qian <ming.qian@nxp.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
	Mingjia Zhang <mingjia.zhang@mediatek.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jack Zhu <jack.zhu@starfivetech.com>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v1 1/9] media: v4l2-ctrls: Add user controls for StarFive
 JH7110 ISP
Message-ID: <20231215102438.GH21146@pendragon.ideasonboard.com>
References: <20231214065027.28564-1-changhuang.liang@starfivetech.com>
 <20231214065027.28564-2-changhuang.liang@starfivetech.com>
 <20231214113955.GK12450@pendragon.ideasonboard.com>
 <e6059181-a1bb-438b-8490-108c64316171@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6059181-a1bb-438b-8490-108c64316171@starfivetech.com>

Hi Changhuang,

On Fri, Dec 15, 2023 at 01:55:09PM +0800, Changhuang Liang wrote:
> On 2023/12/14 19:39, Laurent Pinchart wrote:
> > On Wed, Dec 13, 2023 at 10:50:19PM -0800, Changhuang Liang wrote:
> >> Add a control base for StarFive JH7110 ISP driver controls, and reserve
> >> 32 controls，also add some controls for StarFive JH7110 ISP.
> > 
> > ISP parameters should be passed through parameters buffers, not V4L2
> > control. See for instance the V4L2_META_FMT_RK_ISP1_PARAMS format in the
> > mainline kernel, it describes how to store ISP parameters in a buffer.
> > The rkisp1 driver is an example of how this can be implemented.
> 
> That means I need to add a video output device before ISP subdev? And 
> use queue/dequeue buffer to get the ISP paremeters?

Yes, that is correct.

> > Please note that the ISP parameters need to be documented precisely,
> > regardless of how they're passed by userspace to the kernel. Even with
> > V4L2 controls, documentation would be needed. Please see below for
> > additional comments.
> 
> I will add annotations for this file next version.
> 
> >> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> >> ---
> >>  MAINTAINERS                        |   1 +
> >>  include/uapi/linux/jh7110-isp.h    | 342 +++++++++++++++++++++++++++++
> >>  include/uapi/linux/v4l2-controls.h |   6 +
> [...]

-- 
Regards,

Laurent Pinchart

