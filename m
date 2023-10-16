Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8427CA16C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjJPIRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjJPIRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:17:47 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DFCA1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:17:45 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0EE1457E;
        Mon, 16 Oct 2023 10:17:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1697444257;
        bh=EftfoqGpdDus77//EOZMJorsdbgIE/1k/ECKENXGeo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ove4ASLnI1xkDWh3D0UPJYm3A3yzl8x/HTcVunVopBNNknPPycXiL8Whlwsa6CHWy
         UR2ZzoWnlYhdUpotdsAyru/CJZBMcWgCXFdVtxS175AUp5wYL28IC4A7XEBgbCVpHe
         A4BYyFOGVKOHKRuX/ewRtt4ixIXMShRqyIPmB9JE=
Date:   Mon, 16 Oct 2023 11:17:49 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH] drm: bridge: adv7511: get edid in hpd_work to update CEC
 phys address
Message-ID: <20231016081749.GE23177@pendragon.ideasonboard.com>
References: <20231014-adv7511-cec-edid-v1-1-a58ceae0b57e@bang-olufsen.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231014-adv7511-cec-edid-v1-1-a58ceae0b57e@bang-olufsen.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alvin,

Thank you for the patch.

CC'ing Hans Verkuil, to review the CEC side.

On Sat, Oct 14, 2023 at 09:43:01PM +0200, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> The adv7511 driver is solely responsible for setting the physical
> address of its CEC adapter. To do this, it must read the EDID. However,
> EDID is only read when either the drm_bridge_funcs :: get_edid or
> drm_connector_helper_funcs :: get_modes ops are called. Without loss of
> generality, it cannot be assumed that these ops are called when a sink
> gets attached. Therefore there exist scenarios in which the CEC physical
> address will be invalid (f.f.f.f), rendering the CEC adapter inoperable.
> 
> Address this problem by always fetching the EDID in the HPD work when we
> detect a connection. The CEC physical address is set in the process.
> 
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> ---
> Pardon the insertion of the ugly adv7511_get_edid() prototype, but I did
> not want to clobber git history by rearranging a bunch of functions. If
> this is the preferred approach I will happily re-spin the patch.

There's nothing wrong in rearranging functions, it is actually preferred
to adding forward declarations. You can submit a set of two patches, one
to reorder the functions, and then a second one to fix the problem. This
makes review easier by isolating the refactoring with no functional
change from the functional changes.

> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index 2611afd2c1c1..3d32c109963c 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -424,6 +424,9 @@ static bool adv7511_hpd(struct adv7511 *adv7511)
>  	return false;
>  }
>  
> +static struct edid *adv7511_get_edid(struct adv7511 *adv7511,
> +				     struct drm_connector *connector);
> +
>  static void adv7511_hpd_work(struct work_struct *work)
>  {
>  	struct adv7511 *adv7511 = container_of(work, struct adv7511, hpd_work);
> @@ -457,6 +460,9 @@ static void adv7511_hpd_work(struct work_struct *work)
>  		if (adv7511->connector.dev) {
>  			if (status == connector_status_disconnected)
>  				cec_phys_addr_invalidate(adv7511->cec_adap);
> +			else
> +				adv7511_get_edid(adv7511, &adv7511->connector);
> +
>  			drm_kms_helper_hotplug_event(adv7511->connector.dev);
>  		} else {
>  			drm_bridge_hpd_notify(&adv7511->bridge, status);
> 

-- 
Regards,

Laurent Pinchart
