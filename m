Return-Path: <linux-kernel+bounces-54940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C033E84B531
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2572C288D83
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD9A131E46;
	Tue,  6 Feb 2024 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVW8MTOM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FBB131755
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 12:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221839; cv=none; b=GYkUlUikBjFaKs/pwODfv7fLPJ2JzdVPxMhvEEuUgRvDFkQzkVkctK89m/fCf+K/eOnTHMblXbly8P8SZp1NXMQExLmkm7ajtPWN44xtRMAxlFlybJYSxqbPvMwYeBCIjiyxeekUyJ4mo7s2VRXQN8WnQwfo8xlI8FMhk0d514M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221839; c=relaxed/simple;
	bh=Eh9mFJNu3igNOGcLHIfJ7s87Z/Jfy3nVIUd2Y6GgrWc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tfz/pWyW0F0Jjirkb+p8o633JezkKERL6EoN3gNcEL6nvRpQSJnkTnPenIIyURYfwom3ZouerZ/onGcgaCbDNNiSfqNjxPJB/OG4WR2JEcA76vdDOiSvQXVaswbflS/PlTEDumhf/HmlrmGZ7pfMT+GpG8XpRNC7Xu0ZbH1zYGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IVW8MTOM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707221836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nyByeByGBXhgAjdphuIb4bp5J0+ODSHdMi41laNeFU0=;
	b=IVW8MTOMXAxUHsaLbgThxfdyjrOEwaZccAwrJGHcaHeTDyE2sbo0g/He6DUk0qEsL4fWu6
	zkMkiOaCGEkQ2/3+ZzCbtVr4BaAnI2tlDJ7kV7hI1VEYmSmrNs5EZ7wuMzB2DwCiOh288s
	MiqtLwt23Z7eVMfSkR/mcUCkyGtwTzQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-bYgJg8nLOKmDJw9BGgFbSg-1; Tue, 06 Feb 2024 07:17:15 -0500
X-MC-Unique: bYgJg8nLOKmDJw9BGgFbSg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40efaee41dbso4186995e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 04:17:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707221833; x=1707826633;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nyByeByGBXhgAjdphuIb4bp5J0+ODSHdMi41laNeFU0=;
        b=jaGRQzTExyqLVbVhKLBm2ClV2LY6G7EpyQ3doSZtIKtlAxJrHO1PMC+f2AkMn85tnl
         O6CNTqv0XXo+nVb3JXCmWa7yK0wgab0TP4Lj9nhVThLRe3ODWHDjijskjP0pYUZ0EEBq
         cA3PYPs0AStvFhZf7ApsfN0+ivpLiQTNam+SB3Xvuu2ztuvrcJOKDueZmcRx8jTWX9Mt
         JTHIUBEQs5e2Pjar84ZKW1e3xFvi5GZOJKLVT9ExgLR3AGcmP7q8WlHMYuICVyFhGjQ0
         Xvr9zKwDIG0Xbn2zoolec1IXgmUDgShYGYtXW9jQyUg2cV4MIjw2HZHVKhcnoaUFpk0A
         poOA==
X-Gm-Message-State: AOJu0YySf5SLPYd9r4F5z9Xrq/doFThw9Rd4L5yCL16w/R+zfgfRfwAE
	0mGNfegiKEetk4e/RXFQbJLhKEay7amYyzt8VRBiQegfR/BCxvYRuKsm1WKj9jpf5V0MveMrqko
	Xjfv7zhPIloqo86N8SGnNR0pcmY1JpMmG1TCBmRrVPPYQ+VCmFURGfwe+xn1XD7u4GviVFQ==
X-Received: by 2002:a05:600c:35ca:b0:40f:c475:6d36 with SMTP id r10-20020a05600c35ca00b0040fc4756d36mr2054655wmq.4.1707221833439;
        Tue, 06 Feb 2024 04:17:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnHGrchOchhuz+Pp7yLhTONaxbqaPCL/U99EVbjnNpOOGX8G6S0bgBFtfINwI1h7UFF7dv/A==
