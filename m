Return-Path: <linux-kernel+bounces-128086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8591C8955EA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C77C1C22333
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACFA86248;
	Tue,  2 Apr 2024 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQ0gDnea"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9125D85624
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066272; cv=none; b=Kv2jhsydtTcR/PluKCbhOUxXxoWAON78zbreKh50rV+eLp/h/stUzAOoROoPate1MX59l6X18DGRPmZRK/LTXbL7G1DVe9gXEGTGOofGMSVT5f8W6Wc90/L2YpJgN7wVYjHJ4FBhg3DEGR5R8U4BVlmyBMACRH1RqAreGmUO31o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066272; c=relaxed/simple;
	bh=/85xZO5dd7u340T2idNeO+B784thCkGA9CgRlZyEzjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8iLmMPFXgi+ICuSX7Yzqei8YUNOzg11W8NbeBxLBWMe2jEKEBRgMFqkopNnuxkM2iPPsv+KHmpCw+S6sseejhPaBvT4mgby7OijwgjkX8m6QH81mSPj5kQ2LePx7rhoIzcsIqCRZlaze6M4EpUSGk1tYLJGyYOiLtiEDqIE64Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQ0gDnea; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712066269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BwIJukPzdelvXDcQMgUp/22xDxOhihi+wolcq3WNR8U=;
	b=IQ0gDneavECPBbS9I2HNumWGMtA25FKk6z3Vz6ypNr2NBnxSDyIZJBmhVsvB/DmJhjb5XA
	W8aOCFejeTAQEFZmqxwD83TqIcd4wEdeHHi16q7iocYD8PGVpEq9Vs64eWNwKgNH2GTB8u
	w1gkXzrh3nvCnhOkwE7RCockyF6QIxE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-zAfygJyhPvGMJVdqeh7KdA-1; Tue, 02 Apr 2024 09:57:48 -0400
X-MC-Unique: zAfygJyhPvGMJVdqeh7KdA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-696ac7aec1dso57748556d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 06:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712066267; x=1712671067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwIJukPzdelvXDcQMgUp/22xDxOhihi+wolcq3WNR8U=;
        b=E6awzGKMTjD+m8y6GESBYQPnRDJqwBiIaOUBhIeSkdgcKMky9UAlClKXJjBe2zByFZ
         6l6qMZwgFX1RG2a930Pmx4+tKFYnTcMAFATW4FMAWg17Hd9VUFAeHBXQcIkDtEkiLlaW
         7qibZIh9hzroCQ8cAFw2ZqYUcFYi8t9kBftWZxcmu3WMimmAHxaLsHByjCZGLhO+O5LM
         Bg9lfQWN9PyvYEBpIVheVEVOLx7rWLwdYtpIXuw4t8uSLbgjSZXZaBLyLPiNo/pMwQcd
         HqzBjtmAK+Kd6gMr7DTyvZO6jRUu6Q1EulXvAFsEycfvtYL0fg5KDx0j1gOgJHYr6931
         OWMA==
X-Forwarded-Encrypted: i=1; AJvYcCXypqN5rG9T9ypPsL/x/MpnwXjgnd3R6D7ugaXUdSdxXY54+CEzObMoj0OwuEnf7Hw3ZW+/ouTfMLXVdZ3FkrE4XZUM8OcAMqGZmsDk
X-Gm-Message-State: AOJu0Yy1XHhQEBKR8mFgdIN8YjWq6NX1ARS7Syx16mkU4OtTIIfAxosU
	3lybuPDldfQlwwYlkwEdssWZIQoPSp9Dpb6fsUdAYfyUltpJR1WUnEZXxYoHnQphTgxY64CgA42
	1za4CP+shKYjZErJDD4SnZuOzfFkDShg+3Kh/G79SklnNuPNKtROKYJ5QPDqoMNi6Vy4mSYYMh4
	WeaebhTSPECpId6ydMcS8zODnQWDkSUJRl0SEf
X-Received: by 2002:a0c:cdcf:0:b0:696:ac91:41c2 with SMTP id a15-20020a0ccdcf000000b00696ac9141c2mr13131335qvn.48.1712066267639;
        Tue, 02 Apr 2024 06:57:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/DCRnBSkIpLSO6upnOO5Tzpg9MZq14xq1VxJcq3TklZyO57ExfrbUAPMJpM/KYX4BnzjqDGw2LVs7yJ/z494=
X-Received: by 2002:a0c:cdcf:0:b0:696:ac91:41c2 with SMTP id
 a15-20020a0ccdcf000000b00696ac9141c2mr13131314qvn.48.1712066267330; Tue, 02
 Apr 2024 06:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402092254.3891-1-ksundara@redhat.com> <20240402092254.3891-2-ksundara@redhat.com>
 <ZgvqPHYj3jS7vGHO@nanopsycho>
