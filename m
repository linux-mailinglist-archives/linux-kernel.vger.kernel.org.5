Return-Path: <linux-kernel+bounces-166417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9278B9A5F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D2C284734
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264BB77A1E;
	Thu,  2 May 2024 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CM09goGP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14096BB47
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714651200; cv=none; b=NbX37b8B09QOGvlob+XlO2CfMxfY1BzJ3+FRY0kigdgoVMYNeX2VjoJIpRVCsgOPGpzX5/8s7B4lpWZj3a1CoG2fE4ukP2q5UdT80fslwz4aFirkd/Kr/d8Jb6Dh2sRQq6OU6YPR9+s6sncmcDA7wWJiiwTojtOcJ+drN+3B5gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714651200; c=relaxed/simple;
	bh=KN7TKbE6WGnLJS73LooKrZkWfYf90HCId1rZoM0L7jE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rRB1N1wyTUi5NHs+w4KYYqmiI4nwPRcELuegwm05PLJjf12159KpLMCmxSAO/xSkCfR7HHl9iCitcP74hwm3ZPc9LnhipIk8RGhMFyB8BhtCLnRAooNcJE0VpirxqsevbAcLPxzy0lVJnmubZ5FsEJnBs36yuJXS1h0gcWdxKo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CM09goGP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714651197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eCXJwwefyfqxgyF/bJ0Xxmw5VqQW6iHWoVYufjmV5Bg=;
	b=CM09goGPRujZbRVoja787rmjQ4RnFEmY26cxoiPjD7u1Q5RdjC39+0DBsGteIsjXFdQVtF
	7iH5jfm4tFKySNxa/y9+hq09Y74LSSYLcKlKyC6jOVDKbDVvG5lb0pJOzgomALREPsAX0k
	z6cLOJFimXGmb9c6JE9Ei/xvccmJxj8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-kVxS-MmqOqm32nuSnWoiDw-1; Thu, 02 May 2024 07:59:56 -0400
X-MC-Unique: kVxS-MmqOqm32nuSnWoiDw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34da4d75ceeso268923f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 04:59:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714651195; x=1715255995;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCXJwwefyfqxgyF/bJ0Xxmw5VqQW6iHWoVYufjmV5Bg=;
        b=suH9Sw8SkiHeDQg1xe6r+pkTjDeuU25ypGSfiIgkUEfDBO7lDE2/haqeX98fGuNhV+
         rW3nJPFFnfZ+VRRRiNFR3hUApJWz2XczV9/WJdmjRLxqgAeI4cXpfDz0YqoQuORQAlY1
         beTHe0XTXiDKxynZbmG4zEW9orzzCdOM7adqSRb61Q4DRDZuWAb15uMQdsEcyiV+afNU
         6ctyM4HlQw1eHgQtHK3tR5FKyYWBfZepn97cgXp51xLsRCf09/Wj1ZGEo/4unO3xCbK+
         oBf4uQZlBX1uLaD7xtDEWwVbAc1fWqHQfsYh3jnCQJlWK41CFXYXSWB1MOro1QJWOwJm
         63Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXeZ4piiatfTMXm8syRt0fPEYgcM+Hi5se0ZdVHmp2AVnqK6RRkfH9YVwUb41Qio950/2aiCyODtfrzC/kSj+cKb2aed/46/DLyMqUp
X-Gm-Message-State: AOJu0Yzu0q8m4pDnmfZEFGPnAHToOTDsY8lqKVJxnf7qKzfTgwO9UJ38
	HvEKihsbYCXMSReYZlGGCqbtlwyH1ni+pFpw2FMiIUK4SwVmNqt3iTf/v/iLeDYYDjXAdQTMsaQ
	JPsB4IEtYLEcXyv8ULLD7M/PDMZpwzZMMphe/Al0BQudXjUyiwWxW8H+XwvbTDQ==
X-Received: by 2002:adf:f543:0:b0:34d:af59:32bc with SMTP id j3-20020adff543000000b0034daf5932bcmr4071791wrp.7.1714651194818;
        Thu, 02 May 2024 04:59:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV/jy4IGT3uZetE9BJTNRXg/+lUJeSa/GWiLoZGDI8Z/wQXewidxw1X08W4MwwyNzNgrEA+w==
X-Received: by 2002:adf:f543:0:b0:34d:af59:32bc with SMTP id j3-20020adff543000000b0034daf5932bcmr4071778wrp.7.1714651194367;
        Thu, 02 May 2024 04:59:54 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b52:6510::f71])
        by smtp.gmail.com with ESMTPSA id n12-20020adfe34c000000b00343d6c7240fsm1107239wrj.35.2024.05.02.04.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 04:59:53 -0700 (PDT)
Message-ID: <74be4e2e25644e0b65ac1894ccb9c2d0971bb643.camel@redhat.com>
Subject: Re: [PATCH net-next v5] net: ti: icssg_prueth: add TAPRIO offload
 support
From: Paolo Abeni <pabeni@redhat.com>
To: MD Danish Anwar <danishanwar@ti.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Jan Kiszka
 <jan.kiszka@siemens.com>, Simon Horman <horms@kernel.org>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, Diogo Ivo
 <diogo.ivo@siemens.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Richard Cochran
 <richardcochran@gmail.com>, Roger Quadros <rogerq@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com, Roger
 Quadros <rogerq@ti.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 02 May 2024 13:59:51 +0200
In-Reply-To: <20240429103022.808161-1-danishanwar@ti.com>
References: <20240429103022.808161-1-danishanwar@ti.com>
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

On Mon, 2024-04-29 at 16:00 +0530, MD Danish Anwar wrote:
> +static int emac_taprio_replace(struct net_device *ndev,
> +			       struct tc_taprio_qopt_offload *taprio)
> +{
> +	struct prueth_emac *emac =3D netdev_priv(ndev);
> +	struct tc_taprio_qopt_offload *est_new;
> +	int ret;
> +
> +	if (taprio->cycle_time_extension) {
> +		NL_SET_ERR_MSG_MOD(taprio->extack, "Cycle time extension not supported=
");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (taprio->cycle_time < TAS_MIN_CYCLE_TIME) {
> +		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "cycle_time %llu is less than m=
in supported cycle_time %d",
> +				       taprio->cycle_time, TAS_MIN_CYCLE_TIME);
> +		return -EINVAL;
> +	}
> +
> +	if (taprio->num_entries > TAS_MAX_CMD_LISTS) {
> +		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "num_entries %lu is more than m=
ax supported entries %d",
> +				       taprio->num_entries, TAS_MAX_CMD_LISTS);
> +		return -EINVAL;
> +	}
> +
> +	if (emac->qos.tas.taprio_admin)
> +		devm_kfree(&ndev->dev, emac->qos.tas.taprio_admin);

it looks like 'qos.tas.taprio_admin' is initialized from
taprio_offload_get(), so it should be free with taprio_offload_free(),
right?

> +
> +	est_new =3D devm_kzalloc(&ndev->dev,
> +			       struct_size(est_new, entries, taprio->num_entries),
> +			       GFP_KERNEL);
> +	if (!est_new)
> +		return -ENOMEM;

Why are you allocating 'est_new'? it looks like it's not used
anywhere?!?=20

> +
> +	emac->qos.tas.taprio_admin =3D taprio_offload_get(taprio);
> +	ret =3D tas_update_oper_list(emac);
> +	if (ret)
> +		return ret;

Should the above clear 'taprio_admin' on error, as well?=20

>=20
Thanks,

Paolo


