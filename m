Return-Path: <linux-kernel+bounces-155092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0D98AE535
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDD07B2770D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77A6135A68;
	Tue, 23 Apr 2024 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhBOmzDs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E08D83CD6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872697; cv=none; b=PPovlnad08eLMkhs5DYAbc7kzU2+H6IglSbBV4YY+Zy1WQpvh9bVjpvPQOtpEJSXxjfM4dM9MvfOuJjD/gcnKiyuHmEe1s87dMa+h6YMv+u8ob9Dko4bEnmgnyFLb9oxzhAsjSUzfm70ZxRSqO8463C8r/T0Ia2OB5+cs5dtw6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872697; c=relaxed/simple;
	bh=xV0c5mBfil10F64nFL3uz0zVoDI8HSRvwXGAPCnbALY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WkW7nvsg7OmmkxH1dEE/hK1b8P65ICPy4n4zZ+MhFX/6JlGvyHWNw7+gCisAQVfDy2wtgOoaMH216rAolcLdjz2kWPhs7jGvlcwfJxuqn2S2xgwXZgjPuv/DZRMMwlaN8SBVLachK0ZkSvNqBXyb5GdgUBmLWGySKlRIHFu+naE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhBOmzDs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713872694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xV0c5mBfil10F64nFL3uz0zVoDI8HSRvwXGAPCnbALY=;
	b=RhBOmzDsXSvFX5xc86ndZQdyMarFOp85/1ABMzStDS53iRoafwwBaVDwbnhLI97zZnJrXz
	lDkHFrEEH5h8nY1DLUSOvIzWcAXF8yQXM4ufr/PWuFKO8nqw6FCFwSyG+PJ5G2Z6ylgCku
	WvBfvz5dMMipyRgs+aubl+JgQpc9pPA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-DZb3-P8TPKCr0FTQtbnkIQ-1; Tue, 23 Apr 2024 07:44:52 -0400
X-MC-Unique: DZb3-P8TPKCr0FTQtbnkIQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-347744e151aso622960f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713872691; x=1714477491;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xV0c5mBfil10F64nFL3uz0zVoDI8HSRvwXGAPCnbALY=;
        b=aFxueMTTzwrN6yJUpAWkct1iAMEVIxarH4jo4hhi5TbX5cFqWncUF46SIo0LkTT5cr
         rbws2HvfIOYqnuggY/uBzCJ4MwqY5uhd5WMt4MWsvdTRtMz9JHOH2lEGRnZiEb65wlWj
         UmKmKA90fJh/pLNIPr6GWfG2r/tiMC5cEDhZ4xg4RifrSYPMj5V1u2F4c45lNMqqJt4H
         B/6u7UGQD8dQzgR0CXjRtldjgL3klnMVj/XbaslZmPpVivgxiVGgxvVd6OlaSiWFHkPS
         cF/Sg/wYXiJObxQiRYg677zh8ttSh0/U9Ir73YtX8EjkZgWFLLaCsvlqv2DNuA2y9fJm
         zEIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgoF1g2BESjWZ0d62/m6I/09l00kglRqawuz+EEVHlCU9fJICoBcpXb9UuJenU5ZzG2uIUh0UuEZ/GczPqHkxO0spgizyBZIC7zKG7
X-Gm-Message-State: AOJu0YxqlnsfdlwzalZAeYlHcAAKOxssoKO/D6SGX9STK3fA/5JBZecj
	isi9NzlUR1VZBXiatbMbF8MPoCuMIJaL0/pNacA8Nx2Co6agy0Zpd/ZLPKBQE/yFcjD8O1DLerX
	GTMwFWHD9knzHPx3OBLq542Dyit6c5XzHPxWBYq/I/E3GLgW392B2aJXKHqLtfg==
X-Received: by 2002:adf:ce05:0:b0:34a:c444:a93b with SMTP id p5-20020adfce05000000b0034ac444a93bmr5437834wrn.7.1713872691706;
        Tue, 23 Apr 2024 04:44:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAgsPKt9SXNKt1KpmO4UGPGC2KrsiDOpatmt2vRqab/9JnRXNEUZjm8o8NWmoZIIrTC0E0yA==
X-Received: by 2002:adf:ce05:0:b0:34a:c444:a93b with SMTP id p5-20020adfce05000000b0034ac444a93bmr5437820wrn.7.1713872691273;
        Tue, 23 Apr 2024 04:44:51 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:172c:4510::f71])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d4604000000b00343826878e8sm14397495wrq.38.2024.04.23.04.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 04:44:50 -0700 (PDT)
Message-ID: <1349286d7f93aabec3b7b43aba9089f96214944e.camel@redhat.com>
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpts: Fix PTPv1 message
 type on TX packets
From: Paolo Abeni <pabeni@redhat.com>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>, s-vadapalli@ti.com, 
	rogerq@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	richardcochran@gmail.com, jreeder@ti.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, srk@ti.com
Date: Tue, 23 Apr 2024 13:44:48 +0200
In-Reply-To: <52c7352f-a91b-3604-5ae0-88d7bb814e51@ti.com>
References: <20240419080547.10682-1-r-gunasekaran@ti.com>
	 <4a92f794480b12c21eaeeeb66521dbe978f08414.camel@redhat.com>
	 <52c7352f-a91b-3604-5ae0-88d7bb814e51@ti.com>
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

On Tue, 2024-04-23 at 16:36 +0530, Ravi Gunasekaran wrote:
> On 4/23/24 3:31 PM, Paolo Abeni wrote:
> > On Fri, 2024-04-19 at 13:35 +0530, Ravi Gunasekaran wrote:
> > > From: Jason Reeder <jreeder@ti.com>
> > >=20
> > > The CPTS, by design, captures the messageType (Sync, Delay_Req, etc.)
> > > field from the second nibble of the PTP header which is defined in th=
e
> > > PTPv2 (1588-2008) specification. In the PTPv1 (1588-2002) specificati=
on
> > > the first two bytes of the PTP header are defined as the versionType
> > > which is always 0x0001. This means that any PTPv1 packets that are
> > > tagged for TX timestamping by the CPTS will have their messageType se=
t
> > > to 0x0 which corresponds to a Sync message type. This causes issues
> > > when a PTPv1 stack is expecting a Delay_Req (messageType: 0x1)
> > > timestamp that never appears.
> > >=20
> > > Fix this by checking if the ptp_class of the timestamped TX packet is
> > > PTP_CLASS_V1 and then matching the PTP sequence ID to the stored
> > > sequence ID in the skb->cb data structure. If the sequence IDs match
> > > and the packet is of type PTPv1 then there is a chance that the
> > > messageType has been incorrectly stored by the CPTS so overwrite the
> > > messageType stored by the CPTS with the messageType from the skb->cb
> > > data structure. This allows the PTPv1 stack to receive TX timestamps
> > > for Delay_Req packets which are necessary to lock onto a PTP Leader.
> > >=20
> > > Signed-off-by: Jason Reeder <jreeder@ti.com>
> > > Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> >=20
> > Please provide a suitable fixes tag, thanks!
>=20
> am65_cpts_match_tx_ts() was added in the very first commit of the file.
> Would that be a suitable fixes tag?=C2=A0

It looks like it is, since such function exposed the buggy behaviour
since the beginning.

> I understand that the purpose of
> the fixes tag is to know to which all previous kernels, the fix needs to
> be applied.=20

Yes, it's used by stable team(s) to filter fixes relevant for a given
stable tree. A correct hash allow to do that automatically.


Cheers,

Paolo


