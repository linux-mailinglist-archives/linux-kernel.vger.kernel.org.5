Return-Path: <linux-kernel+bounces-55233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D907284B96C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764E51F231FA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1151A134CCA;
	Tue,  6 Feb 2024 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G+XBZfa0"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9706134753
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232946; cv=none; b=cXhY7j1PGo01FRwsMUASQNkeaJbyf6nJL5eQ95nJLUOfb9bphwF3x9gakt+G0qnt5CCFeFL5WJiOVNLaJm2A2h7K9UNNWf8o5LCqlVPu6iOJyiz6gEwIKCBQeeVNu0FsTi2PHDHF5yJAVKIh1MSNOuJS+9RLmiv0jTlptppmnY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232946; c=relaxed/simple;
	bh=nvJry5XMvOGWR4v6LHIjeh7txW2SFojhPzOYPJtGQR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2k972mklasK8skBJtXEW95zV9Is0jlfvtGaSBKUnrZQ+iVl2QLFtajOBDfGD46YWkDS/IyV3/AnFOBm3GDQEpIM/WXjCf1tZReYnMe0v1GP3pYanTahxC/u3soWgrGFVdizq381kzkYZFHFRJ41JArwVKitjxmQBMqLLSyyMbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G+XBZfa0; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7c3dda2a76eso35821339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 07:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707232944; x=1707837744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W7Flz4v7O5pMtKrdNKsWuyF1XlOrY9AWIcQRQ7rMTsk=;
        b=G+XBZfa0qhFEtTJYcSUZiK8QQXw7edU4kF2TgAXcuX4zznwZ6cNRwMxdCJREamUCux
         14jrNkDweTXDFl6sBprm6330YgX4N4TaiYAQMisY7t42Jnn2LzYmDEoFPyQiAdKHZGA1
         QZc5XQ0nGKVhX9xvTyELi/gnHUmTdlPuHvOsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707232944; x=1707837744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7Flz4v7O5pMtKrdNKsWuyF1XlOrY9AWIcQRQ7rMTsk=;
        b=gnM/7CZTHn+qx00sBLlp01AafMr/+mZoby/CCaJKQBULj9B/NvHzDN3Wej+wiQ2D3m
         nSFh6/8UXmn1SGjSa9HMfXHa0uVZ8Hm6T/MKtKwPj6JgEUDWbbq/MWdfiuGQ4OlpXf7V
         M4TyOllF3XjL867Lplrs2DNIkay6QFBAPt+zYx9+0lH8WPxGB6X9Eyg9VdftGEXZcboe
         2yOGSYiL+iw1sSiJoB4KMC6jZwipJjAafGoc5oIOCtFyyae2VRPd7+xZpuoSkzPcQiKS
         vI0o10KTlUrLktn1LLUdOuBsQKYYyUSh22SS3YnmgYz4IxaOG1rky3Wox53mXgt5c/ny
         Fp1A==
X-Gm-Message-State: AOJu0YyjcvvAWGR/KqRs7oiXu+JgXvKS0EQ/uc1g9Jzy3M75mZJWFN02
	/dueD4ZES6s1mD5PoHWf7QCDthgpzmGK/JcnIGJMDcSxONFkExJtAISMOJq6jA==
X-Google-Smtp-Source: AGHT+IFt8q7waVjwHUEsyUKsyJ5E3OYGC68VOhih9cdX2E35mExkKRqYgj2KVdzABWDIhUKRGNZtpg==
X-Received: by 2002:a6b:7319:0:b0:7bc:3ceb:6552 with SMTP id e25-20020a6b7319000000b007bc3ceb6552mr3404257ioh.5.1707232944013;
        Tue, 06 Feb 2024 07:22:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX3CFmAG2qqDVjX7edvfHDozcYjd2Q9/kfUUXMnd1crgQxL+I8zeu7ZXzFWWo3l3A2LGuQcM5Uqp98cp1vXEkhvqTxGTZAKW6JuHi3LpkSjp4SLrx7Nxu2eNswYr4dDmsk24feSSYQrGwuA7ZixROi82WAljuN+NgIOh7gSkhJiok3cha9BhLGWq8quRNKxEO6PDPWf56czAJayyJDhWp9t2jrkT5uwFzMMhZYLylqafnHvt15fN6N4bmGE8v49Vjje34dI2csBOc8qFRawQ8DNC1Bul8ZziZs3FIgmoeoFCRGIkOTWWz8bi3PpBxf1tNKqta3C5gbkD7iNMFN2yUwsvTRXOCsaP3eaE0rCmp1jdQgH8iYIM7R0LLXsfqwfvgk5yumrelfeqb6XH7Ve
Received: from localhost (147.220.222.35.bc.googleusercontent.com. [35.222.220.147])
        by smtp.gmail.com with UTF8SMTPSA id q17-20020a0566380ed100b004713f0fbe4fsm451881jas.75.2024.02.06.07.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 07:22:23 -0800 (PST)
Date: Tue, 6 Feb 2024 15:22:22 +0000
From: Matthias Kaehlcke <mka@chromium.org>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 6/7] ASoC: dt-bindings: xmos,xvf3500: add XMOS XVF3500
 voice processor
Message-ID: <ZcJOrvmbukDubcuM@google.com>
References: <20240206-onboard_xvf3500-v3-0-f85b04116688@wolfvision.net>
 <20240206-onboard_xvf3500-v3-6-f85b04116688@wolfvision.net>
 <ZcJDFi+iIQOWzgYw@finisterre.sirena.org.uk>
 <7b472cb2-6658-446a-ae47-411d08798cca@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7b472cb2-6658-446a-ae47-411d08798cca@wolfvision.net>

On Tue, Feb 06, 2024 at 04:05:15PM +0100, Javier Carrasco wrote:
> On 06.02.24 15:32, Mark Brown wrote:
> > On Tue, Feb 06, 2024 at 02:59:34PM +0100, Javier Carrasco wrote:
> > 
> >> The XMOS XVF3500 VocalFusion Voice Processor[1] is a low-latency, 32-bit
> >> multicore controller for voice processing.
> > 
> > Acked-by: Mark Brown <broonie@kernel.org>
> > 
> > though...
> > 
> >> +  vdd-supply:
> >> +    description:
> >> +      Regulator for the 1V0 supply.
> >> +
> >> +  vdd2-supply:
> >> +    description:
> >> +      Regulator for the 3V3 supply.
> > 
> > ...it's a bit weird that the supplies are named like this, usually
> > there'd be some sort of meaningful name (even if it's just VDD_1V0 and
> > VDD_3V3 or something).  Are you sure these are the actual names?
> 
> The names in the datasheet are vdd for the 1V0 supply and vddio for the
> 3V3 supply. I named the latter vdd2 instead because this device does not
> have its own driver and instead it uses the onboard_usb_hub generic
> driver, where the supplies are named vdd and vdd2.
> 
> Those are the names used for devm_regulator_bulk_get(). Is that not the
> right way to match them?

If desired the driver could be extended to support device specific regulator
names through struct onboard_hub/dev_pdata.

