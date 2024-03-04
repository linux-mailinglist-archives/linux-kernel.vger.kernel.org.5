Return-Path: <linux-kernel+bounces-91297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FC0870C74
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0092A1C24BD8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B01D4086B;
	Mon,  4 Mar 2024 21:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDNv2tss"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B8A1F5FD;
	Mon,  4 Mar 2024 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587493; cv=none; b=QxAK6OGo4w1bBIdOv0fWwoG+CgRlkaTx0DAQLreDKob6OMsjRm3Lz0UjvgRNDlKpCzBl6CrhRSTRnVxwg+hYUlzl+r/tJIzkhAxUuJSaw6Oua8xPM9Aodyo+E9niOpgmb9VuE3Gw9OGK98W3QDSi/vLXdiYFQM1+z3LHPGfXlfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587493; c=relaxed/simple;
	bh=GCATK6oSIl6USFFqC/CxN7o9XWA+S9y2ORbBrX3q6D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wmz0jALnhae9X9FR3OvKW8e3kOhX/aIUkSSu0Lrn3mCIXdiFWdOBdVduTrdDdf9x6Ply1DQsacF0BVH67uqxjB5wfr+zb8eLpfyXqwAXgQKC0v8uf3qF3PyBUAfHe28y3yH3/RvM0dBqNcmK92d+FnpsK9GYufGOuFEmns7XfRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDNv2tss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8EBC433F1;
	Mon,  4 Mar 2024 21:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709587493;
	bh=GCATK6oSIl6USFFqC/CxN7o9XWA+S9y2ORbBrX3q6D4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZDNv2tssnLutTbFa6WyGdwustA4QBnMEu+28wfPUMo8UNbH7x/MrrHWTsx7jUSH5Z
	 V4CJ06PkqW0wuMHZ8pqttIE/qrZ/x44WPTlFEJwiVG8dOO24EMkqPvYD+IKV4GZVie
	 Roo7g86uMFOT1N9XHiL4cYPEFT6Kuwj+ZQ1vBnpLkDWaU63Mvz6Jhl68f/CpCqlc6r
	 ZyLqOSTH84Yure/F/MqxK///OW/RM+98OcmotAdR990IgQ7biJM64boHyCEtNU0wJX
	 AgoK8A5P3tEtDHg4OjgwsniRYohrj8FID/DHQ4H1y8hJ+NBIFa4C4WQebR7K6hO/rH
	 ZXjuy84CFAd1Q==
Date: Mon, 4 Mar 2024 15:24:51 -0600
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: =?iso-8859-1?Q?J=E9r=E9mie?= Dautheribes <jeremie.dautheribes@bootlin.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Yen-Mei Goh <yen-mei.goh@keysight.com>
Subject: Re: [PATCH v2 0/3] panel-simple: add support for Crystal Clear
 CMT430B19N00
Message-ID: <20240304212451.GA1056406-robh@kernel.org>
References: <20240304160454.96977-1-jeremie.dautheribes@bootlin.com>
 <20240304-drivable-property-feaeba782880@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240304-drivable-property-feaeba782880@spud>

On Mon, Mar 04, 2024 at 07:29:04PM +0000, Conor Dooley wrote:
> On Mon, Mar 04, 2024 at 05:04:51PM +0100, Jérémie Dautheribes wrote:
> > Hello everyone,
> > 
> > This patch series add support for the Crystal Clear Technology
> > CMT430B19N00 4.3" 480x272 TFT-LCD panel.
> > It also adds Crystal Clear Technology to vendor-prefixes.yaml.
> > 
> > Please note that unfortunately there is no public datasheet available
> > for this panel.
> > 
> > Changes in v2:
> >   - add link to the Crystal Clear Technology website in commit message, as
> >   suggested by Conor Dooley and Neil Armstrong.
> 
> You forgot however to add the acks that I gave you for the two
> dt-binding patches.

I was wondering why my scripts said this was already reviewed with that 
missing. Turns out b4 will now check prior versions and add the tags as 
long as the patch-id matches. Neat, but the submitter really has to 
grasp how that all works (knowing if the patch-id changed) as well as 
the maintainer has to use b4, so we can't really rely on it.

Here's b4 debug log:

  new message: 20240223-subtotal-aground-268d135adeff@spud                                                                     
Running git --no-pager patch-id --stable                                                                                       
  found matching patch-id for Re: [PATCH 2/3] dt-bindings: display: simple: add support for Crystal Clear CMT430B19N00         
  new message: 20240229-woven-lively-1d90687b2d03@spud                                                                         
  skipping reply without trailers: 20240229-woven-lively-1d90687b2d03@spud
  new message: 20240223134517.728568-2-jeremie.dautheribes@bootlin.com                                                         
  skipping non-reply: 20240223134517.728568-2-jeremie.dautheribes@bootlin.com                                                  
Analyzing follow-up: Re: [PATCH v2 0/3] panel-simple: add support for Crystal Clear CMT430B19N00 (conor@kernel.org)            
  no trailers found, skipping                                                                                                  
Analyzing follow-up: Re: [PATCH v2 3/3] drm/panel: simple: add CMT430B19N00 LCD panel support (mripard@kernel.org)             
  no trailers found, skipping                                                                                                  
    adding "Acked-by: Conor Dooley <conor.dooley@microchip.com>" from trailer_map to: [PATCH v2 1/3] dt-bindings: Add Crystal C
lear Technology vendor prefix                                                                                                  
    adding "Link: http://www.cct.com.my/" from trailer_map to: [PATCH v2 1/3] dt-bindings: Add Crystal Clear Technology vendor 
prefix                                                                                                                         
    adding "Acked-by: Conor Dooley <conor.dooley@microchip.com>" from trailer_map to: [PATCH v2 2/3] dt-bindings: display: simp
le: add support for Crystal Clear CMT430B19N00                                                                                 
    adding "Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>" from trailer_map to: [PATCH v2 3/3] drm/panel: simple: add
 CMT430B19N00 LCD panel support                                                                                                
    adding "Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>" from trailer_map to: [PATCH v2 3/3] drm/panel: simple: add 
CMT430B19N00 LCD panel support                                                                                                 

