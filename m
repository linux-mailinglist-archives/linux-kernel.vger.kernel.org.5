Return-Path: <linux-kernel+bounces-106095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BC487E909
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1870B283623
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C5237702;
	Mon, 18 Mar 2024 11:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R56LrXyr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03394364DA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 11:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710762952; cv=none; b=DGuocwpHVqr8rht0WoKuFm8EnkiwUKc5AcF7gRKWHV1MD3PMdCt09bxQM7QoHRUgg1vebKOES2eUHrozcj2X5tuYcX9xTt6kzLhPPSD/hYO2t9nS4w1pBVkfe+iUKV5GnhixDhl5O+npHD4b0/lLS1eOyAzaFNvJKW+twP5yFYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710762952; c=relaxed/simple;
	bh=TlQA9KWALxjW31LLnsZDmOZu2jVvVJ2v7q3jpZzql+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e34J3uFrXPMoePx33QsIQkVhEYO26J8t/u/2JbcRaTEAepdV2lTSY+7o9lXxnAEYvquLVO2z+Jnu9ICnOdi1Q6EiBEGcYMhgR5p5YOpYJtv2KHh8ofidiTo9NYt7Ukz4Ty0ujMNxih6AOulAhk6z96wdTUg3CsAnniRN2oirztI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R56LrXyr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710762950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fji/TsjIDfTCqMth9RdPpKg7LeX5LQN9MfRyiB39gCM=;
	b=R56LrXyrkguQBlgoZhSqOuq/M/OEo/s6iMRJg+fFH0+SlGgV/th9KeahafaN9SWtcF4vBA
	1CuAtgAE+T2+F+TFPU/LNP1tag4ra5Ad/5zVPSIIUeVvX0cZuF5MKcOlvf9Iu/PLsCVuuD
	JmUB1UemhIbInBXFlwoBNiqnuQI8KnI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-_KAhpTWnMrmc5y6mPWttJg-1; Mon, 18 Mar 2024 07:55:48 -0400
X-MC-Unique: _KAhpTWnMrmc5y6mPWttJg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-69057317d23so80825146d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 04:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710762948; x=1711367748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fji/TsjIDfTCqMth9RdPpKg7LeX5LQN9MfRyiB39gCM=;
        b=D1+qY3du+FhpZnKfFwCsHpJov2AYgB39WseRV354uOzIDTvE2s4kEeNVqv+VrlAvse
         HcdUEkkCAaqv1Tsn8LcEBDL2p1qfll6hY04OaH5ZLcatnbFVxd6TS8QFJOKfOViZtZW+
         AMIcE00ayOlbzTpbD8VFSHr9/2SBJ7Ptj7n6w68X+ytq7iAU4s2/l/IvwYVwIogKqMh0
         x1/XYd2/FjkaKSIHDdJ7RWimvpZ6p4S7uPK8jrLUdvtg0eoxBzE5nlom48nSTtTkhkY3
         8dPfSRkgKEfAgrOMXNo2UjTpaVtoL6ugFdzUEtd3Zycl/wEHhedpxinM07EL3y8/7s3H
         MIdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS/NDO/woUkw5Y6/+dJU7yZQg48OUe3g0sU1hceJ5HUEx2Hew2FfhtCAO09zjiwUN3Wy8bJEuJNFzv+YlluzITyUclkvIXmpovzguU
X-Gm-Message-State: AOJu0YwxWvtirrveOm5koCfZFziqt7c0m23SOeFSEX6F5vRaM/Q9iWcZ
	3yZfanSxyHuYLiXbD1G865o4BPrfjJfSDx2jIv7X8y+EwHchGc1Fpl8FceewN45IWG0gxcMXwvm
	BQaIkiS1QnxGQ8w9/JL0CO7u8152CorD1P4Q65taxGdSnTDni44bkjrFIfiwoduGMmvaqqS/0mE
	bi9Dt6+mzd8oH1DEekI3AiMgtdRsVxZZLu9RPQ
X-Received: by 2002:ad4:59ce:0:b0:690:b99a:22b2 with SMTP id el14-20020ad459ce000000b00690b99a22b2mr11868573qvb.44.1710762948426;
        Mon, 18 Mar 2024 04:55:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0piHQYTZV/rsZPduwXaeEr6xmXop1gS4YV8C6uj4H5QpQhwzW2Ggp4jNCLBfoiZjU3fR9zbEn00eRonXYHig=
X-Received: by 2002:ad4:59ce:0:b0:690:b99a:22b2 with SMTP id
 el14-20020ad459ce000000b00690b99a22b2mr11868565qvb.44.1710762948065; Mon, 18
 Mar 2024 04:55:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305152641.53489-1-ksundara@redhat.com> <SJ0PR18MB5216589DBE2D5345BD016BE0DB272@SJ0PR18MB5216.namprd18.prod.outlook.com>
