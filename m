Return-Path: <linux-kernel+bounces-22363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C98AE829CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14455B26522
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777F04B5BF;
	Wed, 10 Jan 2024 14:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l5449Al+"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508D1482E2;
	Wed, 10 Jan 2024 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704897196; x=1736433196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=up1ALyv91qXOuxdi+OKZLdtkwIszJmhb5lLTZL8S+Wc=;
  b=l5449Al+GC6fByb/BsFnvSz0zKog1Dvk+LoaHcApq1ZpFw8dIhRom+FU
   +8ScYYoM4M5HX1fjgR7w6J1ic0tOTaE6y4QzV3Wx7OrIFs5A6OrU0VHw6
   ZlQdKmnmt4iWV/YBkUgXb+06EfCg2coa6frMvIdhPIz4f6C7RKT7ve8RV
   W21QnOXKrjQ6jYqteGjLnCTfmAEr0OU5xH70Fk+z7P2UxN1bOGPD2o8Si
   x6bNKXs12RikL8gYvDSD1XEeox43zaeZ7UN5OukWlxl+VCEj2FDJzGuZ/
   1nmKzLbMmRL3q8iYai3xFpgwaOSNmA78UIekz34J4A1AzjNnxPNTnnOqG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="397392525"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="397392525"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 06:31:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="1113469599"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="1113469599"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jan 2024 06:31:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 0435A2BE; Wed, 10 Jan 2024 16:31:27 +0200 (EET)
Date: Wed, 10 Jan 2024 16:31:27 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sanath S <Sanath.S@amd.com>
Cc: mario.limonciello@amd.com, andreas.noever@gmail.com,
	michael.jamet@intel.com, YehezkelShB@gmail.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v3 0/4] Add support for downstream port reset(DPR)
Message-ID: <20240110143127.GO2543524@black.fi.intel.com>
References: <20240106165723.3377789-1-Sanath.S@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240106165723.3377789-1-Sanath.S@amd.com>

Hi,

On Sat, Jan 06, 2024 at 10:27:19PM +0530, Sanath S wrote:
> Tunnels created by boot firmware results in incorrect PCI resource
> allocation, which results in failure of extending daisy chain.
> This series aims to resolve inconsistent tunnels or paths created
> by boot firmware.
> 
> Before:
>            +-03.1-[04-62]----00.0-[05-07]--+-02.0-[06]----00.0
>            |                               \-04.0-[07]--
> After:
>            +-03.1-[04-62]----00.0-[05-62]--+-02.0-[06]----00.0
>            |                               \-04.0-[07-62]-- 
> 
> This series also aligns with windows behaviour of performing a teardown
> of tunnels and resetting the downstream ports using DPR during the init
> sequence.
> 
> Changes since V3:
>  - Remove discover_tunnel() api before resetting DPR.
>  - Add lane and protocol adapters reset in tb_switch_reset()
>  - Addition of tb_lc_reset_port() for TBT1, TBT2 and TBT3 routers.
>  - Addition of tb_path_deactivate_hop() api to help suppport path
>    reset of given hop index.
>  - Addition on new patch to store and indicate host router reset 
>    status of USB4 v2
> 
> Changes since V2:
>  - Perform DPR only for USB4 routers.
>  - Update kernel-doc and return value to -EOPNOTSUPP.
>  - Limit delay range to 10-15ms.
> 
> Sanath S (4):
>   thunderbolt: Introduce usb4_port_reset() and tb_lc_reset_port()
>   thunderbolt: Extend tb_switch_reset() to support lane and protocol
>     adapter reset
>   thunderbolt: Store host router reset status in nhi_probe()
>   thunderbolt: Teardown tunnels and reset downstream ports created by
>     boot firmware

Thanks for the series!

I will give this a try on our end too to make sure there are no issues.
If things look good I will queue these for v6.9 after v6.8-rc1 is
released.

