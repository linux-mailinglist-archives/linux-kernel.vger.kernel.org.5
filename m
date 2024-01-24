Return-Path: <linux-kernel+bounces-36883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0642383A815
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08B501C242FA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11C31B7E1;
	Wed, 24 Jan 2024 11:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z5fZQnAz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6403E1AAB1;
	Wed, 24 Jan 2024 11:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096315; cv=none; b=LlB41ebEBM8yoY/iuD6yuAWclsWdQc+/OJTFAO5MsfUiP4tSznnhy7ldJ0CpzaNR+xTQMHVFqTiZ9iA1TXtQKtWfk3GYc4suplEuyhQqcC380deLQulC6Bspj9GQInt3Y+WY3kO7bezgKiLQ+2nPIkv6PdL33AcBOClJf0Iiy/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096315; c=relaxed/simple;
	bh=4KDkITjThVdXmK+bUfn3eDscOtSdUbZiuDnwLDTI5eE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OUDrrop254cr00EAkCS69AzzZOD99cRwmVTddmbqRI4XYdTjRE/BPp0jIsUan/43YXLy4kUho1hfK5nEQyTR8di910WU1hQIMlA7/GjNsIrB9nQYl22wzM+QrObGMFG1IP9nxH/TBD3febsP1xzUeyO3XCscAomiXRSmOPLlQd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z5fZQnAz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706096313; x=1737632313;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4KDkITjThVdXmK+bUfn3eDscOtSdUbZiuDnwLDTI5eE=;
  b=Z5fZQnAzWketCuAZfYBBqmBKmDwO2T6cxkOA78eKiE+vUvVzUiewZO5i
   KHZrd51dqv7bNgnkdGH27VYUKVMQQ3l7jtBphJ356WfWfArc+PNwNxo5b
   w6sBvoxNGTG2X2XCgjzG7DwY/KBn/z48xTx03l23O6M+mUV0NgY2CRM0f
   hDdC1wsbDItGs2LH2k95XQs68rVbjgVwur/PzZVk7n6nuUTSj+hkqCHzL
   nqufUlFiBYbow+gCZGx8YVYmZo4lpD2NX90Tms1mtbQHmcbTYj0Xgwil/
   ZvRAFCLTjcOIKlJ4cuc1/4ieHUzQdNh1jESpvX11+hUdW3zmuXVh5oKtr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1691926"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1691926"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 03:38:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="820437647"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="820437647"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.46])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 03:38:23 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 24 Jan 2024 13:38:18 +0200 (EET)
To: Francesco Dolcini <francesco@dolcini.it>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, linux-bluetooth@vger.kernel.org, 
    linux-mediatek@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-arm-kernel@lists.infradead.org, greybus-dev@lists.linaro.org, 
    linux-iio@vger.kernel.org, Netdev <netdev@vger.kernel.org>, 
    chrome-platform@lists.linux.dev, platform-driver-x86@vger.kernel.org, 
    linux-serial <linux-serial@vger.kernel.org>, linux-sound@vger.kernel.org, 
    Francesco Dolcini <francesco.dolcini@toradex.com>, 
    Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
    Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
    Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>, 
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
    Eric Dumazet <edumazet@google.com>, 
    "David S. Miller" <davem@davemloft.net>, 
    Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
    Hans de Goede <hdegoede@redhat.com>, Benson Leung <bleung@chromium.org>, 
    Tzung-Bi Shih <tzungbi@kernel.org>, Rob Herring <robh@kernel.org>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2] treewide, serdev: change receive_buf() return type
 to size_t
In-Reply-To: <20240122180551.34429-1-francesco@dolcini.it>
Message-ID: <7d4309e5-fdcd-13d7-2d4a-7139779e3fdd@linux.intel.com>
References: <20240122180551.34429-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-695447939-1706096298=:1372"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-695447939-1706096298=:1372
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 22 Jan 2024, Francesco Dolcini wrote:

> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>=20
> receive_buf() is called from ttyport_receive_buf() that expects values
> ">=3D 0" from serdev_controller_receive_buf(), change its return type fro=
m
> ssize_t to size_t.
>=20
> The need for this clean-up was noticed while fixing a warning, see
> commit 94d053942544 ("Bluetooth: btnxpuart: fix recv_buf() return value")=
=2E
> Changing the callback prototype to return an unsigned seems the best way
> to document the API and ensure that is properly used.
>=20
> GNSS drivers implementation of serdev receive_buf() callback return
> directly the return value of gnss_insert_raw(). gnss_insert_raw()
> returns a signed int, however this is not an issue since the value
> returned is always positive, because of the kfifo_in() implementation.
> gnss_insert_raw() could be changed to return also an unsigned, however
> this is not implemented here as request by the GNSS maintainer Johan
> Hovold.
>=20
> Suggested-by: Jiri Slaby <jirislaby@kernel.org>
> Link: https://lore.kernel.org/all/087be419-ec6b-47ad-851a-5e1e3ea5cfcc@ke=
rnel.org/
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> #for-iio

Acked-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-695447939-1706096298=:1372--

