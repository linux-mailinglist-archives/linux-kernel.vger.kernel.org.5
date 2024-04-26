Return-Path: <linux-kernel+bounces-159656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A63928B31A5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B82F1F21497
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ED513C8EF;
	Fri, 26 Apr 2024 07:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajCoFuxz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4B013C3EC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 07:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714117512; cv=none; b=hpyGhfhe9Of+yplBLHfhO/8hHHblm3aYl+1BOmC2I1Se0i+MK7QiLF60ndM6+z7QCo7bUN6vS05FsK2NgOa788VxxfmzLnfMsA9oq5wDleOZxel+wjd0MOSVPizMOLgHK/dGMYsQfzT4rJ13PnFUeZwZarcDdJcoLGfg3UmKWZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714117512; c=relaxed/simple;
	bh=rUd+NDHbSv3c2fwov86iAf1+ncoc84+vbeTpHpltIo0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dIumIUkE7KonkLgCyTQHvQAW+e8AXFZJKRH/dfyHbGY6rYNbKGbP0GdFk42TyRY+kTLkYvIBv2f6fkOCxgCT/tXRQAWqhKFW+SFtX9I7Ka2HQgF0J+jph1wWYms2cmt/BubA/X5FekIcwF/gOgVGKPsq9xtheJuflCiNyokgTEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajCoFuxz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714117510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rUd+NDHbSv3c2fwov86iAf1+ncoc84+vbeTpHpltIo0=;
	b=ajCoFuxzW0GCZywPfev17TU6RO3q8rjYN+D6xG3oFfdEi9qoj95XZvtG3EBznwF9/2GLgI
	1xzE+tmnZZ4hN80afJTAPTwB+AJp0W0HqiBTM9kg5/ldo3RrbXe+lhMdG+2Y1BBgxIIXsG
	eCZFLy+BiDNhd/YjBEyHZoEI/b6AOnE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-XAhAAsEJMDyvE33bslc7DA-1; Fri, 26 Apr 2024 03:45:08 -0400
X-MC-Unique: XAhAAsEJMDyvE33bslc7DA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-79085537977so968385a.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 00:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714117508; x=1714722308;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rUd+NDHbSv3c2fwov86iAf1+ncoc84+vbeTpHpltIo0=;
        b=NFIjgwUWsdBpQzUJ6KJMib9D/zqx66+khmvCQ301wPx9VzxwD07FUx+PCX90DAGpW3
         HbTz5f6xJB8KddDq2aiPtbW9Mu3ACa4VSqmLpLKwDAWN+aO+KbET/3DzwobBIkGHCBv6
         KM2QdYpE2pzqM4ZVZ25gIjh7rvo631C5PFXJQTrQgyKvIcpS5BrUz0QHI5k9QRpaLF+6
         HZth2tXcQ+RY/IiC/1Tp1H/SncsoayhppN0pmoeylHrtdMkCraOLuc+W74hn0OPlFOvA
         yEfA2luUkVq3rGRJsrMX7AaH0FMMdiwYn7kZ8ZgYj4oqwhYB9No/uAqf7aLzfczqYYvn
         ktPA==
X-Forwarded-Encrypted: i=1; AJvYcCXyVbPYA/S3RBF5MZ6G0pq2OIdXjwzXk0LY8CY+tb8ofwyTgCw2S9339vKdBXWRbd6INHQuIB0fOhBrJr5Jzkivva6Mu8OkLXa7SELn
X-Gm-Message-State: AOJu0YydzYdJDiRo58NITAMVoauB7GAk3ozPymgj+g+bWkfrPq4OnSFY
	hD/ty3tPxvIREH9fb+ReRhK6e9z+XgTaAOuzEit5TwrJWrNJkBYyr561SuE2GzXlVjM0JRP+Key
	ZbY0PVcF4oEVCxIeIW9kee+iaaueRunrmfnGacnvpLTG/6rMm0ybNktb/fQDlhg==
X-Received: by 2002:a05:620a:1998:b0:790:b14a:f3b2 with SMTP id bm24-20020a05620a199800b00790b14af3b2mr268119qkb.0.1714117508089;
        Fri, 26 Apr 2024 00:45:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBpIQQ4Cw0i6lKebwdcfxqWo1Ele2lBbNOsET58txmVyPf0uijghKM0MhFbnu1UARMdDHjxg==
X-Received: by 2002:a05:620a:1998:b0:790:b14a:f3b2 with SMTP id bm24-20020a05620a199800b00790b14af3b2mr268091qkb.0.1714117507816;
        Fri, 26 Apr 2024 00:45:07 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id f10-20020a05620a15aa00b0079061110054sm5937871qkk.13.2024.04.26.00.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 00:45:07 -0700 (PDT)
Message-ID: <e36256905e924df9690202671e1797d6214592df.camel@redhat.com>
Subject: Re: [PATCH v6 04/10] PCI: Make devres region requests consistent
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Sam
 Ravnborg <sam@ravnborg.org>, dakr@redhat.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org
Date: Fri, 26 Apr 2024 09:45:04 +0200
In-Reply-To: <20240424201236.GA504035@bhelgaas>
References: <20240424201236.GA504035@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-24 at 15:12 -0500, Bjorn Helgaas wrote:
> On Mon, Apr 08, 2024 at 10:44:16AM +0200, Philipp Stanner wrote:
> > Now that pure managed region request functions are available, the
> > implementation of the hybrid-functions which are only sometimes
> > managed
> > can be made more consistent and readable by wrapping those
> > always-managed functions.
> >=20
> > Implement a new pcim_ function for exclusively requested regions.
> > Have the pci_request / release functions call their pcim_
> > counterparts.
> > Remove the now surplus region_mask from struct pci_devres.
>=20
> This looks like two patches; could they be separated?
>=20
> =C2=A0 - Convert __pci_request_region() etc to the new pcim model
>=20
> =C2=A0 - Add pcim_request_region_exclusive()
>=20
> IORESOURCE_EXCLUSIVE was added by e8de1481fd71 ("resource: allow MMIO
> exclusivity for device drivers") in 2008 to help debug an e1000e
> problem.=C2=A0 In the 16 years since, there's only been one new PCI-
> related
> use (ne_pci_probe()), and we don't add a user of
> pcim_request_region_exclusive() in this series, so I would defer it
> until somebody wants it.

Alright, sounds reasonable to me.
Since pcim_request_region_exclusive() can be dropped we can also omit
separating this patch to begin with I'd say.

P.


>=20
> Bjorn
>=20


