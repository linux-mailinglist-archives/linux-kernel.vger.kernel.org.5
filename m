Return-Path: <linux-kernel+bounces-95363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97045874CBD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF7C284618
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9C585650;
	Thu,  7 Mar 2024 10:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZhsPLU9N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2AD125DC
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709808818; cv=none; b=bOcEv74uFykquWpeIncF11XxtDHqsiHMqGQtV5rHWgQxEDjz7YM9BtNpQz6B/uMB+aW8wD+UEFqVSsoWLB79Uc1JJPNwt/3zz4JUUPOgAqP+scx5b5OEEPY1ec/t3lQ88Uj7lRumiu6PsR7clBIw9ZICzuhxAdXr/7xNnziPOo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709808818; c=relaxed/simple;
	bh=lq4R6tXCFsBbARiuRwZoE/2ztQKLbBR6UmN6e1OWWfM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fqSpmZLC7SkfEILxrlqIhS7NROJOKNghyhazBtkGMgIqN7gBLozVoQRWMGi9ycmAngTlP0dbRJUUwofS7ehPHQ0BeAzG06V8RG5kEOvFrVSgKZGPc1TJynR1qpZUNmZjbxnGIFOgFNkq8S1SDPPDgQfP23/C18i/SVTt1veV8l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZhsPLU9N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709808816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lq4R6tXCFsBbARiuRwZoE/2ztQKLbBR6UmN6e1OWWfM=;
	b=ZhsPLU9NAKURaUct9/7LS3sNwu7AkJECg895UT8XuWt2DONBJTRexelskN8W9iuy+VAN9/
	6vJf4iXkEJoxZ4OschON4JNhqI19w7P1JqSpyIZM5ctotxwy97vpb11VzLh4Pwzg2pOQAO
	1ccMHJsnCUArf5rYsgyCZwkExedq4+Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-n0BKqU5MOJS-X4kyIJo2_g-1; Thu, 07 Mar 2024 05:53:34 -0500
X-MC-Unique: n0BKqU5MOJS-X4kyIJo2_g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33e69db74d9so74420f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 02:53:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709808489; x=1710413289;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lq4R6tXCFsBbARiuRwZoE/2ztQKLbBR6UmN6e1OWWfM=;
        b=loGYT+o0cLNICCA+yxoamhmBYiM++L7qqLHSDh5wQRYXn8CLma/KOsGFhVkHkc5IKO
         5qE+/ubf8DUjwyfqbl0zMc9wA1zJ9xziswbfb1nlhG+M+Gnh/zh2z/zIMr/hb1LpNxh2
         97KUWTwoi8+EeyYD1QRSr+kVfWaUnR/9/jOu1892mdcTfTyO9t3HcIxXI/pVRzR57qBZ
         2/udieJt/Lr7jbu3A+LXPHFC4gpJ7KmgoYSN5gEK1KaJmbzhMZ3nQteSp7vRcgQM3ny4
         sxpTZQ2N8uhvipKWkSVO8J6lWHoTxGqLkEuku2SkEb54LaRgAUerw2raHmuJa5vnnvSR
         atUA==
X-Forwarded-Encrypted: i=1; AJvYcCUCNBCiYCTLP1JV1LHBETKQdHO/sewPkBZqUUZGVfIXMS9BT6L/ebCd5zcNbcxESBNib68+ZzjLcooOsKpaccOB0s8Ln2cos5vMur92
X-Gm-Message-State: AOJu0Yw/rRzBoB7FdvLn17Rf8QQeYfTUDH/FFtUhGBAm8vcNGMsRJSON
	TEo3GFj4fUgeZQh+o6IhVjnNCHVCSu0oKltXWDU/1UPVjgOzqm5iYEfgS2MKXyf+D1G3ev0GRLJ
	1u20XPvBW+VYCXXwBm2RhNZU2b2VJtFHsUYuJI3CsTxo+UEnwynBLnE0ks/BFMg==
X-Received: by 2002:adf:a3c2:0:b0:33e:65ea:cb8c with SMTP id m2-20020adfa3c2000000b0033e65eacb8cmr722272wrb.7.1709808488849;
        Thu, 07 Mar 2024 02:48:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2KWLJ6eTrzXB1p8eE7+S12r0SRoXLGO1mUdVY+ozSRTac+V2215KF9CW1sYp1Osn2mS7xgA==
X-Received: by 2002:adf:a3c2:0:b0:33e:65ea:cb8c with SMTP id m2-20020adfa3c2000000b0033e65eacb8cmr722257wrb.7.1709808488468;
        Thu, 07 Mar 2024 02:48:08 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-235-19.dyn.eolo.it. [146.241.235.19])
        by smtp.gmail.com with ESMTPSA id f15-20020adffccf000000b0033dedd63382sm19985966wrs.101.2024.03.07.02.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 02:48:08 -0800 (PST)
Message-ID: <f44c6961c6585711d72c59da971c17d26c54c7da.camel@redhat.com>
Subject: Re: [PATCH net-next v3 1/2] doc: sfp-phylink: update the porting
 guide with PCS handling
From: Paolo Abeni <pabeni@redhat.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
	 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Russell King
	 <linux@armlinux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
	Kallweit <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Date: Thu, 07 Mar 2024 11:48:06 +0100
In-Reply-To: <20240301164309.3643849-2-maxime.chevallier@bootlin.com>
References: <20240301164309.3643849-1-maxime.chevallier@bootlin.com>
	 <20240301164309.3643849-2-maxime.chevallier@bootlin.com>
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

On Fri, 2024-03-01 at 17:43 +0100, Maxime Chevallier wrote:
> Now that phylink has a comprehensive PCS support, update the porting
> guide to explain the process of supporting the PCS configuration. This
> also removed outdated references to phylink_config fields that no longer
> exists.
>=20
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

FTR, this looks sane to me, and I think we should merge the series,
unless someone from the phy crew bark soon ;)

Thanks,

Paolo


