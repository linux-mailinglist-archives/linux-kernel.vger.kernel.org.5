Return-Path: <linux-kernel+bounces-72855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A1F85B98D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F794B22FDF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84381657D7;
	Tue, 20 Feb 2024 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WILWcCbJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108FF64A80
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426268; cv=none; b=pNPZVkrX2HtQL1R5c30ZGIvJEO6dCARgGsS3rxEh3j7IH+22Cgjb4oCgk9CLEzMvlswOokc2C2bFFJ4W1nTpoqhekULQ42eRSKK2Gm8T5j1IsJOvoaNQO3utD3jaimAqak3qi9qwSc6IZYW/1c/i0RqYruIN89U/5w3R/w6hSTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426268; c=relaxed/simple;
	bh=gFms9h+t9TpIytTSNSIgaIkXNbLktX4XDv9i7G5Gsw0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AtKAIvhn/EwYd1Q6cuYr8nLozGlyi6ybZcNapNAcaN+eP4cNWC0gdunsv3ldhOJNfl+SuK6Xiv4NxcsT2CmMd6iWmEPCGnVjCdLWJH7Tgd0S+rFYH7n0DU3si1+bawhZfd+6/mjG+nS1xB8FSZz3VuadS7Tl20Y2OORgy5A8nIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WILWcCbJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708426266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gFms9h+t9TpIytTSNSIgaIkXNbLktX4XDv9i7G5Gsw0=;
	b=WILWcCbJ+30SlWMlIP5uaucdCl5x449MnZm/kn6harBJmVHVLWLVZWNkeOwKdIUNv2jmeu
	g6Ad9AXiG46kY41J/iviyyZ1FzL4mgIc/XEGF6VjDS+xBVhzBX6kYdwBkm2ehKGJ7Idx2v
	gwjoYaO5UK+zCAHJXuQ0afZNAXkoS8M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-7gEZH5pBMwC8viP_t4l3dw-1; Tue, 20 Feb 2024 05:51:04 -0500
X-MC-Unique: 7gEZH5pBMwC8viP_t4l3dw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33d1896e0d5so438962f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708426263; x=1709031063;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gFms9h+t9TpIytTSNSIgaIkXNbLktX4XDv9i7G5Gsw0=;
        b=Jyj9g/mbl4qpvR7fUq/o9U7CN/6Cob6mh8lUsyhbBWAJzVw0nI32tQK6SBhFl56r7M
         nwEreks+XzdBsDkkFh+QrWvbHsZCibGhtSX1+bsbNKQwmU27F7EiPoJI7nIpxWrel4Lr
         T9CqqRu1Rdk7XgHSLtilxdbxOiUCTjAHyrgLL2r01gcSo097t/u/9II16so4auEmVbMW
         7LySgRPbRoHOrkwxjlv717ZUvj5as6xapRrFJJNrlOK+19r0Gx+MiVuSnC1LtwoqQe2f
         67Je37xCS5dcX5REBkw4BOZyiygVJEZtpF0ORb6ZKyiTcl2viEmiDOVZDfAR8D8/bFAr
         7BVw==
X-Forwarded-Encrypted: i=1; AJvYcCUuj2O5HmH/Fr0HO1VXfS68zv/Zzt2Dp7AFOUt8fKbR9WJAt3Ci9krtTcFjgm3jZGbo8Id77R8jMQzR0UDwEAglBQRgmAqbVV7/Gjdx
X-Gm-Message-State: AOJu0YyWQTQ6ison4B7el2SLdyQO2hzt2sSOl0BV1k+se47eOJxZFt1Y
	gWY1XFMVkz6+qNu9/6d+Vl9MDg4LFxmf+HW2J2oAr0XGK21yhBxhNZfVd7gn3/mJ+gIpxPm1avY
	HG32LmECMahL48cYOWsQpHnFOKiUI0tco9cXE+sE4J0Y0BEYT3SaIjfcu+gmA3Q==
X-Received: by 2002:a05:600c:510a:b0:411:de28:bb52 with SMTP id o10-20020a05600c510a00b00411de28bb52mr10452966wms.4.1708426263069;
        Tue, 20 Feb 2024 02:51:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUNimcpyY/1g2ysTqT9zw+cZcG1hwdfEtTiZ1zoou2n/DfOAnxjdDcgwvmNuhEROxe5tsv6Q==
X-Received: by 2002:a05:600c:510a:b0:411:de28:bb52 with SMTP id o10-20020a05600c510a00b00411de28bb52mr10452946wms.4.1708426262743;
        Tue, 20 Feb 2024 02:51:02 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-230-79.dyn.eolo.it. [146.241.230.79])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c025000b004101543e843sm13958608wmj.10.2024.02.20.02.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 02:51:02 -0800 (PST)
Message-ID: <68a7dbd619a1a609f102a0786c37bc33c24cdbcd.camel@redhat.com>
Subject: Re: [PATCH] net: stmmac: mmc_core: Assign, don't add interrupt
 registers
From: Paolo Abeni <pabeni@redhat.com>
To: Jesper Nilsson <jesper.nilsson@axis.com>, Florian Fainelli
	 <f.fainelli@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
 kernel@axis.com
Date: Tue, 20 Feb 2024 11:51:00 +0100
In-Reply-To: <20240219104025.GM22484@axis.com>
References: <20240216-stmmac_stats-v1-1-7065fa4613f8@axis.com>
	 <61bdd802-abe4-4544-8e48-9493a6bb99c8@gmail.com>
	 <20240219104025.GM22484@axis.com>
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

On Mon, 2024-02-19 at 11:40 +0100, Jesper Nilsson wrote:
> On Fri, Feb 16, 2024 at 09:13:51AM -0800, Florian Fainelli wrote:
> > So in premise I agree with the patch, that incrementing those is not th=
e
> > right way to go about them. However these registers are currently provi=
ded
> > as part of the statistics set, but they should instead be accessed via =
the
> > register dumping method.
>=20
> You mean extending the dump register code to dump the MAC Management Coun=
ter
> registers that are not counters?
> > From what I understand it's only the Rx and Tx interrupt and interrupt =
mask
> registers that aren't counters. Oh, and the MMC control register itself?
>=20
> To be honest, I don't think their use can justify the code churn.
>=20
> > In either case you will get at best a snapshot of those two registers a=
t any
> > given time and I suppose this can help diagnose a stuck RX condition, b=
ut
> > not much more than that.
>=20
> Yeah, their use is very doubtful. For me, they only introduce more nonsen=
se
> data in my logs.
>=20
> The Rx registers looks to have been added in the first version of the MMC
> back in 2011, but the Tx registers never was.
> In commit 1c901a46d57 Giuseppe mentions the MMC interrupts as something t=
o
> add later (if actually useful).
>=20
> So Serge's suggestion to drop the entries completely is actually quite at=
tractive.

Please, go ahead and drop such entries.

Thank!

Paolo


