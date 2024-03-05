Return-Path: <linux-kernel+bounces-91780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EED1087167B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EAEB281517
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A823F7E59A;
	Tue,  5 Mar 2024 07:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcYPXvoe"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8817D3FE;
	Tue,  5 Mar 2024 07:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709622857; cv=none; b=E9gP+bgxV4SlUWdETaDzK+MCc7oLJR4+mzLpe5X699Gk9KKd0iCQQVEr+rByQEVZX62OXbRobDTDufkbPxxmPeOURD36QDVHD1tzAR1XIDvXC25dZSFykA1kW9uK1st6cg83gKDGL8o4lIQR4ReH7L/+YMSBOR5VIDCilPdxkk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709622857; c=relaxed/simple;
	bh=SIYTczHVdxaeGArMm3hbe+IIsqq3i7S0WVZ3zb5Tdpk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VmTg2XtLjcBWnavXudby+s+mGqGWDdUTyowmpIx9UkJUCT9xI9RKjuciK3KeOcD3MdG/3akjoo9Qh6iZELxKx+hmeLDFPiNIyzOXHkLmPaB3zjArFh3620oOyKMieaCmG9fo7zt/hT0ZGXG9WNOstYUERcco1YVPzkEKSLDpaas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcYPXvoe; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5658082d2c4so7267237a12.1;
        Mon, 04 Mar 2024 23:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709622854; x=1710227654; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SIYTczHVdxaeGArMm3hbe+IIsqq3i7S0WVZ3zb5Tdpk=;
        b=RcYPXvoecgP7AKGs75WELWboEyeAfCL5PsVBnVAqmUa7CBbgtg+soUdvC5+oQaGmRF
         870+T6Wznka/SqNdmD8TbqXh/wMnNchQH0Ri+Xf9M5d66RVMFKhbxoMuwswXmg/0WX53
         7J9sbPj0Ze3fuRY6haBdWdE8835vOZBvjFkQ4sqocWRk6ohiFqneTd5sdNFhDwqo38wt
         80qi/S4QQcxOZmhIaBg/KK0qCEstcUbK4s4PwVpaUTMQ/EuJStdVCe3oakkOP1R5i5XM
         uIlDQVbqH7jnkXApA24J4Se1zX5S/kP6s2jV8PpZyW5uijOgyM9hqfJkc984bMb9aI1+
         W9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709622854; x=1710227654;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SIYTczHVdxaeGArMm3hbe+IIsqq3i7S0WVZ3zb5Tdpk=;
        b=w2w7tSz+K0IOuaoyCg+D+FaccYeXpbWZglvezNug/FEPZ0gpdYqf8ihne1iHTqvvai
         ZThAlh56iSBvZSA2opLDBvkkzvOAoC3FfFSy6EC1SxHGerOwJs4o5OFFicv+yam+69Vs
         n3ABZKwBN1FrptQu5RUDCmYWexfygBxTNBLcQ+Gi72pu0a22KqKMhm5iGe9o8ud9/SQG
         74WRmELELluHzPmvTRQEFiblLH2rb7b0X+e0MGuyGSioe8SgKWin/NrPcFa17cGU00VQ
         qdBh1Xxb19T6GTt2WsemyZ55ItSggWhBRH1uZ6rBRCghuXjrjAcSfIpdCzsYxnpMwLs3
         aRqw==
X-Forwarded-Encrypted: i=1; AJvYcCWD7rPzGGH9Oc4Z4nCTA2f9EHbc/OvSNttn4Il+TWHA1Qh7kEwJkGG7/gAenRuwLd766wkyxrZ3f/Aqh4SKo2VNQrkC/UBpRIlV94rNwl8aORHjpNOeVBAoMtC/DMQjZm5L7jKgNY6VoQ==
X-Gm-Message-State: AOJu0YyHjjquVV2t3nw9olRnR3LfdzvwW7soKWAIQfr502ChALQGfW/b
	063LPd3Qt6zERbS0+7pMgLtD78Z1JxR2zGyHjQKf2Q3Inh8BxQCY
X-Google-Smtp-Source: AGHT+IEpIQj0ZZ8kz+w9e760n/zFqI6d6t5uOCxp1QwEmIpJPs/iv4eB0RULE9ITJoF1PMPtB/aYOw==
X-Received: by 2002:a50:8dc7:0:b0:566:131a:26ee with SMTP id s7-20020a508dc7000000b00566131a26eemr7127162edh.35.1709622853937;
        Mon, 04 Mar 2024 23:14:13 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id h26-20020aa7c95a000000b005663b0d7243sm5455225edt.83.2024.03.04.23.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 23:14:13 -0800 (PST)
Message-ID: <ca0e141e624edb4f9977ea9f805f74645654bca7.camel@gmail.com>
Subject: Re: [PATCH v3 0/2] Synchronize DT overlay removal with devlink
 removals
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Saravana Kannan <saravanak@google.com>, Rob Herring <robh@kernel.org>
Cc: Herve Codina <herve.codina@bootlin.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, Max
 Zhen <max.zhen@amd.com>,  Sonal Santan <sonal.santan@amd.com>, Stefano
 Stabellini <stefano.stabellini@xilinx.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Date: Tue, 05 Mar 2024 08:17:38 +0100
