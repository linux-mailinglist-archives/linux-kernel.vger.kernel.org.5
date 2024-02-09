Return-Path: <linux-kernel+bounces-59261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8D384F417
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C175F1C227C4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230BD288A7;
	Fri,  9 Feb 2024 11:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="bQMfRtT4"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39C03FEC
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 11:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707476574; cv=none; b=caeGMJoABVZLlCQy2BJvIHZna0IaTb2dqphWVBXXxwq/Id9Q5jtCyO0hDeNAN4Z1GTDmGRXMHyH/L9OH/U5YyM+s061YCgYnvFUCuZav9oWHTyPzH/rmxxO2UNqr7BIE8GlOurZmHLn+qMs/YQoF6R98juKN5sVUkg5i7qcMgbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707476574; c=relaxed/simple;
	bh=eACiRKeasrYPhMZpFzldo5Pay8lxD7sLsJ+SIFlrb1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9NsYeh/pmnbn2uWZv2jdhNgAUkR15Dq5qiS1FABAQ9yrDMKgcahbAmAiKO0RnU65VUSNmFrJ98bfSociVQJoXxdLhs8bvSC99xovbl5zo1j1cmwP2ik9FZPdeMuVnBT7tc0Lty0voXHcj0++7lKhQT5sYVTxgxoQpLL3RJDWV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=bQMfRtT4; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5114a21176cso314383e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 03:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1707476571; x=1708081371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuYIlExUBLY2J6M+ngxVOAFSad/SHF5e+TMcqooCk/4=;
        b=bQMfRtT44d5ELVaQoIJET81yhJlyOaITRzYJljspC9x4gSGKuUyj7e5LnP+MT25vzt
         r4cjWbLMO8lW9UIVzMnEdQZXjktgSBjtVPafapnJ+xZgeMuYHwXSYXLmnW8TOviDTFu+
         PJnJhQUHTPbR2P4SvgpPkM1/gBoP5bl2Lvktk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707476571; x=1708081371;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vuYIlExUBLY2J6M+ngxVOAFSad/SHF5e+TMcqooCk/4=;
        b=f3rkTyAaTRruE/5Ah6BAjPOXMQhCt2YhLC3hP+y1M/P0xcvifYWoQO6It1XTw4nKH7
         0kKd4B+ECSqrRhXUC8Uaf3/UO0kcpWY37JTUQfIKxXLzWtemNz1aAbRMqYOXmW0AwyDG
         FSjDbqZ4cslpRAt9U0KjhDQF0LqLaBbVDKPdkmTPrmIsGD6AOXRe1kFGBFBoJQl/D8Mm
         Jq5vHw1JbPchNJICl3KPyODl6ymT73fXeVrl2ZAjM/0b6aPKl6uBBfEuQIZhh1IAbX4W
         yGQvA6ZNmx7+vGPHQjfO8m1O9P1/Kp9NbcAEKZnGV4naSW/nB7Rc7UbLN+5Ltpi7Tcl9
         Gi+g==
X-Gm-Message-State: AOJu0YxWkmg4ee4PmSLesjn0ZAB1cFnQsyUqGw+kewSyi3spa1r2MKlk
	CrZblUrAboOcGc9NTFqx8pdnASF25iBdtIb0ieslJMYIhjkDosUnt02AlIFnglCIEYEALbAHJ7Y
	N
