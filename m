Return-Path: <linux-kernel+bounces-44727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4820842696
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038491C25573
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143096D1DF;
	Tue, 30 Jan 2024 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ew4Uhpl8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC19E6D1B1;
	Tue, 30 Jan 2024 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706623392; cv=none; b=bk4DJS3xgcxNlTCS4TRlvOtWSHQgUT6mujFsLepR0cuNG9CGiNEGcOy1+UcQwlgA6CrpxKQ+znBhZeOPdzA7AyDzPo/KeR0yWRESQprRw0pJwrZyRJ7Co2TKOO7V8UNDg2snQhBK5CINExi1M0cE8bYGvAuhKtIXjlUotSE7rEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706623392; c=relaxed/simple;
	bh=DzsaNEVFKguc0ZC4CtlzX7lscBOx1aUABMiNF9+SE+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEJw6NG92SI7I/aiNmOisJc6Tfx4nMc5n0+FMknJINtoxP64pHFb6PVwFxw56AOwpsjO/jgjF73/GIh2GA4IUeqxA4kMOtyHnKxS9XidSyEw9wkLx3G7hNjBLEmxkPV7u/l3M64ZxbzgobRH4ZdPfZ8VI6+Kdn0G5VgLw51IIFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ew4Uhpl8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706623391; x=1738159391;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DzsaNEVFKguc0ZC4CtlzX7lscBOx1aUABMiNF9+SE+U=;
  b=Ew4Uhpl8Ue1muczcA+RtPNqyl3P1jfCDZE+NCtFLmXw4FV5vw5FG8Z/Z
   dr9DWeJ6Yl8vJUPe+AtrSfspSlM8giu9d2m/wlWZkPWWsXwahZj1W8kzi
   UKp9x4SMu+/BvmwpnhESLl4Q5PcdpV/GMU7PgBXqKYemaPjYCfdCPwjAU
   hemVJNMGBjAFWRrnWN9XtPpcb4Rpt4NZoQuPsO4t6zA7OdVXlnMwmdO8A
   RKNdzDhQ0hstSdN00fzl+HJt52tTeq+96RiIPVVUuF4efSjLkWn4FZHqQ
   PcvCMS0vadwJO9p9aQlrI2uEHs2g8b+8UjCqPxQdzEuAZ/A15wqJg8Id2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="10676692"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="10676692"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 06:03:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3697226"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 30 Jan 2024 06:03:08 -0800
Date: Tue, 30 Jan 2024 21:59:42 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-fpga@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luwei Kang <luwei.kang@intel.com>, Moritz Fischer <mdf@kernel.org>,
	Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, LKML <linux-kernel@vger.kernel.org>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: fpga: dfl: fme: Return directly after a failed devm_kasprintf()
 call in fme_perf_pmu_register()
Message-ID: <ZbkAziPCX+RDSgfP@yilunxu-OptiPlex-7050>
References: <d94376b6-12e8-45bb-a9be-4887bb316d35@web.de>
 <ZbjJYMlDifIv0WId@yilunxu-OptiPlex-7050>
 <ZbjPDX1y2I9Heanq@yilunxu-OptiPlex-7050>
 <49183574-ea83-4517-8e34-5d6e87ede064@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49183574-ea83-4517-8e34-5d6e87ede064@web.de>

On Tue, Jan 30, 2024 at 11:48:31AM +0100, Markus Elfring wrote:
> >>> Thus return directly after a failed devm_kasprintf() call.
> >>>
> >>> Fixes: 724142f8c42a7 ("fpga: dfl: fme: add performance reporting support")
> >
> > One more char of sha.
> 
> There are different preferences involved.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.8-rc2#n109

Ah, I mean you use 13 chars, but 12 chars is better. Also the doc
doens't seem to enforce 12 chars, but checkpatch warns on that. So just
follow the 12 chars style.

Thanks,
Yilun

> 
> Regards,
> Markus

