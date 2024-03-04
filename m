Return-Path: <linux-kernel+bounces-90516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F0287007B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367D31C21116
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1563A1B2;
	Mon,  4 Mar 2024 11:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wc1ve5y7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1572339FE1;
	Mon,  4 Mar 2024 11:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709552178; cv=none; b=YHSvSM+x845dXR/V7m4iLaWyPRk8v4hc7tqkjyljGLIQmVtrbG/HoWpmAdboNzockCrdS/iC7Rw+zWqNKoMMTQkhfZjfJVExmtAaY3eaP4q6Jk9fUCnrrYzJxkE5GwTpmVCSxrsjXg/Q3RL+8z3i08gnnX7spKdoAcp8SNpYgO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709552178; c=relaxed/simple;
	bh=IKlS2ZfKbMyeYjGu47DNNEETvYZft8GS7e92DzZ2yfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJ+1wzFTtCNLjn7u0PyhHgdBMefjU354610KfcOLZKdiK3FH9eKE477zceFy1UzMkBGOUq9LtXGHf1o8VvAq9KkbQfHj43EOOspQvDMA1wmwOvn8jZ1PzOrMQY++mFz3rZc7TSr09b8ryNT12nWgRcNkaBTTJ2Rh5AkPtP/qbks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wc1ve5y7; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709552177; x=1741088177;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IKlS2ZfKbMyeYjGu47DNNEETvYZft8GS7e92DzZ2yfk=;
  b=Wc1ve5y7xUptdfZLZSiPXyuyctFzXp9/kzjwBxlLqMOikTJvWDPCGEcH
   NbDJJ9unSIBDySJ2lOtyRzwQMoBrPso+B07KLdc2MG1HgTGs+Vn0bnSwd
   sxjRoeurPEcp1LrWb5qhHMmLhjonkTsCAsWTfo47MeYROENPVdJuSisw7
   LCJZzHo/vp4+8dNF4Iq6hMq7pugimB9GiC6YRntnf/JiulwpoT5X6X+dW
   mgvlI3uvFKsrmVTB97v/2a2wXhh07HT2WwRbaIndVbpZsaKUk7FbAZkx3
   8RsQr+6PcOeZ1gy1E3tkuy83hQPJFVyDGAM7b1pa2//tUynozq72SXGAq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4205051"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4205051"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 03:36:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="914103470"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="914103470"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 03:36:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rh6c6-00000009hcR-38kV;
	Mon, 04 Mar 2024 13:36:10 +0200
Date: Mon, 4 Mar 2024 13:36:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: pressure: BMP280 core driver headers sorting
Message-ID: <ZeWyKhIEm8D13C__@smile.fi.intel.com>
References: <20240303165300.468011-1-vassilisamir@gmail.com>
 <20240303165300.468011-2-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240303165300.468011-2-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Mar 03, 2024 at 05:52:57PM +0100, Vasileios Amoiridis wrote:
> Sort headers in alphabetical order.

..

>  #include <linux/bitops.h>
>  #include <linux/bitfield.h>
> -#include <linux/device.h>
> -#include <linux/module.h>
> -#include <linux/nvmem-provider.h>
> -#include <linux/regmap.h>
> +#include <linux/completion.h>
>  #include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>

>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>

(see below)

> -#include <linux/gpio/consumer.h>
> -#include <linux/regulator/consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h> /* For irq_get_irq_data() */
> -#include <linux/completion.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/random.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>

While at it, please, move iio/* group to be here (and surrounded by
blank lines).

>  #include <asm/unaligned.h>

-- 
With Best Regards,
Andy Shevchenko



