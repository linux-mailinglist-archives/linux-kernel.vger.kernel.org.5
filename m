Return-Path: <linux-kernel+bounces-83290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEBC869158
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD96E290B3B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C35C13AA51;
	Tue, 27 Feb 2024 13:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cbUsXMOD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB70135A43;
	Tue, 27 Feb 2024 13:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039207; cv=none; b=ffboRUKT4K/cr7N2CTatw2bazPwb7Fjxd5RlcfZ46yh4SItv4Cck9g1+No/QtiKq+G2YXy5a5qbrAc3wiCcaD3BoZKytsOyr/7w2ChtidpUKBFS3HwHeYJHQ6jYoh3fT7scUUtbuICgCBtC+UChfyPYHJo0FXzTHBTHjT/DSnP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039207; c=relaxed/simple;
	bh=Lo1alY1DMUzHMBubW78/87yTq2DNgr0TtCs+L7XaYSI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UydrJdtZBNzsw/CKYoMV8rrLKJ5bWcLybAaFw3fZ8XX29hSpuEznGl2ZEIMsY4WOZLIok1oDlaR3uNeS5hwd429Dx9IGFcoYJWnwxH2GrCvPquDbVQg6nyJOj3SZiZwQsiu5PwCT4SC2YBYGp5nEgfukax9oQhj+aGs86BMqwJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cbUsXMOD; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709039206; x=1740575206;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Lo1alY1DMUzHMBubW78/87yTq2DNgr0TtCs+L7XaYSI=;
  b=cbUsXMOD/EtiX/QKTcQI6O2BTQzOaFGTNO/2+bSNP5PQKTg+tn5SY+es
   83LvXS2C1pZRNOKfMJsMV8wl0cetHMwGqsvQ0biTX5LCaL4wfeJ49AV/P
   0XRovQe9N/6Lp4va+6G/+v3daBEJW89mW5WK824ZOmRGS7EnuMtHEr69o
   8kgVHR9iueK/gNlnnA/kG2SBgm6a4K/uXp1KTlitv0KpCt6ufu57Un/QO
   yLB5pDprgD0MVR6ROFGtWHel6m8kBOHBka75ba4eazMuYdxcF3NLounzz
   CFei7rhaVxBcjeN0rSJ6P80CqGPxhip9IB4cd7GVDFFhlIOU1ki5YQdbW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3505315"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3505315"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 05:06:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6973266"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.34.61])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 05:06:42 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Feb 2024 15:06:37 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>
cc: Shyam-sundar.S-k@amd.com, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    sathyanarayanan.kuppuswamy@linux.intel.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] platform/x86: intel_scu_ipcutil: Make scu
 static
In-Reply-To: <20240223163901.13504-3-W_Armin@gmx.de>
Message-ID: <53ba6c16-f0af-44ee-73c5-f6b983ed6420@linux.intel.com>
References: <20240223163901.13504-1-W_Armin@gmx.de> <20240223163901.13504-3-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 23 Feb 2024, Armin Wolf wrote:

> The variable is only used internally and has no external users,
> so it should me made static.
> 
> Compile-tested only.
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
> Changes since v1:
> - remove Fixes tag
> - add Reviewed-by tag
> ---
>  drivers/platform/x86/intel_scu_ipcutil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel_scu_ipcutil.c b/drivers/platform/x86/intel_scu_ipcutil.c
> index b7c10c15a3d6..7d87cbd4b9c6 100644
> --- a/drivers/platform/x86/intel_scu_ipcutil.c
> +++ b/drivers/platform/x86/intel_scu_ipcutil.c
> @@ -22,7 +22,7 @@
> 
>  static int major;
> 
> -struct intel_scu_ipc_dev *scu;
> +static struct intel_scu_ipc_dev *scu;
>  static DEFINE_MUTEX(scu_lock);
> 
>  /* IOCTL commands */

Thanks, I took this 3/3 and 1/3 into review-ilpo.

Please check the comment I raised against 2/3.

-- 
 i.


