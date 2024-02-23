Return-Path: <linux-kernel+bounces-78485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7E8861401
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8253D1F226A4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53247566D;
	Fri, 23 Feb 2024 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S5YoKLjY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B8B522D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708698755; cv=none; b=hvZ2j3OMri9kOTgbUPzpeUeDUBUDjvfvd1/lQUAYa8hcLhKmGZThrRYTFXIgXE/jQzWrcH9hVnAc6wUJOYiqkn3ic412q7tPFx6Usqyur7nGQqkz8pp2KZmbiMWfpfwUrtivutMGnhwDV0ZPqn/YjjYfx9ClS1Ee9R721QVG27c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708698755; c=relaxed/simple;
	bh=28uU8XDmFkPxmKehFoVzJfAg7wTqvDYjNfQvEmRUDp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRt9EevNuaTy3TzeRYYaFSHeOjZTzgu7nIqwnX8FTKYp8hDMvgk7oQtJub4vLkv/kIfzDqfBpJ1qVjzjiYSH7We9WevcnCYuAphXlpgLm6qmgOww7a4sGU8ikFtyJhrJpz+w2878GAGh/GQ62TrxyFTn8/qWdJ6cXzBkV3Lf7J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S5YoKLjY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708698754; x=1740234754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=28uU8XDmFkPxmKehFoVzJfAg7wTqvDYjNfQvEmRUDp4=;
  b=S5YoKLjYQmXozAUHq+fscx4jCDD0z7j/fXiP59EJIdxxrOm2O6rrdX2J
   Sw4+UNLOiPeGnHpjxIByfFQhYpFIw68QZREbw4HlC1bjiKN/8NI88qG1r
   5gXDFJPZ1hgF3PN5PTYxy33/8v1+sDs05tJrILn8nzS6Yk1mJseRYXvfe
   81tb7x+RQxSQaet40zUJcGvsK8Kl+MpzH1OZWk+rOeHb1O8PDLWHJCfQx
   qBupHECZarNf3LkC76uq8ub3jn+d5AE36X0/0nFMNHukBSA9/5b3HBgsz
   u6bjb/tFO3jAQMQonEDD0JXU15A2k2G2pDu3xlCJNOFzLqNJHP9n1liTK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="3521883"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="3521883"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 06:32:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="913747532"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="913747532"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 06:32:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdWbF-00000006vIk-36xo;
	Fri, 23 Feb 2024 16:32:29 +0200
Date: Fri, 23 Feb 2024 16:32:29 +0200
From: 'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-kernel@vger.kernel.org, 'MyungJoo Ham' <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v1 1/1] extcon: intel-mrfld: Don't shadow error from
 devm_extcon_dev_allocate()
Message-ID: <ZdisfbUS7zVTtj1i@smile.fi.intel.com>
References: <20231222161854.2955859-1-andriy.shevchenko@linux.intel.com>
 <ZcUqiaGI8N-FLijJ@smile.fi.intel.com>
 <CGME20240222131814epcas1p3b7a6a405f1170dcfac8e0f53b0f49d4c@epcas1p3.samsung.com>
 <ZddJeYhe8pCHup9a@smile.fi.intel.com>
 <061201da662b$f5b68f60$e123ae20$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <061201da662b$f5b68f60$e123ae20$@samsung.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 23, 2024 at 04:43:15PM +0900, Chanwoo Choi wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Thursday, February 22, 2024 10:18 PM
> > On Thu, Feb 08, 2024 at 09:24:58PM +0200, Andy Shevchenko wrote:

..

> > Here is another one, can it be applied as well?
> 
> Applied it. Thanks.

Thank you!

-- 
With Best Regards,
Andy Shevchenko



