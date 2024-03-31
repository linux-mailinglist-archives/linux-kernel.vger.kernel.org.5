Return-Path: <linux-kernel+bounces-126082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E89D18931D1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 15:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8012817B8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 13:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE46144D27;
	Sun, 31 Mar 2024 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aw5NpLdd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A78144D13;
	Sun, 31 Mar 2024 13:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711893227; cv=none; b=EaHlHb7iabf99+W+XF0s18Hw45UaQvTdc+QHf9XMrWq7Sy4QKDegK2i0FxZoe0PaTaKShk3aQ964HIrrxhZM0ekaV7v1nbpnjfafd5p8bMxyEoqp4237OCaYcTFQWEdUSl8XzPazjNGLI3cmjGkeNvjIbu7RN/dQf/1jhyVlikE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711893227; c=relaxed/simple;
	bh=HZcoANQm+m6eHWitU14xeSVvP4uJHQVXHY2wtEadUVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jriDqskD3O5Iu2ZmyfKR7SoWMaJVsfkirQELfUW/b1lceQquXzf2j9kfWGPwM3KMZe7I7W2yN0r2YO070JBsB/xOqdOelWiBD7Dl7y3CRX2GZnjvlWQSxjHb8HszhjJf8upl9I7iTNbchvx5dwuBnwKPQ0N24W2DudhN1D/BdCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aw5NpLdd; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711893225; x=1743429225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HZcoANQm+m6eHWitU14xeSVvP4uJHQVXHY2wtEadUVc=;
  b=Aw5NpLddqUOsWbLgnP9S67YVMubFkiAgftYxkUl0uoXI2RcEgz9jJEtC
   cJUptNxm5sNy0+WQy2AdlNa3yMF1TcHWxjWa9KkAgdUf1F1heg5yqjr07
   mcEL0J5I5Hqb0N0Kk4tEde9pgf+jFW6pWkkg6cJwOfvVuylDDaJb8y1+x
   J/TZEWns8yqNj1lUC/oHiwcEeSnNYrOhZvSqXdOl7/MZ4WE0oBROglRnV
   0f6oPDtaWzsZqR8VI+bepjqDh6XD1BOfSZlk+G3UB1FdRPdku9zj1DAUP
   cgv0yGjYoeW8PPCofeb6wTwL0xZMYmTPMC3GO40rq/7PP0SVImSRPttd/
   Q==;
X-CSE-ConnectionGUID: 4z/g0kh8RlayBo8RQxEVnA==
X-CSE-MsgGUID: sSxvBCWxSTeJFOhR7wLxEQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="7240446"
X-IronPort-AV: E=Sophos;i="6.07,170,1708416000"; 
   d="scan'208";a="7240446"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 06:53:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,170,1708416000"; 
   d="scan'208";a="21896299"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 31 Mar 2024 06:53:41 -0700
Date: Sun, 31 Mar 2024 21:48:52 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Tull <atull@opensource.altera.com>,
	Russ Weight <russ.weight@linux.dev>, linux-fpga@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fpga: bridge: add owner module and take its refcount
Message-ID: <ZglpxIFgiPkZ0sat@yilunxu-OptiPlex-7050>
References: <20240322171839.233864-1-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322171839.233864-1-marpagan@redhat.com>

On Fri, Mar 22, 2024 at 06:18:37PM +0100, Marco Pagani wrote:
> The current implementation of the fpga bridge assumes that the low-level
> module registers a driver for the parent device and uses its owner pointer
> to take the module's refcount. This approach is problematic since it can
> lead to a null pointer dereference while attempting to get the bridge if
> the parent device does not have a driver.
> 
> To address this problem, add a module owner pointer to the fpga_bridge
> struct and use it to take the module's refcount. Modify the function for
> registering a bridge to take an additional owner module parameter and
> rename it to avoid conflicts. Use the old function name for a helper macro
> that automatically sets the module that registers the bridge as the owner.
> This ensures compatibility with existing low-level control modules and
> reduces the chances of registering a bridge without setting the owner.
> 
> Also, update the documentation to keep it consistent with the new interface
> for registering an fpga bridge.
> 
> Other changes: opportunistically move put_device() from __fpga_bridge_get()
> to fpga_bridge_get() and of_fpga_bridge_get() to improve code clarity since
> the bridge device is taken in these functions.
> 
> Fixes: 21aeda950c5f ("fpga: add fpga bridge framework")
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Xu Yilun <yilun.xu@intel.com>
> Reviewed-by: Russ Weight <russ.weight@linux.dev>
> Signed-off-by: Marco Pagani <marpagan@redhat.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next.

