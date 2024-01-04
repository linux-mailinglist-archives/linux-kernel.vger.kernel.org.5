Return-Path: <linux-kernel+bounces-16866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C35824527
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9303F283825
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0CE24A10;
	Thu,  4 Jan 2024 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UQsQYXLp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995C0249FE;
	Thu,  4 Jan 2024 15:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B25C433C8;
	Thu,  4 Jan 2024 15:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704382792;
	bh=OXcH/CGMv+jOMglY0LpslAtDGAHu9ahBpG1qwfguGOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UQsQYXLpOaYLJDF6Yy76da6yqsD3KRs5IU5j5a74G0TH5B1c8RGhT/NGlzep2hFFU
	 qNmH+Lkv0WfVflUnHk6Nc58cK0zOz1ugcMJD504r4cX/SOUl5CIHtm81FhBoCx9dpC
	 7sHoTd+poqnBBOK7vlHQMg/0Ug7NhjJbnH+ELNPo=
Date: Thu, 4 Jan 2024 16:39:49 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-kernel@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] driver core: Keep the supplier fwnode consistent
 with the device
Message-ID: <2024010436-bulb-direness-5582@gregkh>
References: <20231114074632.192858-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114074632.192858-1-herve.codina@bootlin.com>

On Tue, Nov 14, 2023 at 08:46:32AM +0100, Herve Codina wrote:
> The commit 3a2dbc510c43 ("driver core: fw_devlink: Don't purge child
> fwnode's consumer links") introduces the possibility to use the
> supplier's parent device instead of the supplier itself.
> In that case the supplier fwnode used is not updated and is no more
> consistent with the supplier device used.
> 
> Use the fwnode consistent with the supplier device when checking flags.
> 
> Fixes: 3a2dbc510c43 ("driver core: fw_devlink: Don't purge child fwnode's consumer links")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
> Changes v2 -> v3:
>   Do not update the supplier handle in order to keep the original handle
>   for debug traces.
> 
> Changes v1 -> v2:
>   Remove sup_handle check and related pr_debug() call as sup_handle cannot be
>   invalid if sup_dev is valid.
> 
>  drivers/base/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 4d8b315c48a1..440b52ec027f 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2082,7 +2082,7 @@ static int fw_devlink_create_devlink(struct device *con,
>  		 * supplier device indefinitely.
>  		 */
>  		if (sup_dev->links.status == DL_DEV_NO_DRIVER &&
> -		    sup_handle->flags & FWNODE_FLAG_INITIALIZED) {
> +		    sup_dev->fwnode->flags & FWNODE_FLAG_INITIALIZED) {
>  			dev_dbg(con,
>  				"Not linking %pfwf - dev might never probe\n",
>  				sup_handle);
> -- 
> 2.41.0
> 

Is this still needed?  If so, how come no one is noticing it?

thanks,

greg k-h

