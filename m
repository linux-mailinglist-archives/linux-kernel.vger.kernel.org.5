Return-Path: <linux-kernel+bounces-7050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E94381A0FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F414F1F224A9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFF538F8C;
	Wed, 20 Dec 2023 14:20:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E5B38DDF;
	Wed, 20 Dec 2023 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="375309609"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="375309609"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 06:20:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="866987944"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="866987944"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 06:20:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rFxQT-00000007YXL-3LxH;
	Wed, 20 Dec 2023 16:19:57 +0200
Date: Wed, 20 Dec 2023 16:19:57 +0200
From: Andy Shevchenko <andy@kernel.org>
To: xiongxin <xiongxin@kylinos.cn>
Cc: fancer.lancer@gmail.com, hoan@os.amperecomputing.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v5] gpio: dwapb: mask/unmask IRQ when disable/enale it
Message-ID: <ZYL4DfamQdj45gxh@smile.fi.intel.com>
References: <20231219101620.4617-1-xiongxin@kylinos.cn>
 <20231220022901.29158-1-xiongxin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220022901.29158-1-xiongxin@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 20, 2023 at 10:29:01AM +0800, xiongxin wrote:
> In the hardware implementation of the I2C HID driver based on DesignWare
> GPIO IRQ chip, when the user continues to use the I2C HID device in the
> suspend process, the I2C HID interrupt will be masked after the resume
> process is finished.
> 
> This is because the disable_irq()/enable_irq() of the DesignWare GPIO
> driver does not synchronize the IRQ mask register state. In normal use
> of the I2C HID procedure, the GPIO IRQ irq_mask()/irq_unmask() functions
> are called in pairs. In case of an exception, i2c_hid_core_suspend()
> calls disable_irq() to disable the GPIO IRQ. With low probability, this
> causes irq_unmask() to not be called, which causes the GPIO IRQ to be
> masked and not unmasked in enable_irq(), raising an exception.
> 
> Add synchronization to the masked register state in the
> dwapb_irq_enable()/dwapb_irq_disable() function. mask the GPIO IRQ
> before disabling it. After enabling the GPIO IRQ, unmask the IRQ.

...

> v5:
> 	* fix typo in patch description

Thank you! This looks perfect!

-- 
With Best Regards,
Andy Shevchenko



