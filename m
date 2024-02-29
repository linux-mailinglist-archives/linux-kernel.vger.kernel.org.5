Return-Path: <linux-kernel+bounces-87067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F150B86CF31
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 436ADB2B341
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32C778295;
	Thu, 29 Feb 2024 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fh1o4r5V"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EFD7828B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223628; cv=none; b=A7miJKXhE4ZRScbOAJZLUeV47rp/FsvKB+W/uTdlMd6anCqqEIYeOUQd+eW+jaXIu37cuNOeXAJhUbKuygg2akgqQYpy7yGByGv72en3ptNo9/TP054TJ1MRm02ToppP/E54j5yDYPbxr5OOeK/qwe5oBx5+EsnUzDbCK5ub8ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223628; c=relaxed/simple;
	bh=5akJAYIzzDJf3+0III/J1h+mlaUltOxaG9R8wmii+rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnOrZMWMfXoEfhM3gfbBwDdOootEiJ/PaTZG3Fg1dcDNAjtINLh1gE3IA5bsXwbMzUVe07Uc6A3be9Wbba8uYoIzQkesKGywYGTIcicPT3CotQeu8K8uq8kXRy+vLnBjYn8nn9zG8M4TkjYeiYoktdvqOzJpLwozEYNguWBujBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Fh1o4r5V; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36576b35951so6998315ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709223625; x=1709828425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g8Qq8yPD2u9VlGqCnCi7K91emb+vPhb1JZTph4xZca0=;
        b=Fh1o4r5V3NV6hYmmXDVU/Y9GxmzQ83D5o6s0cyDo2DHoJk1KKmJDqFr2UDN2ZYIuw5
         +fFl6JK1gnZPmrRnL2r7QcPTwpF4NqL2lVd3JndkE95TcMi4NzER0qnmk3LnjG29orAM
         wvdW6KZUuiiIjVKXMiJ+sG91PCzkhW8etUvXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709223625; x=1709828425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8Qq8yPD2u9VlGqCnCi7K91emb+vPhb1JZTph4xZca0=;
        b=Y1NrtlieEjKoOZdJgEGkYm5F1iNFyH3jYI4uLah4Dr4jNtBTl3aQ6VlPN0m/7uddB4
         kcfg6q5hyRElSkMApQRZ1dy7mk+vPTbXvZ+BYQaDrugcR52Fy1RMoVklaPgQSx7waWmj
         2r03Zf4ME52Dbv+CreJuVolc1k7J4/+I8g/ukWPOvXG1+V2YmeBN7YdjpzwndH+6fZpn
         k2fy/jS54hHYA5ppgtfFklCc0+STFIh1uRkduXr993SPakuORcqUbm3cCkdegNjP7xwR
         tzjNubOuaH2qg4PjxDwnNTXn3tuxVTbY9lv29bCFt96LJDha1xvkah32wLxeLRz5Xrac
         Nnhw==
X-Forwarded-Encrypted: i=1; AJvYcCUvhgifaDWviwppBpL2U1Mv/JuYDU1CU+EUakN/VLA5pXi2i/eVAF1URMw7N15ERE1QJI9Suazva+2x4I5mjFwtohGhui3pSbOKM+eF
X-Gm-Message-State: AOJu0YxavjD4BoMp/iFtSDp5W7Pn90KY+ZJFh2l4rDVAajtigVbfOfHE
	ci+D9BpkK5sdh3j353jwjjMkThXmJIYenu+fHzT3cdHb4eeTlAqLXj/yNx99vQ==
X-Google-Smtp-Source: AGHT+IFreo0hr/9MzkZCTngz7lMqfGeDlbi8HZb7O7X2LxBPXUVABjMPoOBmX8meMjGxInCXYjaVSw==
X-Received: by 2002:a92:c7d1:0:b0:365:1749:cae0 with SMTP id g17-20020a92c7d1000000b003651749cae0mr2946229ilk.7.1709223625514;
        Thu, 29 Feb 2024 08:20:25 -0800 (PST)
Received: from localhost (144.57.222.35.bc.googleusercontent.com. [35.222.57.144])
        by smtp.gmail.com with UTF8SMTPSA id s17-20020a92cb11000000b00363d8ee8cf7sm393454ilo.48.2024.02.29.08.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 08:20:25 -0800 (PST)
Date: Thu, 29 Feb 2024 16:20:24 +0000
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
Subject: Re: [PATCH v6 2/9] usb: misc: onboard_hub: use device supply names
Message-ID: <ZeCuyLeC9SBNBkk_@google.com>
References: <20240229-onboard_xvf3500-v6-0-a0aff2947040@wolfvision.net>
 <20240229-onboard_xvf3500-v6-2-a0aff2947040@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240229-onboard_xvf3500-v6-2-a0aff2947040@wolfvision.net>

On Thu, Feb 29, 2024 at 09:34:45AM +0100, Javier Carrasco wrote:
> The current implementation uses generic names for the power supplies,
> which conflicts with proper name definitions in the device bindings.
> 
> Add a per-device property to include real supply names and keep generic
> names for existing devices to keep backward compatibility.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>

Acked-by: Matthias Kaehlcke <mka@chromium.org>

