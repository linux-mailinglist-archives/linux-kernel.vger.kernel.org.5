Return-Path: <linux-kernel+bounces-126087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A638931FF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B301C20FD5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 14:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2281448CF;
	Sun, 31 Mar 2024 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LEm0WQFx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1682F3B;
	Sun, 31 Mar 2024 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711895974; cv=none; b=pka5zHYSs30EEMb+YctV+gJ5Dlv5FlvsvVHt97RFJwNN3qZ8nuYmKKLrQ/pfo69NjHJItANFPuHZbhnku3i1ketuEazZZB69xTnWVF37FITxtv87NpFlhUDHCCPYO5kgMJWV8tjywZaQJuuwAieIkoNg0ITomq4INewk2ytLcS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711895974; c=relaxed/simple;
	bh=Yr7QgpoloklAjRb1NPaSLk0w+kU1jaHFGFJSCWmfwT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDLMgadNwlAXku1SErvMOWkF8xz7j9m1II4lAasrXHPHd2GLG4BXQWy7XfS+T22JqfcyL0wvF4IAaXmwaIZZhYuQtpBALLsOvolslb4p6z6bUrIrLFw5XkjXWUv8mzuepRALz5WQM7nKgrms75125dYQQUyvV8qwX9RkVLVH2Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LEm0WQFx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711895973; x=1743431973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yr7QgpoloklAjRb1NPaSLk0w+kU1jaHFGFJSCWmfwT4=;
  b=LEm0WQFxDy6gTqAhxvcA9p1APciBhgR/hITlnViUY0Ke1sY+pRFdj9sa
   o0xt0Ph9xKBGutkS2XSwqnAGzFAbmCYm0T8iSbwSOgFf2W/AELezDC7am
   i/RlXZ3UimdGhVVuE2ZlOp+NwS2yLwh576mpv7nNwsrvXrAmziDJshK1S
   NA0i1BXOuOrncpfHxNlRX85X/MFoVVf4lVBWFvYUkn8PYlnLy8WE/QneM
   gSZusCng8IU6Qr0aw0PBgcRfFzSDd7Paoxjsoe0ClFn6F1rPjg+2klojb
   Goer9hiekfmezvQmvk2Dj5vK7DyV7PxldTiv/W/PH8c4WWXJMK29f3OVM
   Q==;
X-CSE-ConnectionGUID: 44bafuEdSyKUvjJzmwOMTw==
X-CSE-MsgGUID: 0cyHvS0ZQ/W54qbAMEiVoQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="17653424"
X-IronPort-AV: E=Sophos;i="6.07,170,1708416000"; 
   d="scan'208";a="17653424"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 07:39:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,170,1708416000"; 
   d="scan'208";a="18087295"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 31 Mar 2024 07:39:29 -0700
Date: Sun, 31 Mar 2024 22:34:40 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Charles Perry <charles.perry@savoirfairelinux.com>
Cc: mdf@kernel.org, avandiver@markem-imaje.com, bcody@markem-imaje.com,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>, linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 3/4] fpga: xilinx-selectmap: add new driver
Message-ID: <Zgl0gPt/pc+vXyGw@yilunxu-OptiPlex-7050>
References: <20240321220447.3260065-1-charles.perry@savoirfairelinux.com>
 <20240321220447.3260065-4-charles.perry@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321220447.3260065-4-charles.perry@savoirfairelinux.com>

> +static int xilinx_selectmap_write(struct xilinx_fpga_core *core,
> +				  const char *buf, size_t count)
> +{
> +	struct xilinx_selectmap_conf *conf = to_xilinx_selectmap_conf(core);
> +	u32 i;

comparing u32 with size_t is problematic.

size_t i;

I can fix it in place.

Thanks,
Yilun

> +
> +	for (i = 0; i < count; ++i)
> +		writeb(buf[i], conf->base);
> +
> +	return 0;
> +}

