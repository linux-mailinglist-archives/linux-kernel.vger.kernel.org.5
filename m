Return-Path: <linux-kernel+bounces-66866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716AB8562CD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49191C21706
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FA712BF0C;
	Thu, 15 Feb 2024 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vn0WNA4H"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3C87484
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999208; cv=none; b=bwUOKQY5077oeOBhzll0al5m35+V5ZrYzS8GYljUeICrWkljmd0PO0DahgYywlZeCy0qZe4jnnSk2oji/NKWDvDLeQWz6xbxDDCR3yYittbOvuN+OmJqCP+8TKlceagGhGZ+Q/wF2U/SxOl0Eff89osKDSff6MGy3qsvvPDlpPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999208; c=relaxed/simple;
	bh=NFs89QnBgbGgSlfJvu4mQnmgXCXRYhOZW4oE1DEnSFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RmQRDMAUa3sAIvdJzwMslKPDUx+ECNBG/0jReU63JFAmFNESoNct9OcxnWTLlRUbPQv0VaVASVbY1+dETkximbZO94buBu5v8G3xZ1pC2AQyUYliAEYsz+THW3c53liL4ymWhxVbqke4kfq5+qb4lqQAxxxIQRvZhUdd9A5RjdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vn0WNA4H; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41FCD1RD110654;
	Thu, 15 Feb 2024 06:13:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707999181;
	bh=TJ0yNevOP636XIwjw9GslgubE0f5OWjcY8GZRp0ladc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=vn0WNA4HZuuMrikuBDPLvnNW0/+LvmCmlwdntaPvMCWr0iWqMGnHA2wo6S0P5x542
	 QHTCFicqV0TKFot4t5NM8ckUsM4vWi/xTTOgPPEyWhql+c7p/q+SsPYd+8Mv5u56dp
	 0lOl31pORu3qnzZcC68ettBy4Xp5ZzafrJjmk2pQ=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41FCD14q109834
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 06:13:01 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 06:13:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 06:13:01 -0600
Received: from [172.24.227.31] (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41FCC4qn059758;
	Thu, 15 Feb 2024 06:12:58 -0600
Message-ID: <1a056ce4-3f43-4ca7-bc29-d297cb38a1d0@ti.com>
Date: Thu, 15 Feb 2024 17:42:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/tidss: Fix sync-lost issue with two displays
Content-Language: en-US
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Jyri Sarha
	<jyri.sarha@iki.fi>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        "Sam
 Ravnborg" <sam@ravnborg.org>, Devarsh Thakkar <devarsht@ti.com>,
        "Francesco
 Dolcini" <francesco@dolcini.it>
CC: Tomi Valkeinen <tomi.valkeinen@ti.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <20240213-tidss-fixes-v1-0-d709e8dfa505@ideasonboard.com>
 <20240213-tidss-fixes-v1-2-d709e8dfa505@ideasonboard.com>
From: Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20240213-tidss-fixes-v1-2-d709e8dfa505@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 13/02/24 13:46, Tomi Valkeinen wrote:
> A sync lost issue can be observed with two displays, when moving a plane
> from one disabled display to an another disabled display, and then
> enabling the display to which the plane was moved to. The exact
> requirements for this to trigger are not clear.
> 
> It looks like the issue is that the layers are left enabled in the first
> display's OVR registers. Even if the corresponding VP is disabled, it
> still causes an issue, as if the disabled VP and its OVR would still be
> in use, leading to the same VID being used by two OVRs. However, this is
> just speculation based on testing the DSS behavior.
> 
> Experimentation shows that as a workaround, we can disable all the
> layers in the OVR when disabling a VP. There should be no downside to
> this, as the OVR is anyway effectively disabled if its VP is disabled,
> and it seems to solve the sync lost issue.
> 
> However, there may be a bigger issue in play here, related to J721e
> erratum i2097 ("DSS: Disabling a Layer Connected to Overlay May Result
> in Synclost During the Next Frame"). Experimentation also shows that the
> OVR's CHANNELIN field has similar issue. So we may need to revisit this
> when we find out more about the core issue.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Display SubSystem")

Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>

> ---
>  drivers/gpu/drm/tidss/tidss_crtc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
> index 5f838980c7a1..94f8e3178df5 100644
> --- a/drivers/gpu/drm/tidss/tidss_crtc.c
> +++ b/drivers/gpu/drm/tidss/tidss_crtc.c
> @@ -265,6 +265,16 @@ static void tidss_crtc_atomic_disable(struct drm_crtc *crtc,
>  
>  	reinit_completion(&tcrtc->framedone_completion);
>  
> +	/*
> +	 * If a layer is left enabled when the videoport is disabled, and the
> +	 * vid pipeline that was used for the layer is taken into use on
> +	 * another videoport, the DSS will report sync lost issues. Disable all
> +	 * the layers here as a work-around.
> +	 */
> +	for (u32 layer = 0; layer < tidss->feat->num_planes; layer++)
> +		dispc_ovr_enable_layer(tidss->dispc, tcrtc->hw_videoport, layer,
> +				       false);
> +
>  	dispc_vp_disable(tidss->dispc, tcrtc->hw_videoport);
>  
>  	if (!wait_for_completion_timeout(&tcrtc->framedone_completion,
> 

