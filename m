Return-Path: <linux-kernel+bounces-86293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C989186C382
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449D41F25B07
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B50E1E86C;
	Thu, 29 Feb 2024 08:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQDhQtZ0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0883653
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709195489; cv=none; b=ZxBAvoUUdQ+Obk5v/JACEDwecKlQxk/VtBdYeOFxTvUZFxzkTTKX7zFX0wxqzQvPP/zSvO4px4O38N6PKLQSs5UiaTYNsdsZhhMercgPnZV8vHSTcFKlLt8ODiqT35TR7G/1cSx9/2EZ2TD1KuOvNGA4F2FPmAFCI88ElP0OltU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709195489; c=relaxed/simple;
	bh=F96VMGY/1+ny0v3zBI/FmNuBoJ9l2wiLijc1Bjt3peM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DKMCEW+mIJxdscssOKteOQTomzXt7RrFq6UrMA8APx8pbeI+5hZqDjzZe/HZ+abWVWWyEkqZDmQhrmSALVz/FcOzT+uvfbuSkmvKA0Dq875ezyQXKdHlSVLkYvELCx3uQJ5jhvpil3PeHBO/dJopZwOv8UGgcl/b3BaupTb0xck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iQDhQtZ0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709195486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F96VMGY/1+ny0v3zBI/FmNuBoJ9l2wiLijc1Bjt3peM=;
	b=iQDhQtZ01+8reVTPL4ngYzM1Lh2Fx3iiFrr3gkbKcJ6/3yP/lPjEcNwp4EvyIex53mBYx+
	qxov+YWOS8oVkaTGTeyN14QmE2+ETcFMZQ2NjvAgg8CnWOXzxM+H3a/o+fAzW21ArVpG9m
	vHtshE3GbXWef+MWW4Qw7ch6ErYxy8U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-hHqwkUtiOVa-RUHIVcUdaQ-1; Thu, 29 Feb 2024 03:31:24 -0500
X-MC-Unique: hHqwkUtiOVa-RUHIVcUdaQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-565465a4df8so46830a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709195483; x=1709800283;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F96VMGY/1+ny0v3zBI/FmNuBoJ9l2wiLijc1Bjt3peM=;
        b=vgK3e8ILnfqTgtuSymc3O47QVtlfL3j5e13Zh867UvZ1kgXrtPKnCYvfI35fEmypBB
         y2MLD+BQmZsWqQixmsNWGUfz7F7COERA+9BS1QBqJFG/WhYzpYqoRIQRyHcBcAnpXg17
         c4SeH1NTnCEzQGxMqTviWzvJ7Bqz2ouwp26krd1Yw0KZJUIx4uKngNFs0dcP8FoI6+KU
         R6oYY37M2D6vKERrYj/cTrGEt6BgzmC0p+MwHjZathzL29gWHLXLrKzHZ881E3bYfRpb
         5Ko9kt5u0umNBw2qI4G0tp32MIpqdL+6WCI9z5W1UB8Lyoua8khDN2kyIZp9sOs9TOfa
         ZViA==
X-Forwarded-Encrypted: i=1; AJvYcCUVCUq3wOMdUuZfBcHWnP+nS81OPSzidwnsNLO9rdAilakuzFdvhojz6tisAeYnuIbYDKj0YoGRHXdM2DJKO2xPpbTaZ+w434a94qlg
X-Gm-Message-State: AOJu0Yz/mQGzIVBsztVmyQhtv7P+pobssB0N3RWDZDOKUqOxjdcseyll
	2CBuAH0AmY4FfFM2wKdN/YHRouhQBV5xdGtSl6/6i0cS1APpFWlEJNYsEpd9GB0AbVFRZm0eR6s
	ddYr7FTxRBnqBEq8ykuZRkGi+gadCCSqtdntqa6XEJ/hRjcaOvu04GFM6aUfkMR4uOtA4Qw==
X-Received: by 2002:a05:6402:348a:b0:565:4b6e:7f71 with SMTP id v10-20020a056402348a00b005654b6e7f71mr1021683edc.3.1709195482917;
        Thu, 29 Feb 2024 00:31:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJyLgQTYvjx+Awxx6Pkh5a+KQTrqM3/9iyg3u8Appxys0BavMevcua4mg/ZxWXcAt9yVscxA==
X-Received: by 2002:a05:6402:348a:b0:565:4b6e:7f71 with SMTP id v10-20020a056402348a00b005654b6e7f71mr1021663edc.3.1709195482544;
        Thu, 29 Feb 2024 00:31:22 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32e0:8800:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id en12-20020a056402528c00b005667bcc44b4sm395856edb.9.2024.02.29.00.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 00:31:21 -0800 (PST)
Message-ID: <2057fd477ad404c9adf603eac1ad933c04ecf293.camel@redhat.com>
Subject: Re: [PATCH v3 00/10] Make PCI's devres API more consistent
From: Philipp Stanner <pstanner@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Sam
 Ravnborg <sam@ravnborg.org>, dakr@redhat.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Date: Thu, 29 Feb 2024 09:31:20 +0100
In-Reply-To: <20240206134000.23561-2-pstanner@redhat.com>
References: <20240206134000.23561-2-pstanner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

@Bjorn:
Hey Bjorn, are we good with this series? Any more wishes or
suggestions?

P.


