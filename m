Return-Path: <linux-kernel+bounces-82482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AA8868526
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A321F2210C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1D61859;
	Tue, 27 Feb 2024 00:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f/s9uHkM"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355B74A22
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708994921; cv=none; b=UEMw2jrQZMXE09/Hz+7iUWt6ZmPIekTYZ7GE6DQBeknCUBroIav0CQXWBed4SaOP7T5IJ4Gvf/eI7UHREJ3kJuDaszaOlEhJad/czJT5n9ru7mutrU0nCUdxvDIF08MbG6obCsfx1BarkxeWyf5V8aCiA0lj9OvdVEDWO/m6Zh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708994921; c=relaxed/simple;
	bh=1d5ZkL9n1t8/7gU9h2KWeJ28p1lq19jfuE6mDI7FasA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qasc4qkGxolqeqw/WqS8PxwYkJHOmFhHYkzOJdiysv60qSeOdngDdgUQtccfDGUX1liDKDRqd0RlM4uG3ATsQ2wK8ikL8jj6EslOWf2154uQf5cOqWeTiy5l/Q+wsJLWbJbv/0ymaD4pQf7lfSTW9EvdhJ21weUAbCS3PZFKgVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f/s9uHkM; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dc0e5b223eso30921735ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708994919; x=1709599719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HEv2j8AE2R1WryNqIlQAju++XXgILMVuNPnvcySZm4w=;
        b=f/s9uHkMDWX3yBFa336bVUbwZ9bEJcqPdIY+qrW9PtaaMy/Z9Ki9vhdMABCOoIC7uF
         KKCC+YNR6Pe8nvjw5oPKwB5jPDmLp4vBK2DbzgtNYy8FPK19s5QEzgLrZ4FAt8mZtg6n
         seE96dJPjnqy10NcFkGQEWuoob61BFiSV34gA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708994919; x=1709599719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEv2j8AE2R1WryNqIlQAju++XXgILMVuNPnvcySZm4w=;
        b=xCc20I+vCGpzx1NQTzSNkyLJ5ygcv1XTI6yfkIZ5WsCxJVa8trzybgyCe88wkIPWLp
         dP6NYePttJf7i+sWsiOESpldp68mDO86KTzJhtItJ42kfT2YiREVIzlV1vnMBLjz1w5I
         N5Atm8sfCkUCrUvgfD5z6nUs7+lVqxHR5dBf6+i58++4Dd2EC/eSOvc3kyoqDaPeKOKs
         9L4lNie47d2G7F7lZX91fjMUVToJ4hRqejHLVgNq5L4+5QEsdumNJuK/yWP6x8sYHPh2
         +N3dNC0C9p75KhkfaEs4V09rY5Ixplc4PIOdp6GV9X6DswThJtu64SSyVV3tC9hMYjMo
         KIAA==
X-Forwarded-Encrypted: i=1; AJvYcCUjxTNj2NmLpq3vqahr9lbZdXEXaTtMSVqwgyy2pAyyUxaS49l/EJoOJo6YKWZOXdsxin+3XEYnr7gJnzUm+TVi/RWk8elGrtyviwAG
X-Gm-Message-State: AOJu0YyGg47UBgfK6oIvRJ5Ev/ej27uYrOmccgb2IpfR5FTiQKm++tOb
	pivNnIEQ01aOB40Ybb3oYyWvSVFhm8TlgiEMxKmxt76kNbp2SiyBm4sHLAyojzc8k4mCdEV7Zw0
	=
X-Google-Smtp-Source: AGHT+IHGJtdVOQpGyp67EsMcKEw8vdfeBxtaDugOps7hSmbzF/cwPxXouymJyTiqq1Ez9gjFIz6aew==
X-Received: by 2002:a17:902:aa42:b0:1dc:771f:ae56 with SMTP id c2-20020a170902aa4200b001dc771fae56mr7798438plr.29.1708994919507;
        Mon, 26 Feb 2024 16:48:39 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902e34300b001db8a5ea0a3sm283583plc.94.2024.02.26.16.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 16:48:38 -0800 (PST)
Date: Mon, 26 Feb 2024 16:48:38 -0800
From: Kees Cook <keescook@chromium.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	gustavoars@kernel.org, Peter Rosin <peda@axentia.se>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH v2] mux: convert mux_chip->mux to flexible array
Message-ID: <202402261647.CCCF97AF@keescook>
References: <20240226212925.3781744-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226212925.3781744-1-jacob.e.keller@intel.com>