X-Google-Smtp-Source: AGHT+IH6E0/AASvROXrvxkigjakcyaKsJ20YLXJ0nvKogI/yEfwVIZAEoyri+p2vNSQzIFe+xvTWHg==
X-Received: by 2002:a05:6512:308d:b0:50e:7f87:f5aa with SMTP id z13-20020a056512308d00b0050e7f87f5aamr1043351lfd.3.1707476570842;
        Fri, 09 Feb 2024 03:02:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWcBvPi7bshClS192/V6ZRLWgmi+XBhW0KLYsT4pwcEnPxPLcoUYXf0vqnlp0ao0VBAMGZrRxHYkLlUaTbOufIsNZgsL8Ni95XiSJwJ7enQuhI1VYzpheOYOISBMY3HT0GdUPXSk5jBu2+adnorJga+EeBf4ngFka2exnzouuU8oIQ1wpxXk6kT/BlZ4yW2DgLNM/G/IfBLuegBzzZGoqIKVu4Q7GCWSq6XN2uI73zbEvK0ytHbgXR8MLJOrC71U0G7eYqndH91qXPe1Xhde79Slk4O2kV0/SbVlOzTHwZqHtzEmyBSEgjZaNy+Rs2ZiOdiTugqLAs0bNPlvdE5ixbR+iVCkkSR+80=
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id bk27-20020a0560001d9b00b0033b55661f32sm1570062wrb.9.2024.02.09.03.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 03:02:50 -0800 (PST)
Date: Fri, 9 Feb 2024 12:02:48 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Maxime Ripard <mripard@kernel.org>
Cc: Sui Jingfeng <sui.jingfeng@linux.dev>,
	Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [etnaviv-next v13 7/7] drm/etnaviv: Add support for vivante
 GPU cores attached via PCI(e)
Message-ID: <ZcYGWEG8eqAiqqai@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
References: <20240206172759.421737-1-sui.jingfeng@linux.dev>
 <20240206172759.421737-8-sui.jingfeng@linux.dev>
 <ZcNO9aZwWzyYs-Rv@phenom.ffwll.local>
 <jahydq72bqb27de2ijwwmdjh4ri326mxhfjn5pbvf7cqcpnauq@rw5hjdiroi5d>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jahydq72bqb27de2ijwwmdjh4ri326mxhfjn5pbvf7cqcpnauq@rw5hjdiroi5d>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Thu, Feb 08, 2024 at 04:27:02PM +0100, Maxime Ripard wrote:
> On Wed, Feb 07, 2024 at 10:35:49AM +0100, Daniel Vetter wrote:
> > On Wed, Feb 07, 2024 at 01:27:59AM +0800, Sui Jingfeng wrote:
> > > The component helper functions are the glue, which is used to bind multiple
> > > GPU cores to a virtual master platform device. Which is fine and works well
> > > for the SoCs who contains multiple GPU cores.
> > > 
> > > The problem is that usperspace programs (such as X server and Mesa) will
> > > search the PCIe device to use if it is exist. In other words, usperspace
> > > programs open the PCIe device with higher priority. Creating a virtual
> > > master platform device for PCI(e) GPUs is unnecessary, as the PCI device
> > > has been created by the time drm/etnaviv is loaded.
> > > 
> > > we create virtual platform devices as a representation for the vivante GPU
> > > ip core. As all of subcomponent are attached via the PCIe master device,
> > > we reflect this hardware layout by binding all of the virtual child to the
> > > the real master.
> > > 
> > > Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> > 
> > Uh so my understanding is that drivers really shouldn't create platform
> > devices of their own. For this case here I think the aux-bus framework is
> > the right thing to use. Alternatively would be some infrastructure where
> > you feed a DT tree to driver core or pci subsystem and it instantiates it
> > all for you correctly, and especially with hotunplug all done right since
> > this is pci now, not actually part of the soc that cannot be hotunplugged.
> 
> I don't think we need intermediate platform devices at all. We just need
> to register our GPU against the PCI device and that's it. We don't need
> a platform device, we don't need the component framework.

Afaik that's what this series does. The component stuff is for the
internal structure of the gpu ip, so that the same modular approach that
works for arm-soc also works for pci chips.

Otherwise we end up with each driver hand-rolling that stuff, which is
defacto what both nouveau and amdgpu do (intel hw is too much a mess for
that component-driver based approach to actually work reasonably well).

Cheers, Sima

> > I think I've seen some other pci devices from arm soc designs that would
> > benefit from this too, so lifting this logic into a pci function would
> > make sense imo.
> 
> Nouveau supports both iirc.
> 
> Maxime



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