On Tue, 2024-02-06 at 14:39 +0100, Philipp Stanner wrote:
> Changes in v3:
> =C2=A0 - Use the term "PCI devres API" in some forgotten places.
> =C2=A0 - Fix more grammar errors in patch #3.
> =C2=A0 - Remove the comment advising to call (the outdated) pcim_intx() i=
n
> pci.c
> =C2=A0 - Rename __pcim_request_region_range() flags-field "exclusive" to
> =C2=A0=C2=A0=C2=A0 "req_flags", since this is what the int actually repre=
sents.
> =C2=A0 - Remove the call to pcim_region_request() from patch #10. (Hans)
>=20
> Changes in v2:
> =C2=A0 - Make commit head lines congruent with PCI's style (Bjorn)
> =C2=A0 - Add missing error checks for devm_add_action(). (Andy)
> =C2=A0 - Repair the "Returns: " marks for docu generation (Andy)
> =C2=A0 - Initialize the addr_devres struct with memset(). (Andy)
> =C2=A0 - Make pcim_intx() a PCI-internal function so that new drivers
> won't
> =C2=A0=C2=A0=C2=A0 be encouraged to use the outdated pci_intx() mechanism=
.
> =C2=A0=C2=A0=C2=A0 (Andy / Philipp)
> =C2=A0 - Fix grammar and spelling (Bjorn)
> =C2=A0 - Be more precise on why pcim_iomap_table() is problematic (Bjorn)
> =C2=A0 - Provide the actual structs' and functions' names in the commit
> =C2=A0=C2=A0=C2=A0 messages (Bjorn)
> =C2=A0 - Remove redundant variable initializers (Andy)
> =C2=A0 - Regroup PM bitfield members in struct pci_dev (Andy)
> =C2=A0 - Make pcim_intx() visible only for the PCI subsystem so that
> new=C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 drivers won't use this outdated API (Andy, Myself)
> =C2=A0 - Add a NOTE to pcim_iomap() to warn about this function being
> the=C2=A0=C2=A0=C2=A0 onee
> =C2=A0=C2=A0=C2=A0 xception that does just return NULL.
> =C2=A0 - Consistently use the term "PCI devres API"; also in Patch #10
> (Bjorn)
>=20
>=20
> =C2=A1Hola!
>=20
> PCI's devres API suffers several weaknesses:
>=20
> 1. There are functions prefixed with pcim_. Those are always managed
> =C2=A0=C2=A0 counterparts to never-managed functions prefixed with pci_ =
=E2=80=93 or so
> one
> =C2=A0=C2=A0 would like to think. There are some apparently unmanaged fun=
ctions
> =C2=A0=C2=A0 (all region-request / release functions, and pci_intx()) whi=
ch
> =C2=A0=C2=A0 suddenly become managed once the user has initialized the de=
vice
> with
> =C2=A0=C2=A0 pcim_enable_device() instead of pci_enable_device(). This
> "sometimes
> =C2=A0=C2=A0 yes, sometimes no" nature of those functions is confusing an=
d
> =C2=A0=C2=A0 therefore bug-provoking. In fact, it has already caused a bu=
g in
> DRM.
> =C2=A0=C2=A0 The last patch in this series fixes that bug.
> 2. iomappings: Instead of giving each mapping its own callback, the
> =C2=A0=C2=A0 existing API uses a statically allocated struct tracking one
> mapping
> =C2=A0=C2=A0 per bar. This is not extensible. Especially, you can't creat=
e
> =C2=A0=C2=A0 _ranged_ managed mappings that way, which many drivers want.
> 3. Managed request functions only exist as "plural versions" with a
> =C2=A0=C2=A0 bit-mask as a parameter. That's quite over-engineered consid=
ering
> =C2=A0=C2=A0 that each user only ever mapps one, maybe two bars.
>=20
> This series:
> - add a set of new "singular" devres functions that use devres the
> way
> =C2=A0 its intended, with one callback per resource.
> - deprecates the existing iomap-table mechanism.
> - deprecates the hybrid nature of pci_ functions.
> - preserves backwards compatibility so that drivers using the
> existing
> =C2=A0 API won't notice any changes.
> - adds documentation, especially some warning users about the
> =C2=A0 complicated nature of PCI's devres.
>=20
>=20
> Note that this series is based on my "unify pci_iounmap"-series from
> a
> few weeks ago. [1]
>=20
> I tested this on a x86 VM with a simple pci test-device with two
> regions. Operates and reserves resources as intended on my system.
> Kasan and kmemleak didn't find any problems.
>=20
> I believe this series cleans the API up as much as possible without
> having to port all existing drivers to the new API. Especially, I
> think
> that this implementation is easy to extend if the need for new
> managed
> functions arises :)
>=20
> Greetings,
> P.
>=20
> Philipp Stanner (10):
> =C2=A0 PCI: Add new set of devres functions
> =C2=A0 PCI: Deprecate iomap-table functions
> =C2=A0 PCI: Warn users about complicated devres nature
> =C2=A0 PCI: Make devres region requests consistent
> =C2=A0 PCI: Move dev-enabled status bit to struct pci_dev
> =C2=A0 PCI: Move pinned status bit to struct pci_dev
> =C2=A0 PCI: Give pcim_set_mwi() its own devres callback
> =C2=A0 PCI: Give pci(m)_intx its own devres callback
> =C2=A0 PCI: Remove legacy pcim_release()
> =C2=A0 drm/vboxvideo: fix mapping leaks
>=20
> =C2=A0drivers/gpu/drm/vboxvideo/vbox_main.c |=C2=A0=C2=A0 20 +-
> =C2=A0drivers/pci/devres.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1015 ++++++++++=
+++++++++++--
> --
> =C2=A0drivers/pci/iomap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
18 +
> =C2=A0drivers/pci/pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 123 ++-
> =C2=A0drivers/pci/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 25 +-
> =C2=A0include/linux/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
18 +-
> =C2=A06 files changed, 1004 insertions(+), 215 deletions(-)
>=20


