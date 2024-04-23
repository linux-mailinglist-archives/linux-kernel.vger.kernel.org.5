Return-Path: <linux-kernel+bounces-154929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BCF8AE329
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62491F22978
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4420C80045;
	Tue, 23 Apr 2024 10:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B66/a2NO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431997E116
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869709; cv=none; b=q7nOT3Ubjax3HiKh67no5LBQkyBriai0XeR5tUSvQvsbVRsCKXCE3pwRrrkpIDDQ3AxQN5c3fwyOFeQwwBetofRg4fJwj/l2Fsvo4j2TI4pZudHYf4+HfNb4R61psyk8X106vLfu2CwQYcc7eMDqlKP2vmrAGt7NoXi7efAWDa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869709; c=relaxed/simple;
	bh=nglQwmEI9S4PpwkTZlV2pbFJyqoVOIhi4F3/+t0CTt8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=glU5aRFpg9qPURH1cRAE1jUsr+MOYHjXuvTNmKSxU9Jshw0eXLsY3qhTTPghxmYD3VK1yVOwIwFigoj6K5IfyHpyzao3AXtiar7jhB8Db3Rgo0f7+pkidW+xrinBqS3J9JZ49F7+F6RBpBTGVw9nbzzeZHufpzbjy2tY3j8Hu2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B66/a2NO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713869706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fRCPL2CykbeXsbjfW7wTs7HoD7qoPawf+vMKP9w+9do=;
	b=B66/a2NOEnK4CTC9TcpK+Q3Iwok5hT3+OcxbCr4EPemFIpKS6NM9Fg5BwQsn8fAWoCSjis
	mcxN7GpMRWkfRPwN6JTjokfRkQG5rz7V6Wowloa1U/btLYCc7i1bPu4uD16ztV/5Gn8QsB
	1wloWwRPVLC2VoB91NFpnIATFG2T1fY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-6qW4e8qOOsKVn64qu7xesw-1; Tue, 23 Apr 2024 06:55:01 -0400
X-MC-Unique: 6qW4e8qOOsKVn64qu7xesw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4188cfbabe3so6767435e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713869698; x=1714474498;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fRCPL2CykbeXsbjfW7wTs7HoD7qoPawf+vMKP9w+9do=;
        b=n9Snc9dMzybXJOQzXpLIdU9YmehI0vdjyfgbTUKZDMPoNk0Qz2NJiMiFRUHGoeaB8U
         7rylmuC/u1KXMOQ8oxdpXtMW3XOFzpO5n3aFQj3ZDX4qCqx0BKbtiNZZyFDV4IWLDiPK
         SkcVLudx4+f0oXkQX+TdxPnCDZD7SNMJ/XzLLioIVLqiEpP6l0dqsK6KtWzJtRUl5MC3
         vC0OdF4GQcma9VX1IyW5wOh79GwcxheIN1XLJvqFJdUTIUaMuD92da5AW+x987/EL8OA
         abuppwSqDvlhNMpDDFhVjrlMr7CWKfJ+SOpt5YJmsiSF7S0Wqrfzh3WAHwAiz2yIvQkz
         Vnqg==
X-Gm-Message-State: AOJu0YwuOlHyjJwepAdptsxT34fvMrgBdZSMyHTxe0GiUy1ZtGhU/Q7l
	yteTX7dldk0TprPBFepY/XUvHRLLqjwKEBNhARtZFwX5FvjH6g/TKQJNNlanGmnE7b8Nfp42get
	L4H5BpObeAuZ0usuPfC3rOc0clmLc+9F1wiNsdxrRe6AE80kFBy3kPAwQsmFzpQ==
X-Received: by 2002:a05:600c:1c9c:b0:418:ef65:4b5f with SMTP id k28-20020a05600c1c9c00b00418ef654b5fmr8849786wms.3.1713869697937;
        Tue, 23 Apr 2024 03:54:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbxc+hyvs87hZeqsIfYQ5GfmVILZxXwggx9OYW4GdNItIL5ThpnsfAcenQyjRuzinaQeRBBw==
X-Received: by 2002:a05:600c:1c9c:b0:418:ef65:4b5f with SMTP id k28-20020a05600c1c9c00b00418ef654b5fmr8849776wms.3.1713869697582;
        Tue, 23 Apr 2024 03:54:57 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:172c:4510::f71])
        by smtp.gmail.com with ESMTPSA id n8-20020a05600c500800b0041a97870d6fsm3600224wmr.2.2024.04.23.03.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 03:54:57 -0700 (PDT)
Message-ID: <f493e39063ee52a3d263de27bfd240149d910a88.camel@redhat.com>
Subject: Re: [PATCH] ibmvnic: Use -EBUSY in __ibmvnic_reset()
From: Paolo Abeni <pabeni@redhat.com>
To: Markus Elfring <Markus.Elfring@web.de>, linuxppc-dev@lists.ozlabs.org, 
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Haren Myneni <haren@linux.ibm.com>,  Jakub Kicinski
 <kuba@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "Naveen N. Rao"
 <naveen.n.rao@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Nick
 Child <nnac123@linux.ibm.com>, Rick Lindsley <ricklind@linux.ibm.com>,
 Thomas Falcon <tlfalcon@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Tue, 23 Apr 2024 12:54:55 +0200
In-Reply-To: <4cff158d-b5ac-4dca-9fbb-626237c1eafe@web.de>
References: <4cff158d-b5ac-4dca-9fbb-626237c1eafe@web.de>
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

On Fri, 2024-04-19 at 16:08 +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 19 Apr 2024 15:46:17 +0200
>=20
> Add a minus sign before the error code =E2=80=9CEBUSY=E2=80=9D
> so that a negative value will be used as in other cases.
>=20
> This issue was transformed by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/net/ethernet/ibm/ibmvnic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ib=
m/ibmvnic.c
> index 5e9a93bdb518..737ae83a836a 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -3212,7 +3212,7 @@ static void __ibmvnic_reset(struct work_struct *wor=
k)
>  		    adapter->state =3D=3D VNIC_REMOVED) {
>  			spin_unlock_irqrestore(&adapter->state_lock, flags);
>  			kfree(rwi);
> -			rc =3D EBUSY;
> +			rc =3D -EBUSY;
>  			break;
>=20

AFAICS the error is always used as bool, so this will not change any
behavior in practice. I tend to think we should not merge this kind of
change outside some larger work in the same area, but I'd love a second
opinion from the driver owners.

Thanks,

Paolo
> 		}



