Return-Path: <linux-kernel+bounces-92335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB883871EBA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80E7A1F237B5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF3F5A4E0;
	Tue,  5 Mar 2024 12:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzVCvSui"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606BC5A0FA
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640861; cv=none; b=DDKz1d289edB/m5tG2S/8T3qjA8auNuI9uB20tNSCZQ5djm8ikHRAarEYEOpvvzr81Gy5rISGxtYgJzQkckJ61Nb5XiUN90SFKigWDdAhx4G+jm9WkHMNMaERzEewlGFcMiN7qFYj3RirBVL7AGTHRXxuNzolOJBjkGFgcC2Qk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640861; c=relaxed/simple;
	bh=iUUfZ5ZCtCnqfF/mXQXgZgS5VBRFnGVcwXPjE7EqbMM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MAV0OwIeM3ZiuaVh/s0ebK0xAorbeX5AIdohNEf7qV5Sva2FUpljHfQpA5t4f0TQr6KKKopR3eOqxQKTPIJxnGiJsiUextezJzKXrwHiAGpLCv8lmnjO6ydMHLNqNSTPGuRPi49cEcT4cFBGZLfg/SvMPOBz4oG2IBu3xtE1sUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LzVCvSui; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709640858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7HURfjI7Faw+R208eEH1/6yoOtyByjWguc0Ty+w+M30=;
	b=LzVCvSuib1rmjitT2lQm5MMBU5lnhJdyQHgIe4dMBat7VUrnw8f3st050vYUq7JDRPkw4j
	ZW15gqzIx9kyphsEzjPjtAOGA5adNDkiOZyy+ANEGJiDhfQvtsyK0gtdcb/d9VEfElUeLa
	keYzria8sqFsWOXPWRbgMdMtUFyzw4k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-FXNQOVPJO--7-hca_ma90A-1; Tue, 05 Mar 2024 07:14:16 -0500
X-MC-Unique: FXNQOVPJO--7-hca_ma90A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3377bf95b77so643053f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 04:14:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709640855; x=1710245655;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HURfjI7Faw+R208eEH1/6yoOtyByjWguc0Ty+w+M30=;
        b=Yc0//MzDss89KZLekR9gEYKjf+OV1v6OX2QgdkURVJwEv7wAu/aC438A5xIRRMjE8Y
         74MYIenDSPHtAAyGOGW75tcha6vZGHd2IaEOSnftMUbG2j9xeveaRLUwfnggi5C+ieTW
         BXZkLxRLGtyjJc+0fDTymksbhqr8tLY6le75IsAhz6r6JoK4rxdJjSKMcB2ekpnJRqed
         FYXvILEpFwsKlbS4KRPQIGzP3nTUjOfQ9Di8kVwlamBl0+rRwX80UAl36sQJ3je4Edk9
         eFJgpgRLoU4v5MKu6DtH7fNjWBgCVmDZz0BpgqYj/BqR3TNsaVvdbP9KQV9LOSk00n89
         FICw==
X-Forwarded-Encrypted: i=1; AJvYcCXdKzRbYAPBJCsgQCttR/BpXrJMQNqsRR0id38O4v3BhX1LARHxQ4JFlGmcDtoq+HhhExBf/wa2k6rgzaKrdvAqlttSnVdhMe2t0XW7
X-Gm-Message-State: AOJu0YynyBAPFrtLdCKVWEa/ofFb0W04S/vJHEUN7z0Dzy+jRXhetdO7
	Ss5SCWpwOsW1XMVf9mElLB8SC7SPadwuJ7qIg23E3ZcgDXZnN7eZ5bhUIYCK+sMg5HsKtRKsQrx
	50GHVi6NQ/9hF4x4WPWDAY5xs+UCaslijRVdKWe1MeKqldO2w/E8q+20MlADtjw==
X-Received: by 2002:a05:600c:511c:b0:412:b2af:2632 with SMTP id o28-20020a05600c511c00b00412b2af2632mr144224wms.0.1709640855458;
        Tue, 05 Mar 2024 04:14:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBttRvlQntInwpccaKG5QagCN8I9mJfQO1DtnWPNVs34f9Ppf8zQnggnyzacwyc0deqs4a6g==
X-Received: by 2002:a05:600c:511c:b0:412:b2af:2632 with SMTP id o28-20020a05600c511c00b00412b2af2632mr144211wms.0.1709640855093;
        Tue, 05 Mar 2024 04:14:15 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-235-19.dyn.eolo.it. [146.241.235.19])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d6309000000b0033e122a9a91sm14128708wru.105.2024.03.05.04.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 04:14:14 -0800 (PST)
Message-ID: <8a3ccdc5445d0cfda36418dd50746f13f447bdaa.camel@redhat.com>
Subject: Re: [PATCH net-next v3] net: netconsole: Add continuation line
 prefix to userdata messages
From: Paolo Abeni <pabeni@redhat.com>
To: Matthew Wood <thepacketgeek@gmail.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Breno Leitao
	 <leitao@debian.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 05 Mar 2024 13:14:13 +0100
