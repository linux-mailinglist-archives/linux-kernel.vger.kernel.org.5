Return-Path: <linux-kernel+bounces-58168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE07384E22D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E657B2A2C0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166E976C64;
	Thu,  8 Feb 2024 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ByXtfVjM"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67331E485;
	Thu,  8 Feb 2024 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707399755; cv=none; b=EMfyL4MVOQA9p3ZzjEj4NoFPz8JIeb+hlS/8ToD0OT5dSdqJgOWgHVhomSTMtaBHcqPOAi2WkMf/AVE20NEHTVqnZ1jUEMXcdhVSlsoUFdhINfDLfTuwxcn7TcbCju843gb0RlR6ygy1d0XxjGUhZxMeraxOWSQtyONprihLj24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707399755; c=relaxed/simple;
	bh=pyRGOt/cCSoXwL5MuB6r980v2EdUtNXRYTnNkulb+nQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qTiNTttFoZLQ+SFcw5IxVvf87dAGSqbalXnaPJzPIGZMcMxedzcJ5QZ94ElLlgWKpE5DPsNnDnzos3t2yyIbYf+FRTa4pD/kxevNDtOJD8P5E+fWcInY6Jxtg/ZPES3dDsRz1uKGHlF9g+JEm0oY7p+TW3fWwVBm3LK4OXmpfGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ByXtfVjM; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707399753; x=1738935753;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pyRGOt/cCSoXwL5MuB6r980v2EdUtNXRYTnNkulb+nQ=;
  b=ByXtfVjMintXni95PHwKMxDH82JuKGyJkAhaj4uWCno7yTt3ggv4E4X3
   ZiWF6RXZmRu68LhFukf4LHbv+RQX+gz8+eil8jV8iptYhGxkh4eNaEfeY
   WX5a9AAuL2KCPnPexj0vGP0iULT7UgTAUzzO76+UYVkvq5zXxYoN1AbnR
   1kQV3/g97bp4h3B/vaJ5ptO83trao2B/WWBI6jgQelJX8ntCTZyrUtHcH
   AadhdkWnbOaCuEAMaPTIu4r5vY+WcQ2AIH2KPk9R5ofvsjfTUusszTAl7
   8eK7vsv84tlEpvrLd2AZQJi5C5Nqj9mYtL55M8QxXjSmWK7d+lGrkYpqx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="436353636"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="436353636"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 05:42:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="910360041"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="910360041"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.52.95])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 05:42:31 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 8 Feb 2024 15:42:28 +0200 (EET)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: Netdev <netdev@vger.kernel.org>, 
    sathyanarayanan.kuppuswamy@linux.intel.com, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 1/8] platform/x86/intel/sdsi: Set message size during
 writes
In-Reply-To: <20240201010747.471141-2-david.e.box@linux.intel.com>
Message-ID: <0d83b5fc-03ff-b96d-a55a-57ee954fed26@linux.intel.com>
References: <20240201010747.471141-1-david.e.box@linux.intel.com> <20240201010747.471141-2-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-425400672-1707399748=:1104"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-425400672-1707399748=:1104
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 31 Jan 2024, David E. Box wrote:

> New mailbox commands will support sending multi packet writes and updated
> firmware now requires that the message size be written for all commands
> along with the packet size. Since the driver doesn't perform writes large=
r
> than the packet size, set the message size to the same value.
>=20
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel/sdsi.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/int=
el/sdsi.c
> index 556e7c6dbb05..a70c071de6e2 100644
> --- a/drivers/platform/x86/intel/sdsi.c
> +++ b/drivers/platform/x86/intel/sdsi.c
> @@ -252,6 +252,7 @@ static int sdsi_mbox_cmd_write(struct sdsi_priv *priv=
, struct sdsi_mbox_info *in
>  =09=09  FIELD_PREP(CTRL_SOM, 1) |
>  =09=09  FIELD_PREP(CTRL_RUN_BUSY, 1) |
>  =09=09  FIELD_PREP(CTRL_READ_WRITE, 1) |
> +=09=09  FIELD_PREP(CTRL_MSG_SIZE, info->size) |
>  =09=09  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
>  =09writeq(control, priv->control_addr);

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-425400672-1707399748=:1104--