On Mon, Feb 26, 2024 at 01:29:25PM -0800, Jacob Keller wrote:
> The mux_chip structure size is over allocated to additionally include both
> the array of mux controllers as well as a device specific private area.
> The controllers array is then pointed to by assigning mux_chip->mux to the
> first block of extra memory, while the private area is extracted via
> mux_chip_priv() and points to the area just after the controllers.
> 
> The size of the mux_chip allocation uses direct multiplication and addition
> rather than the <linux/overflow.h> helpers. In addition, the mux_chip->mux
> struct member wastes space by having to store the pointer as part of the
> structures.
> 
> Convert struct mux_chip to use a flexible array member for the mux
> controller array. Use struct_size() and size_add() to compute the size of
> the structure while protecting against overflow.
> 
> After converting the mux pointer, notice that two 4-byte holes remain in
> the structure layout due to the alignment requirements for the dev
> sub-structure and the ops pointer.
> 
> These can be easily fixed through re-ordering the id field to the 4-byte
> hole just after the controllers member.
> 
> This changes the layout from:
> 
> struct mux_chip {
>         unsigned int               controllers;          /*     0     4 */
> 
>         /* XXX 4 bytes hole, try to pack */
> 
>         struct mux_control *       mux;                  /*     8     8 */
>         struct device              dev __attribute__((__aligned__(8))); /*    16  1488 */
> 
>         /* XXX last struct has 3 bytes of padding */
> 
>         /* --- cacheline 23 boundary (1472 bytes) was 32 bytes ago --- */
>         int                        id;                   /*  1504     4 */
> 
>         /* XXX 4 bytes hole, try to pack */
> 
>         const struct mux_control_ops  * ops;             /*  1512     8 */
> 
>         /* size: 1520, cachelines: 24, members: 5 */
>         /* sum members: 1512, holes: 2, sum holes: 8 */
>         /* paddings: 1, sum paddings: 3 */
>         /* forced alignments: 1 */
>         /* last cacheline: 48 bytes */
> } __attribute__((__aligned__(8)));
> 
> To the following:
> 
> struct mux_chip {
>         unsigned int               controllers;          /*     0     4 */
>         int                        id;                   /*     4     4 */
>         struct device              dev __attribute__((__aligned__(8))); /*     8  1488 */
> 
>         /* XXX last struct has 3 bytes of padding */
> 
>         /* --- cacheline 23 boundary (1472 bytes) was 24 bytes ago --- */
>         const struct mux_control_ops  * ops;             /*  1496     8 */
>         struct mux_control         mux[];                /*  1504     0 */
> 
>         /* size: 1504, cachelines: 24, members: 5 */
>         /* paddings: 1, sum paddings: 3 */
>         /* forced alignments: 1 */
>         /* last cacheline: 32 bytes */
> } __attribute__((__aligned__(8)));
> 
> This both removes risk of overflowing and performing an under-allocation,
> as well as saves 16 bytes of otherwise wasted space for every mux_chip.

This looks like a great clean-up, thank you!

> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> Changes since v1:
> * Rebased and updated the commit message slightly.
> 
>  drivers/mux/core.c         |  7 +++----
>  include/linux/mux/driver.h | 10 +++++-----
>  2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
> index 775816112932..9225abca7897 100644
> --- a/drivers/mux/core.c
> +++ b/drivers/mux/core.c
> @@ -98,13 +98,12 @@ struct mux_chip *mux_chip_alloc(struct device *dev,
>  	if (WARN_ON(!dev || !controllers))
>  		return ERR_PTR(-EINVAL);
>  
> -	mux_chip = kzalloc(sizeof(*mux_chip) +
> -			   controllers * sizeof(*mux_chip->mux) +
> -			   sizeof_priv, GFP_KERNEL);
> +	mux_chip = kzalloc(size_add(struct_size(mux_chip, mux, controllers),
> +				    sizeof_priv),
> +			   GFP_KERNEL);
>  	if (!mux_chip)
>  		return ERR_PTR(-ENOMEM);
>  
> -	mux_chip->mux = (struct mux_control *)(mux_chip + 1);
>  	mux_chip->dev.class = &mux_class;
>  	mux_chip->dev.type = &mux_type;
>  	mux_chip->dev.parent = dev;
> diff --git a/include/linux/mux/driver.h b/include/linux/mux/driver.h
> index 18824064f8c0..84dc0d3e79d6 100644
> --- a/include/linux/mux/driver.h
> +++ b/include/linux/mux/driver.h
> @@ -56,18 +56,18 @@ struct mux_control {
>  /**
>   * struct mux_chip -	Represents a chip holding mux controllers.
>   * @controllers:	Number of mux controllers handled by the chip.
> - * @mux:		Array of mux controllers that are handled.
> - * @dev:		Device structure.
>   * @id:			Used to identify the device internally.
> + * @dev:		Device structure.
>   * @ops:		Mux controller operations.
> + * @mux:		Flexible array of mux controllers that are handled.
>   */
>  struct mux_chip {
>  	unsigned int controllers;
> -	struct mux_control *mux;
> -	struct device dev;
>  	int id;
> -
> +	struct device dev;
>  	const struct mux_control_ops *ops;
> +
> +	struct mux_control mux[];

This can gain the __counted_by annotation as well:

	struct mux_control mux[] __counted_by(controllers);

With that:

	Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook

