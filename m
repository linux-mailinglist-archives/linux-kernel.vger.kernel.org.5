Return-Path: <linux-kernel+bounces-102104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28A687AE70
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A063283AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6445B5B03A;
	Wed, 13 Mar 2024 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XyIvhhVH"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FCD5A10F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348593; cv=none; b=SaycTAtosSt5o6sWLHOJb5c8dSug//ePLuD4yml2Bfb/tsVjW/TKKq/5wkxyGqfoKPztfts0Xo+1B6Ev0NSRKZtRfdMHUU87Nev+vgoJqCX0ajzAtQrCXbYMf+CF9FciHBqvAbd4HXGHwvPsgHWbW9K+nfhx8gZcLeqRr9v1JlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348593; c=relaxed/simple;
	bh=hPL3zw5JCqO9Uf0fSyTYE74YPTyUk0Giy5TIIbo6qF4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dt1AR5d7MWM4Vb4XFkSK7z1I8XdkbE0Vl0c0jQgaTRxTwD35KaaUCYleJA7Q6AZcZAgnYkya/29aAd1SJO0q7EXTlYKJonQbTEco4G7dOYK7AOTC63+vOGlxzj1Hm0DQVdslgWaYh8jzMj9uSOn2iD8tkxbWx/Dn5HhjWq1Hg7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XyIvhhVH; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5682360e095so48318a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710348589; x=1710953389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPkIANYlnqpJGOaQz5GtJSLehMlH+HibJAm6EUdPbkE=;
        b=XyIvhhVHlKZYnacQWGKlDtD3CMP6ZTq6capZFpjAY18Bcr8SCaEdTKWnL8aPI/NMn4
         yBLrKZOtaMRoRRMT31YTrY1kIDgpppyKPF0HDCGeGgFgNANk/1UGjvBkmUBfYxIh7o2B
         4V8wmTWqq1ibX8iDzyxyu3q1eqD5OyZ7scSSvkS3dk3UG2rOXp+N+Trmc4yNMf/FLmzc
         pE3feMENX4iueUAOP8WUmVUMX8sjvM7FoSL1h/a82D51MiAX6f0nAVcZP7GT+ktkc08F
         w3rWI3rRqwUfnN7DYNnicnXJyGj9p+G2mMlb0bG5PPfwKdj2tzNanajJcFXWOgmpyyz1
         BywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710348589; x=1710953389;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QPkIANYlnqpJGOaQz5GtJSLehMlH+HibJAm6EUdPbkE=;
        b=tx1doOfkkxHBpw86ATwovvxaWBqdlPrVBItspWkSF2+V1El9Libk5S98aYgqz3lTjT
         PxI6WKT0DwvGiP/TmEhhK5YblP54CtBB2KbR7HkTU+kTF2kOLS9av3JiwccxqeVUiIYH
         ZpZqDy0HVppVROYo2t45W4Hlvy0BL/RaXo7ZugRfZXPZpVzsm7HguLZGLNdtm1vpagNa
         Yaitj7k10sl6vTl5zqI8n6a+s88Bs+Cu8pOnJSxD9BgQYNSaff05aQSSjRGRwETzfM6S
         sD7SrozFtAaUpdVTqMB+/3IBHe19Knn9EkMOC0Ru/atbky4vMC3pp/7vVtv3yU6ZoElb
         n26Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGN0VITZjrkSwYDKlkxdTBqN7saAB/T/QuJJO3iAC0wQbL3O9K9KwVJWPP+na2jag9ANlyE3QbRp33CohUG69pKBTPR7qtem/Wd82S
X-Gm-Message-State: AOJu0YwwBRSuht5i+T9hhfWE2GfxmDhJ1Jp42/AXDwTpkcBO7jKHwST9
	3Yw5XZcSn7AQuOf74NUseSyKJZe7U7fnF9a/wGLZfIaIC62vME4v20uBeiF7ZkE=
X-Google-Smtp-Source: AGHT+IGqIboO89JDdz68otiTxC7R5thbY+dJhwJvuyQri1Y0mW+DslANVakowZJW0e4mX3PczuljcA==
X-Received: by 2002:a17:907:a644:b0:a46:134c:ae8c with SMTP id vu4-20020a170907a64400b00a46134cae8cmr9631602ejc.50.1710348588653;
        Wed, 13 Mar 2024 09:49:48 -0700 (PDT)
Received: from localhost (host-82-56-173-172.retail.telecomitalia.it. [82.56.173.172])
        by smtp.gmail.com with ESMTPSA id bn23-20020a170906c0d700b00a462e4d7216sm2787595ejb.76.2024.03.13.09.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 09:49:48 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Wed, 13 Mar 2024 17:49:47 +0100
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Saenz Julienne <nsaenz@kernel.org>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	dave.stevenson@raspberrypi.com, Phil Elwell <phil@raspberrypi.org>,
	Maxime Ripard <maxime@cerno.tech>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Dom Cobley <popcornmix@gmail.com>
Subject: Re: [PATCH v2 01/15] dmaengine: bcm2835: Fix several spellos
Message-ID: <ZfHZK8fb8m41t9UF@apocalypse>
Mail-Followup-To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Saenz Julienne <nsaenz@kernel.org>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	dave.stevenson@raspberrypi.com, Phil Elwell <phil@raspberrypi.org>,
	Maxime Ripard <maxime@cerno.tech>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Dom Cobley <popcornmix@gmail.com>
References: <cover.1710226514.git.andrea.porta@suse.com>
 <f57e15192166d696aca23804f8ac79dfe81fd399.1710226514.git.andrea.porta@suse.com>
 <831fee14-387a-41d9-8dfc-e3ba09a140b1@broadcom.com>
 <ZfHFiHdAeXgoNHNk@apocalypse>
 <886b0def-7884-4780-8b7f-e29bf3d9ce7d@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <886b0def-7884-4780-8b7f-e29bf3d9ce7d@broadcom.com>

On 09:38 Wed 13 Mar     , Florian Fainelli wrote:
> On 3/13/24 08:26, Andrea della Porta wrote:
> > On 08:00 Wed 13 Mar     , Florian Fainelli wrote:
> > > 
> > > 
> > > On 3/13/2024 7:08 AM, Andrea della Porta wrote:
> > > > Fixed Codespell reported warnings about spelling and coding convention
> > > > violations, among which there are also a couple potential operator
> > > > precedence issue in macroes.
> 
> and s/macroes/macros/

right, sorry about that...

> 
> > > > 
> > > > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > > 
> > > There are no spelling errors being fixed in this commit, this is purely
> > > stylistic and conforming to the Linux coding style guidelines.
> > 
> > -	/* detect a size missmatch */
> > -	if (buf_len && (d->size != buf_len))
> > +	/* detect a size mismatch */
> > +	if (buf_len && d->size != buf_len)
> > 
> > Isn't 'missmatch' a spelling error? Maybe I can drop the word 'several', since it's
> > indeed only one...
> 
> Can we agree this was easy to miss when 99% of the changes are stylistic?
> The summary is that the commit subject and the message are not describing
> what this patch is about.
> -- 
> Florian
> 

I agree with you that I could've added '...and coding style fixes' to the subject
(while also dropping 'several').  The comment seems fine enough though. Maybe
you're suggesting to separate the patches into two, one dealing with spelling
errors and the other with coding conventions?

Many thanks,
Andrea

