Return-Path: <linux-kernel+bounces-8656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B92AD81BAB4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640A01F2515F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DE958232;
	Thu, 21 Dec 2023 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZBnVtgt9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A395C55E66;
	Thu, 21 Dec 2023 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703172346; x=1734708346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xJ0AVvheUL6wZxgkx3XQPaIwMWIH/srjmc/pD4WUabA=;
  b=ZBnVtgt9tGGttSOUjb4hfFd12qERjlsnmo2ekGgq/8Fppm5nNlx+1led
   FICbPdYGfYo0lCyfdKiGLrtaotx0y3vMEKAKrX811efN81u30iuyvgnRm
   u9wKksjn2NZfqFmMfYuIrLeqdLXB8Q/5e2ok6G5vTGLoyg3ILHI3jIBE9
   JPa8aUODKkmMJdN9fjv4Tgd+1WvSKaBXo9yI8NuTqUwRw9N5jGhdVk+uK
   fsNGuYRS+AUWCWCUUs1nIxwegc9n/xMJH7QGOsnwQh2VZfHhZz4OlmYMz
   Sq79vNB26WqdKOAYuo9pwUFiz3Nimk4BqDUMHRCRZQPh0iSTn3sY97sBm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="380975911"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="380975911"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 07:25:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="949955002"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="949955002"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 07:25:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rGKvb-00000007skq-2VII;
	Thu, 21 Dec 2023 17:25:39 +0200
Date: Thu, 21 Dec 2023 17:25:39 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Raul Rangel <rrangel@chromium.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 17/22] of: irq: add wake capable bit to
 of_irq_resource()
Message-ID: <ZYRY8ypZ1cYNRMcP@smile.fi.intel.com>
References: <20231220235459.2965548-1-markhas@chromium.org>
 <20231220165423.v2.17.I29b26a7f3b80fac0a618707446a10b6cc974fdaf@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220165423.v2.17.I29b26a7f3b80fac0a618707446a10b6cc974fdaf@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 20, 2023 at 04:54:31PM -0700, Mark Hasemeyer wrote:
> Add wake capability information to the IRQ resource. Wake capability is
> assumed based on conventions provided in the devicetree wakeup-source
> binding documentation. An interrupt is considered wake capable if the
> following are true:
> 1. A wakeup-source property exits in the same device node as the
>    interrupt.
> 2. The IRQ is marked as dedicated by setting its interrupt-name to
>    "wakeup".
> 
> The wakeup-source documentation states that dedicated interrupts can use
> device specific interrupt names and device drivers are still welcome to
> use their own naming schemes. This API is provided as a helper if one is
> willing to conform to the above conventions.
> 
> The ACPI subsystems already provides similar APIs that allow one to
> query the wake capability of an IRQ. This brings closer feature parity
> to the devicetree.

...

>  		r->start = r->end = irq;
>  		r->flags = IORESOURCE_IRQ | irqd_get_trigger_type(irq_get_irq_data(irq));
> +		if (__of_irq_wake_capable(dev, index))
> +			r->flags |= IORESOURCE_IRQ_WAKECAPABLE;
>  		r->name = name ? name : of_node_full_name(dev);

		irq_flags = irqd_get_trigger_type(irq_get_irq_data(irq));
		if (__of_irq_wake_capable(dev, index))
			irq_flags |= IORESOURCE_IRQ_WAKECAPABLE;

		*r = DEFINE_RES_NAMED(irq, 1, name ?: of_node_full_name(dev), irq_flags);

?

...

Or even refactor ioport.h (in a separate patch) as we seems already have
two users (and might be more in the existing code):

#define DEFINE_RES_IRQ_NAMED_FLAGS(_irq, _name, _flags)			\
	DEFINE_RES_NAMED((_irq), 1, (_name), (_flags) | IORESOURCE_IRQ)
#define DEFINE_RES_IRQ_NAMED(_irq, _name)				\
	DEFINE_RES_IRQ_NAMED_FLAGS((_irq), (_name), 0)
#define DEFINE_RES_IRQ(_irq)						\
	DEFINE_RES_IRQ_NAMED((_irq), NULL)

(Note, I will Ack such a patch once it appears.)

-- 
With Best Regards,
Andy Shevchenko



