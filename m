Return-Path: <linux-kernel+bounces-83803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28A5869EAF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972BD28B5A5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF761487D7;
	Tue, 27 Feb 2024 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eyUIl0H7"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE20145FE6
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057567; cv=none; b=B1QUY9NxC7zUFyACfGjtrheRPvK3qu53cyvCky5rkDbBHJ2ux1RLG6xeHS4l5sM4VrST+NN/uOpJnXDlhfQZnkKvgKudICbe7jR8alBTe9bMibK+Lt37b3k4VuPsmaMPlHxnYUIuYG9cB8uecRen5wQkmYqUV+UhyWM/G551YT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057567; c=relaxed/simple;
	bh=cg9qu1nZlxnC68Ueeoocn/P6r5hs5t9MDoe/bzmk888=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R51450x7kCjzUFLN0SkykrAoDAWxQB48KbUMc9p7WeO9SUYtYN2hxt3fWjLq2ttMTwGxJk3wurEagKss86i+1akIUbB48I/MECZnWbD4tz6QoFtnE+Qk3hdvT36dwadWoKsTnvOan0Ly/ScBsi3SH9ahntVDiO4mmDs0VJGqQcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eyUIl0H7; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-365169e0938so132815ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709057565; x=1709662365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9xo3DafYnz7qDd1iyNarBE0C+acGQnxfRXgU4VP6u+M=;
        b=eyUIl0H7ncs3ylQqTu0mSwGbC82HxXtlkyrkqFfGcpyR2+v3Btg6IxUiNmsjjX3n3u
         XVK1keJtroTd/pSf1TVj58vuG3el2WjFuos4d/z1+qCNkdyB7dxdget3J41HlqPdLx7P
         aJTrDFzRIouwfVNPGPxRo+oToe/7+a9UBOdQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709057565; x=1709662365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xo3DafYnz7qDd1iyNarBE0C+acGQnxfRXgU4VP6u+M=;
        b=vnAbcGr/hPGftjMf8R/cJbNHJag5X9GfP/l77sDNFKot9bMJdR6mFnkpmQgZPOdTLX
         YYXjTDT7Z8/Tp8JmhMeETm0svckEiAkLCBFRQC3uYN1lv7vJ+hsGPvMzOTyPVYGeD/2U
         G1yzZMKF0JzAiVDZk+sGFwrQPGDfj8xYP35zEYGb/N1fRe7LmFuSt1JVT62Jystxzmdk
         M8WSUF7R60tTjorUmnCrsEVbzpjgO2sZTPxUrjBo9ZxfM0zaMj6GxyN1vX+j/78x7TNf
         8EjNVnz9t1JlZHFa6bfeOLi4VOT0Lo73c9lw2Wg8F0mN5+7Zl4xpUKazoyh1+8d7Bb4z
         MLkA==
X-Forwarded-Encrypted: i=1; AJvYcCXD8YEiMuKe0lRFQNmXFpgmecXNU/jh9wdb2hB+IP1zS1kdYGXbsu8hE7w9Qat/hhPbbU4s4qBYi7VITrIJuQAG9qXSy+mEjfPii8u5
X-Gm-Message-State: AOJu0YyIw8/3lPtb5S68t8hRDNvws81mRAq2G+A5JGJBy0OY7sZxN45p
	o1AZ6KejhNu1UxygsOwKF7ijyd7tzzSnppXLjHJaAGf29s6wDvGPphtH2a3B1Q==
X-Google-Smtp-Source: AGHT+IGjrhhbq3O4yJbGQNPJHVvQDH/cLI79okVS/czvt6vJUsosc4jtEJE++l5mG9grtKNLuUoKMw==
X-Received: by 2002:a05:6e02:1aae:b0:365:b00e:c3cc with SMTP id l14-20020a056e021aae00b00365b00ec3ccmr105566ilv.2.1709057565143;
        Tue, 27 Feb 2024 10:12:45 -0800 (PST)
Received: from localhost (147.220.222.35.bc.googleusercontent.com. [35.222.220.147])
        by smtp.gmail.com with UTF8SMTPSA id br17-20020a05663846d100b004742452a382sm1963310jab.45.2024.02.27.10.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 10:12:44 -0800 (PST)
Date: Tue, 27 Feb 2024 18:12:44 +0000
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
Subject: Re: [PATCH v4 6/8] usb: misc: onboard_dev: use device supply names
Message-ID: <Zd4mHOEs6tHELUXl@google.com>
References: <20240220-onboard_xvf3500-v4-0-dc1617cc5dd4@wolfvision.net>
 <20240220-onboard_xvf3500-v4-6-dc1617cc5dd4@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220-onboard_xvf3500-v4-6-dc1617cc5dd4@wolfvision.net>

On Tue, Feb 20, 2024 at 03:05:50PM +0100, Javier Carrasco wrote:
> The current mechanism uses generic names for the power supplies, which
> conflicts with proper name definitions in the device bindings.
> 
> Add a per-device property to include real supply names and keep generic
> names as a fallback mechanism for backward compatibility.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>

For v5 you could consider making this [1/8] (i.e. before the renaming
of the driver). That way support for new hubs doesn't necessarily have
to wait for the entire series to land. Since this series is underway
I think new bindings shouldn't use 'vdd-supply' but the device
specific name of the supply.

