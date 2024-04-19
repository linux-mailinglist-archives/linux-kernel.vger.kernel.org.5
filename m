Return-Path: <linux-kernel+bounces-151331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526178AAD11
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D18F1282906
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD3F80034;
	Fri, 19 Apr 2024 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MAOxZKaB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5857883D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713523801; cv=none; b=rN26vqFoPI4lQ1fi9bN6PSBzJgLyB1PK1J4jauo59f+2C1kXoU2OiwUXV8iaVfF39s3Fnskl2/Y4CJbfFRF4BKqIc3sO8FZmdscqesDkaprUwrK2tn0k9jyyDM5h9cE8B/WNMe59ryfpoehV2K1z6ifqYi1bc7jCL0PnUMHrXJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713523801; c=relaxed/simple;
	bh=hjId5g25Qv0MAFJVEGSlgl5IE0yTiV+lXkMvoweZIJc=;
	h=From:To:Cc:Subject:Date:MIME-Version:Message-ID:In-Reply-To:
	 References:Content-Type; b=pBOeq9yqiJYGaEFsaps6sbzQ8tpctgX5KceCehcZRnu2m5ZgoZuBJj2Mafc2KZNDs7CF0P93QkU7hFKhc8t8Bl5gE5VM3Tu82muHueneaHnAGfUp/UK7QHwY8UZBfwzaz4rY48RtqWWx4LcJrRwhPgV1svBNuVi2KGMALtKuipo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MAOxZKaB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713523798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EeYX0GCkCOIaHHXjBHu66M1OAJv9FbPYfe8qhd0NzCo=;
	b=MAOxZKaBsiw14GPDKCms09K3E6i20/zff92X7I56EesLY2MoI9OBwMgyqRVEIlg3GELSu8
	Vc9aGpGFS2XIxfhRQ7xY6mVxVu5J0yD4pRj+rGsOVETbDS3GzO97Bls8ksu8kEKqou3Vbl
	tF+bGMDhux7Jgos1E8raxGcbG40MjeM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-SsTqOgmpMbSVegwcKQrung-1; Fri, 19 Apr 2024 06:49:57 -0400
X-MC-Unique: SsTqOgmpMbSVegwcKQrung-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2da2f30cb50so14291451fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 03:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713523796; x=1714128596;
        h=content-transfer-encoding:user-agent:organization:references
         :in-reply-to:message-id:mime-version:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EeYX0GCkCOIaHHXjBHu66M1OAJv9FbPYfe8qhd0NzCo=;
        b=diTSSe4U0oKoG7hjqt04bncVvFqqXX07e+HemvxInHxhXCbvEkadOzzAGQGoA0QV2q
         jfEHVW2K91AW6ceTQQfHe9U3pLA+UQZiX3M78JWjZ+M82UfGNleVJdG4NokCsE6B55Vd
         U1VxbWYxUvJ1jTavQ4v4nFcqWEsxWuxlhBEFOhpl5ZldT9Acfx+ZFPESiaFnKna/bCOx
         lx3cpIG3UAoIKNwe/ZjOzSfsXFHtPzpEE4PzFRhGTIfHmd8w+DqmBGXG6CpptwKU6qku
         pM6hbPUzj5StUWZ8Mvr19+MKqRf+l6YNpg/KpnLwSwmXPtfuOdAWoCd8jPQnivF1b+mx
         7pXw==
X-Forwarded-Encrypted: i=1; AJvYcCUxlgS6S8xucRf9eSeJp8NqDdImCqiYV3uuQrNq1ul2P6IlLvRXojxC5eBf/MdlR0el3VcUgrWPYyHt91ub9wG5QUCZ56ey7h6poryA
X-Gm-Message-State: AOJu0YxobyuxMSsdmeoBXl+/LQKzTJ5kMSbWc4hIvMqkI9JuzU+jYsq5
	xX/lEoBGNIyQPnt6WJIlLzjuw+qNrkEWivdkQng4AioZHjIS7oiS5ptdCp5VCce2u4ccLhuNaE4
	Iq/AoOZCFB5dffZy62Qu8rxk3w9PZ6jRBWt45GNas8/mF94IlfZKUlPE2injo0A==
