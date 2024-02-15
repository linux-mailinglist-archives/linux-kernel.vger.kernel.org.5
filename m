Return-Path: <linux-kernel+bounces-66922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D248563A5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47CAD1F264B7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D2312EBC6;
	Thu, 15 Feb 2024 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvTrVYIw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7416412DDB4
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001390; cv=none; b=foBYj2dIMUxVePbbi0hB7ZI8zpouVbXz0enJcM0htYussKZui9qrWeaiWRrVIGv1JGI+vw8smhqNu7sw96X0DdkSj7EA9zoKuRZW6NIRoDXZz+/OAIF/7nVbBnduToAh1ScbnmyFvYUhT0eStjCcYIT6uamEsrOYCav3Sl4hp/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001390; c=relaxed/simple;
	bh=5N5szYrlx9aJ9OnSpU/dAV8YrVJfZg9KSMyvYgRcPgU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R2EuDii8wBdni9GutsyiJViFFHgZE5Q54JPDpAkOBJPFHA4iCkqMlD+rIKvkfkPcfFfYNrTbFyUmXk1L5l8+8TfKL0p7ikWB91ma4pwR5hxTdKu/18861OMrM4pqQCcbYt5NOGSnc3F4ubULFWZEYKUprb9mM61nA6mX/oOzNV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CvTrVYIw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708001388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tabdxGuJE+/IMOSNqJQdsby1dFEjuJX8szCANcxoeAw=;
	b=CvTrVYIwYGxMh1ylVKUTHC+7RAZXRCQKVc9CJpkcckQYWktkdjojtdkmlv3jYD8sBjsXvw
	orf3ShK7714TohrNRDWlb7G0k3774PNkQX/C8n+AOarNTazBCNv7HGGi6drMrlivzERm5o
	WPMfBFeD21NdQeY4wW/mXRA7aEvO8dI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-TNG8sBPDMO-zwL8SMI9E5w-1; Thu, 15 Feb 2024 07:49:46 -0500
X-MC-Unique: TNG8sBPDMO-zwL8SMI9E5w-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d0aa5cf924so166741fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 04:49:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708001385; x=1708606185;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tabdxGuJE+/IMOSNqJQdsby1dFEjuJX8szCANcxoeAw=;
        b=XxdilJSuiIxXJB3ded0rMSrRnYsimZjLIhMrF1zcGJNC4UGGM+GiyUET+lENKrUqqb
         qujRMAPl3GIa6Y2TBIA4zpIRzKU0vcu2ZV67A576xkVeIeyGHJwd8A/iBycyeX5Vu81x
         qZF1IkWWZkC/kjBS+JsixC2Qzv14yHrB+3CA33kVbWcxxUGeur/MFRrqNQWrJ/KvP7TX
         c7EKqzx7pCTTsKkXV6MwjZTysiUWXFcFC5q9VCkNHzm8aWljpnCmfk0T4S+L6X+pIqiE
         Jozo9jZxFvmDpsms3qRpdaoJsFHDiRGcyxBroI6LzCkDUVOPeMUfqbV3ZNltotbyqsaN
         fsAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy6123M9DqtJ7RgZYHxaZITSgtukXD5yrZpawL5TmWJ0/5oIVbJjKPlieBN6WbFpeTU50tw5qX7ggnH1bMULd+TulL7EcEx76LYzi0
X-Gm-Message-State: AOJu0YzhPVjm0bX1+YnMvIdJqu7yufrro34GKngWXyyOyk774eJ+hudn
	yHM5O9GeC9nr+Zmkobih7yIk11KtaXHbR3RFm3Qugw+/ZOJOc4Pq2Zaz0WZfnNYuDupka5tEKG2
	msnwtT59gN6LRAlffbOkoYJ65Dhtzb9KILJl4cSKHtv0XPC2mJTFyK1gsB2PyA02vUYdPYA==
X-Received: by 2002:a2e:3313:0:b0:2d0:d055:4d34 with SMTP id d19-20020a2e3313000000b002d0d0554d34mr1202267ljc.1.1708001385223;
        Thu, 15 Feb 2024 04:49:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhSP4pfJQOnIVxNB1gY9tPguhymzbDh1SRtdrnposP8/d3k8E5xUKij3ZSE7Fb98Z7kGMNXA==
X-Received: by 2002:a2e:3313:0:b0:2d0:d055:4d34 with SMTP id d19-20020a2e3313000000b002d0d0554d34mr1202258ljc.1.1708001384871;
        Thu, 15 Feb 2024 04:49:44 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-227-156.dyn.eolo.it. [146.241.227.156])
        by smtp.gmail.com with ESMTPSA id jl24-20020a05600c6a9800b00410ac2d6b40sm4966135wmb.8.2024.02.15.04.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 04:49:44 -0800 (PST)
Message-ID: <7dd8ed05495a8f9e1dad7f27e5186f62c8c0b730.camel@redhat.com>
Subject: Re: [PATCHv5] PPPoL2TP: Add more code snippets
From: Paolo Abeni <pabeni@redhat.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, James Chapman
	 <jchapman@katalix.com>, tparkin@katalix.com, edumazet@google.com, 
	gnault@redhat.com
Cc: davem@davemloft.net, kuba@kernel.org, corbet@lwn.net,
 netdev@vger.kernel.org,  linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 15 Feb 2024 13:49:42 +0100
In-Reply-To: <20240214012102.dsdgcdgvwgfabzdi@begin>
References: <20240214012102.dsdgcdgvwgfabzdi@begin>
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

On Wed, 2024-02-14 at 02:21 +0100, Samuel Thibault wrote:
[...]
> +  - Bridging L2TP sessions which have PPP pseudowire types (this is also=
 called
> +    L2TP tunnel switching or L2TP multihop) is supported by bridging the=
 PPP
> +    channels of the two L2TP sessions to be bridged::
> +
> +        /* Input: the session PPPoX data sockets `session_fd1` and `sess=
ion_fd2`
> +         * which were created as described further above.
> +         */
> +
> +        int ppp_chan_fd;
> +        int chindx1;
> +        int chindx2;
> +        int ret;
> +
> +        ret =3D ioctl(session_fd1, PPPIOCGCHAN, &chindx1);
> +        if (ret < 0)
> +                return -errno;
> +
> +        ret =3D ioctl(session_fd2, PPPIOCGCHAN, &chindx2);
> +        if (ret < 0)
> +                return -errno;
> +
> +        ppp_chan_fd =3D open("/dev/ppp", O_RDWR);
> +        if (ppp_chan_fd < 0)
> +                return -errno;
> +
> +        ret =3D ioctl(ppp_chan_fd, PPPIOCATTCHAN, &chindx1);
> +        if (ret < 0) {
> +                close(ppp_chan_fd);
> +                return -errno;
> +        }
> +
> +        ret =3D ioctl(ppp_chan_fd, PPPIOCBRIDGECHAN, &chindx2);
> +        close(ppp_chan_fd);
> +        if (ret < 0)
> +                return -errno;
> +
>          return 0;
> =20
> +It can be noted that when bridging PPP channels, the PPP session is not =
locally terminated, and no local PPP interface is created.  PPP frames arri=
ving on one channel are directly passed to the other channel, and vice vers=
a.

You need to format the above sentence to fit a more reasonable line
length.

Thanks!

Paolo