In-Reply-To: <SJ0PR18MB5216589DBE2D5345BD016BE0DB272@SJ0PR18MB5216.namprd18.prod.outlook.com>
From: Karthik Sundaravel <ksundara@redhat.com>
Date: Mon, 18 Mar 2024 17:25:37 +0530
Message-ID: <CAPh+B4JH-Wb1qetsqfnCeLcxTpOM72TSTwreqP9H6sxnP9Kn9A@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH v5] ice: Add get/set hw address for VFs using
 devlink commands
To: Suman Ghosh <sumang@marvell.com>
Cc: "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, 
	"anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "jiri@resnulli.us" <jiri@resnulli.us>, 
	"michal.swiatkowski@linux.intel.com" <michal.swiatkowski@linux.intel.com>, 
	"rjarry@redhat.com" <rjarry@redhat.com>, "aharivel@redhat.com" <aharivel@redhat.com>, 
	"vchundur@redhat.com" <vchundur@redhat.com>, "cfontain@redhat.com" <cfontain@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 3:28=E2=80=AFPM Suman Ghosh <sumang@marvell.com> wro=
te:
>
> >----------------------------------------------------------------------
> >Changing the MAC address of the VFs are not available via devlink. Add
> >the function handlers to set and get the HW address for the VFs.
> >
> >Signed-off-by: Karthik Sundaravel <ksundara@redhat.com>
> >---
> > drivers/net/ethernet/intel/ice/ice_devlink.c | 78 +++++++++++++++++++-
> > drivers/net/ethernet/intel/ice/ice_sriov.c   | 62 ++++++++++++++++
> > drivers/net/ethernet/intel/ice/ice_sriov.h   |  8 ++
> > 3 files changed, 147 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c
> >b/drivers/net/ethernet/intel/ice/ice_devlink.c
> >index 80dc5445b50d..39d4d79ac731 100644
> >--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
> >+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
> >@@ -1576,6 +1576,81 @@ void ice_devlink_destroy_pf_port(struct ice_pf
> >*pf)
> >       devlink_port_unregister(&pf->devlink_port);
> > }
> >
> >+/**
> >+ * ice_devlink_port_get_vf_fn_mac - .port_fn_hw_addr_get devlink
> >+handler
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
> >+      struct devlink_port_attrs *attrs =3D &port->attrs;
> [Suman] I agree with Wojciech about using container_of:

[Karthik] when I use container_of(), on some occasions I get core dump
in get and set functions.
These issues were not seen in the earlier versions.
Can you please suggest any pointers on what could have gone wrong ?

struct ice_vf *vf =3D container_of(port, struct ice_vf, devlink_port);

[  597.658325] ------------[ cut here ]------------
[  597.658329] refcount_t: underflow; use-after-free.
[  597.658430] CPU: 18 PID: 1926 Comm: devlink Not tainted 6.8.0-rc5-dirty =
#1
[  ...]
[  597.658506]  ? refcount_warn_saturate+0xbe/0x110
[  597.658509]  ice_devlink_port_get_vf_fn_mac+0x39/0x70 [ice]
[  597.658607]  ? __pfx_ice_devlink_port_get_vf_fn_mac+0x10/0x10 [ice]
[  597.658676]  devlink_nl_port_fill+0x314/0xa30
[  ...]
[  597.658835] ---[ end trace 0000000000000000 ]---


[  859.989482] ------------[ cut here ]------------
[  859.989485] refcount_t: saturated; leaking memory.
[  859.989500] WARNING: CPU: 0 PID: 1965 at lib/refcount.c:19
refcount_warn_saturate+0x9b/0x110
[  ...]
[  859.989671]  ? refcount_warn_saturate+0x9b/0x110
[  859.989674]  ice_get_vf_by_id+0x87/0xa0 [ice]
[  859.989777]  ice_set_vf_fn_mac+0x33/0x150 [ice]
[  859.989858]  ice_devlink_port_set_vf_fn_mac+0x61/0x90 [ice]
[  859.989940]  devlink_nl_port_set_doit+0x1d3/0x610
[  ...]
[  952.413933] ---[ end trace 0000000000000000 ]---

>
> >+      struct devlink_port_pci_vf_attrs *pci_vf;
> >+      struct devlink *devlink =3D port->devlink;
> >+      struct ice_pf *pf;
> >+      struct ice_vf *vf;
> >+      int vf_id;
> >+
> >+      pf =3D devlink_priv(devlink);
> >+      pci_vf =3D &attrs->pci_vf;
> >+      vf_id =3D pci_vf->vf;
> >+
> >+      vf =3D ice_get_vf_by_id(pf, vf_id);
> >+      if (!vf) {
> >+              NL_SET_ERR_MSG_MOD(extack, "Unable to get the vf");
> >+              return -EINVAL;
> >+      }
> >+      ether_addr_copy(hw_addr, vf->dev_lan_addr);
> >+      *hw_addr_len =3D ETH_ALEN;
> >+
> >+      ice_put_vf(vf);
> >+      return 0;
> >+}
> >+
> >+/**
> >+ * ice_devlink_port_set_vf_fn_mac - .port_fn_hw_addr_set devlink
> >+handler
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
> >+      int vf_id;
> >+
> >+      pf =3D devlink_priv(devlink);
> >+      pci_vf =3D &attrs->pci_vf;
> >+      vf_id =3D pci_vf->vf;
> >+
> >+      ether_addr_copy(mac, hw_addr);
> >+
> >+      return ice_set_vf_fn_mac(pf, vf_id, mac); }
> >+
> >+static const struct devlink_port_ops ice_devlink_vf_port_ops =3D {
> >+      .port_fn_hw_addr_get =3D ice_devlink_port_get_vf_fn_mac,
> >+      .port_fn_hw_addr_set =3D ice_devlink_port_set_vf_fn_mac, };
> >+
> > /**
> >  * ice_devlink_create_vf_port - Create a devlink port for this VF
> >  * @vf: the VF to create a port for
> >@@ -1611,7 +1686,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
> >       devlink_port_attrs_set(devlink_port, &attrs);
> >       devlink =3D priv_to_devlink(pf);
> >
> >-      err =3D devlink_port_register(devlink, devlink_port, vsi->idx);
> >+      err =3D devlink_port_register_with_ops(devlink, devlink_port,
> >+                                           vsi->idx, &ice_devlink_vf_po=
rt_ops);
> >       if (err) {
> >               dev_err(dev, "Failed to create devlink port for VF %d, er=
ror
> >%d\n",
> >                       vf->vf_id, err);
> >diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> >b/drivers/net/ethernet/intel/ice/ice_sriov.c
> >index 31314e7540f8..73cf1d9e9daa 100644
> >--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> >+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> >@@ -1216,6 +1216,68 @@ ice_get_vf_cfg(struct net_device *netdev, int
> >vf_id, struct ifla_vf_info *ivi)
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
> >+int ice_set_vf_fn_mac(struct ice_pf *pf, int vf_id, u8 *mac) {
> >+      struct device *dev;
> >+      struct ice_vf *vf;
> >+      int ret;
> >+
> >+      dev =3D ice_pf_to_dev(pf);
> >+      if (is_multicast_ether_addr(mac)) {
> >+              dev_err(dev, "%pM not a valid unicast address\n", mac);
> >+              return -EINVAL;
> >+      }
> [Suman] I would suggest put all the validation checks at the beginning of=
 the function.
> >+
> >+      vf =3D ice_get_vf_by_id(pf, vf_id);
> [Suman] Any reason we are passing vf_id instead of the vf itself? If you =
decide to pass vf itself please move the ether_addr_equal() check at the be=
ginning also.
>
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
 MAC
> >*/
> >+              vf->pf_set_mac =3D false;
> >+              dev_info(dev, "Removing MAC on VF %d. VF driver will be
> >reinitialized\n",
> >+                       vf->vf_id);
> >+      } else {
> >+              /* PF will add MAC rule for the VF */
> >+              vf->pf_set_mac =3D true;
> >+              dev_info(dev, "Setting MAC %pM on VF %d. VF driver will b=
e
> >reinitialized\n",
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
> >  * @netdev: network interface device structure diff --git
> >a/drivers/net/ethernet/intel/ice/ice_sriov.h
> >b/drivers/net/ethernet/intel/ice/ice_sriov.h
> >index 346cb2666f3a..a03be184a806 100644
> >--- a/drivers/net/ethernet/intel/ice/ice_sriov.h
> >+++ b/drivers/net/ethernet/intel/ice/ice_sriov.h
> >@@ -28,6 +28,7 @@
> > #ifdef CONFIG_PCI_IOV
> > void ice_process_vflr_event(struct ice_pf *pf);  int
> >ice_sriov_configure(struct pci_dev *pdev, int num_vfs);
> >+int ice_set_vf_fn_mac(struct ice_pf *pf, int vf_id, u8 *mac);
> > int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac);  int
> >ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_info
> >*ivi); @@ -76,6 +77,13 @@ ice_sriov_configure(struct pci_dev
> >__always_unused *pdev,
> >       return -EOPNOTSUPP;
> > }
> >
> >+static inline int
> >+ice_set_vf_fn_mac(struct ice_pf __always_unused *pf,
> >+                int __always_unused vf_id, u8 __always_unused *mac) {
> >+      return -EOPNOTSUPP;
> >+}
> >+
> > static inline int
> > ice_set_vf_mac(struct net_device __always_unused *netdev,
> >              int __always_unused vf_id, u8 __always_unused *mac)
> >--
> >2.39.3 (Apple Git-145)
> >
>


