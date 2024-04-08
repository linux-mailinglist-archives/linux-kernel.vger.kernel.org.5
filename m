Return-Path: <linux-kernel+bounces-135577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14E189C7DE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D9002847E6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1239D13F45D;
	Mon,  8 Apr 2024 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZtetUDyW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F2413F44D;
	Mon,  8 Apr 2024 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589022; cv=none; b=LZZopLIjCstQ4qqWbX6QtiZ8lQq4CEQCHF19qvzWHrlxrKBYMLDH8mienoeLCssJ5GJvlUdFyB5cv1lOUdtS1y+7koYHsDQ/sTSkS/XIMPRpl9PbuHvPBTuT/PCAmvLjMAIDiv5TjAKPpWwq+HLKvnGBN1INESweqFLmW5QcWec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589022; c=relaxed/simple;
	bh=mnk5b7SUUNV6f4nzqYibLo6ZQdrF+bcVjTjj/K4cdaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFJheE/wzJgZs2955DbNXfNPNnIWodtoY3VeFnXzya/xGpervo8V//V/0ZDuGRH5Rhw7NH5UgG3RhZoDY4dW5HZB+gm3qu4rDBoDv3XK0nBCDcfKUOJpd+mMGGccwrwPEdage9VGSY43zNeu7EddYrCMiI8IRyNEz0zuwzfAAPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZtetUDyW; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712589020; x=1744125020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mnk5b7SUUNV6f4nzqYibLo6ZQdrF+bcVjTjj/K4cdaY=;
  b=ZtetUDyWYXu6eQve7C+DMHSKj8PCZAHhoz6Rt3rhGGM2h1wLhPXQLYxi
   XrrrLJ/f468+X/QIWeQsPbtbWOeQP+2eS+7YTYRNx5T+zP3A/CeylQmDM
   njTVnmoYJN2X1Xy9aewJ61KigrwVY5fikJCueRc37U6UJf+9/lPzUmub7
   AqbyYWnDTH7OutCo7nbZ/65WVUTLSxfn9tbelOsG71wQMUVhmRgtOE7kx
   2NyhGhGUSGAKObPTpWfoF3eTQvlY+obE9EfinBwpqctccUUbLM1pL4p1E
   paTlFonYzyLcylEcAPENBnURT8csdZhk3omt8k7ipeQKhlVao5zvQ2eNv
   Q==;
X-CSE-ConnectionGUID: CMp8XJpQQA6kYvUrcCezlQ==
X-CSE-MsgGUID: NLwcRJT+QW6+kFXIW83Duw==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7728586"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7728586"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 08:10:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="915368199"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="915368199"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 08:10:16 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rtqdR-00000002Yg8-1ePm;
	Mon, 08 Apr 2024 18:10:13 +0300
Date: Mon, 8 Apr 2024 18:10:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Guanbing Huang <albanhuang@outlook.com>
Cc: gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
	linux-acpi@vger.kernel.org, tony@atomide.com,
	john.ogness@linutronix.de, yangyicong@hisilicon.com,
	jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, lvjianmin@loongson.cn,
	albanhuang@tencent.com, tombinfan@tencent.com
Subject: Re: [PATCH v5 0/3] serial: 8250_pnp: Support configurable reg shift
 property
Message-ID: <ZhQI1RgQtQuctUuL@smile.fi.intel.com>
References: <PSAPR06MB4952B86F64A6CEB853114EA4C9002@PSAPR06MB4952.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSAPR06MB4952B86F64A6CEB853114EA4C9002@PSAPR06MB4952.apcprd06.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 08, 2024 at 11:36:21AM +0800, Guanbing Huang wrote:
> From: Guanbing Huang <albanhuang@tencent.com>
> 
> The 16550a serial port based on the ACPI table requires obtaining the
> reg-shift attribute. In the ACPI scenario, If the reg-shift property
> is not configured like in DTS, the 16550a serial driver cannot read or
> write controller registers properly during initialization.
> 
> To address the issue of configuring the reg-shift property, the 
> __uart_read_properties() universal interface is called to implement it.
> Adaptation of PNP devices is done in the __uart_read_properties() function.

Seems okay to me now,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