In-Reply-To: <20240301185855.944405-1-thepacketgeek@gmail.com>
References: <20240301185855.944405-1-thepacketgeek@gmail.com>
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

On Fri, 2024-03-01 at 10:58 -0800, Matthew Wood wrote:
> Add a space (' ') prefix to every userdata line to match docs for
> dev-kmsg. To account for this extra character in each userdata entry,
> reduce userdata entry names (directory name) from 54 characters to 53.
>=20
> According to the dev-kmsg docs, a space is used for subsequent lines to
> mark them as continuation lines.
>=20
> > A line starting with ' ', is a continuation line, adding
> > key/value pairs to the log message, which provide the machine
> > readable context of the message, for reliable processing in
> > userspace.
>=20
> Testing for this patch::
>=20
>  cd /sys/kernel/config/netconsole && mkdir cmdline0
>  cd cmdline0
>  mkdir userdata/test && echo "hello" > userdata/test/value
>  mkdir userdata/test2 && echo "hello2" > userdata/test2/value
>  echo "message" > /dev/kmsg
>=20
> Outputs::
>=20
>  6.8.0-rc5-virtme,12,493,231373579,-;message
>   test=3Dhello
>   test2=3Dhello2
>=20
> And I confirmed all testing works as expected from the original patchset
>=20
> Fixes: df03f830d099 ("net: netconsole: cache userdata formatted string in=
 netconsole_target")
> Reviewed-by: Breno Leitao <leitao@debian.org>

I guess the tag arrived off-list, because I can't see any sign of it on
the ML?!?

> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
> ---
>=20
> v1 -> v2:
> - Calculate 53 byte user data name from: entry length - formatting chars =
- value length
> - Update docs to reflect 53 byte limit for user data name (director)
> v2 -> v3:
> - Added #define for userdata formatting character length (3)
> - Matched all #defines indent level
>=20
>  Documentation/networking/netconsole.rst |  8 ++++----
>  drivers/net/netconsole.c                | 14 +++++++++-----
>  2 files changed, 13 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/networking/netconsole.rst b/Documentation/netw=
orking/netconsole.rst
> index b28c525e5d1e..d55c2a22ec7a 100644
> --- a/Documentation/networking/netconsole.rst
> +++ b/Documentation/networking/netconsole.rst
> @@ -180,7 +180,7 @@ Custom user data can be appended to the end of messag=
es with netconsole
>  dynamic configuration enabled. User data entries can be modified without
>  changing the "enabled" attribute of a target.
> =20
> -Directories (keys) under `userdata` are limited to 54 character length, =
and
> +Directories (keys) under `userdata` are limited to 53 character length, =
and
>  data in `userdata/<key>/value` are limited to 200 bytes::
> =20
>   cd /sys/kernel/config/netconsole && mkdir cmdline0
> @@ -197,8 +197,8 @@ Messages will now include this additional user data::
>  Sends::
> =20
>   12,607,22085407756,-;This is a message
> - foo=3Dbar
> - qux=3Dbaz
> +  foo=3Dbar
> +  qux=3Dbaz
> =20
>  Preview the userdata that will be appended with::
> =20
> @@ -218,7 +218,7 @@ The `qux` key is omitted since it has no value::
> =20
>   echo "This is a message" > /dev/kmsg
>   12,607,22085407756,-;This is a message
> - foo=3Dbar
> +  foo=3Dbar
> =20
>  Delete `userdata` entries with `rmdir`::
> =20
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 0de108a1c0c8..8cc28aec59c8 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -42,12 +42,16 @@ MODULE_AUTHOR("Maintainer: Matt Mackall <mpm@selenic.=
com>");
>  MODULE_DESCRIPTION("Console driver for network interfaces");
>  MODULE_LICENSE("GPL");
> =20
> -#define MAX_PARAM_LENGTH	256
> -#define MAX_USERDATA_NAME_LENGTH	54
> -#define MAX_USERDATA_VALUE_LENGTH	200
> +#define MAX_PARAM_LENGTH		256
> +/* characters used for formatting each userdata entry line (' ', '=3D', =
'\n') */
> +#define USERDATA_FORMAT_CHARS		3
>  #define MAX_USERDATA_ENTRY_LENGTH	256
> +#define MAX_USERDATA_VALUE_LENGTH	200
> +#define MAX_USERDATA_NAME_LENGTH	MAX_USERDATA_ENTRY_LENGTH - \
> +					MAX_USERDATA_VALUE_LENGTH - \
> +					USERDATA_FORMAT_CHARS

AFAICS this is not what Breno asked, and checkpatch complains
rightfully. More importantly it's fragile: what will be the result of

	MAX_USERDATA_NAME_LENGTH * 2

?

At least some brackets are required:

#define MAX_USERDATA_NAME_LENGTH	(MAX_USERDATA_ENTRY_LENGTH -
					 MAX_USERDATA_VALUE_LENGTH - \
					 USERDATA_FORMAT_CHARS)

Thanks,

Paolo


