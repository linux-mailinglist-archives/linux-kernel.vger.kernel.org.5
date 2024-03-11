Return-Path: <linux-kernel+bounces-99003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE8487823E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF69E1C216BB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9362482D7;
	Mon, 11 Mar 2024 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VgMnQe2s"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EA8481A2;
	Mon, 11 Mar 2024 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710168621; cv=none; b=GNFsQs3MRmYvLM4haM0njM9FGXPUdnmBAfLKwydNm19OyA1aTL3aGZ7gshV4gFiBd59pgQVmd3FvTeCNsGDpPR3w73mNdpy4iDYegisnnIYmn+XdpcTaS7XsDYiK9FrRSUOnktXeZXKVdYRXkv/pnZW/TNTJj35AJ6amO7UUaK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710168621; c=relaxed/simple;
	bh=gk/GzbxaMbExhVzfs2uNFiHjDdAeoOPU3wmsCeb1K34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGJHMjWfgXJiTlBiC9GqCpaYvcLF/JfuT/aJwpeTnGyaXkAVlAaZwO/cOt/poGHlP4QKHhN4qjmEQrBusfpZdV5WMa+HSOTb0fgVKsT6+1yKQyJoR7Hfo0sla3w/aOWPmOMeFTQdedYkraDFR2DDx6wuQb26xwmjI844qwEfa7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VgMnQe2s; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710168620; x=1741704620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gk/GzbxaMbExhVzfs2uNFiHjDdAeoOPU3wmsCeb1K34=;
  b=VgMnQe2sh3YGnYaXxmRqn7I2qkZ84ygh4n0siSr6iGq9ULs5ra2Fg3ro
   +WYdKbCbZFdxcbIIy+NY6C62NNPFIFYcDiavYl9QLdocKuXfCciOe0L1b
   L3xv0zftvtYpy/oUBUscDIrjflfIjB/jTy1Wjrk6MH1COcdbPbJUV9+nL
   JfmdCZofmacR5Jy+mk8sxPmjv0rWNx0oN2FO+XcBwOE8LiKASM9aM9mQZ
   r6hOA47rDPL0Cw943/ik2aAZEcJqb4yAclKuKWeb4S6sxpwBLwyklbpbV
   hyRIcR99Y8nSsY2FsHT8qGRWdjm5qXBTo3T3/rtpg+67z6+jaQzP+2tpU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4688769"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4688769"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 07:50:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="914361948"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="914361948"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 07:50:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rjgyl-0000000Bekl-1d6H;
	Mon, 11 Mar 2024 16:50:15 +0200
Date: Mon, 11 Mar 2024 16:50:15 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sean Young <sean@mess.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH v1 0/5] media: ir-spi: A few cleanups
Message-ID: <Ze8aJ2U-kKkd4JPC@smile.fi.intel.com>
References: <20240305174933.1370708-1-andriy.shevchenko@linux.intel.com>
 <Ze8UTyZQ_Ev6s4fz@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze8UTyZQ_Ev6s4fz@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 11, 2024 at 04:25:19PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 05, 2024 at 07:48:25PM +0200, Andy Shevchenko wrote:
> > While removing of_gpio.h where it's being unused, this driver seems to
> > deserve more love. Hence this series.
> 
> Sean, any comments on this series?

Since previous reply, I found an answer in your repository :-)
Thanks!

-- 
With Best Regards,
Andy Shevchenko



