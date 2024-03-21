Return-Path: <linux-kernel+bounces-110054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A49885968
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754D828270C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5AA134CD;
	Thu, 21 Mar 2024 12:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eeYD4e8D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62B23717B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711025474; cv=none; b=Hz5mObX7FxnsA4fNEc2ti1INLb1MPMZ7Lp4a5rUWngFd53EFRFa42P+nIRa/nv7K0eSI/XMbYI+xxNPzCi/DAjRc9kfVwccg9WvvUJ0sIhJXHoTY/VKUqTFN5m6CYY4b02emKF9RMdkSC9tMMC6mpD0ZKUMAlqHz9/c5BoTNgV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711025474; c=relaxed/simple;
	bh=mx2EyshZF2dDk5lO0KgoXsCB1NH2Idk1VG7LQZUiiPY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ftv08X0N6wFSHQDUFVKiJRlJM0/4LENunWyY7FEF3Sc3eWS1lAdXTT76RbeW439WdGJz1CMy5HNLGV2UBhTBChlZ4O9tjk5PwCtl2jGnWWDflQdJ/OUFL1Gg4ZKm/Wjl0wqHLszxxXOR0o5bvablbbUIix7FfWbYQzm+BhO0fyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eeYD4e8D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711025471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mx2EyshZF2dDk5lO0KgoXsCB1NH2Idk1VG7LQZUiiPY=;
	b=eeYD4e8DU0c/RJ8B+DfPV8lPw/KLdvAh3ktz6mZW+9OpXIJsck6zhH/XZCyXGa2+QOZHvq
	lhVxNqayIKi3PFcChd3Iz2Cwupf5rZ9OUuVloq2PrXAp3vNRmnf8SDiaCtLqpcsTkIj6mW
	7UtXPLGGtTGpNAyA/dcticf56gaWkOk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-kC9llyq7PminODh5uXt97w-1; Thu, 21 Mar 2024 08:51:10 -0400
X-MC-Unique: kC9llyq7PminODh5uXt97w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4146d5038c0so2207325e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 05:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711025469; x=1711630269;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mx2EyshZF2dDk5lO0KgoXsCB1NH2Idk1VG7LQZUiiPY=;
        b=RbW4IXD8+jXhQukC7bQThLtYkukhMId9g2sQYbHlgELLZeLfFMhoDcNMZz1/4KVMxq
         0TKaLdKgDb8lTl+cDclepawcO9cxaazYu+eijTvqsDOD3jPxnCSqn/Ronqd/sOpvoR3p
         +TNmUwdINzdQztGEDLh7kLYHvrWle31QyB+MBRFMdNvuOlpdDcC33kftA6PEsXDhGagE
         Wr2E8V1G3fyMRnsGtRuzkRX3d2a7H/7G0NnTp6M+TFFejDWrKaKS+ObEwq7s5pox3u51
         qq42TdBTmiEmYfQFatRvmWBf9NBTeAWI00H8TbDp7nNXxzJXftwQYbLDhL4QyaElIAlo
         lDRw==
X-Forwarded-Encrypted: i=1; AJvYcCXaMeW/pdaNs7t2/qY/tNi1mIYJgEmHZnuGk+tMInP45UfWHTNJvn34VJdck7JhRQuP6Yls58Zf2Jcp1a0vdPQup5KkfezXfQj2MOup
X-Gm-Message-State: AOJu0YxD23d7JScQo3ZPZ1ISvUfnnZjsGJJ1yz4PY/izf48AP6U3WO9z
	yfAujLCZP9Sv7MGWq3SlEMzJKQVpb9WTVUcNTIqaUyB/mQR0uFneI1swnUeUvMiWi85w1LUqqfi
	alXEMcKEGf+1ThZcHaF/7GI1wEeeyPVdd5AEHGXC0ODfmzcd7rMTRis53Ag42vA==
X-Received: by 2002:a05:600c:510e:b0:414:6445:db2 with SMTP id o14-20020a05600c510e00b0041464450db2mr6120853wms.4.1711025469004;
        Thu, 21 Mar 2024 05:51:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTMeHuepMFvOPmrfodzsVOL0EK+8DJ1O4xn4TkSP/UQZYUb1jczt4uvqPOrWlw9Ro/bfgOEQ==
X-Received: by 2002:a05:600c:510e:b0:414:6445:db2 with SMTP id o14-20020a05600c510e00b0041464450db2mr6120836wms.4.1711025468648;
        Thu, 21 Mar 2024 05:51:08 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-130.dyn.eolo.it. [146.241.249.130])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c358b00b004140e701884sm5472033wmq.22.2024.03.21.05.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 05:51:08 -0700 (PDT)
Message-ID: <7b3a5167319156e96b7f754d23de455f3a80079a.camel@redhat.com>
Subject: Re: [PATCH net v2] net: ll_temac: platform_get_resource replaced by
 wrong function
From: Paolo Abeni <pabeni@redhat.com>
To: Claus Hansen Ries <chr@terma.com>, "netdev@vger.kernel.org"
	 <netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
 "michal.simek@amd.com" <michal.simek@amd.com>, "wei.fang@nxp.com"
 <wei.fang@nxp.com>,  "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
 "robh@kernel.org" <robh@kernel.org>,  "harini.katakam@amd.com"
 <harini.katakam@amd.com>, "dan.carpenter@linaro.org"
 <dan.carpenter@linaro.org>,  "u.kleine-koenig@pengutronix.de"
 <u.kleine-koenig@pengutronix.de>, "wanghai38@huawei.com"
 <wanghai38@huawei.com>,  "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Thu, 21 Mar 2024 13:51:06 +0100
In-Reply-To: <f512ff25a2cd484791757c18facb526c@terma.com>
References: <f512ff25a2cd484791757c18facb526c@terma.com>
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

On Wed, 2024-03-20 at 14:19 +0000, Claus Hansen Ries wrote:
> From: Claus Hansen Ries <chr@terma.com>
>=20
> Hope I am resubmitting this correctly, I've fixed the issues in=20
> the original submission.

Sorry for nit picking, but please re-submit dropping the above line,
you probably don't want them in git history, too.

In the next submission you can retain the already collected RB tag.

Additionally it looks like the From matches the sender email address:
it's not needed (but it does not hurt not will produce any differences
in git history).

Cheers,

Paolo


