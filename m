Return-Path: <linux-kernel+bounces-107375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0D087FBA4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4FF1F228EA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A719B7E10D;
	Tue, 19 Mar 2024 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FH51gcbG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657B27D419
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710843449; cv=none; b=Ou2x+kQvbW5itUCqjeIhQnIJ8BqmAUQpeWu3H7eKmrOA3f7EphqGhtgsd+4d7TLs/mxwTQJsoNnDmi/AjWAxIXt+QSqU/XZheTg8uNBuSOjf/AZ2dJNa1QBuJX5ZBbnu3PFGI/afwNZWyz2kowMoa6b/99XceYCG1mJbF0ZSCGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710843449; c=relaxed/simple;
	bh=+vYQuE4cmp5aqOHp2teOxW5ChzVfrnEdCOORJu5LYOE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FARre/Z7KNr1bluo8fpiN+KU9R10mu+lfT9X32Q8GTBC3pQ0FflxhGQOLnuOWVu/vg8EyL8PLtbdk4Jy7Ng7bMbjYHtBtbnhtacivwFSxOg9RFHwKQFaV45uOgnKvILmeW5J4QplwVzsYQXzUWAIQzAYl55Ea06jRDsf3jtYM1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FH51gcbG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710843447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+vYQuE4cmp5aqOHp2teOxW5ChzVfrnEdCOORJu5LYOE=;
	b=FH51gcbGXDtrM/imgwQNpiqT8fa/3y3NnK08hrMSw2BlFcvgPKCcHe4io989JRaBsmWJW8
	MdMZfzbPeXcqscmKOUu7VSqqkw0nyKESW4o+MZi/RXp59/CA5+Yh9oGLtC/vHcV3K54lcm
	U//yCpAu/pDlDr1CpfNozSofJXZHCFA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-fJr0uFgxNyS6Y5FatbGR_A-1; Tue, 19 Mar 2024 06:17:25 -0400
X-MC-Unique: fJr0uFgxNyS6Y5FatbGR_A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4141087d9b4so3784455e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710843445; x=1711448245;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vYQuE4cmp5aqOHp2teOxW5ChzVfrnEdCOORJu5LYOE=;
        b=xKl6LEWZxYupINkWu84Wkwa7WdlrkPyO8y1imxFifpiS5JQVQmYEFLmP0826zf/fRq
         bhG+uJOtg48KtjkjErgXQhXKTemLdMkRJ25mQanmpHrb5eFdzL9k0gXW5ipT3vepob5U
         l1wd7JbTZs0P/1RYkpyuyCmJQKjfyAHRGUhoyT80tXMy4VDm+Y1zrELOBynoboZE0QUb
         6Qo56542LosotVFqfjkLLZOatSUfQFNgiDbuYSXdGaBQakjpcHdtVyT05E5M/8Vvht3H
         U8T0s6dLFtV3RfxzRGjTsnjRmQdo17vOiVNKIQkae/bETbRukQcDrZIb4/LgXlexr4/7
         0KhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmZSOs/wlQwwFw+eAqXWhy8zPWpS+6vk0KiXexs71iv4mdjBkTa2FMWm61QvUURiCG4+2xv4sQsvRkX/2LjD1y9Pxt5661IMyHWvBM
X-Gm-Message-State: AOJu0YyaoU/SROpDL5S7dq4cT6v+Y7kqGNt9oRpXeSj/xXwi08k8Myyb
	a+MYJbPvyPNqbd0yLdRltRjytW5SS3SHIXlopMJgTQmoH2BwArX8MTl5MGAWIf/aYRQJqrhjp8F
	LaPia2om7UBPpij7uEQIFM7xwn00TMjM9NVl3B5Jz88R2XtJMHsQsy6Ct1lujyg==
X-Received: by 2002:a5d:453c:0:b0:33e:4503:3ba4 with SMTP id j28-20020a5d453c000000b0033e45033ba4mr1206451wra.7.1710843444756;
        Tue, 19 Mar 2024 03:17:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdn2WDMuJ0ENj52hlQsZAerS1NC2YHv+deowOx7596Wgkk+Z2m3oT0AzcYJXihtGvK3foxqQ==
X-Received: by 2002:a5d:453c:0:b0:33e:4503:3ba4 with SMTP id j28-20020a5d453c000000b0033e45033ba4mr1206441wra.7.1710843444383;
        Tue, 19 Mar 2024 03:17:24 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-224-202.dyn.eolo.it. [146.241.224.202])
        by smtp.gmail.com with ESMTPSA id p10-20020a5d638a000000b0033e206a0a7asm11905057wru.26.2024.03.19.03.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:17:23 -0700 (PDT)
Message-ID: <557e819bc6acdfc2311fe2254b1f382bad8368fc.camel@redhat.com>
Subject: Re: [PATCH iwl-next 5/7] i40e: Consolidate checks whether given VSI
 is main
From: Paolo Abeni <pabeni@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>, intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "open
 list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Date: Tue, 19 Mar 2024 11:17:22 +0100
In-Reply-To: <20240318143058.287014-6-ivecera@redhat.com>
References: <20240318143058.287014-1-ivecera@redhat.com>
	 <20240318143058.287014-6-ivecera@redhat.com>
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

On Mon, 2024-03-18 at 15:30 +0100, Ivan Vecera wrote:
> In the driver code there are 3 types of checks whether given
> VSI is main or not:
> 1. vsi->type =3D=3D/!=3D I40E_VSI_MAIN
> 2. vsi =3D=3D/!=3D pf->vsi[pf->lan_vsi]
> 3. vsi->seid =3D=3D/!=3D pf->vsi[pf->lan_vsi]->seid
>=20
> All of them are equivalent and can be consolidated. Convert cases
> 2 and 3 to case 1.

Minor nit: while at it, what about introducing an helper for such
check?

Reordering the patches you could use it also in i40e_pf_get_main_vsi()

Cheers,

Paolo


