Return-Path: <linux-kernel+bounces-19609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C444A826FA4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32291C21FA4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA8044C7D;
	Mon,  8 Jan 2024 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ogsUDni9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5814438A;
	Mon,  8 Jan 2024 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DABA82000D;
	Mon,  8 Jan 2024 13:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704720183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FsViLUTtGI0FGj6ozi2lqrqfTfYZWRiUqJ4UdhRsYyw=;
	b=ogsUDni9AfsiTRalY4li5F+jqN+/N+Tp9JzubNhq8uAJ6MDiHbpaBBgcJUWNVyuneKIIbw
	BxUKQQs6s0hqqEWEL+0UWu9Qpc2uTWzzuRmFuabl1/cvD0nzvCfJtfCuuHgQoRD7Fc999B
	Xa5hUMxrknJatJi0nrtqs8pP+MiLQOtnV8uEIuSrRPEB0D/UvwbA/KzJWxTTi4dp/RmXQ5
	LspxUuU4nDlpqbcfyor79DHviSY4asL2mUfMlKcMVKAuuy83jXrik1UhGr+TBIOQ/MPeLz
	5jIO4p4AADzQ1zuAsCUbOtiUT/D0pK/HUB5/zEz7m9iQeVbNRfr/AccReXLskg==
Date: Mon, 8 Jan 2024 14:23:02 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Saravana Kannan
 <saravanak@google.com>, linux-kernel@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] driver core: Keep the supplier fwnode consistent
 with the device
Message-ID: <20240108142302.7ecd2705@bootlin.com>
In-Reply-To: <2024010436-bulb-direness-5582@gregkh>
References: <20231114074632.192858-1-herve.codina@bootlin.com>
	<2024010436-bulb-direness-5582@gregkh>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Greg,

On Thu, 4 Jan 2024 16:39:49 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Tue, Nov 14, 2023 at 08:46:32AM +0100, Herve Codina wrote:
> > The commit 3a2dbc510c43 ("driver core: fw_devlink: Don't purge child
> > fwnode's consumer links") introduces the possibility to use the
> > supplier's parent device instead of the supplier itself.
> > In that case the supplier fwnode used is not updated and is no more
> > consistent with the supplier device used.
> > 
> > Use the fwnode consistent with the supplier device when checking flags.
> > 
> > Fixes: 3a2dbc510c43 ("driver core: fw_devlink: Don't purge child fwnode's consumer links")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> > Changes v2 -> v3:
> >   Do not update the supplier handle in order to keep the original handle
> >   for debug traces.
> > 
> > Changes v1 -> v2:
> >   Remove sup_handle check and related pr_debug() call as sup_handle cannot be
> >   invalid if sup_dev is valid.
> > 
> >  drivers/base/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 4d8b315c48a1..440b52ec027f 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -2082,7 +2082,7 @@ static int fw_devlink_create_devlink(struct device *con,
> >  		 * supplier device indefinitely.
> >  		 */
> >  		if (sup_dev->links.status == DL_DEV_NO_DRIVER &&
> > -		    sup_handle->flags & FWNODE_FLAG_INITIALIZED) {
> > +		    sup_dev->fwnode->flags & FWNODE_FLAG_INITIALIZED) {
> >  			dev_dbg(con,
> >  				"Not linking %pfwf - dev might never probe\n",
> >  				sup_handle);
> > -- 
> > 2.41.0
> >   
> 
> Is this still needed?  If so, how come no one is noticing it?
> 

I think it is. At least, I don't see anything that make this patch obsolete.

Hervé

