Return-Path: <linux-kernel+bounces-91401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE4D8710F4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF031C222D5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1AB7C0BF;
	Mon,  4 Mar 2024 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dfEtAnKm"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CA37C6C0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 23:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709593843; cv=none; b=XP0kkUfWV+Ksa+Sv2rmHFyUEyv205sium5/Mb4EpTpaKphJIYzp6A+7s6S6VH0vJZLhHajC/Ncdqrr7r0aENL/xcqo6SnOhkNjYIv3aDZ8cBnESlslIsPRUIpKT5qtA5Q4lVekwpojDzTqVnME5Q10fsH2RKFGb1M8g+H0kZzNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709593843; c=relaxed/simple;
	bh=wMZzStv0WI94dHIupt/3qTiQCvxmwKcJlo5DxooTw+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nox3DCmVXNeCkuNCK5LDYP/g+uqSKJrbuMZB67WfeeDcklBthGm+LFlZmkRSiPTBCIie6z8eciksflUS+zU8KAIR8RLmNvrTBEZTPtq8T7OLnkMasuGq4cU+9hlWYsjfccGNgkFQ01zbVPHOFk24pNCwEyJMDrTBv6+1HGuvGQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dfEtAnKm; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-29aa8c4710bso3676108a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 15:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709593840; x=1710198640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9msUTwBa3XNDAwjjPAvGjEpS0Gd3hVi8Z81nRq0fsvc=;
        b=dfEtAnKmFSMK5QWlit8fTzTecWDN5ME/pgJL4QkLqSdE4mkkS77SfxSbjBmWp1hkAh
         J/EecDWUnQQ7w62Utyq7enewe3MBG1fb2R5hF6butE1B6l7qkt/6So861QHDjisYX/Kc
         0MU731QMcrPf0FsM5Lx3MHnE/Hc/Zkxm9/ylk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709593840; x=1710198640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9msUTwBa3XNDAwjjPAvGjEpS0Gd3hVi8Z81nRq0fsvc=;
        b=K88e/x/Axqln3Eqmqa29FCcalbufZT+JicIiAwfDiKS/u48ZWwDHVR8k5Z6DC0cOcI
         vCmJwhOoJ3wo3NQty4k3tsu67nuX3ZqAmdy80IZ+zArqtSi7pwNFyAPaqRuDXM7Wxgi6
         vKloTzFr82sij9b/T6JhTy03GGvjZNKill+i6Fjzdl2+QXEJn2N7WheKhDt+U6s6Diep
         +D5uz211MP33Hm69y2j+VIFmkY99ZTXtD8ijr+lczt5cDc+bupCkpjaeEA+tb8x3ukJB
         lSEvcBcMUMRtT9UCtEneafCV6xFg20ey97WgB7Rjc5/kaWu0U+W8boeZGl57pylr8A1U
         vgHg==
X-Forwarded-Encrypted: i=1; AJvYcCWnDLNcPo7oYfuUfmxCoy3V3z5paxahUHKMYtZFMWuuMxLAkM91Es5Jv0CNRccWKgpLnONOlwtENp5yFMyxhdGGJ476boQ/5hwMlTEK
X-Gm-Message-State: AOJu0YzlolIUzxVpMiRaA03LHbnC5YINQExtKwaGG3m1YpErj23mNRSa
	WQra3u5o5aiJBPNUJSHLi/Kf9deKw1YwlPzdIttEhvNNxKFtRC8+Ce2ONm/m8tXgoYrAbdjd2bg
	=
X-Google-Smtp-Source: AGHT+IEbAr3Hucp75eD8JSPbmT5fSEjkHtUZ6q2D8D6DXvd41jaoEyXkI1zB44xifF8tsNHZEQjQpA==
X-Received: by 2002:a17:90a:e548:b0:29b:1bc5:cfda with SMTP id ei8-20020a17090ae54800b0029b1bc5cfdamr1080411pjb.16.1709593840120;
        Mon, 04 Mar 2024 15:10:40 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fa13-20020a17090af0cd00b00298f2ad430csm8380840pjb.0.2024.03.04.15.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 15:10:39 -0800 (PST)
Date: Mon, 4 Mar 2024 15:10:39 -0800
From: Kees Cook <keescook@chromium.org>
To: Alex Elder <elder@ieee.org>
Cc: Alex Elder <elder@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo A . R . Silva" <gustavo@embeddedor.com>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] greybus: Avoid fake flexible array for response data
Message-ID: <202403041507.BEF59739@keescook>
References: <20240304211940.it.083-kees@kernel.org>
 <1c5ab1e7-ac66-438c-bc49-0785810e9355@ieee.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c5ab1e7-ac66-438c-bc49-0785810e9355@ieee.org>

On Mon, Mar 04, 2024 at 04:45:11PM -0600, Alex Elder wrote:
> On 3/4/24 3:19 PM, Kees Cook wrote:
> > FORTIFY_SOURCE has been ignoring 0-sized destinations while the kernel
> > code base has been converted to flexible arrays. In order to enforce
> > the 0-sized destinations (e.g. with __counted_by), the remaining 0-sized
> > destinations need to be handled. Instead of converting an empty struct
> > into using a flexible array, just directly use a pointer without any
> > additional indirection. Remove struct gb_bootrom_get_firmware_response
> > and struct gb_fw_download_fetch_firmware_response.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Thanks for adding the comments!  This looks good to me.
> 
> Reviewed-by: Alex Elder <elder@linaro.org>
> 
> 
> 
> I want to call attention to a few other spots that should
> get a little more attention--related directly to what you're
> doing here.
> 
> I noticed that the GB_CONTROL_TYPE_GET_MANIFEST response
> structure also contains only a flexible array.  It might
> be good to add a similar comment in gb_interface_enable(),
> above this line:
>         manifest = kmalloc(size, GFP_KERNEL);
> The definition of the gb_control_get_manifest_response structure
> could probably be replaced with a comment.
> 
> 
> The response buffer for an I2C transfer consists only of incoming
> data.  There is already a comment in gb_i2c_operation_create()
> that says this:
>         /* Response consists only of incoming data */
> The definition of the gb_i2c_transfer_response structure should
> then go away, in favor of a comment saying this.
> 
> The response buffer for a SPI transfer consists only of incoming
> data.  It is used three times in "driver/staging/greybus/spilib.c":
> - calc_rx_xfer_size() subtracts the size of the response structure,
>   and that should be replaced by a comment (and the structure
>   definition should go away)
> - gb_spi_decode_response() takes the response structure as an
>   argument.  That could be replaced with a void pointer instead,
>   with a comment.
> - gb_spi_transfer_one_message() is what passes the response buffer
>   to gb_spi_decode_response(), and could be adjusted to reflect
>   that the response consists only of data--rather than a struct
>   containing only a flexible array.
> 
> 
> Kees:  I'm *not* asking you to deal with these, I'm just mentioning
> them to you.  My comments above (without someone else confirming)
> are not sufficient to dictate how to address these.

Okay, thanks! Yeah, I took a look at struct gb_i2c_transfer_response and
I think it might trip the memcpy checking too since it's zero sized, but
it's on the source side, which isn't as strictly checked.

I'll add a TODO item to track these, though.

-Kees

-- 
Kees Cook

