Return-Path: <linux-kernel+bounces-45038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EBC842ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E0B1C257FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00B612BEAA;
	Tue, 30 Jan 2024 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TGmk8Bnb"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802B21292C2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635606; cv=none; b=qtPgEz0hHo5Hn4kEjFJpo/mMYIISKbTzUi5sBLXq8sJVbGiF1v7UuDbRH0iiJUPd6UIteYGZadoxvGrA6geif4DGPk1xl5GnEsSjBZKACtPZNWXIGqZklrpniCwBvC9E/eONrZxe9suoWWkqvSh4N8NR0pdFKLIK/zjVja/66C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635606; c=relaxed/simple;
	bh=tujS63Z3WTO3HL/gA030RreduT7A4LeLdFjqM6yXNnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivfTIjZmMLHRDXg+22ISe8w48N8sKrmue3NVJhv0lFV6iKi8eez/gT9/OfaUWurPR3jbFJ5AOwLlF+S11yBVQWG+sP9qasyy48+u2dQgT3tt34RDHmPgu9qYG2/CogVnbwDZOe/Ra9zJyrWWrlV0KGb8EBCtYFM5x8uXdp3a4DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TGmk8Bnb; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7bed8fee278so175919839f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706635603; x=1707240403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XHEc5V/RfvIUcDqDPWtfK2Fbm134fj3EfnAyQgIeJsU=;
        b=TGmk8BnbaburrtVf4hxBD9barLu3slCpIOTxK0I4oHi227NxZRGS1T5we2C2WFoANR
         QIpUUJ5kOQiK12Y60RP6iV34x0aeYWLzP79OcH0lVZ9/b4IcHfDnHGZsYcQI28z482fH
         AijkXdIKZCcnaKvzjIm1u7CPEJ+rliuo/1e1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706635603; x=1707240403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHEc5V/RfvIUcDqDPWtfK2Fbm134fj3EfnAyQgIeJsU=;
        b=okiyo8V1LNwHuF130p/l9qkxO/556akoABpN6Xc1iGKF7elPUUWRMzqXe1Eee1Fi5v
         4iqm+Nhsnk8kW1qA5ObPIoWdzbJIWst62f17QljIDB5O96gHDpBqdEd3uU+LLON+4JD1
         9DRKOVSG8JBF5RX9GBdx2HhvR9r/uep7yQUScPM9k3sYW+QPHVmPYys2cYGtM/mpqc1z
         URUCmm5svJtgF2TOLzkkW555lzF47YyZuY8uGIvJwIicfLQo6EUtAizXhRuHDZNa4GhV
         X88Aa7Keoq3gt4iu0sd9rcrl7p1///5RlQCwPf1zkq1R8JBX0IzTtrPcvoE/tVVK+3yy
         qM7A==
X-Gm-Message-State: AOJu0Yx+6DqnoUiVxRwxQhSVXu1iFLii/F5XRfk1mA1AUGvsZoSevZUP
	NgybCgwmV36KPD3nyDDiDdcRZCBvAS43vWsE92iEEOWIKtUuvzSfRUVUp3hs4A==
X-Google-Smtp-Source: AGHT+IFimfDfRCnK1E0ZunAlWv35M1YoVKRH2MzzR63F6QtSUlTwYNRe0SPuAy6cbeJgD5ssxgxk2w==
X-Received: by 2002:a05:6602:1249:b0:7ba:c1d9:7664 with SMTP id o9-20020a056602124900b007bac1d97664mr8268582iou.20.1706635603591;
        Tue, 30 Jan 2024 09:26:43 -0800 (PST)
Received: from localhost (110.41.72.34.bc.googleusercontent.com. [34.72.41.110])
        by smtp.gmail.com with UTF8SMTPSA id k28-20020a02335c000000b00470e7cd33acsm135832jak.27.2024.01.30.09.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 09:26:43 -0800 (PST)
Date: Tue, 30 Jan 2024 17:26:42 +0000
From: Matthias Kaehlcke <mka@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Javier Carrasco <javier.carrasco@wolfvision.net>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: misc: onboard_hub: add support for XMOS XVF3500
Message-ID: <ZbkxUlFSKlUkcHaC@google.com>
References: <20240130-onboard_xvf3500-v1-0-51b5398406cb@wolfvision.net>
 <20240130-onboard_xvf3500-v1-2-51b5398406cb@wolfvision.net>
 <ZbkfsVr-1pOTa1ic@google.com>
 <2024013024-borax-enjoying-beb5@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024013024-borax-enjoying-beb5@gregkh>

On Tue, Jan 30, 2024 at 08:19:40AM -0800, Greg Kroah-Hartman wrote:
> On Tue, Jan 30, 2024 at 04:11:29PM +0000, Matthias Kaehlcke wrote:
> > Hi Javier,
> > 
> > I understand your motivation for using the onboard_usb_hub driver
> > for powering up a non-hub device, it feels a bit hacky to use it
> > as is though. Re-using the driver might be the right thing to do,
> > but then it should probably be renamed to onboard_usb_dev (or
> > similar) and do the hub specific bits as special case.
> > 
> > Greg, do you have any thoughts on this?
> 
> Yeah, this worries me, adding non-hub support to this driver feels odd.

It is odd as long as this driver claims to be hub-specific, but truth
is that the hub-specific bits are a small part of the driver, I think
it might be worthwhile to consider adapting the driver to other devices
if there is no clear better solution.

A possible alternative could be a separate onboard_usb_dev driver for
non-hub devices, with a similar structure as the onboard_hub driver,
but without the hub-specific bits.

> Why can't this all just be done in an individual driver for this device
> itself?

I suppose the reason is the good old chicken-egg situation that the (USB)
driver is only instantiated after the device has bee powered on, which is
what the driver is supposed to take care of. For the onboard_hub driver
this was solved by having a platform driver that is instantiated by the
parent hub if the onboard hub has a device tree entry. Probably something
similar would be needed for an individual driver, and the generic hub
driver would have to call the equivalent of onboard_hub_create_pdevs()
for all drivers of this type (or a wrapper that does this).

m.

