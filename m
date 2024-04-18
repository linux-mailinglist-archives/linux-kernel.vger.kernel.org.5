Return-Path: <linux-kernel+bounces-149970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B52398A9894
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60F91C20C6C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C3C15E7F0;
	Thu, 18 Apr 2024 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ekomtfTr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D90215E5DB;
	Thu, 18 Apr 2024 11:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713439929; cv=none; b=DpXagm7kQKgxvzwI+YRypgMVr1eotDnSPYs9f8zj5g1kkN+luEQXq2OVPEr52CRg7WxQyrEqQLPLOD8fofHzoi3ZKwjvITBH+3ZhWxN95Pcq8XPiU8qWSpA1z8BN0THOWxp1GaITurwW/7Y/Q/RAfCw9xo7Nfh+tNdgVwekrvso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713439929; c=relaxed/simple;
	bh=HQxeyED3Z82cVQSD6uzhUbrNuIaqk/Ru44l/pAWP8c8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=c542XH++t1NBWXltk3cWrjj7Zhq2EeGlZGtma1eP+7s9MkmCifskNpZ2AOvE94e4nFRMLSiViCf8efA2Zvf1aUQXoEIjjOdnsni2RycsdKHleTtLouTAggSsSFyfNPJR+R3+V8n1JYwS7aYbYS3desRWuoOQYeYbnqxcIEHPb34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ekomtfTr; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713439928; x=1744975928;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HQxeyED3Z82cVQSD6uzhUbrNuIaqk/Ru44l/pAWP8c8=;
  b=ekomtfTrSueymx/j0rETIzrUqJi/FaEZiDnhBPfEIbewjao0spdUrCBC
   BiKT/YYM4XMwub/qUyPBOqg4pKmg9tVOxtfQmbH/JIM6u6iMIhPq5tl8A
   dX3EymqyhWC72aHj3Lan2q7EZw1jcdedIP04YVAjXpvfuTSR6+hwDRAHY
   w7I1TEkSauFugfu3t/+60czCl8XHVMgtkUu6Td/TSb87xlUyof5U4ILgb
   sRhWO5A2rJHO+BZWz4oM/wcyK4mybl3ntKDAiWTKyO7qSi5J8Q/bqVYkb
   TIVxFcmw4rP1Ul/Uw+Xge1fj0dA7XuCKoyq6oeMdiXIWi2rS0UoDGso2v
   Q==;
X-CSE-ConnectionGUID: 5S9PyJZ0Tr2AmCu7viEtqQ==
X-CSE-MsgGUID: sDArExs7TPy2Q/+TQvkXOg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9098737"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="9098737"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:32:08 -0700
X-CSE-ConnectionGUID: tnh4fF/PR2q00vnd2tmwrA==
X-CSE-MsgGUID: kd/VHbO+TwCHHg/mNJKX/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="23013166"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.36])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:32:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 18 Apr 2024 14:32:01 +0300 (EEST)
To: Parker Newman <parker@finest.io>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v4 2/7] serial: exar: added a exar_get_nr_ports
 function
In-Reply-To: <33f2bf66bc334573c10cf670a299ecef0b7264bc.1713382717.git.pnewman@connecttech.com>
Message-ID: <e5ea43d8-90a1-c157-9932-99192fc5d138@linux.intel.com>
References: <cover.1713382717.git.pnewman@connecttech.com> <33f2bf66bc334573c10cf670a299ecef0b7264bc.1713382717.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1371258394-1713439921=:986"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1371258394-1713439921=:986
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 17 Apr 2024, Parker Newman wrote:

> From: Parker Newman <pnewman@connecttech.com>
>=20
> Moved code for getting number of ports from exar_pci_probe() to a
> separate exar_get_nr_ports() function. CTI specific code will be added
> in another patch in this series.
>=20
> Signed-off-by: Parker Newman <pnewman@connecttech.com>
> ---
> Changes in v3:
> - Only moved existing code in this patch, will add CTI code in subsequent
>   patch
>=20
>  drivers/tty/serial/8250/8250_exar.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/825=
0/8250_exar.c
> index 04ce5e8ddb24..72385c7d2eda 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -704,6 +704,21 @@ static irqreturn_t exar_misc_handler(int irq, void *=
data)
>  =09return IRQ_HANDLED;
>  }
>=20
> +static unsigned int exar_get_nr_ports(struct exar8250_board *board,
> +=09=09=09=09=09struct pci_dev *pcidev)
> +{
> +=09unsigned int nr_ports =3D 0;

It's always set, so no need to initialize.

> +=09if (pcidev->vendor =3D=3D PCI_VENDOR_ID_ACCESSIO)
> +=09=09nr_ports =3D BIT(((pcidev->device & 0x38) >> 3) - 1);
> +=09else if (board->num_ports)
> +=09=09nr_ports =3D board->num_ports;
> +=09else
> +=09=09nr_ports =3D pcidev->device & 0x0f;
> +
> +=09return nr_ports;
> +}
> +
>  static int
>  exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
>  {
> @@ -723,12 +738,12 @@ exar_pci_probe(struct pci_dev *pcidev, const struct=
 pci_device_id *ent)
>=20
>  =09maxnr =3D pci_resource_len(pcidev, bar) >> (board->reg_shift + 3);
>=20
> -=09if (pcidev->vendor =3D=3D PCI_VENDOR_ID_ACCESSIO)
> -=09=09nr_ports =3D BIT(((pcidev->device & 0x38) >> 3) - 1);
> -=09else if (board->num_ports)
> -=09=09nr_ports =3D board->num_ports;
> -=09else
> -=09=09nr_ports =3D pcidev->device & 0x0f;
> +=09nr_ports =3D exar_get_nr_ports(board, pcidev);
> +=09if (nr_ports =3D=3D 0) {
> +=09=09dev_err_probe(&pcidev->dev, -ENODEV,
> +=09=09=09=09"failed to get number of ports\n");
> +=09=09return -ENODEV;

=09=09return dev_err_probe(&pcidev->dev, -ENODEV,
=09=09=09=09     "failed to get number of ports\n");

Other than those two small things,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1371258394-1713439921=:986--

