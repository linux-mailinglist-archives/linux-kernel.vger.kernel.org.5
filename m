Return-Path: <linux-kernel+bounces-127438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55367894B59
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9857B21CF0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA2C1A5AC;
	Tue,  2 Apr 2024 06:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BrQAbdrA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6442B18E29;
	Tue,  2 Apr 2024 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712039118; cv=none; b=nnJsYI/BZgHFIMx6XH5uzJHTFH/Pb9f9ScLxHXXpO2RX2rG0xzf7dJHlMNgEBeC1JPpiU7VtwKTd/HrsbHgkfb3yozu9DQRk9l+IiWhL9n+F3WtAk2heVV14eIqhPp+Er8UAYM94ahNEbYbzHg9btWD9PsFaLZhP0onr0iYNvY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712039118; c=relaxed/simple;
	bh=zKIs5Rjm9Axb/VD3kkOHg5ZttvZfEfpr3Im0059bWQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZYs59D3DEzuPCASFdfGYg3abBpajbcxrH4t3qN/mgg9KUhNm82OBQfU4gzXUKMQzBXud57RhBXWH5nEqjxzWX788IEGDYg/aw5MzjZSiGS+yJD0A5wB6pRyYrvcG/Wu+aRSUPXr4PmEbl5QOxTWtAILE7gHK//U8iao4wl8qAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BrQAbdrA; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712039116; x=1743575116;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zKIs5Rjm9Axb/VD3kkOHg5ZttvZfEfpr3Im0059bWQA=;
  b=BrQAbdrADySWljbPqWq9/LO4KIStscjK1YMchAeDVMw8jmZYsjVQb9OZ
   DFHvo3jcG9o6NxxANBrULFzokZzn2O1V4EAISW4QsBuEDKgOUcNKwvJPh
   XAocKQ900CYq6G1/nmIyqiBB3Pg8tgMrCG0d7V/yZi0OC06VgWSxKBd7+
   RJ6nqUJQdeWsoiHY2kzCwRyCb+4a0JaXvsWUhlFJ0N/mKFMQATPd6nWfL
   cvqZImfkfopEWzZ0jqyGoFnctdSD5yQA6WGxmR6ZfyB+YVRRFYsRwKX+V
   htLaEaSdFl+/VDE6lk6CteQ7b42j5PUn36OqEgeMB2xP5lGIlWR157aD9
   Q==;
X-CSE-ConnectionGUID: j4/zo/FfSdGqiA4s0M7YIw==
X-CSE-MsgGUID: AVaSsbHhTimTsVzyebJ6mg==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7774956"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="7774956"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 23:25:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="17928830"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 01 Apr 2024 23:25:13 -0700
Date: Tue, 2 Apr 2024 14:20:22 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Russ Weight <russ.weight@linux.dev>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fpga: tests: use KUnit devices instead of platform
 devices
Message-ID: <ZgujpnLfHTp+WRNL@yilunxu-OptiPlex-7050>
References: <20240329174849.248243-1-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329174849.248243-1-marpagan@redhat.com>

On Fri, Mar 29, 2024 at 06:48:47PM +0100, Marco Pagani wrote:
> KUnit now provides helper functions to create fake devices, so use them
> instead of relying on platform devices.
> 
> Other changes: remove an unnecessary white space in the fpga region suite.
> 
> Reviewed-by: Russ Weight <russ.weight@linux.dev>
> Signed-off-by: Marco Pagani <marpagan@redhat.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Does this patch has dependency on module owner changes for fpga-mgr/bridge/region?

Thanks,
Yilun

