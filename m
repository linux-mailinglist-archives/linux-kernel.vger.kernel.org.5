Return-Path: <linux-kernel+bounces-155853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 000FD8AF808
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3088BB24000
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EDB142E60;
	Tue, 23 Apr 2024 20:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SjbSo5px"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182691DFD0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713904467; cv=none; b=lkO3i0u/XzouvorMQxVVpxj6gY/WbkaBqJnNp1QeDxaowLi4SdtwXuwlmJT+FniogUyoWpiwweeMgAz7pE07zX8vBZryLVC2yqO/+/T3KzqpCVXn8wGuZUAE67ulT8fJagBfutx8ZgZC3IcYlqtCXbli+A5rYUxuhQWAaqynnPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713904467; c=relaxed/simple;
	bh=n+mPufYoYEFt9YUN0i64MuiWCBENtKpOpSJonH/OoLU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OULxmgVy8KCYaU4NxVAXcBljjSol6eslhdjHoYmIAAYgejeosDsPghP3HPpMxzMnEiP5LdeixoT8L6S18wUqC0JVT7iT+bsnCdH3FymF+HEFCr0kj7tDMcbPLNdGJ2pHS2icp1LvtMiXs8dn+X3v4OBidZefg3yJMThRUVvnNU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SjbSo5px; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713904466; x=1745440466;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=n+mPufYoYEFt9YUN0i64MuiWCBENtKpOpSJonH/OoLU=;
  b=SjbSo5pxQOpJzThUNzD3ghiMYV3dTShkyOQA1SBdd+fjC0xzk/lIdzjq
   B+QgSi33zzdvoztz9f+PphUMUaVfYRuu548Eb3+tS18gj9QYxj358VJD3
   3573gD7CfgZlZZuXOy2bVcg8viIg/w8pNQ1aTKlGVRUsmY+BuP+yj3ieM
   2MHwq8m7pnKqQ6CG0HDUazXcMfgcTtA1WEsGHamLiy3PgI+cQdqSOznJ9
   PBJ5x53Ac/dpYOgO0DDJCzPzPDKQA35IMBVosTWtJ/2euNpew+8UykoNH
   BNBCFSp8B3vQi6zK/nb0IACZw8bqCRFRISfmrSLsldHGnt8sAB8n4mGhh
   w==;
X-CSE-ConnectionGUID: 7KX+s5rJTiy57DUvwvbE0w==
X-CSE-MsgGUID: UJy7ToLwSxe1SSqD3ikoLg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="13299060"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="13299060"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 13:34:26 -0700
X-CSE-ConnectionGUID: GxTH2lVwQi2FNpROiMxuNQ==
X-CSE-MsgGUID: il72+M1PQ92DcOnmKKdxMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="61936980"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 13:34:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzMqM-00000000T50-2XEw;
	Tue, 23 Apr 2024 23:34:22 +0300
Date: Tue, 23 Apr 2024 23:34:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: kempld: Remove custom DMI matching code
Message-ID: <ZigbTqKIruqIw_zG@smile.fi.intel.com>
References: <20240418095319.3232118-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418095319.3232118-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 18, 2024 at 12:53:19PM +0300, Andy Shevchenko wrote:
> The ->init() open codes the functionality of DMI matching code.
> Moreover, all DMI quirks are using the same callback and driver_data.
> With this in mind, refactor the DMI matching code.

..

> +	int ret -ENODEV;

Wrong version had been sent, please ignore this.

-- 
With Best Regards,
Andy Shevchenko



