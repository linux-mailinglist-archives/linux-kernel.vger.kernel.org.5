Return-Path: <linux-kernel+bounces-51092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7D1848667
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D231C21BEE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 13:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DF45DF37;
	Sat,  3 Feb 2024 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="idt908nJ"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBA25DF16
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706965235; cv=none; b=tV768zkMNbnJR6w6zTtzIJEvDD4AoO7fPyLh7nQWR6saZFaod7cfa9atFxw0aS2JNSk8Gh2vN7GJMenvJL/tYY2zRjBtbj7+xpUwz3COKmeOLqjXCxGQK7LL3dPw00fRLjNSDBHKW328qMCkopkVAar+/KQRVBnSAwJHnUUqaUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706965235; c=relaxed/simple;
	bh=S75Q5QilJ7eP2ULEPrRQni/nwxoTPN2l+b26Mk0Njz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r3k6pMP92hL3DBCnjasvV0WeHQeO8jyBaAS9YDs+kV99ufM0lvdVXevYdRJE4fEzwWshWmHbCNATEpxi3AfREC8bnoNs7IU6MwDGx4KYoJeGmM8ujM1Yp5li2XP6eC7+E+Lr6GoQdNJ/NflccYhz3JmWVSa2oZLWsmg9sAbR8Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=idt908nJ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5112a04c7acso4952743e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 05:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706965231; x=1707570031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AVUyfz7WUW7XcdP5/LKYCmtcqOBYqv5sksk1vtX1nCA=;
        b=idt908nJuBhsWajqH81SujAWQkgiBhWSDAb50Wsjb8kdyjHds/ZlfeH1/9yYowMntS
         vhBR/K2x0RUtAgwwXPgVglvL8nIPYdRvyzbFgCyh1gtsFgGoNadqkXyforJ6eEdhnsQ4
         V74j9SEO5XYDOS04OCT0p+4SEbrTVDU72kn8nX1kSWOIX5FaTo+AuUR/2+ggtYkgduh0
         lPAYlEomIm3Xad6BYb/sJAG89fgq74Yi3lKvJzDq48CHz7F4cQH6Edena0okvgXvRnjd
         Kmby8hLCeGlLSc6IybcUuMI5NoyLw8F9OIP812JTaFSUmvbDMlfPr8OEu6wFKWs3Rtua
         ks8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706965231; x=1707570031;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVUyfz7WUW7XcdP5/LKYCmtcqOBYqv5sksk1vtX1nCA=;
        b=UoG0VSmfCspQEKEt/pVHhPeQY/OeV6qo01iJMJGhPRg/4fH+VDy+Npde3Rqjya4M8m
         CfrJlm+W5n8rEK3ZDOBOIEkVaLfaPvoqtl2ErJYbmKe5PLaGps+Cu+CoNI6+95G8CS+K
         bYepLYBBkGsDgqGparrB21ah/b5Ovn5sbQPnHNIC9qg/xPSCzAvybClMVSw1yA1ltDsW
         CVlafOgKes9j+7Ae4OB5OOMvgH3LG4/vZ1nfvMVWwgi7ZIY1QGQgNjNqqzEQnRKuwt/E
         vkdVxVV2x5QJG0YA1elmbD1/gB3AKx4Gc+Ogl6AGms0Eam78mAK79/pgaBuOA5/prQdO
         2yBQ==
X-Gm-Message-State: AOJu0Yxfy8NsIfHO3OAfpAr6CYcG2BkduatiE9ZbmG2olwZ2FvLwUU0+
	eZkUeSB23LJVjoNIlMOqeb98RumGuX+yS5GK5oMjTAFk1bM1w+RF1Ual3TKVboA5Cjm/m+ONs6R
	5
X-Google-Smtp-Source: AGHT+IEelo4Z3puO6Kda/3pUuLOa9r/xnRutr71fC2kSACe4n8LJMHYeywJebFaAOPWhv25RJtKK5g==
X-Received: by 2002:a19:6912:0:b0:50e:50ee:f378 with SMTP id e18-20020a196912000000b0050e50eef378mr2893908lfc.65.1706965230747;
        Sat, 03 Feb 2024 05:00:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVtpHdvk1nlX+i9KcvhNgNQxu+pGhsV71NQ595emyIcVEQB3VSZUMshj/VPH+SPlk6T7ciDFCr8eNthIP7HBiyBnqK+QXL3EhxZZR6egu5xOW1j4Cpczv9Dmoh38RlCETXLCAcSbnkYRyTabVYsijIWH2DkvdVszGKIdG1tZIxjYKFmmfwSH1Z2ZduZ6K1Q4SXkEFPWt9FzgztHTfFST79nm127m785g5Z6eTwydH537Gtpmnp6EWxFVkAjy9OZcmqPixBWqfxKiqV3l60SxqSQMX+n6rG2Fy1bHaRlYeovgpuRiNkhOQJTDd7DaXmOMx1DpuC7C4EPYk93wrm9yquZQVtEfBFGSFuUylo8OwVFJA/uCRecZQyYsLt1ch5RxgzIKfGbrzfLnuHHILSDi218ffhqXbWi++CxiwCJET8WFB1VIhFPkB6/OZuO/fVx9jWJxseCYFRHqP1aj5luShWcUCDnHq0oroRiE8sBMgukXSry5e7L9/Oj3XipYWnogTDQtBX3SveJbfWmZ+teNnce6+aRoKsifj0vAhivQYXbosx4QpO46IjKSVupJLWJxAhb/fz/xKQARFhLCmx6TzCGtQojMPn48mMQR50ZIBuydjpvpFX0kVCDMR5uw8qqAIyPf+ukhu8DLLJuD84a4D/QqEPAx8tP9HPwqH2W9gPX84WJTGL9cXM=
