Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EDC7D34E2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbjJWLna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbjJWLnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:43:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7138C170A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698061391; x=1729597391;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=naMve0NtYrZVuHqK6fpiTmU0a5b61Mp5wefHU8KFuO8=;
  b=h9M+HpXidqOeERVAWwUnNKZ8p75e31zd1BTIV5Db9gQ3zj+7u6K0DP56
   D470V/xqA8HBwc6RK0SG3kjyDXkaCpy30+D+TWqBf37B2HegYMer5xXHC
   0+iiGHYb3Nd5NSQNpaN5mcQRsKrYx4VA+uQkE+XDomj6RAWR/eEeNo3kM
   n1dNtSAxndAzUY8zJtI1BD/+xwvrZYHNkuk5kRXx+j53vntSzIzKHMfxi
   W9hQA6ZpO0+2m37CdPmOmBeM+2SD6XWEi/tLZb+DhxWlbZU6E6fvW7C53
   leMsf9A1fLuZi2KzvYTNEEpGh9M4yblnBG1H2KIh7R5eT1auapcwbqQm/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="390708448"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="390708448"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 04:43:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="1089468449"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="1089468449"
Received: from evlad-mobl.ger.corp.intel.com (HELO localhost) ([10.252.47.180])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 04:42:59 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Subject: Re: [PATCH] drm: bridge: adv7511: get edid in hpd_work to update
 CEC phys address
In-Reply-To: <20231014-adv7511-cec-edid-v1-1-a58ceae0b57e@bang-olufsen.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231014-adv7511-cec-edid-v1-1-a58ceae0b57e@bang-olufsen.dk>
Date:   Mon, 23 Oct 2023 14:42:56 +0300
Message-ID: <87pm15bm4f.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Oct 2023, Alvin =C5=A0ipraga <alvin@pqrs.dk> wrote:
> From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
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
> Signed-off-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> ---
> Pardon the insertion of the ugly adv7511_get_edid() prototype, but I did
> not want to clobber git history by rearranging a bunch of functions. If
> this is the preferred approach I will happily re-spin the patch.
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/d=
rm/bridge/adv7511/adv7511_drv.c
> index 2611afd2c1c1..3d32c109963c 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -424,6 +424,9 @@ static bool adv7511_hpd(struct adv7511 *adv7511)
>  	return false;
>  }
>=20=20
> +static struct edid *adv7511_get_edid(struct adv7511 *adv7511,
> +				     struct drm_connector *connector);
> +
>  static void adv7511_hpd_work(struct work_struct *work)
>  {
>  	struct adv7511 *adv7511 =3D container_of(work, struct adv7511, hpd_work=
);
> @@ -457,6 +460,9 @@ static void adv7511_hpd_work(struct work_struct *work)
>  		if (adv7511->connector.dev) {
>  			if (status =3D=3D connector_status_disconnected)
>  				cec_phys_addr_invalidate(adv7511->cec_adap);
> +			else
> +				adv7511_get_edid(adv7511, &adv7511->connector);

This leaks the returned EDID.

BR,
Jani.

> +
>  			drm_kms_helper_hotplug_event(adv7511->connector.dev);
>  		} else {
>  			drm_bridge_hpd_notify(&adv7511->bridge, status);
>
> ---
> base-commit: 4366faf43308bd91c59a20c43a9f853a9c3bb6e4
> change-id: 20231014-adv7511-cec-edid-ff75bd3ac929
>

--=20
Jani Nikula, Intel
