Return-Path: <linux-kernel+bounces-15689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D578823050
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217D61F241F1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A592C1B283;
	Wed,  3 Jan 2024 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gjuyWpIF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8541A1B26C;
	Wed,  3 Jan 2024 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4T4tbs0ZVNz9stN;
	Wed,  3 Jan 2024 16:16:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1704295001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IuXh48BAQbEdwA1TrRsSkNBESpC4cFsNlnC9KrshjaA=;
	b=gjuyWpIFQp9owXYt+yhOUAOair3NQQNvAXllOaRD0rUDOhMJr2LZjnCTp+Sb/obKXFsS4m
	IX2sf329qhiaS/ZCZFSpC+8/SmKjXGMCi9Q67UCLSawNnVyKegbU5QjzuLQeSPxwdql6NU
	FuV+VWzKu3njPey5FYyq7RPdYZ0XNt8EdC2NrXK/SdqZHIGQFqr4ot82BH1+SiGYqfSO0I
	PV7trpSAwdtb0toiQtleokzH9Np0cjgS4hSsnVCz1bThYoSJSnUaTAuDNkHggfytNiK510
	YdEbogxr4MJrxEZbFEwKC2XHQh5tHqr2NjXlRBe6wSbT6X+xlZd/cm6Vk97pCQ==
Message-ID: <37647c33-7f9d-4763-8bf4-cfc5c9a811de@mailbox.org>
Date: Wed, 3 Jan 2024 16:16:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] drm: property: One function call less in
 drm_property_create() after error detection
Content-Language: en-CA
To: Markus Elfring <Markus.Elfring@web.de>, dri-devel@lists.freedesktop.org,
 kernel-janitors@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <ff7ce5d0-59fa-470c-8dd6-68dbe65c18e5@web.de>
 <9b1e7330-f4f6-47f8-a568-eaea1624bb6f@web.de>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <9b1e7330-f4f6-47f8-a568-eaea1624bb6f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: a3tith5w19ocqf5if416i7ko7o9xc9da
X-MBO-RS-ID: 90cb4ebc5a3fddc3ff6

On 2023-12-26 10:38, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 26 Dec 2023 08:44:37 +0100
> 
> The kfree() function was called in one case by the
> drm_property_create() function during error handling
> even if the passed data structure member contained a null pointer.
> This issue was detected by using the Coccinelle software.
> 
> Thus use another label.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/gpu/drm/drm_property.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
> index 596272149a35..3440f4560e6e 100644
> --- a/drivers/gpu/drm/drm_property.c
> +++ b/drivers/gpu/drm/drm_property.c
> @@ -117,7 +117,7 @@ struct drm_property *drm_property_create(struct drm_device *dev,
>  		property->values = kcalloc(num_values, sizeof(uint64_t),
>  					   GFP_KERNEL);
>  		if (!property->values)
> -			goto fail;
> +			goto free_property;
>  	}
> 
>  	ret = drm_mode_object_add(dev, &property->base, DRM_MODE_OBJECT_PROPERTY);
> @@ -135,6 +135,7 @@ struct drm_property *drm_property_create(struct drm_device *dev,
>  	return property;
>  fail:
>  	kfree(property->values);
> +free_property:
>  	kfree(property);
>  	return NULL;
>  }
> --
> 2.43.0
> 

This change is pointless at best, kfree(NULL) works fine.


Out of curiosity, what exactly did Coccinelle report?


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer


