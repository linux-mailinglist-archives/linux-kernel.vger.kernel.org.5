Return-Path: <linux-kernel+bounces-76236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC29285F49A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 403D6B22558
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6F33771F;
	Thu, 22 Feb 2024 09:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJdxu8bC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D8117F3
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708594741; cv=none; b=L6t7JwGX/dj1CyOqsMFU7Hpmu4mg1gzvPip4Y59wDxVSD2dTy/vU0uIaPOBYyGuX9ZgD9zltZELGnyiqwi5Ay1GL2vPW9Sbbd06Eu+Pu1LI7gsEVt5d+LowS7E9mz7+9wTBiecFNc7YCCkeyqMtgsy5WzZfrjlE8nqQ9Ih55Jag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708594741; c=relaxed/simple;
	bh=PkSJy8SMxG40Y7D597XKNCZ85h9qerEH1l5wf9lzQ/0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EYdrbc8/QkFbmnkwCWuXJKgdxf7PIRPEZfJHUUBOI1CeDEeVJ0x8xc/ljItcdjT/3iYPLGS7XBrrtoTRucYkXlVGcwKGevPC0v6k2cD9R1jJGuW7kQ0Axsz/+OUPns9sgrd7mX+kJzc50vcNLvb91K7g0RX/b8YYCa8wDPYLRE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AJdxu8bC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708594739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PkSJy8SMxG40Y7D597XKNCZ85h9qerEH1l5wf9lzQ/0=;
	b=AJdxu8bCe39K6jTQa9MeUzVarWrFlIhYo6AtpEzqt568kMWuq2e6pVX7j4i8M/JsXHEZIS
	5YOLSFcXOFua++pXffq3rjVR3izBvPDqJsh9WiSXE24abVexaNUr/ipAKURR7lnFGbsEpt
	7BDMWVStM+EhwCwQSpqEAcr9wTSaRBE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-6CdODwX5PYGZ4IW99ZvECQ-1; Thu, 22 Feb 2024 04:38:56 -0500
X-MC-Unique: 6CdODwX5PYGZ4IW99ZvECQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e354aaf56so16167595e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:38:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708594735; x=1709199535;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PkSJy8SMxG40Y7D597XKNCZ85h9qerEH1l5wf9lzQ/0=;
        b=iACg7GqnBgvGgQHRBxnMCywP/tv5qof0+qOqnRH2Kp/oAvdMoYR8ILQ/DxoqZ+j56s
         /Oc62GaR2NCPGEvttBeQ03wHEkKPTgIup2ns/iQYsVbHn0qQqt2RVYTB5uyLq7hhJFZ0
         jV/Fjk9JRsvJzcsDhQcFo4oYVnzgxA1NiwtncxEWT4aclaL2bIrQt4sscolaZ8PrN9Hr
         ea49jkjm6h7XwQKjBMeSAB2VIbMh8YJ8N8Zd29erf/TIPE1slz9UfPIrsRJPtAhEko9j
         NJTZ3Lpo/RPJcJ2GvQHKDec2t00OHBadjtQVTC9ciC/2shs7yt/97CI7vn5zoa9vNHHn
         L+Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXzf2KwWBNkvTPT6o2ZUp1+FZywTcKixv1yd7yFa3ypGIT/VtA194zM1aDpGXhPsMQPC7D/r5oLMIdcSY/GiC5s7veVPDqKKuVVX3OA
X-Gm-Message-State: AOJu0YziuDqf9maN8TmtDRvHvPNOVeUVK55y3FOhJvh5fvoNskJ4zHSp
	UcE+ytuls05L3rrSGwZ9PBe9OUjR5hNKCz+XB4f45sHo4L8wfy7kjpPC3tvbgDQfwgC/hGQIRnF
	6Iv70oAIZk8hOi4tZlQV2hL1Oj2sW2/NXeDzFpZg/BJOi7qX5N+bJ5I7Zl2+/EQ==
X-Received: by 2002:a05:600c:1ca8:b0:412:52a2:bd4e with SMTP id k40-20020a05600c1ca800b0041252a2bd4emr11689184wms.3.1708594735321;
        Thu, 22 Feb 2024 01:38:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMnKjbckCWhczRwAG585M6C2mhZOHxTNTdSk4rMneElz89fYAs3onf90whOGWwLN1Vun6v2g==
X-Received: by 2002:a05:600c:1ca8:b0:412:52a2:bd4e with SMTP id k40-20020a05600c1ca800b0041252a2bd4emr11689170wms.3.1708594734960;
        Thu, 22 Feb 2024 01:38:54 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-224-236.dyn.eolo.it. [146.241.224.236])
        by smtp.gmail.com with ESMTPSA id p9-20020a7bcc89000000b00412393ddac2sm5426873wma.6.2024.02.22.01.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 01:38:54 -0800 (PST)
Message-ID: <55c1527f778ada6458dfc3d626d36e5367886dbb.camel@redhat.com>
Subject: Re: [PATCH v2] net: stmmac: mmc_core: Drop interrupt registers from
 stats
From: Paolo Abeni <pabeni@redhat.com>
To: Jesper Nilsson <jesper.nilsson@axis.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kernel@axis.com
Date: Thu, 22 Feb 2024 10:38:53 +0100
In-Reply-To: <20240220-stmmac_stats-v2-1-0a78863bec70@axis.com>
References: <20240220-stmmac_stats-v2-1-0a78863bec70@axis.com>
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

On Tue, 2024-02-20 at 13:00 +0100, Jesper Nilsson wrote:
> The MMC IPC interrupt status and interrupt mask registers are
> of little use as Ethernet statistics, but incrementing counters
> based on the current interrupt and interrupt mask registers
> makes them actively misleading.
>=20
> For example, if the interrupt mask is set to 0x08420842,
> the current code will increment by that amount each iteration,
> leading to the following sequence of nonsense:
>=20
> mmc_rx_ipc_intr_mask: 969816526
> mmc_rx_ipc_intr_mask: 1108361744
>=20
> These registers have been included in the Ethernet statistics
> since the first version of MMC back in 2011 (commit 1c901a46d57).
> That commit also mentions the MMC interrupts as
> "something to add later (if actually useful)".
>=20
> If the registers are actually useful, they should probably
> be part of the Ethernet register dump instead of statistics,
> but for now, drop the counters for mmc_rx_ipc_intr and
> mmc_rx_ipc_intr_mask completely.
>=20
> Signed-off-by: Jesper Nilsson <jesper.nilsson@axis.com>

It looks like this could target the 'net' tree. Anyway it does not
apply cleanly to 'net' nor 'net-next'. Could you please rebase &&
repost, including Serge's tags and explicitly setting the target tree
into the subj prefix?

Thanks!

Paolo


