Return-Path: <linux-kernel+bounces-79619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A5B8624C4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58FCD1F22A4A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52C53A1A6;
	Sat, 24 Feb 2024 11:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+GVFbGo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338921AACE
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708775571; cv=none; b=ZtYHltqNXbOyEGVThLJnYQsyfsYB99cu/0w+fXeERAVgUy1Ti7JuTBkEHCxU4rCA1CvTcBuUldkIX70I9/INRo1DXivVANGMTcr9RLl2J/isWehaGn6HMgDWX2VELOOCetz9eMqNKl3pLsG5yiyMMzmUL+ESuXuUgEcU3ELQYOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708775571; c=relaxed/simple;
	bh=uY0E/RBEKApxcCM2847zoCCtWaxMibeDudfsn3XcWA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vE5dJbkjRbltyPosNS7mEJdHCYWVUQQHYcPaKSsMnFVjCKHR8HH5Y+jTobb3LRl/XHBTWDzfLxMx4dQaDcYJ3TXUa7Zdcf7qli2I4nCYKAxD3Kmj2I1bVOlG7yNoLgaefqKz0uh0FBDejUdor+uCMQ2bmDsKvhQerWOHuGNKONA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h+GVFbGo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708775568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVWQffDK/ZUjAh++ittTy+1YShatNEsUrXGS8707I/s=;
	b=h+GVFbGois68P0WrqvjqPze2RFSPLymwBrC+WyfWMDSrhEvZDwVGD/rZFluhhkcGt1OUsz
	JLa+1YI1YBLJeBWOUEl8o7Pl0QwQVNV7OZ3gKKOh+LddFg+YsROlbSUvOZ8eMXdtsRLZJp
	0PWWlGhdcAl0QZOpu8fw427Q/7BNuIs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-WG02cS6vNV-jPOKp4PtPCA-1; Sat, 24 Feb 2024 06:52:46 -0500
X-MC-Unique: WG02cS6vNV-jPOKp4PtPCA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-68fce519ed4so11341906d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:52:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708775566; x=1709380366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVWQffDK/ZUjAh++ittTy+1YShatNEsUrXGS8707I/s=;
        b=VJhGLBKxZVI+Md+24/ypk+yMFnG7vdQ/mqO25DRgk7gkziuuwdhAQVt2JJ6qhh+AdR
         Hpx8B5O3RhjoZ8u2rE2xn192b8FlT0PoB+RE51ho0WpiAhVwZqa+U3GmpgC66ByydNSZ
         q5dn0gHOQYY04x0msg7a7Fkn/rwxUHcK6McL0pfnTNbbB2yBoUQCkzNd7HjTxvMub8QZ
         sBz4ZUij63xOra840R9I9RqODXsM/6xkihLbLrtB4KIxv1yfSQM5mLFBRWMrBA8myY6l
         3xS7v6nZm930pc3djw7CLgdC9lelPpITBlLo7BTPGu2bQjsL3dl/9xbUipEp07w/gK2t
         2wVg==
X-Forwarded-Encrypted: i=1; AJvYcCUK+ShOuC/TlCZQjxQcAOv2Zs4wKRk180LGUK776i1CelW8sCTV3J9mloBKMaMM3CEeKg9lOPce2eeWMcRbuLx7V540DcG2BLRvTj+B
X-Gm-Message-State: AOJu0YwJEkAWCBr3GMMWnimG9SBQp4UQBzrU56Rp1tWCMlUEy//mEoDQ
	dIx2k7vsCPZ9swZEvDNIQBDeOcd/aFu1X1Ob0SDO82VXxOlVuMwbVUxmLU5NHWbfh4Eo7k+/0hk
	G8CUZHuQxnirRZlZ5wNzv4/3WvsEO4tLq8+037B1s6wQpDStqEy9uHyj9uIWVSngR2vgKhKLm1m
	5d6IaiQ94ORrxLPdGKjOlwGC7KPBJWBDteYnoT
X-Received: by 2002:a0c:f051:0:b0:68f:d23c:9c40 with SMTP id b17-20020a0cf051000000b0068fd23c9c40mr2163224qvl.30.1708775566327;
        Sat, 24 Feb 2024 03:52:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqFfJNn3YyEHSZdbCj5QSsTY41zQB8+5mJC0GreQRD8BADwcjsJXHeMW2gR+qhAamQCfaMVGW3tSUYdKdsc/E=
X-Received: by 2002:a0c:f051:0:b0:68f:d23c:9c40 with SMTP id
 b17-20020a0cf051000000b0068fd23c9c40mr2163211qvl.30.1708775566058; Sat, 24
 Feb 2024 03:52:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209100912.82473-1-ksundara@redhat.com> <ZctlswYbV1RHU2ip@mev-dev>
In-Reply-To: <ZctlswYbV1RHU2ip@mev-dev>
From: Karthik Sundaravel <ksundara@redhat.com>
Date: Sat, 24 Feb 2024 17:22:35 +0530
Message-ID: <CAPh+B4KrsKiN=QOU4HntCQh4OrJR=NpxJcOzvB05yxnc1WgKzw@mail.gmail.com>
Subject: Re: [PATCH v3] ice: Add get/set hw address for VFs using devlink commands
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de, jiri@resnulli.us, 
	rjarry@redhat.com, aharivel@redhat.com, vchundur@redhat.com, 
	cfontain@redhat.com, jacob.e.keller@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 6:21=E2=80=AFPM Michal Swiatkowski
