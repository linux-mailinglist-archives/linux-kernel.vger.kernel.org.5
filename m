Return-Path: <linux-kernel+bounces-55278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9EB84BA1D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51F141F26D2D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D561339A8;
	Tue,  6 Feb 2024 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h5fqMoi6"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EBF13398B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234579; cv=none; b=KQFJoVpOj7T/33Uzwboxi6r7He+xt9k2HG9DpgWNdC2+bhQFUvL96szeGrqICfw80/puJgET1aHCaJbxA/nUPFdOrr3LUMDfD2pTGk1vu9E4bPwp7/OLor5mlUsH036T511ZMjGGooM5QXD5t53D8gaO/lpzmapokfy04UQmjtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234579; c=relaxed/simple;
	bh=bdl37jmtCEivilMOrqGrJq6Jlst6fkKekum2b0E0mjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CX1v9PKxQmbYCORILHS254QEGi0V1UWxO2A1KjQZ846Pu1QZwnZze5cqiBcUJUVhQCEX+W8vik6qcSYJZlkcxcqJePNXhnVOSMfs6Jdq7hlhp8ylmkE/jGOyxqJ1jn4mC/klGDkhLbcLfYE7PpPahB4aHPnLtgpuXnvfVNl5LHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h5fqMoi6; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-363b5ce4260so14102395ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 07:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707234576; x=1707839376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zCqPj3GZFJlmXLFLaYfVOm5VLNMuP0812vX0CpyGkb8=;
        b=h5fqMoi65rZvMyPbhKq1SyUhBIHoyXhy5BUXfUr2B8LMfMkQtXvZu7Oo4AaLA7ctHD
         9bFXRn1zS5dZD426J9L2jXm0t2dACzUQoCw/pv72t+M6IPQR3tWOsm5SF2FYiER8MJHI
         EnQdFEq3RkgmNxCpbWOkNs4AyXWuKHHR0mNMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707234576; x=1707839376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCqPj3GZFJlmXLFLaYfVOm5VLNMuP0812vX0CpyGkb8=;
        b=gFa+l+BWUc4mI+wM18uGO2PxKACAtHAYAi6SPktqAh+/PWrEwtSYlXkZPyw889wf91
         tGpiYYudWuuC0ih5Tp4K4Kr3DDqqrKQFHCmLsbAuAog6xrFNgyepRISZUcFxstCxRXTX
         XBpeHmhXnDzlYXT68OZqJjD3jGzG58C25LXU3d3JOKmZZ6Ocx0dE5lj0hMih8VC/8SzK
         vhsYTw4BGB7qJ64blIvZ60aq3nTZLno3oSYjuYm87lLXdUdtq8wF97b7BdpFUX6/8AbF
         HBwKX5ntLuhrOkwmXfKfAY/wTUKPxuIwK32U5L9+1EnphXKzshZjRQSxYxPNbH2i0AWh
         IC7g==
X-Gm-Message-State: AOJu0YzqrV+Wb+GO6SxISCvhtnCjhiqaobFQXR3rLJ8lJN5BHFbP1OqO
	gYJssgqx826Rp/X8MRrx2lYcfA08jGpxzky+zRafPJiKQV+bEemiDdtXpODjvA==
X-Google-Smtp-Source: AGHT+IFIEPMtHymxpfWYxcgZHzqkoP18uLj2m3G0KSirljW2704g78xPq+vrE/pwaTgUYtR+AfppAA==
X-Received: by 2002:a05:6e02:318b:b0:363:9f50:9715 with SMTP id cb11-20020a056e02318b00b003639f509715mr3945451ilb.31.1707234576759;
        Tue, 06 Feb 2024 07:49:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW/L96TBq5qchBhAn0e6I03zaNcO4TTP3E7jPFQqVTVF4Xw7sqIMfXoYxWFZSVxC0LF9fReknnkcM1CdGcu9VDCGKfdNrWFv2WY8R0Dx6sIHC/wvEur6toWcSiuGiujz+d2GwvENcuzSH7Jp62GsdfM9OMxUD9beAjwYPmPs06TJyE2y6FMlF7jcGcgyyPMXOcXD3s0e0GeLZcM/kclZS+m+/mOoZPFKgHPL9qVP9fWK2oKNSqYDd7x5KE+CMsSeF3/zYCaj2Dk+mYSixB/InDUxDTB6sv9g0uquZg1N8my4gzoN5vTlIehSM5FkesArKUaSflAOoBdwIWdJGW4D/MJ6jqeFuKtAxILkcqad5fRf+6YNkpP15mOWh+SnqzJEjQy6hlPonNbUuZhYn3u
Received: from localhost (147.220.222.35.bc.googleusercontent.com. [35.222.220.147])
        by smtp.gmail.com with UTF8SMTPSA id fo10-20020a056638648a00b0047136dd0dabsm568883jab.158.2024.02.06.07.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 07:49:36 -0800 (PST)
Date: Tue, 6 Feb 2024 15:49:35 +0000
From: Matthias Kaehlcke <mka@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: Javier Carrasco <javier.carrasco@wolfvision.net>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 6/7] ASoC: dt-bindings: xmos,xvf3500: add XMOS XVF3500
 voice processor
Message-ID: <ZcJVD4CGhlWRwgfM@google.com>
References: <20240206-onboard_xvf3500-v3-0-f85b04116688@wolfvision.net>
 <20240206-onboard_xvf3500-v3-6-f85b04116688@wolfvision.net>
 <ZcJDFi+iIQOWzgYw@finisterre.sirena.org.uk>
 <7b472cb2-6658-446a-ae47-411d08798cca@wolfvision.net>
 <ZcJR0LrwaS5GAf5h@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZcJR0LrwaS5GAf5h@finisterre.sirena.org.uk>

On Tue, Feb 06, 2024 at 03:35:44PM +0000, Mark Brown wrote:
> On Tue, Feb 06, 2024 at 04:05:15PM +0100, Javier Carrasco wrote:
> 
> > The names in the datasheet are vdd for the 1V0 supply and vddio for the
> > 3V3 supply. I named the latter vdd2 instead because this device does not
> > have its own driver and instead it uses the onboard_usb_hub generic
> > driver, where the supplies are named vdd and vdd2.
> 
> > Those are the names used for devm_regulator_bulk_get(). Is that not the
> > right way to match them?
> 
> The binding should really use vddio instead of vdd2 but if that's an
> existing binding then it gets more annoying, probably that existing
> binding is wrong too since vddio does sound like an entirely plausible
> standard name for a 3.3V supply. :/  At the very least the binding
> should document the weird mapping, though ideally the driver would be
> tought to request names matching the datasheet if the compatible is the
> one for this device.  Doing the better naming might be too much hassle
> though.

Initially the driver targeted a device with a single supply, the name
'vdd' was kept generic since it was expected that other devices would be
supported (except for a couple of minor bits the driver is not device
specific). Later support for a device with two supplies was added, with
the generic name 'vdd2' to support other devices with multiple regulators.

Using the correct naming would be doable, with the caveat that the old
naming still needs to be supported for backwards compatibility.