In-Reply-To: <ZgvqPHYj3jS7vGHO@nanopsycho>
From: Karthik Sundaravel <ksundara@redhat.com>
Date: Tue, 2 Apr 2024 19:27:35 +0530
Message-ID: <CAPh+B4LJokN=-ii7fMkpSsucsBK7uROHwDSwXypX+moDRkiKXw@mail.gmail.com>
Subject: Re: [PATCH v7] ice: Add get/set hw address for VFs using devlink commands
To: Jiri Pirko <jiri@resnulli.us>
Cc: jesse.brandeburg@intel.com, wojciech.drewek@intel.com, sumang@marvell.com, 
	jacob.e.keller@intel.com, anthony.l.nguyen@intel.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de, 
	michal.swiatkowski@linux.intel.com, rjarry@redhat.com, aharivel@redhat.com, 
	vchundur@redhat.com, cfontain@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 4:51=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Tue, Apr 02, 2024 at 11:22:54AM CEST, ksundara@redhat.com wrote:
> >Changing the MAC address of the VFs is currently unsupported via devlink=
.
> >Add the function handlers to set and get the HW address for the VFs.
> >
> >Signed-off-by: Karthik Sundaravel <ksundara@redhat.com>
> >---
> > drivers/net/ethernet/intel/ice/ice_devlink.c | 63 +++++++++++++++++++-
> > drivers/net/ethernet/intel/ice/ice_sriov.c   | 62 +++++++++++++++++++
> > drivers/net/ethernet/intel/ice/ice_sriov.h   |  8 +++
> > 3 files changed, 132 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/=
ethernet/intel/ice/ice_devlink.c
> >index 80dc5445b50d..10735715403a 100644
> >--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
> >+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
> >@@ -1576,6 +1576,66 @@ void ice_devlink_destroy_pf_port(struct ice_pf *p=
f)
> >       devlink_port_unregister(&pf->devlink_port);
> > }
> >
> >+/**
> >+ * ice_devlink_port_get_vf_fn_mac - .port_fn_hw_addr_get devlink handle=
r
> >+ * @port: devlink port structure
> >+ * @hw_addr: MAC address of the port
> >+ * @hw_addr_len: length of MAC address
> >+ * @extack: extended netdev ack structure
> >+ *
> >+ * Callback for the devlink .port_fn_hw_addr_get operation
> >+ * Return: zero on success or an error code on failure.
> >+ */
> >+
> >+static int ice_devlink_port_get_vf_fn_mac(struct devlink_port *port,
> >+                                        u8 *hw_addr, int *hw_addr_len,
> >+                                        struct netlink_ext_ack *extack)
> >+{
> >+      struct ice_vf *vf =3D container_of(port, struct ice_vf, devlink_p=
ort);
> >+
> >+      ether_addr_copy(hw_addr, vf->dev_lan_addr);
> >+      *hw_addr_len =3D ETH_ALEN;
> >+
> >+      return 0;
> >+}
> >+
> >+/**
> >+ * ice_devlink_port_set_vf_fn_mac - .port_fn_hw_addr_set devlink handle=
r
> >+ * @port: devlink port structure
> >+ * @hw_addr: MAC address of the port
> >+ * @hw_addr_len: length of MAC address
> >+ * @extack: extended netdev ack structure
> >+ *
> >+ * Callback for the devlink .port_fn_hw_addr_set operation
> >+ * Return: zero on success or an error code on failure.
> >+ */
> >+static int ice_devlink_port_set_vf_fn_mac(struct devlink_port *port,
> >+                                        const u8 *hw_addr,
> >+                                        int hw_addr_len,
> >+                                        struct netlink_ext_ack *extack)
> >+
> >+{
> >+      struct devlink_port_attrs *attrs =3D &port->attrs;
> >+      struct devlink_port_pci_vf_attrs *pci_vf;
> >+      struct devlink *devlink =3D port->devlink;
> >+      struct ice_pf *pf;
> >+      u8 mac[ETH_ALEN];
>
> Why you need this extra variable?
The function signature of ice_set_vf_fn_mac() is kept to match
ice_set_vf_mac(), and hence the ``u8 *mac`` is used instead of ``const
u8 *mac``.
A copy of the mac is made to facilitate the same.
Considering the usage of mac in ice_set_vf_fn_mac(), the function
signature could be modified to take a ``const u8 *mac`` as well.
>
>
> >+      u16 vf_id;
> >+
> >+      pf =3D devlink_priv(devlink);
> >+      pci_vf =3D &attrs->pci_vf;
> >+      vf_id =3D pci_vf->vf;
> >+
> >+      ether_addr_copy(mac, hw_addr);
> >+
> >+      return ice_set_vf_fn_mac(pf, vf_id, mac);
> >+}
> >+
> >+static const struct devlink_port_ops ice_devlink_vf_port_ops =3D {
> >+      .port_fn_hw_addr_get =3D ice_devlink_port_get_vf_fn_mac,
> >+      .port_fn_hw_addr_set =3D ice_devlink_port_set_vf_fn_mac,
> >+};
> >+
> > /**
> >  * ice_devlink_create_vf_port - Create a devlink port for this VF
> >  * @vf: the VF to create a port for
> >@@ -1611,7 +1671,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
> >       devlink_port_attrs_set(devlink_port, &attrs);
> >       devlink =3D priv_to_devlink(pf);
> >
> >-      err =3D devlink_port_register(devlink, devlink_port, vsi->idx);
> >+      err =3D devlink_port_register_with_ops(devlink, devlink_port,
> >+                                           vsi->idx, &ice_devlink_vf_po=
rt_ops);
> >       if (err) {
> >               dev_err(dev, "Failed to create devlink port for VF %d, er=
ror %d\n",
> >                       vf->vf_id, err);
> >diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/et=
hernet/intel/ice/ice_sriov.c
> >index 31314e7540f8..b1e5cd188fd7 100644
> >--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> >+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> >@@ -1216,6 +1216,68 @@ ice_get_vf_cfg(struct net_device *netdev, int vf_=
id, struct ifla_vf_info *ivi)
> >       return ret;
> > }
> >
> >+/**
> >+ * ice_set_vf_fn_mac
> >+ * @pf: PF to be configure
> >+ * @vf_id: VF identifier
> >+ * @mac: MAC address
> >+ *
> >+ * program VF MAC address
> >+ */
> >+int ice_set_vf_fn_mac(struct ice_pf *pf, u16 vf_id, u8 *mac)
> >+{
> >+      struct device *dev;
> >+      struct ice_vf *vf;
> >+      int ret;
> >+
> >+      dev =3D ice_pf_to_dev(pf);
> >+      if (is_multicast_ether_addr(mac)) {
> >+              dev_err(dev, "%pM not a valid unicast address\n", mac);
> >+              return -EINVAL;
> >+      }
> >+
> >+      vf =3D ice_get_vf_by_id(pf, vf_id);
> >+      if (!vf)
> >+              return -EINVAL;
> >+
> >+      /* nothing left to do, unicast MAC already set */
> >+      if (ether_addr_equal(vf->dev_lan_addr, mac) &&
> >+          ether_addr_equal(vf->hw_lan_addr, mac)) {
> >+              ret =3D 0;
> >+              goto out_put_vf;
> >+      }
> >+
> >+      ret =3D ice_check_vf_ready_for_cfg(vf);
> >+      if (ret)
> >+              goto out_put_vf;
> >+
> >+      mutex_lock(&vf->cfg_lock);
> >+
> >+      /* VF is notified of its new MAC via the PF's response to the
> >+       * VIRTCHNL_OP_GET_VF_RESOURCES message after the VF has been res=
et
> >+       */
> >+      ether_addr_copy(vf->dev_lan_addr, mac);
> >+      ether_addr_copy(vf->hw_lan_addr, mac);
> >+      if (is_zero_ether_addr(mac)) {
> >+              /* VF will send VIRTCHNL_OP_ADD_ETH_ADDR message with its=
 MAC */
> >+              vf->pf_set_mac =3D false;
> >+              dev_info(dev, "Removing MAC on VF %d. VF driver will be r=
einitialized\n",
> >+                       vf->vf_id);
> >+      } else {
> >+              /* PF will add MAC rule for the VF */
> >+              vf->pf_set_mac =3D true;
> >+              dev_info(dev, "Setting MAC %pM on VF %d. VF driver will b=
e reinitialized\n",
> >+                       mac, vf_id);
> >+      }
> >+
> >+      ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
> >+      mutex_unlock(&vf->cfg_lock);
> >+
> >+out_put_vf:
> >+      ice_put_vf(vf);
> >+      return ret;
> >+}
> >+
> > /**
> >  * ice_set_vf_mac
> >  * @netdev: network interface device structure
> >diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.h b/drivers/net/et=
hernet/intel/ice/ice_sriov.h
> >index 346cb2666f3a..11cc522b1d9f 100644
> >--- a/drivers/net/ethernet/intel/ice/ice_sriov.h
> >+++ b/drivers/net/ethernet/intel/ice/ice_sriov.h
> >@@ -28,6 +28,7 @@
> > #ifdef CONFIG_PCI_IOV
> > void ice_process_vflr_event(struct ice_pf *pf);
> > int ice_sriov_configure(struct pci_dev *pdev, int num_vfs);
> >+int ice_set_vf_fn_mac(struct ice_pf *pf, u16 vf_id, u8 *mac);
> > int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac);
> > int
> > ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_inf=
o *ivi);
> >@@ -76,6 +77,13 @@ ice_sriov_configure(struct pci_dev __always_unused *p=
dev,
> >       return -EOPNOTSUPP;
> > }
> >
> >+static inline int
> >+ice_set_vf_fn_mac(struct ice_pf __always_unused *pf,
> >+                u16 __always_unused vf_id, u8 __always_unused *mac)
> >+{
> >+      return -EOPNOTSUPP;
> >+}
> >+
> > static inline int
> > ice_set_vf_mac(struct net_device __always_unused *netdev,
> >              int __always_unused vf_id, u8 __always_unused *mac)
> >--
> >2.39.3 (Apple Git-146)
> >
>


