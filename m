Return-Path: <linux-kernel+bounces-129613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E77896D52
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8CB28FAD3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E4613A271;
	Wed,  3 Apr 2024 10:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCzBAQrA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29331136989
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141619; cv=none; b=dpAx2m85HdG9NYy2dPXbeuqw6RJw8d30amKSqNNFgVNaNkxG2bIdZWEBRVjDnCcJwW2zZup5oNiEV3rjsytWOxEhqRFKS6QJvYHOeg5rOIgJsp6ypviwrGreG0yaV9Yv5IH8G8dU8f7Rnc9f6sLYgC8y2HP4FgkWX8Q3MM6kOLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141619; c=relaxed/simple;
	bh=8+OO5fg0HbK1fATSGiD8L9xS5yKSj1z9Ff9gG/OGB54=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iCRuf2EweVAj0W4acr6lBhHxrLDwhC8fe6eFaa8gEDQLQHbE7CWAcp03A8bDj56g3MKM6qM5jKziRLxtAaG+rJkqnPLgXiTE37HAHJxgE9JpZKysM2+BX9Q/64ijPRV3l6BoBOWOEMoKITLDLwKifJrjv6YbR/a2V8rULRXAuTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GCzBAQrA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712141616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8+OO5fg0HbK1fATSGiD8L9xS5yKSj1z9Ff9gG/OGB54=;
	b=GCzBAQrAd7xSYvzP3WxGcVOfyzM/PL7kjdQOYI02mDeCQAdtPQn/AV1iH+MZLGnikAb0hE
	tZuUB40Mb/JxXP9ngYsu4CHeD8IpNSNHleVapw2NFZh9g0KL/uWBXL6hN0AikAecnKKDfj
	MfoTl37DViFk0HCqznHqBB1ulapChAw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-ZsM07JpSNECUr9XhDph-Sg-1; Wed, 03 Apr 2024 06:53:25 -0400
X-MC-Unique: ZsM07JpSNECUr9XhDph-Sg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d49590ee73so10474211fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 03:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712141604; x=1712746404;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+OO5fg0HbK1fATSGiD8L9xS5yKSj1z9Ff9gG/OGB54=;
        b=oMuv99Ro4ND6X1POpcKXsviCIrOKpXt+RQcFn+/+DtLlTGhHxhI9fqOKy5/u9yiOSk
         bz1MCBDe2H1mN9N546Z6T3BOpeRhheuLEQqg2jcooZalePEtfb2gJMqcatQjgyJhaDXf
         GzmWq59aBi0RBKZ67efmDu2mvVFeNGbLrKPXGENOaxMOzGEkZY8J+8FJ3M0dDaVsGm1N
         l64XLtxw64pG97VZ8A+/tlLesId7F7qwUggCzZD197/y+body6W5FPtBCbcRa3+yDWEN
         wKl68KF/TJX8CE6R6wLimXU+VuQdUaDqJP04om06iYZaXFEVUuVjMgBLS/P3zJzWU78Z
         4GNA==
X-Forwarded-Encrypted: i=1; AJvYcCXAsxk4tAOMDBgvb661RrtafaQ2YhkryMo0gtBGyd1ziq5+R7OOaw/7coVHeftoHtirRfor/CePF9oN6lwhuPqP3nfluGhWehThUUVL
X-Gm-Message-State: AOJu0YwUqKGJMAnXTmwmGSC+8sp+uNNqyDl8RBILSWDGmHtEcIRfdHKx
	bOPtV+wbNYbx9mtxKZz7jThk4seD6KPqYWX83un7KMs/8zjBumEI2znYIC3neW8xrUyqV+RUxgR
	M0Xz9ZM6udUB1aCx2FlIeIRs/MB8Uy1WntG6mrVelsQp9fF5XOekJ+lk0EGv3iPSEJw50Sg==
X-Received: by 2002:a05:6512:7b:b0:516:ae65:73db with SMTP id i27-20020a056512007b00b00516ae6573dbmr4381289lfo.3.1712141604100;
        Wed, 03 Apr 2024 03:53:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjn7dG+sxNM/GDupLVuY/mvqIzKlvjQq9VhNhWJkqbmTDC3k9ch7DJcWzRvAmguatrfS3H8w==
X-Received: by 2002:a05:6512:7b:b0:516:ae65:73db with SMTP id i27-20020a056512007b00b00516ae6573dbmr4381282lfo.3.1712141603723;
        Wed, 03 Apr 2024 03:53:23 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id z2-20020a05600c0a0200b00415515263b4sm17094709wmp.7.2024.04.03.03.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 03:53:23 -0700 (PDT)
Message-ID: <bf586356686053641b52902bf7928db08baa44ea.camel@redhat.com>
Subject: Re: [PATCH v4 0/2] devres: A couple of cleanups
From: Philipp Stanner <pstanner@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 03 Apr 2024 12:53:22 +0200
In-Reply-To: <20240403104820.557487-1-andriy.shevchenko@linux.intel.com>
References: <20240403104820.557487-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-03 at 13:46 +0300, Andy Shevchenko wrote:
> A couple of ad-hoc cleanups. No functional changes intended.

But it seems that since v3 my "Reviewed-by"s have disappeared. Is that
intentional, should I look through it again?

P.

>=20
> v4:
> - rebased on top of the latest vanilla (v6.9-rcX)
>=20
> v3:
> - rebased on top of driver-core-testing (Philipp)
> - added tags (Philipp)
>=20
> v2:
> - fixed plural vs. singular "to have" (Philipp)
>=20
> Andy Shevchenko (2):
> =C2=A0 devres: Switch to use dev_err_probe() for unification
> =C2=A0 devres: Don't use "proxy" headers
>=20
> =C2=A0lib/devres.c | 26 +++++++++++++++-----------
> =C2=A01 file changed, 15 insertions(+), 11 deletions(-)
>=20


