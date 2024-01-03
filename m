Return-Path: <linux-kernel+bounces-16005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 989308236E9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA852878A4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ECB1D691;
	Wed,  3 Jan 2024 21:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="FI8w5b/m"
X-Original-To: linux-kernel@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1491D697;
	Wed,  3 Jan 2024 21:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6D7A6D52;
	Wed,  3 Jan 2024 22:06:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1704315985;
	bh=SodjiVnFsVemtH8EJ+pL/zZCwg/O4PbVNowZr4W9viQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FI8w5b/mATBLfPR6CmjGREnHYyvrik9RzhcjoVrVWHft4V6isL2zNSRjoSqpGLCaQ
	 +1Dg1Bd6xQvdh/21nnAdGq/5wXYrZjk17hdq8OXV+EuaGBnXuEdaz9MDswnOdTlWIa
	 zv7qG9fE2qpviu38eOB+RfcIE6MC6pJDN3yHnRZo=
Date: Wed, 3 Jan 2024 23:07:34 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Hans de Goede <hdegoede@redhat.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Mehdi Djait <mehdi.djait@bootlin.com>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: i2c: thp7312: select CONFIG_FW_LOADER
Message-ID: <20240103210734.GC17142@pendragon.ideasonboard.com>
References: <20240103155811.4092035-1-arnd@kernel.org>
 <20240103174820.GA17142@pendragon.ideasonboard.com>
 <775efa9b-0917-4e89-abc5-470c9f4506db@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <775efa9b-0917-4e89-abc5-470c9f4506db@infradead.org>

On Wed, Jan 03, 2024 at 12:06:33PM -0800, Randy Dunlap wrote:
> On 1/3/24 09:48, Laurent Pinchart wrote:
> > On Wed, Jan 03, 2024 at 04:58:05PM +0100, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> The recently added driver uses the firmware loader mechanism but causes
> >> a link failure when that is in a loadable module while thp7312 itself
> >> is built-in:
> >>
> >> arm-linux-gnueabi-ld: drivers/media/i2c/thp7312.o: in function `thp7312_probe':
> >> thp7312.c:(.text+0x4164): undefined reference to `firmware_upload_register'
> >>
> >> Select the required Kconfig symbol. Note that the driver specifically
> >> needs the firmware upload interface that is controlled by CONFIG_FW_UPLOAD,
> >> but there is no link failure when that is disabled because the interfaces
> >> are stubbed out here.
> >>
> >> Fixes: 7a52ab415b43 ("media: i2c: Add driver for THine THP7312")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > I've posted a similar fix yesterday, see
> > https://lore.kernel.org/linux-media/20240102074518.24968-1-laurent.pinchart@ideasonboard.com
> > 
> > What approach do you think is best ?
> 
> By far the dominant use of FW_LOADER is to select it instead of depend on it,
> so I prefer Arnd's patch.

The alternative could save space, but I expect that to be an uncommon
use case, as FW_LOADER will likely be selected for other reasons anyway. 

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> >> ---
> >>  drivers/media/i2c/Kconfig | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
> >> index 78a87331686e..4c3435921f19 100644
> >> --- a/drivers/media/i2c/Kconfig
> >> +++ b/drivers/media/i2c/Kconfig
> >> @@ -674,6 +674,7 @@ menu "Camera ISPs"
> >>  config VIDEO_THP7312
> >>  	tristate "THine THP7312 support"
> >>  	depends on I2C
> >> +	select FW_LOADER
> >>  	select MEDIA_CONTROLLER
> >>  	select V4L2_CCI_I2C
> >>  	select V4L2_FWNODE

-- 
Regards,

Laurent Pinchart

