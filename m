Return-Path: <linux-kernel+bounces-88190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF5B86DE58
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6FD41F281BE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E35F6A8A3;
	Fri,  1 Mar 2024 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XC5IuHIw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274A36A352
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285695; cv=none; b=W9pW2uK3ZWV/zI9HvwQEbARJAicH9CnFWc1AraJ9i8hD/22BJwn92i/QZKlL2Z+aip5T/QdQdedIpP5Pw0dlJe/nn/EP13fOir+MPruSroVNlsMEYM3L7mWOR+nUVwT3o2X5yFd1+EtPPoAkwot3o1g2IXQtGcgO98xRD2dRexQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285695; c=relaxed/simple;
	bh=xUzguapjnO/ASwX7eqgiIKisU9asefIceRf+xZr60sc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tLZhPpd4uuE6VIRzbo3HjnjJuff8YNVJUgbsL8HYubDRriYl+VRNaN8RdaIvHLXnenqCq/knaF00F7Iw1ESmd9ONirNz5KnZLaxWyAkIivZOFL4eEKO3C32kaRa7P/+DAKZZ5WpsFNbUoxounE53JAmk71KLUlmdZE+jlXts6zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XC5IuHIw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709285693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xUzguapjnO/ASwX7eqgiIKisU9asefIceRf+xZr60sc=;
	b=XC5IuHIwSPakAnJ/LjWT2THwmR1CY+gSlgeJnoMh+cp8XKb7a8F6Xk1ZxbfNLnrjlku2o5
	AyIzA9taU2tvVxF8CpkT9uLCIA0vVbS1LmqWGr8x3Ard2Qq2CQZjVk2lHGLxXsZVpFWfVk
	/U/PXvSRA5767KoqjsRCgmSNu8TGRsY=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-WgHk05VXMXOqtxCZNO0ysA-1; Fri, 01 Mar 2024 04:34:51 -0500
X-MC-Unique: WgHk05VXMXOqtxCZNO0ysA-1
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-dcdb00ff6e0so612826276.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 01:34:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709285386; x=1709890186;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xUzguapjnO/ASwX7eqgiIKisU9asefIceRf+xZr60sc=;
        b=qFsKNfJMTrD0GSDlkOgad/QmfypZc3AKBGK7+ranfAEAzeQGgnPjTwpJcIRONScGgf
         0ZQim5ZQdUaUfVJ1z7qBPFpAI60Id95QUAkOJlDcjvmZZ2W5RfNav3rnXV6UUFjYz3u1
         opNy4F+3oob41Ed4EjJtWt6rxe9kfTi98lumdZoISs7xQNGIss5XOrEmHcHoca6VkSlP
         Wg1JMJCAX6Ps+4ZG9cmPp8FfE6X7iicmPHxFe2Sgf6kUqwqX3SyRXXC6OdFdlG/oR5SJ
         7WMnDN+0ji/gztEqFBcNTfNTw33pnVFPg3potYTuSECBKUbHxSp9rgKwVjkoAM6L5o7T
         CuTg==
X-Forwarded-Encrypted: i=1; AJvYcCX1GOx3cF08sC2ohaOeE9GGqis3sO0bChbNhSlDER7LmP7qfyE8J7lSh8pFs6yiQj4lsONaNV2PllcMmIXDFsnVzCPwZSN/5y88XSBe
X-Gm-Message-State: AOJu0YyvBeUzw1u5Rl3vjcnOWOfR7FjCbCUFcBTAfYEJq8wKj9Ljz5CS
	Ibci6xbwv89inGGaYczeYWer1QYzeS3uD6eMXWEYXFWjbDWTNyU2jIp9bm/bRr5EgqkBu31JrPx
	OoAF4+bhIDymjdnp5wH/xEQNmVHIsR3dD1JzwgIJpn9rUuJB/lYkG8JFdZHLk7A==
X-Received: by 2002:a25:820a:0:b0:dcc:8617:d6da with SMTP id q10-20020a25820a000000b00dcc8617d6damr764219ybk.4.1709285386075;
        Fri, 01 Mar 2024 01:29:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2RdbWeJU69WfSLJ6KahAECor/gofhdJ9ItLhUg99VOwuO3lZOaOjqitHJwv+Y3BImlFdLbQ==
X-Received: by 2002:a25:820a:0:b0:dcc:8617:d6da with SMTP id q10-20020a25820a000000b00dcc8617d6damr764203ybk.4.1709285385721;
        Fri, 01 Mar 2024 01:29:45 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id c3-20020ac87dc3000000b0042dac47e9b4sm1549107qte.5.2024.03.01.01.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 01:29:45 -0800 (PST)
Message-ID: <7158e09386f0345d2e87ea5433dabf38db027971.camel@redhat.com>
Subject: Re: [PATCH v3 00/10] Make PCI's devres API more consistent
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Sam
 Ravnborg <sam@ravnborg.org>, dakr@redhat.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org
Date: Fri, 01 Mar 2024 10:29:42 +0100
In-Reply-To: <20240229205715.GA362688@bhelgaas>
References: <20240229205715.GA362688@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-29 at 14:57 -0600, Bjorn Helgaas wrote:
> On Thu, Feb 29, 2024 at 09:31:20AM +0100, Philipp Stanner wrote:
> > @Bjorn:
> > Hey Bjorn, are we good with this series? Any more wishes or
> > suggestions?
>=20
> Sorry, haven't had a chance to go through it yet.=C2=A0=20
>=20
> FWIW, I just tried to apply these on top of pci/devres, but it failed
> here:
>=20
> =C2=A0 Applying: PCI: Add new set of devres functions
> =C2=A0 Applying: PCI: Deprecate iomap-table functions
> =C2=A0 Applying: PCI: Warn users about complicated devres nature
> =C2=A0 Applying: PCI: Make devres region requests consistent
> =C2=A0 Applying: PCI: Move dev-enabled status bit to struct pci_dev
> =C2=A0 error: patch failed: drivers/pci/pci.h:811
> =C2=A0 error: drivers/pci/pci.h: patch does not apply
> =C2=A0 Patch failed at 0005 PCI: Move dev-enabled status bit to struct
> pci_dev
>=20
> Haven't investigated, so maybe it's some trivial easily fixed thing.

For me, based on Linus's master, this applies with the previous series.

It seems to me that this issue only exists on linux-next, the reason
being that git searches for struct pci_devres in line 811, but on
linux-next, because of previous additions, the struct moved to line
827, and poor git can't find it anymore.

I could fix that and provide a v4.


P.


>=20
> Bjorn
>=20


