Return-Path: <linux-kernel+bounces-37233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6138583ACFB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878CB1C251A6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9477A709;
	Wed, 24 Jan 2024 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CKfKiWGw"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3959022085;
	Wed, 24 Jan 2024 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109315; cv=none; b=eyrYAWWh29TaLG4PLJ3ASNHAWr0m2SCVQbLJY3cID4Mp6t7Rk3EGi2iFor5nEKR91RZ2pgs4X53ho1Oi2cluZwuBkgHDAi1KG7BxXMoifq42wFNfW+FcdcH1Y/970xVGev/jcXJScqpfWqXNrEu+C/MfUaPtLUZiwJ1R6cmpL5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109315; c=relaxed/simple;
	bh=uzQLDGWYhf9xfb4Lm9GWu2gEumrrxwpUwu6HE1AQ6n0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BmOjgYyQiGGIhkV9tebnCiC0cXqAxbLwU1qyfWqlL0rn+jjTiESDIuNqgBCn6QGwaU3ulQJfsxnamWuTqMGBe9Pe2z5CGOgagK27XjfGKXyIDy/gzEMyeOXd3anSxeA7ToRD45vQ+benDcQ0JqMpAQRqKJcspuHeLgw7J5orFng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CKfKiWGw; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706109313; x=1737645313;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uzQLDGWYhf9xfb4Lm9GWu2gEumrrxwpUwu6HE1AQ6n0=;
  b=CKfKiWGwxLJ/ImggqwJZZj1DS9Lzky2rl0zD5cEOI4B2SCJ5CZvudmFN
   EpGvLCVEDsP0sWmqqwV4VVcO2GPHc26vcTFqEyk/I1O+CCrj9SQZ6Xcgn
   2ZmJLOf6HyTFsP81J+s9qzzsuVAR1hvzs5MXqbU6aot/NITLumDJ95hXo
   OeHGC9vfFNyMx6YYsTQpOcd3xA77uEO0wNYFPDx0i6O1gSyQMRBlJMhXZ
   50cRkQ0VctI4+ktrR6cDH38YFKr/YJL5OMD5jsZOkzd0xaJociA1JlB9f
   yYC6V5GXn+leeVCKMW9ShoWhLPMhWkOcdD2HSPSj3NlRhk/DQAdNHdBd7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="401529939"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="401529939"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 07:15:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2072375"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.46])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 07:15:06 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 24 Jan 2024 17:15:01 +0200 (EET)
To: Frank Li <Frank.Li@nxp.com>
cc: alexandre.belloni@bootlin.com, conor.culhane@silvaco.com, 
    devicetree@vger.kernel.org, gregkh@linuxfoundation.org, 
    imx@lists.linux.dev, jirislaby@kernel.org, joe@perches.com, 
    krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org, 
    linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
    linux-serial@vger.kernel.org, miquel.raynal@bootlin.com, robh@kernel.org, 
    zbigniew.lukwinski@linux.intel.com
Subject: Re: [PATCH v4 6/8] i3c: target: func: add tty driver
In-Reply-To: <20240123231043.3891847-7-Frank.Li@nxp.com>
Message-ID: <744bf8d6-48a3-81b4-baa8-d8c06500a971@linux.intel.com>
References: <20240123231043.3891847-1-Frank.Li@nxp.com> <20240123231043.3891847-7-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 23 Jan 2024, Frank Li wrote:

> Add tty over I3C target function driver.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

> diff --git a/drivers/i3c/func/tty.c b/drivers/i3c/func/tty.c
> new file mode 100644
> index 0000000000000..bad99c08be0ac
> --- /dev/null
> +++ b/drivers/i3c/func/tty.c
> @@ -0,0 +1,475 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 NXP
> + * Author: Frank Li <Frank.Li@nxp.com>
> + */
> +
> +#include <linux/iopoll.h>
> +#include <linux/i3c/target.h>
> +#include <linux/serial_core.h>
> +#include <linux/slab.h>
> +#include <linux/tty_flip.h>
> +
> +static DEFINE_IDR(i3c_tty_minors);
> +
> +static struct tty_driver *i3c_tty_driver;
> +
> +#define I3C_TTY_MINORS		8
> +
> +#define I3C_TX_NOEMPTY		BIT(0)
> +#define I3C_TTY_TRANS_SIZE	16
> +#define I3C_TTY_IBI_TX		BIT(0)

Lacking #include for BIT()


> +	do {
> +		req = i3c_target_ctrl_alloc_request(func->ctrl, GFP_KERNEL);
> +		if (!req)
> +			goto err_alloc_req;
> +
> +		req->buf = (void *) (sport->buffer + offset);

Casting to void is unnecessary.

> +		req->length = rxfifo_size;
> +		req->context = sport;
> +		req->complete = i3c_target_tty_rx_complete;
> +		offset += rxfifo_size;
> +
> +		if (i3c_target_ctrl_queue(req, GFP_KERNEL))
> +			goto err_alloc_req;
> +	} while (req && (offset + rxfifo_size) < UART_XMIT_SIZE);

Extra ().

> +static void i3c_port_shutdown(struct tty_port *port)
> +{
> +	struct ttyi3c_port *sport =
> +		container_of(port, struct ttyi3c_port, port);

Just put this to a single line, nothing important is lost even on 80 char
screen.

> +static void i3c_port_destruct(struct tty_port *port)
> +{
> +	struct ttyi3c_port *sport =
> +		container_of(port, struct ttyi3c_port, port);

Ditto.

> +	if (i3c_target_ctrl_set_config(func->ctrl, func)) {
> +		dev_err(&func->dev, "failure set i3c config\n");

failed to set i3c config


> +	read_poll_timeout(i3c_target_ctrl_fifo_status, val, !val, 100, timeout, false,
> +			  sport->i3cdev->ctrl, true);
> +
> +	i3c_target_ctrl_set_status_format1(sport->i3cdev->ctrl, sport->status & (~I3C_TX_NOEMPTY));

Unnecessary ().

-- 
 i.


