Return-Path: <linux-kernel+bounces-3435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2806816C30
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149101C22EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95BF199D0;
	Mon, 18 Dec 2023 11:33:14 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CCF19BD6;
	Mon, 18 Dec 2023 11:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="399324312"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="399324312"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 03:33:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="841448115"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="841448115"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 03:33:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rFBrt-00000006uZd-1qHe;
	Mon, 18 Dec 2023 13:33:05 +0200
Date: Mon, 18 Dec 2023 13:33:05 +0200
From: Andy Shevchenko <andy@kernel.org>
To: xiongxin <xiongxin@kylinos.cn>
Cc: fancer.lancer@gmail.com, hoan@os.amperecomputing.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [v2] gpio: dwapb: mask/unmask IRQ when disable/enale it
Message-ID: <ZYAt8Zlv9XMYO5FF@smile.fi.intel.com>
References: <20231218081246.1921152-1-xiongxin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218081246.1921152-1-xiongxin@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 18, 2023 at 04:12:46PM +0800, xiongxin wrote:
> In the hardware implementation of the i2c hid driver based on dwapb gpio
> irq, when the user continues to use the i2c hid device in the suspend
> process, the i2c hid interrupt will be masked after the resume process
> is finished.
> 
> This is because the disable_irq()/enable_irq() of the dwapb gpio driver
> does not synchronize the irq mask register state. In normal use of the
> i2c hid procedure, the gpio irq irq_mask()/irq_unmask() functions are
> called in pairs. In case of an exception, i2c_hid_core_suspend() calls
> disable_irq() to disable the gpio irq. With low probability, this causes
> irq_unmask() to not be called, which causes the gpio irq to be masked
> and not unmasked in enable_irq(), raising an exception.
> 
> Add synchronization to the masked register state in the
> dwapb_irq_enable()/dwapb_irq_disable() function. mask the gpio irq
> before disabling it. After enabling the gpio irq, unmask the irq.

> Fixes: 7779b3455697 ("gpio: add a driver for the Synopsys DesignWare APB GPIO block")
> Signed-off-by: xiongxin <xiongxin@kylinos.cn>

Your SoB should go last.

> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>

Then at all means what this SoB for? Either it's missing Co-developed-by,
or simply wrong.

> Tested-by: xiongxin <xiongxin@kylinos.cn>

This is assumed to be done by the contributor, but it's harmless to have it.

With the above being sorted out,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

...

To Serge, I give my vote to hwirq as it is aligned with the documentation.

-- 
With Best Regards,
Andy Shevchenko



