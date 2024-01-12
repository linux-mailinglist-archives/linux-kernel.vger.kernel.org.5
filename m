Return-Path: <linux-kernel+bounces-24795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BF682C2AA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039D81F2129F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB716EB4E;
	Fri, 12 Jan 2024 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VR7hgF78"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FC56DD1D;
	Fri, 12 Jan 2024 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705072909; x=1736608909;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7jVffiOSFNJ/djyJtPLNRXhEr/dyJlXTdJT72bt17RM=;
  b=VR7hgF78ftRXFs8+TdZjMPtMYYNfGH6Nt6kqw0RIDwDNApmMOmQR8CZs
   2GNQbufgNNPp6RfXkhPf/F7O9KerjR1B74QObg6nbeijyOuSD3/9yloRB
   ne2tiP/BbnOEjZoviH6u3m18i57hCN478seQc3pKxcry92GPKDkex0DJe
   v6/hjTcsr7XyPn57RbHapYrsE9qpD0bjZSz4LiXR9UQMi36tnjk4Re6du
   IQQHGw2+ybstNt9iGPafDaWPgby/eQqEIFU0yJ4IKDuJr+jGKRDn4hb7N
   5Wo0pBvtGpQw3BsUFJxE1jEmr+JPgH/vOWGKHqBg7wCBDZK+nsSkyiWeO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="12681077"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="12681077"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 07:21:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="786373596"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="786373596"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.33.141])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 07:21:44 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 12 Jan 2024 17:21:40 +0200 (EET)
To: Liming Sun <limings@nvidia.com>
cc: Vadim Pasternak <vadimp@nvidia.com>, 
    David Thompson <davthompson@nvidia.com>, 
    Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, 
    Dan Carpenter <dan.carpenter@linaro.org>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] Drop Tx network packet when Tx TmFIFO is full
In-Reply-To: <20240111173106.96958-1-limings@nvidia.com>
Message-ID: <107b5fda-d3ec-48c1-107e-53502a1de0bd@linux.intel.com>
References: <f250079635da4ba75c3a3a1d7c3820f48cfc3f06.1704380474.git.limings@nvidia.com> <20240111173106.96958-1-limings@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-168994210-1705072900=:1030"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-168994210-1705072900=:1030
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 11 Jan 2024, Liming Sun wrote:

> Starting from Linux 5.16 kernel, Tx timeout mechanism was added
> in the virtio_net driver which prints the "Tx timeout" warning
> message when a packet stays in Tx queue for too long. Below is an
> example of the reported message:
>=20
> "[494105.316739] virtio_net virtio1 tmfifo_net0: TX timeout on
> queue: 0, sq: output.0, vq: 0=C3=971, name: output.0, usecs since
> last trans: 3079892256".
>=20
> This issue could happen when external host driver which drains the
> FIFO is restared, stopped or upgraded. To avoid such confusing
> "Tx timeout" messages, this commit adds logic to drop the outstanding
> Tx packet if it's not able to transmit in two seconds due to Tx FIFO
> full, which can be considered as congestion or out-of-resource drop.
>=20
> This commit also handles the special case that the packet is half-
> transmitted into the Tx FIFO. In such case, the packet is discarded
> with remaining length stored in vring->rem_padding. So paddings with
> zeros can be sent out when Tx space is available to maintain the
> integrity of the packet format. The padded packet will be dropped on
> the receiving side.
>=20
> Signed-off-by: Liming Sun <limings@nvidia.com>
> ---
> v2->v3:
>   Updates for Ilpo's comments:
>   - Revises commit message to avoid confusion.
> v2: Fixed formatting warning
> v1: Initial version

Thanks, the commit message makes much more sense now!

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-168994210-1705072900=:1030--