<michal.swiatkowski@linux.intel.com> wrote:
>
> On Fri, Feb 09, 2024 at 03:39:12PM +0530, Karthik Sundaravel wrote:
> > Changing the MAC address of the VFs are not available
> > via devlink. Add the function handlers to set and get
> > the HW address for the VFs.
> >
> > Signed-off-by: Karthik Sundaravel <ksundara@redhat.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_devlink.c | 86 +++++++++++++++++++-
> >  1 file changed, 85 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net=
/ethernet/intel/ice/ice_devlink.c
> > index 80dc5445b50d..7ed61b10312c 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_devlink.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
> > @@ -1576,6 +1576,89 @@ void ice_devlink_destroy_pf_port(struct ice_pf *=
pf)
> >       devlink_port_unregister(&pf->devlink_port);
> >  }
> >
> > +/**
> > + * ice_devlink_port_get_vf_mac_address - .port_fn_hw_addr_get devlink =
handler
> > + * @port: devlink port structure
> > + * @hw_addr: MAC address of the port
> > + * @hw_addr_len: length of MAC address
> > + * @extack: extended netdev ack structure
> > + *
> > + * Callback for the devlink .port_fn_hw_addr_get operation
> > + * Return: zero on success or an error code on failure.
> > + */
> > +
> > +static int ice_devlink_port_get_vf_mac_address(struct devlink_port *po=
rt,
> > +                                            u8 *hw_addr, int *hw_addr_=
len,
> > +                                            struct netlink_ext_ack *ex=
tack)
> > +{
> > +     struct devlink_port_attrs *attrs =3D &port->attrs;
> > +     struct devlink_port_pci_vf_attrs *pci_vf;
> > +     struct devlink *devlink =3D port->devlink;
> > +     struct ice_pf *pf;
> > +     struct ice_vf *vf;
> > +     int vf_id;
> > +
> > +     pf =3D devlink_priv(devlink);
> > +     if (attrs->flavour =3D=3D DEVLINK_PORT_FLAVOUR_PCI_VF) {
> > +             pci_vf =3D &attrs->pci_vf;
> > +             vf_id =3D pci_vf->vf;
> > +     } else {
> > +             NL_SET_ERR_MSG_MOD(extack, "Unable to get the vf id");
> > +             return -EADDRNOTAVAIL;
> > +     }
> > +     vf =3D ice_get_vf_by_id(pf, vf_id);
> You need to call ice_put_vf(vf); when you finish with vf.
>
> This way to get vf pointer is fine, I wonder if it can be done using
> container_of on port variable. Jake, what do you think?
> CC: Jacob Keller
>
> > +     if (!vf) {
> > +             NL_SET_ERR_MSG_MOD(extack, "Unable to get the vf");
> > +             return -EINVAL;
> > +     }
> > +     ether_addr_copy(hw_addr, vf->dev_lan_addr);
> > +     *hw_addr_len =3D ETH_ALEN;
> > +     return 0;
> > +}
> > +
> > +/**
> > + * ice_devlink_port_set_vf_mac_address - .port_fn_hw_addr_set devlink =
handler
> > + * @port: devlink port structure
> > + * @hw_addr: MAC address of the port
> > + * @hw_addr_len: length of MAC address
> > + * @extack: extended netdev ack structure
> > + *
> > + * Callback for the devlink .port_fn_hw_addr_set operation
> > + * Return: zero on success or an error code on failure.
> > + */
> > +static int ice_devlink_port_set_vf_mac_address(struct devlink_port *po=
rt,
> > +                                            const u8 *hw_addr,
> > +                                            int hw_addr_len,
> > +                                            struct netlink_ext_ack *ex=
tack)
> > +{
> > +     struct net_device *netdev =3D port->type_eth.netdev;
> Is it PF netdev?
Its VF netdev
>
> > +     struct devlink_port_attrs *attrs =3D &port->attrs;
> > +     struct devlink_port_pci_vf_attrs *pci_vf;
> > +     u8 mac[ETH_ALEN];
> > +     int vf_id;
> > +
> > +     if (attrs->flavour =3D=3D DEVLINK_PORT_FLAVOUR_PCI_VF) {
> > +             pci_vf =3D &attrs->pci_vf;
> > +             vf_id =3D pci_vf->vf;
> > +     } else {
> > +             NL_SET_ERR_MSG_MOD(extack, "Unable to get the vf id");
> > +             return -EADDRNOTAVAIL;
> > +     }
> > +
> > +     if (!netdev) {
> > +             NL_SET_ERR_MSG_MOD(extack, "Unable to get the netdev");
> > +             return -EADDRNOTAVAIL;
> > +     }
> > +     ether_addr_copy(mac, hw_addr);
> > +
> > +     return ice_set_vf_mac(netdev, vf_id, mac);
> > +}
> > +
> > +static const struct devlink_port_ops ice_devlink_vf_port_ops =3D {
> > +     .port_fn_hw_addr_get =3D ice_devlink_port_get_vf_mac_address,
> > +     .port_fn_hw_addr_set =3D ice_devlink_port_set_vf_mac_address,
> > +};
> > +
> >  /**
> >   * ice_devlink_create_vf_port - Create a devlink port for this VF
> >   * @vf: the VF to create a port for
> > @@ -1611,7 +1694,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
> >       devlink_port_attrs_set(devlink_port, &attrs);
> >       devlink =3D priv_to_devlink(pf);
> >
> > -     err =3D devlink_port_register(devlink, devlink_port, vsi->idx);
> > +     err =3D devlink_port_register_with_ops(devlink, devlink_port,
> > +                                          vsi->idx, &ice_devlink_vf_po=
rt_ops);
> >       if (err) {
> >               dev_err(dev, "Failed to create devlink port for VF %d, er=
ror %d\n",
> >                       vf->vf_id, err);
> > --
> > 2.39.3 (Apple Git-145)
> >
>