In-Reply-To: <CAGETcx96Nj1RnR2wFOZYJRr=kyBLkcobY0crxBFSLGWmNaXT4A@mail.gmail.com>
References: <20240229105204.720717-1-herve.codina@bootlin.com>
	 <20240304150248.GA211460-robh@kernel.org>
	 <CAGETcx96Nj1RnR2wFOZYJRr=kyBLkcobY0crxBFSLGWmNaXT4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-03-04 at 22:17 -0800, Saravana Kannan wrote:
> On Mon, Mar 4, 2024 at 7:02=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
> >=20
> > On Thu, Feb 29, 2024 at 11:52:01AM +0100, Herve Codina wrote:
> > > Hi,
> >=20
> > Please CC Saravana on this.
>=20
> Nuno, this is why I was replying to the older series. I didn't even
> get this one.

Arghh, I see... In lot's of replies I was mentioning you :)

- Nuno S=C3=A1

>=20
> >=20
> > >=20
> > > In the following sequence:
> > > =C2=A0 of_platform_depopulate(); /* Remove devices from a DT overlay =
node */
> > > =C2=A0 of_overlay_remove(); /* Remove the DT overlay node itself */
> > >=20
> > > Some warnings are raised by __of_changeset_entry_destroy() which=C2=
=A0 was
> > > called from of_overlay_remove():
> > > =C2=A0 ERROR: memory leak, expected refcount 1 instead of 2 ...
> > >=20
> > > The issue is that, during the device devlink removals triggered from =
the
> > > of_platform_depopulate(), jobs are put in a workqueue.
> > > These jobs drop the reference to the devices. When a device is no mor=
e
> > > referenced (refcount =3D=3D 0), it is released and the reference to i=
ts
> > > of_node is dropped by a call to of_node_put().
> > > These operations are fully correct except that, because of the
> > > workqueue, they are done asynchronously with respect to function call=
s.
> > >=20
> > > In the sequence provided, the jobs are run too late, after the call t=
o
> > > __of_changeset_entry_destroy() and so a missing of_node_put() call is
> > > detected by __of_changeset_entry_destroy().
> > >=20
> > > This series fixes this issue introducing device_link_wait_removal() i=
n
> > > order to wait for the end of jobs execution (patch 1) and using this
> > > function to synchronize the overlay removal with the end of jobs
> > > execution (patch 2).
> > >=20
> > > Compared to the previous iteration:
> > > =C2=A0
> > > https://lore.kernel.org/linux-kernel/20231130174126.688486-1-herve.co=
dina@bootlin.com/
> > > this v3 series:
> > > - add the missing device.h
> > >=20
> > > This series handles cases reported by Luca [1] and Nuno [2].
> > > =C2=A0 [1]: https://lore.kernel.org/all/20231220181627.341e8789@booty=
/
> > > =C2=A0 [2]:
> > > https://lore.kernel.org/all/20240205-fix-device-links-overlays-v2-2-5=
344f8c79d57@analog.com/
> > >=20
> > > Best regards,
> > > Herv=C3=A9
> > >=20
> > > Changes v2 -> v3
> > > =C2=A0 - Patch 1
> > > =C2=A0=C2=A0=C2=A0 No changes
> > >=20
> > > =C2=A0 - Patch 2
> > > =C2=A0=C2=A0=C2=A0 Add missing device.h
> > >=20
> > > Changes v1 -> v2
> > > =C2=A0 - Patch 1
> > > =C2=A0=C2=A0=C2=A0 Rename the workqueue to 'device_link_wq'
> > > =C2=A0=C2=A0=C2=A0 Add 'Fixes' tag and Cc stable
> > >=20
> > > =C2=A0 - Patch 2
> > > =C2=A0=C2=A0=C2=A0 Add device.h inclusion.
> > > =C2=A0=C2=A0=C2=A0 Call device_link_wait_removal() later in the overl=
ay removal
> > > =C2=A0=C2=A0=C2=A0 sequence (i.e. in free_overlay_changeset() functio=
n).
> > > =C2=A0=C2=A0=C2=A0 Drop of_mutex lock while calling device_link_wait_=
removal().
> > > =C2=A0=C2=A0=C2=A0 Add=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'Fixes' ta=
g and Cc stable
> > >=20
> > > Herve Codina (2):
> > > =C2=A0 driver core: Introduce device_link_wait_removal()
> > > =C2=A0 of: overlay: Synchronize of_overlay_remove() with the devlink =
removals
> > >=20
> > > =C2=A0drivers/base/core.c=C2=A0=C2=A0=C2=A0 | 26 ++++++++++++++++++++=
+++---
> > > =C2=A0drivers/of/overlay.c=C2=A0=C2=A0 | 10 +++++++++-
> > > =C2=A0include/linux/device.h |=C2=A0 1 +
> > > =C2=A03 files changed, 33 insertions(+), 4 deletions(-)
> > >=20
> > > --
> > > 2.43.0
> > >=20


