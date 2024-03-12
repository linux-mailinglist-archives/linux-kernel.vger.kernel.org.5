Return-Path: <linux-kernel+bounces-100057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1491879144
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB7E1F22F17
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A69A79B63;
	Tue, 12 Mar 2024 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/yksnMp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6396C78292
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236591; cv=none; b=SsoZgc6dIHesq1JYf+iRaRKgysKfnrTj1l92f/FdE9ciiLU90Ac5fErCI6ShGzK5DrlcHdIl+pGM6IRubzanVDsos25Nm/geQeWnXTlJBGWfO5uomdw3TgPXHk+dsuHw8gHrx52CiYjgHCFSqE18HAsj2x7zWCWd1HwbheyAzNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236591; c=relaxed/simple;
	bh=5Oe6ifA4nFeRb0AbxHIwpSKGDYpu4k5R/mqNxUNiyjY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oCGY9+ayP0qUueCLlDp5ciAlmIOlXcWhCxcDQmZtB6mYLWCERDrlXJp3+CLGeB3Y0GogmuPyAKvkS4v7+r2xC2Z/IjZek3H7DI2/hifDbcjhc685AJZPP7Cmx6RU1GzWI2kiWob+asEfD/yFMdUQeANZ8ByGmaL5MCGrTUX9SuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F/yksnMp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710236587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zkoU9UJnpw3j31uueFKXitHacYspIFI5o4gY/R2WanY=;
	b=F/yksnMpJUlsIB6L9C2tvHzTjM0krq/viupTJKXxVTUVzzNBi5uAG39e/J8MD6TD1zDKYy
	P0U/d2LeZRXXftvuruQR+VhOK/e16grk4zB/Czjs6kk00EX7ltjXoZluDS42mIAUGsBOIS
	V1wGH7clWBlFMQF9csnRLxQonZtZin8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-hDrV3n4KPqernY3lSquaOw-1; Tue, 12 Mar 2024 05:43:05 -0400
X-MC-Unique: hDrV3n4KPqernY3lSquaOw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-567eb0397e3so1558107a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710236584; x=1710841384;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zkoU9UJnpw3j31uueFKXitHacYspIFI5o4gY/R2WanY=;
        b=PyyE6u9U04lKKMpuiL4zC5PRVZQ98lByQwt3un8kEHGtIfCIf2EOghUMaYswPP1OsW
         wNdRfStQSVMOagFDLAsrhqSK5pPiDnJuaBDJKu0OKH7nnzdNI7OsjQVcT1dHzD51Axev
         QAQmpsa4iweBd6CTJn3rcJiPsgAjgEC/eY3gGQ2/Z3264N0IEHZuerCw1rAFz7Dzfw0h
         TekqAyWbrq+piYZAGCCq+8UpBmSHbaQj9heTKhGKtN7ks+nA4yidrFkUwEj0sX4RPets
         lSuzDHtzcCk8CxmyOk64C4o9oQGIje/6BYYxpZTVTB8jgESuwoylFwNsIhBoIECzD7F1
         oP8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrkDjSfpQ67AvravO7RM0uitkbfFKIkysgg/v15yhMKm4x1avo9V1OlGOCgjR5mV80ZcQI0FyzyP6MrIsXfOwDOBflapu4b0xKZtJD
X-Gm-Message-State: AOJu0YxQqG42u8l1sBSOtPFIXGlne4ywZn2MX1EQDbF1elkYz+MkR9xa
	q3izQMJgZnhkypyzbd9TUNCtNa1cdpi/cb1mio1D7FFhFdxAXOQh03bPF6uHefC7LMjmNarpifk
	jN8EzjphM6XsPAesM3Gd4hmnOeGGp1fGi/MOPr9GGbbpbTK0N4kewYVufDlht1g==
X-Received: by 2002:a05:6402:1bc5:b0:568:3bce:f57c with SMTP id ch5-20020a0564021bc500b005683bcef57cmr4304731edb.0.1710236584284;
        Tue, 12 Mar 2024 02:43:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrtMNt5KP9jeA/ShxRjll7IcncAaRkvIhLs0/ZmGxRVb44bQImgDz/cToA1a9im6aFr3zOFQ==
X-Received: by 2002:a05:6402:1bc5:b0:568:3bce:f57c with SMTP id ch5-20020a0564021bc500b005683bcef57cmr4304722edb.0.1710236583852;
        Tue, 12 Mar 2024 02:43:03 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-128.dyn.eolo.it. [146.241.226.128])
        by smtp.gmail.com with ESMTPSA id q5-20020a50c345000000b00568366e9890sm3994108edb.42.2024.03.12.02.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:43:03 -0700 (PDT)
Message-ID: <9fb980b65b8b4bc7c994cdfa1bac72e3f7c5677e.camel@redhat.com>
Subject: Re: [PATCH net-next v3 1/1] net: bridge: switchdev: Improve error
 message clarity for switchdev_port_obj_add/del_deffered operations
From: Paolo Abeni <pabeni@redhat.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Jiri Pirko <jiri@resnulli.us>,
  Ivan Vecera <ivecera@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew@lunn.ch>,  Eric Dumazet <edumazet@google.com>, Florian
 Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
 Vladimir Oltean <olteanv@gmail.com>
Cc: Simon Horman <horms@kernel.org>, kernel@pengutronix.de, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Tue, 12 Mar 2024 10:43:01 +0100
In-Reply-To: <20240309063238.884067-1-o.rempel@pengutronix.de>
References: <20240309063238.884067-1-o.rempel@pengutronix.de>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-03-09 at 07:32 +0100, Oleksij Rempel wrote:
> Enhance the error reporting mechanism in the switchdev framework to
> provide more informative and user-friendly error messages.
>=20
> Following feedback from users struggling to understand the implications
> of error messages like "failed (err=3D-28) to add object (id=3D2)", this
> update aims to clarify what operation failed and how this might impact
> the system or network.
>=20
> With this change, error messages now include a description of the failed
> operation, the specific object involved, and a brief explanation of the
> potential impact on the system. This approach helps administrators and
> developers better understand the context and severity of errors,
> facilitating quicker and more effective troubleshooting.
>=20
> Example of the improved logging:
>=20
> [   70.516446] ksz-switch spi0.0 uplink: Failed to add Port Multicast
>                Database entry (object id=3D2) with error: -ENOSPC (-28).
> [   70.516446] Failure in updating the port's Multicast Database could
>                lead to multicast forwarding issues.
> [   70.516446] Current HW/SW setup lacks sufficient resources.
>=20
> This comprehensive update includes handling for a range of switchdev
> object IDs, ensuring that most operations within the switchdev framework
> benefit from clearer error reporting.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Simon Horman <horms@kernel.org>

Very minor nit: the reviewed-by tag should come first it that has been
collected before posting the given revision.

More relevantly:

## Form letter - net-next-closed

The merge window for v6.9 has begun and we have already posted our pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes
only.

Please repost when net-next reopens after March 25th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#develop=
ment-cycle

--=20
pw-bot: defer


