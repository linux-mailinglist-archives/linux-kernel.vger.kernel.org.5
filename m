Return-Path: <linux-kernel+bounces-70718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9B2859B80
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45FB5281983
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5A01CF94;
	Mon, 19 Feb 2024 05:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dw7TTuXW"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABF83FF4
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 05:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708319046; cv=none; b=hEQCC7hL4+JdxUm5BO0dYGIMAMAEBsCB/60GeY2IxUawouO+5jcxUSr5hl7uV67qTY7n/9lbHB9UDk4phWpclR1upiM1i83WTf9fvCzUEkxG0VFbf9gbk16r8LO3mDNrRc6S82ViWcI10JWpJDW/TMfQiBFWl5ZjJaL7+QC8Pyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708319046; c=relaxed/simple;
	bh=OQUbTWpsyfJky7G4Vw2b1kIc+3UWUfWO20ZLbqaRsk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Foa97pgs63pT7pQE+yKC7RhvatAbrA0432v2oKpfVaV4+ePJ3Fh6T+zumaMUM2Kj0VtcZoEQfnSwvtzEQgsfgsQNAj45rxcCI4pzfkM4ujM54YsS7POrzZH67FRJDQ73a6pzXTtoxTjR533+MNGhQPJyyuk+oAXRKbfe4SFapbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Dw7TTuXW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d934c8f8f7so37000295ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 21:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708319045; x=1708923845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sy2YaU44Xzss5zx7kgvslISkld6TxisI9EFhWrYVrgI=;
        b=Dw7TTuXWF+/wl9rqabZuURAUNeki90Dhb7wJXffD/tgbaaapIupaPElsWdK/QJkj8e
         tV+wwlRXeSPzy9YIuFQP6+6/APiJxRHFPZDMlFXoywJ15OBCsAwjnOXZl7ZIHZHUKAjO
         OfV1QwZ365h8YtfbdIENCdmi+6vRaxcuP8mKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708319045; x=1708923845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sy2YaU44Xzss5zx7kgvslISkld6TxisI9EFhWrYVrgI=;
        b=FLkWx0UDEOOjMZzsVMm4/UVQTOVcHGtxVWKHAfUIMM4h+m1EDYF0bGQ13Resi5mGEM
         zPNF/9Pc3xILyfro7ra8LlgrDSStZIkWSrt2x1YtTH813lu6Xw5j1SsZAhKmeixXikod
         o4VcU8SCTdxo+PUXyyMtOAuH6g5AJpKp+CtL6fTj6sIwqiYEpeW2tlATiZrgsJ3mCe1/
         WFwY9OR1Wxiirghsrl7hvNmZjVagxiNi8yMGrJMUpLsCgzWHrea2ECX0XPA6Vxwyypv2
         0xZL9IPbTPtWxW6oxPPtaUSyGvhE1+vJzRaPRsr+P1KV7zU1EuVAFjBtanNNsdlNstmJ
         CJEA==
X-Forwarded-Encrypted: i=1; AJvYcCW2F2/II2opilwJXQjt02SDP+jeBIjiFmGExZwWB6jgcz5HqyeyDsEhnFaR7rWm5rHHKiewY+C4Igf0MvlJG4aIJirac5tNqEJbvlEX
X-Gm-Message-State: AOJu0YyXKTH4bZeQZ+HiHOyeRWRHR71I8nRXHJz5fFsjRv6KHxy5lq30
	pFbuxEVOeToFJOtFGPugx2E2RlU7u0PD/DhtrlAAuTNjBJLFlI2ay3JBmWOGRA==
X-Google-Smtp-Source: AGHT+IERCSPk3qDCxDTUOnKHeleegt5yUUSTiYJf6qBv69aCgnYIJ7j9dioWkmCbv0bHPswdvR4mXA==
X-Received: by 2002:a17:903:1c6:b0:1db:d7a8:850b with SMTP id e6-20020a17090301c600b001dbd7a8850bmr3434760plh.25.1708319044686;
        Sun, 18 Feb 2024 21:04:04 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t12-20020a1709028c8c00b001d9773a198esm3420532plo.201.2024.02.18.21.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 21:04:03 -0800 (PST)
Date: Sun, 18 Feb 2024 21:04:03 -0800
From: Kees Cook <keescook@chromium.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Peter Rosin <peda@axentia.se>,
	gustavoars@kernel.org, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org
Subject: Re: [PATCH -next] mux: convert mux_chip->mux to flexible array
Message-ID: <202402182100.1D5BBE45@keescook>
References: <20230223014221.1710307-1-jacob.e.keller@intel.com>
 <e8782296-49bc-33a2-47b3-45c204551806@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8782296-49bc-33a2-47b3-45c204551806@intel.com>

On Mon, Feb 27, 2023 at 12:28:43PM -0800, Jesse Brandeburg wrote:
> On 2/22/2023 5:42 PM, Jacob Keller wrote:
> > The mux_chip structure size is over allocated to additionally include both
> > the array of mux controllers as well as a device specific private area.
> > The controllers array is then pointed to by assigning mux_chip->mux to the
> > first block of extra memory, while the private area is extracted via
> > mux_chip_priv() and points to the area just after the controllers.
> > 
> > The size of the mux_chip allocation uses direct multiplication and addition
> > rather than the <linux/overflow.h> helpers. In addition, the mux_chip->mux
> > struct member wastes space by having to store the pointer as part of the
> > structures.
> > 
> > Convert struct mux_chip to use a flexible array member for the mux
> > controller array. Use struct_size() and size_add() to compute the size of
> > the structure while protecting against overflow.
> > 
> > After converting the mux pointer, notice that two 4-byte holes remain in
> > the structure layout due to the alignment requirements for the dev
> > sub-structure and the ops pointer.
> > 
> > These can be easily fixed through re-ordering the id field to the 4-byte
> > hole just after the controllers member.
> 
> Looks good to me (just a driver dev, not a mux dev!). Also added
> linux-i2c mailing list and a couple others for more review.
> 
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> related thread (cocci script) at [1]
> 
> [1]
> https://lore.kernel.org/all/20230227202428.3657443-1-jacob.e.keller@intel.com/

*thread necromancy*

Can we land this? It's the last struct_size() instance that the above
Coccinelle script flags.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

