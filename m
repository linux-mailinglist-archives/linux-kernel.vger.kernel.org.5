Return-Path: <linux-kernel+bounces-44381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F04D842149
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9152869A5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AD660DC9;
	Tue, 30 Jan 2024 10:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JICJnfHu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14A123779;
	Tue, 30 Jan 2024 10:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610656; cv=none; b=Qg4zeeIWlqCrTckTfod0VeWRA5T3FmeG4dmpdUQdsg8l+Tm+5HZcsv2c4SZY8maqmfo201n44CQ0F1KuilcxKzrovaY4wQUCZzUo7qI3EcQPB7GJ+dXMA96qG9tzPe+5v2JtXAdpioqsV5YOIOfhOJZJ8mq4fq0AN1hzWgxAS60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610656; c=relaxed/simple;
	bh=bokjRCTHRF/85uPjFe8vz4az5AiPIirDJDOGpjfdOjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tE4/spTfFf/dG54H/9iv0vyXk1qHpcf9At9+TEP5l62eF3/Dy332oVo0iwLtp5kTMY7Yq4UkCJZWNkboWa2j0TBz3yTmtTPWwsPFdloltHOTGa107e7rfbW8QrA0qr7Kk81ICLCCPTSWsgdyiH6qYJVf4SAAWyRuEfj5S63EQB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JICJnfHu; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706610654; x=1738146654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bokjRCTHRF/85uPjFe8vz4az5AiPIirDJDOGpjfdOjo=;
  b=JICJnfHuW6/VGoxJcqOkjPF6AUURa7qFGLygM3i+HzBwNj73iOGdxx0M
   L2lKGe3+v+vMxdQqQBtB6YOHlBQNAo/52lVfwqAppSAssLnCexsEThsN6
   eH2k4tgEcjRZ7XbKbq8PV8rbNJgbgA20vdKqbeVD2y6oVM/RO1Rs5KBcP
   H1bbVc34zJND63nZhTz6BZagtT5UU6hDreKtRRPbcJZbApgjPQcF9UA6X
   hwZNdub8wNKILsi2VPhyhKGIGudkyIcyrhIrWfrzJijRo32BV4Nr/Eb8v
   qXpwChkrL2oGVm0Z+t8fNVpZGw8y6OePdATSfhL9DSoRZ3YTnhEARHzLr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="16617390"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="16617390"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 02:30:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="878392696"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="878392696"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jan 2024 02:30:50 -0800
Date: Tue, 30 Jan 2024 18:27:25 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-fpga@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luwei Kang <luwei.kang@intel.com>, Moritz Fischer <mdf@kernel.org>,
	Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, LKML <linux-kernel@vger.kernel.org>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] fpga: dfl: fme: Return directly after a failed
 devm_kasprintf() call in fme_perf_pmu_register()
Message-ID: <ZbjPDX1y2I9Heanq@yilunxu-OptiPlex-7050>
References: <d94376b6-12e8-45bb-a9be-4887bb316d35@web.de>
 <ZbjJYMlDifIv0WId@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbjJYMlDifIv0WId@yilunxu-OptiPlex-7050>

On Tue, Jan 30, 2024 at 06:03:12PM +0800, Xu Yilun wrote:
> On Sat, Jan 27, 2024 at 03:55:19PM +0100, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Sat, 27 Jan 2024 15:43:42 +0100

Sorry, something to fix.

Please shorten your shortlog to less than 75 chars.
Please refer to Documentation/process/submitting-patches.rst

> > 
> > The result from a call of the function “devm_kasprintf” was passed to
> > a subsequent function call without checking for a null pointer before
> > (according to a memory allocation failure).
> > This issue was detected by using the Coccinelle software.
> > 
> > Thus return directly after a failed devm_kasprintf() call.
> > 
> > Fixes: 724142f8c42a7 ("fpga: dfl: fme: add performance reporting support")

One more char of sha.

Please use checkpatch to verify.

Thanks,
Yilun

> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> 
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> 
> > ---
> >  drivers/fpga/dfl-fme-perf.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
> > index 7422d2bc6f37..db56d52411ef 100644
> > --- a/drivers/fpga/dfl-fme-perf.c
> > +++ b/drivers/fpga/dfl-fme-perf.c
> > @@ -925,6 +925,8 @@ static int fme_perf_pmu_register(struct platform_device *pdev,
> >  				PERF_PMU_CAP_NO_EXCLUDE;
> > 
> >  	name = devm_kasprintf(priv->dev, GFP_KERNEL, "dfl_fme%d", pdev->id);
> > +	if (!name)
> > +		return -ENOMEM;
> > 
> >  	ret = perf_pmu_register(pmu, name, -1);
> >  	if (ret)
> > --
> > 2.43.0
> > 
> > 
> 

