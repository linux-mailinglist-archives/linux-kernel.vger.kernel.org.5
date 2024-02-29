Return-Path: <linux-kernel+bounces-87413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E0986D417
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72BB9B22B75
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C320413F44E;
	Thu, 29 Feb 2024 20:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2Z1DD3h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E4513F444
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 20:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238110; cv=none; b=DwHDQCPaypiqrH5yRWeSFVjdaeP8h95EZ/VLvb7WSB4zI3t2C7vdGNvAWstH3VJoCbM6T0BhMaYJZM7pH85axGgXlLD/fyBO2F3XuNlePfToeDoakPyWlFYpJuoicJZMqz4T2YL1E34sKS/MQT4oSgrE6ElrtjhGD9DznctvwJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238110; c=relaxed/simple;
	bh=B/FPXkXJQHjEdyhG6FtQ84TAISWlz+G6nkI1lh/lQdc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ck07LTRbBVaRnNFw6o9qV8X4gILZQ+5dmdZ70haN835fDYM8x9ht//O7Db5B7w4uSqSmj5+RIAN39mDuoNrPF33iDoozuabometP4hu/U1fwoXufh2xwvzcqliq39Ib+PnUlp4HwuJGfiU7YaqillPgLM6GuEMHGyrWFssf4q4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C2Z1DD3h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709238107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B/FPXkXJQHjEdyhG6FtQ84TAISWlz+G6nkI1lh/lQdc=;
	b=C2Z1DD3heZIIQ3bua6r3VWMO6h48Ic5xwFNC8NK0Stg/xY5AGkRfjnREZLPsmKl1O2iR+q
	6e5UgrjfyZ/58+oEV/0flFUhcnBNu4VNUXs7n86dx8uTEPXM+j+irb40ATcifooL3k1X/m
	yvwCQQT3brJUZKNjbupAbBXGNxkesu4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-3aXtK3lCOQ2h8fNpAmtlCw-1; Thu, 29 Feb 2024 15:21:45 -0500
X-MC-Unique: 3aXtK3lCOQ2h8fNpAmtlCw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a4469e9f1d6so7479066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 12:21:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709238105; x=1709842905;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B/FPXkXJQHjEdyhG6FtQ84TAISWlz+G6nkI1lh/lQdc=;
        b=kDMx2eBbGIxiemziZqlv9vW5JHs+bplBQmQCeP9DjnAbKcDzjU7bN8jgxu880pM+Uh
         WHeQpeJSY4GpowieMTbJWV/yyPABMY2DVzrrnhrCpknW7H9GdaMiXpY4S5VO/c+epohj
         Ajp019KwhhbyADjcYys44NNoGqFxMBf9FGtPGh0H2vxcZKbi7TxWJBBoVwf6V3ZbBihT
         01UMfa1CmDt4sah8SiTBTVgBV9/DgPmrX3CX26Vf8Lru3FJqAVdJkzBNvHHqO/KdAVKL
         RWr7cL5NU48RwDC1QLZMObNHUv1Pv+wCUseOB7leSndYW3XEr9AXI1fsBNB7Im8qs+9A
         IOmw==
X-Forwarded-Encrypted: i=1; AJvYcCVzzRhYPt2UfKSIuadNLVkU/8NdAu8s4HhEKCC6OqKmfRf3khdbFa2DLYKkwgxmv/AJZD9p4Ob1wQwXdkxser85Vpbhc8weAeIQJb81
X-Gm-Message-State: AOJu0YxOqKOWjUiEJnOdED1ycm2/PzXzoNCsjNDkEccfYyi+nfDv8n1T
	CSWdu11wOuIPBYB/QFW7kMWRvmFC0tYB0/rMe8qq3OEkCTVUNzEAWwxoFvWMh1Xvqv1APGB68CV
	7/47YQ3jxl3E+dn3YBuZCDLauJ64wuqBHimUNbzTFoC0HZHIZNc4/4NQIIxKsEQ==
X-Received: by 2002:a17:906:329a:b0:a44:6c6:ec19 with SMTP id 26-20020a170906329a00b00a4406c6ec19mr2211766ejw.4.1709238104841;
        Thu, 29 Feb 2024 12:21:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyR///ox6dmfGu1a3KKFAP2iJUGQ4gUqD1RZZA4XKk5YeDaDfoNLJk/ZUKOsfZ585Ss19fKQ==
X-Received: by 2002:a17:906:329a:b0:a44:6c6:ec19 with SMTP id 26-20020a170906329a00b00a4406c6ec19mr2211754ejw.4.1709238104469;
        Thu, 29 Feb 2024 12:21:44 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32e0:8800:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id lb24-20020a170906add800b00a4131367204sm999270ejb.80.2024.02.29.12.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 12:21:44 -0800 (PST)
Message-ID: <d9b2ce52569b2c6a745ca3efa678fa83adfe0fac.camel@redhat.com>
Subject: Re: [PATCH v2 2/2] devres: Don't use "proxy" headers
From: Philipp Stanner <pstanner@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes
	 <linux@rasmusvillemoes.dk>, pstanner@redhat.com
Date: Thu, 29 Feb 2024 21:21:43 +0100
In-Reply-To: <20240229155507.3853059-3-andriy.shevchenko@linux.intel.com>
References: <20240229155507.3853059-1-andriy.shevchenko@linux.intel.com>
	 <20240229155507.3853059-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Wait a second..

On Thu, 2024-02-29 at 17:53 +0200, Andy Shevchenko wrote:
> Update header inclusions to follow IWYU (Include What You Use)
> principle.

Hm, what tree is this based on?

>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> =C2=A0lib/devres.c | 9 ++++++---
> =C2=A01 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/lib/devres.c b/lib/devres.c
> index 27f280a39dca..4fc152de6d8b 100644
> --- a/lib/devres.c
> +++ b/lib/devres.c
> @@ -1,10 +1,13 @@
> =C2=A0// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bug.h>
> =C2=A0#include <linux/device.h>

Where does device.h come from?
That's not on master, is it? (see below).

Is this based on my PCI-devres series?

> -#include <linux/err.h>
> -#include <linux/io.h>
> -#include <linux/gfp.h>
> +#include <linux/errno.h>
> =C2=A0#include <linux/export.h>
> +#include <linux/gfp_types.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> =C2=A0#include <linux/of_address.h>
> +#include <linux/types.h>
> =C2=A0
> =C2=A0enum devm_ioremap_type {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0DEVM_IOREMAP =3D 0,

That's what's currently in Linus's master:

// SPDX-License-Identifier: GPL-2.0
#include <linux/err.h>
#include <linux/pci.h>
#include <linux/io.h>
#include <linux/gfp.h>
#include <linux/export.h>
#include <linux/of_address.h>

enum devm_ioremap_type {



P.


