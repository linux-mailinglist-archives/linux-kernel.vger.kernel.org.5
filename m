Return-Path: <linux-kernel+bounces-12168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3323681F0DC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D781D282B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D112546458;
	Wed, 27 Dec 2023 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EqUeSMdZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE504644B;
	Wed, 27 Dec 2023 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703697606; x=1735233606;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uh4fAirC7kTManarC9UXX0TN/caPGLtg+xbkuzBlZf0=;
  b=EqUeSMdZE1Nb4wQMY8Qpc/8dwkdN7x/SK0IC45NdtJsm/ou4slutndj5
   dJdygIZ4Rbi8zWRmPIoqlL6nzD9wGolJ7jCCo9FEuaiajlFt0Rut9MUJU
   FmgqTTwFiuF35GADLlyhMteM1FH//FIL0v8MQA3J4Fqi6aFlyKKkbjzYd
   hTBlKgRbAchUDYrnkncMFfIS1WH165bHU8qO85q8xOqYJkzAr3B9UVy6R
   xImq95EoVqiTFXaX3Oe/qyE2O9IuJa/PidWfUm3DDr1vhnMgwREd5177W
   CIxvXCRoO6c99W/aHZVwgHVinqA8h/b4l4N6qrDpuVBANygu4ctkHwyHa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="3273404"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="3273404"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 09:20:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="951551797"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="951551797"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 09:20:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rIXZV-00000009TPY-2Wuc;
	Wed, 27 Dec 2023 19:19:57 +0200
Date: Wed, 27 Dec 2023 19:19:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Raul Rangel <rrangel@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 18/24] of: irq: add wake capable bit to
 of_irq_resource()
Message-ID: <ZYxcvSLL8yWW-URu@smile.fi.intel.com>
References: <20231226192149.1830592-1-markhas@chromium.org>
 <20231226122113.v3.18.I29b26a7f3b80fac0a618707446a10b6cc974fdaf@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226122113.v3.18.I29b26a7f3b80fac0a618707446a10b6cc974fdaf@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 26, 2023 at 12:21:22PM -0700, Mark Hasemeyer wrote:
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

> +		u32 irq_flags;
>  		const char *name = NULL;

Don't know if OF style requires reversed xmas tree order. If so, this should be

		const char *name = NULL;
		u32 irq_flags;

Otherwise looks good to me, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



