Return-Path: <linux-kernel+bounces-87061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C466286CEFD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04D60B286EF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E6D6CBE5;
	Thu, 29 Feb 2024 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d+aJNMO2"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BDD4AEF0
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223542; cv=none; b=NK1ztiuF6QEOzZG5D4ocajSrtt6In0NS22OoABXRbJkr2yyysAklfGpTpX3yU65bRmY5i7EskSewMIDUAJa/TWhr6ud5dPkIajSmWCrAgV7g7zBJFb+HHlqLFXOTVrTMLGoHDJE/mUuLrPJx53tbyvC89z82iMB/tl7c+Amc3FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223542; c=relaxed/simple;
	bh=YhuaUfzpQDJP9Vs9GKlifVrtbWHfF96cotaDa7Ud97s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpOZ8PutKtRrGVAexqDrog2ms4OJHX2xAb93dNwS3Z591e5Zaa3UDYdS1dJt6aWs0frJ96TnM2wuh+/2uko58A0GqI8CCMTUMay20KBBvxtwHzpPqz7ZbjJ5lpR21oP9e1rDjwyG3frDT3UQxUb9hn7hSBdIGn9/l4Si4KImR6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d+aJNMO2; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3651b948db6so4247745ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709223540; x=1709828340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iDjcaSL55qXYMAB4NoyOKMuTj/7aaFa6rN5hETeg1qE=;
        b=d+aJNMO2scqiwmjNY5/hcZFF+cPVJJgX2N5qgCud0ot9L/01Mszq8p3B53puztCZvB
         5+o3kQ4fJtgJ28dIAnfB7qr8UJBfSYDHTzHMWCnseafU4mmLFCzj7HugWWfnvwLpnirv
         ND6ytKOb+8jk4i/z81eoYDIO6KIOMzjYSNCpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709223540; x=1709828340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDjcaSL55qXYMAB4NoyOKMuTj/7aaFa6rN5hETeg1qE=;
        b=oixpi6kYNOzn+lpYDfNmA4QAfe5g+7VadPW8ga8r7gfZykh8EZYn18p8mCiHAJ0vxj
         fMfjujt9C3PH/LQydbR4cDgdNCQ7O/wyHVq8+vLePMUvjZWQn3WdNi84hccu6t+fHwh5
         WSrvIPOf8OflTxsvIPLP6StcYYDAiXF2zcvDJU3wEkrTKXOpnsA2lCDUtqDNKQkuflYS
         VIzzLphytYWhyN78646LfXZz5l7r5yAHSbuX0YExzWrL5Jycyd4uAQp6HNA4k1CQlIDe
         KiZMK3h//Hk7o0rTgJyIDHMOqghX5TrMyThw2q5bhM7xP86vnY86sPZkLrDuYfE1hZ9I
         Vbpg==
X-Forwarded-Encrypted: i=1; AJvYcCWa44x/opbat+SXocs+BQESi049tiVMHElM00tLd7IUUspumn41x26G2WV43HGzB+c+myqY2rpn8VC1vFg9CFNN73eBN2e8Hpaxws1/
X-Gm-Message-State: AOJu0YyS6MHvUe1jS7sBUreNrpp/aAa/X0SndSl05MjCCzZ/5k5tYh6I
	+cjxQDNcsNWA03xXnUvcwhzgo7Wi71erGegPpz5G2XWqN9TG46fIrxIgA8YWRA==
X-Google-Smtp-Source: AGHT+IG6SYsudTR8afpmPjLzEt8KXtmaUS4neFhh1HH4JtsY7zddGu+EDbyGNsZuVMQLqJ/dxguupg==
X-Received: by 2002:a92:d404:0:b0:363:c2d4:a365 with SMTP id q4-20020a92d404000000b00363c2d4a365mr2789045ilm.26.1709223540248;
        Thu, 29 Feb 2024 08:19:00 -0800 (PST)
Received: from localhost (144.57.222.35.bc.googleusercontent.com. [35.222.57.144])
        by smtp.gmail.com with UTF8SMTPSA id v4-20020a056e020f8400b00365cdc51c7esm93507ilo.30.2024.02.29.08.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 08:18:59 -0800 (PST)
Date: Thu, 29 Feb 2024 16:18:58 +0000
From: Matthias Kaehlcke <mka@chromium.org>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helen Koike <helen.koike@collabora.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Russell King <linux@armlinux.org.uk>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/9] usb: misc: onboard_hub: use pointer consistently
 in the probe function
Message-ID: <ZeCucidYlrO7f-7t@google.com>
References: <20240229-onboard_xvf3500-v6-0-a0aff2947040@wolfvision.net>
 <20240229-onboard_xvf3500-v6-1-a0aff2947040@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240229-onboard_xvf3500-v6-1-a0aff2947040@wolfvision.net>

On Thu, Feb 29, 2024 at 09:34:44AM +0100, Javier Carrasco wrote:
> Commit 14485de431b0 ("usb: Use device_get_match_data()") overlooked the
> already existing pointer to pdev->dev 'dev'.
> 
> Use the existing pointer 'dev' in device_get_match_data() to keep code
> consistency.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>

Acked-by: Matthias Kaehlcke <mka@chromium.org>