X-Received: by 2002:a05:651c:ba8:b0:2da:802b:2154 with SMTP id bg40-20020a05651c0ba800b002da802b2154mr1212112ljb.16.1713523796109;
        Fri, 19 Apr 2024 03:49:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKOtccsa62gbBZd13tf2iicSZXbwVy7DIQiuVk1wQcVTSS2RHGWNvJAuAi46NFjX5Oaqwdcw==
X-Received: by 2002:a05:651c:ba8:b0:2da:802b:2154 with SMTP id bg40-20020a05651c0ba800b002da802b2154mr1212098ljb.16.1713523795706;
        Fri, 19 Apr 2024 03:49:55 -0700 (PDT)
Received: from localhost (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id fm25-20020a05600c0c1900b00418e2b69e14sm5765738wmb.40.2024.04.19.03.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 03:49:55 -0700 (PDT)
From: Hubert Kario <hkario@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: <linux-crypto@vger.kernel.org>,
 <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>,
 <linux-kernel@vger.kernel.org>,
 <jarkko@kernel.org>,
 <ardb@kernel.org>,
 <git@jvdsn.com>,
 <simo@redhat.com>
Subject: Re: [PATCH v3 0/2] crypto: ecdh & ecc: Fix private key byte ordering =?iso-8859-1?Q?issues?=
Date: Fri, 19 Apr 2024 12:49:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <15623fb6-1ecc-4e6a-872b-07172a3674aa@redhat.com>
In-Reply-To: <20240418152445.2773042-1-stefanb@linux.ibm.com>
References: <20240418152445.2773042-1-stefanb@linux.ibm.com>
Organization: Red Hat
User-Agent: Trojita/0.7-git; Qt/5.15.11; xcb; Linux; Fedora release 38 (Thirty Eight)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Both patches look good to me.

On Thursday, 18 April 2024 17:24:43 CEST, Stefan Berger wrote:
> The 1st patch fixes a byte ordering issue where ctx->private_key is
> currently passed to ecc_is_key_valid but the key is in reverse byte order.
> To solve this issue it introduces the variable 'priv', that is already used=

> throughout the ecc and ecdh code bases for a private key in proper byte
> order, and calls ecc_is_key_valid with 'priv'. Note that ecc_gen_privkey
> also calls __ecc_is_key_valid with 'priv' already.
>
> The 2nd patch gets rid of the 'priv' variable wherever it is used to hold
> a private key (byte-swapped initialized from ctx->private_key) in proper
> byte order and uses ctx->private_key directly that is now initialized in
> proper byte order.
>
> Regards,
>   Stefan
>
> v3:
>   - Added Jarkko's A-b tag
>   - Expanded on the description of changes to ecc_gen_privkey (2/2)
>
> v2:
>   - Added missing zeroizing of priv variable (1/2)
>   - Improved patch description (2/2)
>
>
>
>
> Stefan Berger (2):
>   crypto: ecdh - Pass private key in proper byte order to check valid
>     key
>   crypto: ecdh & ecc - Initialize ctx->private_key in proper byte order
>
>  crypto/ecc.c                  | 29 ++++++++++-------------------
>  crypto/ecdh.c                 |  9 ++++++---
>  include/crypto/internal/ecc.h |  3 ++-
>  3 files changed, 18 insertions(+), 23 deletions(-)
>

--=20
Regards,
Hubert Kario
Principal Quality Engineer, RHEL Crypto team
Web: www.cz.redhat.com
Red Hat Czech s.r.o., Purky=C5=88ova 115, 612 00, Brno, Czech Republic


