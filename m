Return-Path: <linux-kernel+bounces-66865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF7D8562C6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4D61C2118E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6A9127B6E;
	Thu, 15 Feb 2024 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="p5R8Z1Jq"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25B27484
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999163; cv=none; b=rwThyL/EfIn8b/ueaeLdoH3g3sbg1mEV5kaaZAh2luNNf0Z6i6SPLIcXo13cun1tjVbAN26n43PQ1IQvrMoDvsm83Sr/36MnWv8pxVoTn62EVfQMNADe/d0cPTdOZjMp5ybFHOc5Z0VARqZYIz+LKnAjA1TFYpYgwZogDSsRN2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999163; c=relaxed/simple;
	bh=EaukzfZ/zQxKbnDwRDMhXhmoDaS50dhGCB7iA691Zy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b1Qvxr5IG4m2HVkB47YerkpVftDhEriU27H8zdg/UVUVqON43TVx/RbW5w4VeLOVINQSMkiHZqAlDwFUoA5Rwgum0wHbi3zi6p/TphOdD9VJnDztK0/pbFgf54ixOhloPeY7n1o6ZwbbVAjB9gMeTzTnDojhwrjKVvJl69ABTO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=p5R8Z1Jq; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41FCC8jU101571;
	Thu, 15 Feb 2024 06:12:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707999128;
	bh=MpjFvrJHEvLR1rwljrTCryuXjkaerLLnurehV7C17yE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=p5R8Z1Jq1zJxh8mHjct8FxoDXlmH4WfFpUqvrqATGfyh91xrKbL+G1+VCHnJKfMmw
	 oKMbYHRkeRSSG4O62nPpRncOjluu3ERmJvdroxATubJa+FrFbxF6JDRd6IT/PJMCOA
	 WQASiCmlo1jQL8SokFJcgJ65pJZzs2uGonwHAWcQ=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41FCC85d012101
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 06:12:08 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 06:12:08 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 06:12:08 -0600
Received: from [172.24.227.31] (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41FCC4qm059758;
	Thu, 15 Feb 2024 06:12:05 -0600
Message-ID: <8928f697-560c-423f-b618-c60b6f4dda6b@ti.com>
Date: Thu, 15 Feb 2024 17:42:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/tidss: Fix initial plane zpos values
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
 <20240213-tidss-fixes-v1-1-d709e8dfa505@ideasonboard.com>
From: Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20240213-tidss-fixes-v1-1-d709e8dfa505@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Tomi, thank you for the fixes.

On 13/02/24 13:46, Tomi Valkeinen wrote:
> When the driver sets up the zpos property it sets the default zpos value
> to the HW id of the plane. That is fine as such, but as on many DSS
> versions the driver arranges the DRM planes in a different order than
> the HW planes (to keep the non-scalable planes first), this leads to odd
> initial zpos values. An example is J721e, where the initial zpos values
> for DRM planes are 1, 3, 0, 2.
> 
> In theory the userspace should configure the zpos values properly when
> using multiple planes, and in that sense the initial zpos values
> shouldn't matter, but there's really no reason not to fix this and help
> the userspace apps which don't handle zpos perfectly. In particular,
> Weston seems to have issues dealing with the planes with the current
> default zpos values.
> 
> So let's change the zpos values for the DRM planes to 0, 1, 2, 3.
> 
> Another option would be to configure the planes marked as primary planes
> to zpos 0. On a two display system this would give us plane zpos values
> of 0, 0, 1, 2. The end result and behavior would be very similar in this
> option, and I'm not aware that this would actually help us in any way.
> So, to keep the code simple, I opted for the 0, 1, 2, 3 values.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Display SubSystem")

Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>

> ---
>  drivers/gpu/drm/tidss/tidss_plane.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/tidss/tidss_plane.c
> index e1c0ef0c3894..68fed531f6a7 100644
> --- a/drivers/gpu/drm/tidss/tidss_plane.c
> +++ b/drivers/gpu/drm/tidss/tidss_plane.c
> @@ -213,7 +213,7 @@ struct tidss_plane *tidss_plane_create(struct tidss_device *tidss,
>  
>  	drm_plane_helper_add(&tplane->plane, &tidss_plane_helper_funcs);
>  
> -	drm_plane_create_zpos_property(&tplane->plane, hw_plane_id, 0,
> +	drm_plane_create_zpos_property(&tplane->plane, tidss->num_planes, 0,
>  				       num_planes - 1);
>  
>  	ret = drm_plane_create_color_properties(&tplane->plane,
> 