X-Received: by 2002:a05:600c:35ca:b0:40f:c475:6d36 with SMTP id r10-20020a05600c35ca00b0040fc4756d36mr2054631wmq.4.1707221833087;
        Tue, 06 Feb 2024 04:17:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjjPgJZ/UQU0vb/3Gmvkyfz0i2QDyqRcmRXLcaySw+OBkpmVZUMQ7JrrJPMYoeB/lpPUORoaUpBF/bR/P8R7cvSJRZ86ykxKZ9qZ7xmGYt9b70t4u61hATdOwwUfyoRQGwIAIcfrmLtfBwZiaYsSlnqWp7Y9GXKwzN4K7sVmRCasiAVjWVOy4W0/EsMFCfObY8oC9qn3/ur/GyG/66QJxjYfTsTAdqyfzEzj5N+BZsEHbcHWkTOATJ4fCUXAxGt4iH1uHKG/lFEG2/aXnHwbUcuf0pgJBMfvpBSQifumeJngNSNApsTc+DaAyy70UCraDMsh2WTCu5CgxvBYJEYzmZyCtRugop9V+f67wa/yXntTOFMIIbHnUGKM6N0BsybRG5RIMqTZyfq1BCDLor4cLlLAXZqcL1iXTFC+xBJi98AKWswoxoGQkT0XaW+eD3L38NqRfnBTTDhSCzoHp9php8oYIOBQ==
Received: from gerbillo.redhat.com (146-241-224-127.dyn.eolo.it. [146.241.224.127])
        by smtp.gmail.com with ESMTPSA id y34-20020a05600c342200b0040d5ae2906esm1791051wmp.30.2024.02.06.04.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 04:17:12 -0800 (PST)
Message-ID: <726c4945db02fbb130397131b13132a89697986c.camel@redhat.com>
Subject: Re: [PATCH net-next v7] bonding: Add independent control state
 machine
From: Paolo Abeni <pabeni@redhat.com>
To: Aahil Awatramani <aahila@google.com>, David Dillow
 <dave@thedillows.org>,  Mahesh Bandewar <maheshb@google.com>, Jay Vosburgh
 <j.vosburgh@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>,  Andy
 Gospodarek <andy@greyhouse.net>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Herbert Xu
 <herbert@gondor.apana.org.au>, Daniel Borkmann <daniel@iogearbox.net>, Jiri
 Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 06 Feb 2024 13:17:11 +0100
In-Reply-To: <20240202175858.1573852-1-aahila@google.com>
References: <20240202175858.1573852-1-aahila@google.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-02 at 17:58 +0000, Aahil Awatramani wrote:
> Add support for the independent control state machine per IEEE
> 802.1AX-2008 5.4.15 in addition to the existing implementation of the
> coupled control state machine.
>=20
> Introduces two new states, AD_MUX_COLLECTING and AD_MUX_DISTRIBUTING in
> the LACP MUX state machine for separated handling of an initial
> Collecting state before the Collecting and Distributing state. This
> enables a port to be in a state where it can receive incoming packets
> while not still distributing. This is useful for reducing packet loss whe=
n
> a port begins distributing before its partner is able to collect.
>=20
> Added new functions such as bond_set_slave_tx_disabled_flags and
> bond_set_slave_rx_enabled_flags to precisely manage the port's collecting
> and distributing states. Previously, there was no dedicated method to
> disable TX while keeping RX enabled, which this patch addresses.
>=20
> Note that the regular flow process in the kernel's bonding driver remains
> unaffected by this patch. The extension requires explicit opt-in by the
> user (in order to ensure no disruptions for existing setups) via netlink
> support using the new bonding parameter coupled_control. The default valu=
e
> for coupled_control is set to 1 so as to preserve existing behaviour.
>=20
> Signed-off-by: Aahil Awatramani <aahila@google.com>

A couple of minor nits: you should have retained by acked-by from the
previous revision

> v7:
>   Removed coupled_control from procfs
> v6:
>   Added coupled_control to procfs
> v5:
>   Merge documentation patch with changes patch
>   Add version history in comment description
> v4:
>   Remove inline references from c source files
> v3:
>   Edited commit description
>   Edited documentation description
>   Changed function names
>   Only allow coupled_control change when the bond is down
> v2:
>   Removed sysfs changes
>   Added documentation for new paramater
>   Renamed parameter to coupled_control
>   Update bond_set_slave_inactive_flags() with a 8023ad check

The changelog section should be after a '---' separator, to avoid it
landing into the git history. No need to repost.

Cheers,

Paolo