Received: from [192.168.50.4] ([82.78.167.154])
        by smtp.gmail.com with ESMTPSA id j20-20020a170906475400b00a353ca3d907sm1958807ejs.217.2024.02.03.05.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 05:00:30 -0800 (PST)
Message-ID: <397c97ce-2912-42c1-823a-7ad151d73307@tuxon.dev>
Date: Sat, 3 Feb 2024 15:00:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v7 1/7] drm: atmel-hlcdc: add flag and driver ops
 to differentiate XLCDC and HLCDC IP
Content-Language: en-US
To: Manikandan Muralidharan <manikandan.m@microchip.com>, sam@ravnborg.org,
 bbrezillon@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, lee@kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Hari.PrasathGE@microchip.com, Balamanikandan.Gunasundar@microchip.com,
 Durai.ManickamKR@microchip.com, Nayabbasha.Sayed@microchip.com,
 Dharma.B@microchip.com, Varshini.Rajendran@microchip.com,
 Balakrishnan.S@microchip.com
References: <20240129092319.199365-1-manikandan.m@microchip.com>
 <20240129092319.199365-2-manikandan.m@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240129092319.199365-2-manikandan.m@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Manikandan,

On 29.01.2024 11:23, Manikandan Muralidharan wrote:
> Add is_xlcdc flag and LCD IP specific ops in driver data to differentiate
> XLCDC and HLCDC code within the atmel-hlcdc driver files.

I would first prepare the current code base for the addition of XLCDC by
first adding the struct atmel_lcdc_dc_ops, update current code to use it
and after that add XLCDC.

> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h | 37 ++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> index 5b5c774e0edf..d5e01ff8c7f9 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> @@ -177,6 +177,9 @@ struct atmel_hlcdc_layer_cfg_layout {
>  	int csc;
>  };
>  
> +struct atmel_hlcdc_plane_state;

You can move this forward declaration close the the structure that needs it
(struct atmel_lcdc_dc_ops).

> +struct atmel_hlcdc_dc;

And you can get rid if this one if you move struct atmel_lcdc_dc_ops after
struct atmel_hlcdc_dc definition.

> +
>  /**
>   * Atmel HLCDC DMA descriptor structure
>   *
> @@ -288,6 +291,36 @@ atmel_hlcdc_layer_to_plane(struct atmel_hlcdc_layer *layer)
>  	return container_of(layer, struct atmel_hlcdc_plane, layer);
>  }
>  
> +/**
> + * struct atmel_lcdc_dc_ops - describes atmel_lcdc ops group
> + * to differentiate HLCDC and XLCDC IP code support.
> + * @plane_setup_scaler: update the vertical and horizontal scaling factors
> + * @update_lcdc_buffers: update the each LCDC layers DMA registers.
> + * @lcdc_atomic_disable: disable LCDC interrupts and layers
> + * @lcdc_update_general_settings: update each LCDC layers general
> + * confiugration register.
s/confiugration/configuration

> + * @lcdc_atomic_update: enable the LCDC layers and interrupts.

You may want to keep consistency by adding or not '.' at the end of the
documentation statement (I consider '.' is useless)

> + * @lcdc_csc_init: update the color space conversion co-efficient of
> + * High-end overlay register.
> + * @lcdc_irq_dbg: to raise alert incase of interrupt overrun in any LCDC layer.

s/incase/in case

> + */
> +struct atmel_lcdc_dc_ops {
> +	void (*plane_setup_scaler)(struct atmel_hlcdc_plane *plane,
> +				   struct atmel_hlcdc_plane_state *state);
> +	void (*update_lcdc_buffers)(struct atmel_hlcdc_plane *plane,
> +				    struct atmel_hlcdc_plane_state *state,
> +				    u32 sr, int i);
> +	void (*lcdc_atomic_disable)(struct atmel_hlcdc_plane *plane);
> +	void (*lcdc_update_general_settings)(struct atmel_hlcdc_plane *plane,
> +					     struct atmel_hlcdc_plane_state *state);
> +	void (*lcdc_atomic_update)(struct atmel_hlcdc_plane *plane,
> +				   struct atmel_hlcdc_dc *dc);
> +	void (*lcdc_csc_init)(struct atmel_hlcdc_plane *plane,
> +			      const struct atmel_hlcdc_layer_desc *desc);
> +	void (*lcdc_irq_dbg)(struct atmel_hlcdc_plane *plane,
> +			     const struct atmel_hlcdc_layer_desc *desc);
> +};
> +
>  /**
>   * Atmel HLCDC Display Controller description structure.
>   *
> @@ -304,8 +337,10 @@ atmel_hlcdc_layer_to_plane(struct atmel_hlcdc_layer *layer)
>   * @conflicting_output_formats: true if RGBXXX output formats conflict with
>   *				each other.
>   * @fixed_clksrc: true if clock source is fixed
> + * @is_xlcdc: true if XLCDC IP is supported
>   * @layers: a layer description table describing available layers
>   * @nlayers: layer description table size
> + * @ops: atmel lcdc dc ops
>   */
>  struct atmel_hlcdc_dc_desc {
>  	int min_width;
> @@ -317,8 +352,10 @@ struct atmel_hlcdc_dc_desc {
>  	int max_hpw;
>  	bool conflicting_output_formats;
>  	bool fixed_clksrc;
> +	bool is_xlcdc;
>  	const struct atmel_hlcdc_layer_desc *layers;
>  	int nlayers;
> +	const struct atmel_lcdc_dc_ops *ops;
>  };
>  
>  /**

