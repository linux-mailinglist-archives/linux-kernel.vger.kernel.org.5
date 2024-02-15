Return-Path: <linux-kernel+bounces-67022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C50A8564EF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C2F28760A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CD7131E36;
	Thu, 15 Feb 2024 13:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OMcJX4Ux"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D7E131735
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005058; cv=none; b=nlgLffTwQstllOcaTcoFZcelh8KGT0B36RoMQ99dXMToTerHNiNx+GGgk/0wAMxmid7dLJWQeRnfm6E6LzhcWbZ00FmepxMSxv3A/UlgLmZbM6YnhoO6AxmNbvDDU9XKo11me/9NmYdMT38mVcyZENPdlFqX2sjVscLFvbbZReg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005058; c=relaxed/simple;
	bh=xt5sVYVqA9DhK/D8uPDsptYzdU8pMEs6twwLhLplZZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+lzuQ7IfpReSm/M/FWfCbqx9vpVmIpgTgMlR9YvmId90+J6/Zd5iYQ6DGh7TssaC/tMj1ahUvw4fHI1WlnVJ00igsamBmby1MoiUhhK97MXBwojPhpa4PVUUHrnIfPguG5NgXS7panKMnILhb14Bo8kCilKe7YjToszVFkGRvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OMcJX4Ux; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708005057; x=1739541057;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xt5sVYVqA9DhK/D8uPDsptYzdU8pMEs6twwLhLplZZs=;
  b=OMcJX4UxRgSl6Rwq7Gnd8/FcrvSMJnLsRjNe+hG8hsl9EiDyUBytc3jz
   UCcpAJUrBwJJ6TAEMQdu3iDgXGM0cU6udanVxLLYnPLnBmSf7lAuo1rDw
   dcol+1IgXc87ipXCIgRmIG2LyyEDiA/hBqrIKH0QSuz1hEQnL8WhgIfhx
   Jqypzi86dmrS4j84ACLfuxLj29nSqMYhC5TEVB1fQ/b3PjYpO1gaFjPMs
   2Hk/ugWxPFhndTUxmF3563SO4Wp7+qCbyIGb2NmBr/zCaCwXsnmnkpD6+
   uzfJLLvNRxPtLCgMr2RTicZIgku77c9dXyclIXPec2JOuj5kzDHfBP1M2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1964454"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="1964454"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 05:50:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912168947"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="912168947"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 05:50:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rac8Z-00000004nsF-2kKl;
	Thu, 15 Feb 2024 15:50:51 +0200
Date: Thu, 15 Feb 2024 15:50:51 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>
Subject: Re: [PATCH v1 1/1] kernel.h: Move upper_*_bits() and lower_*_bits()
 to wordpath.h
Message-ID: <Zc4Wu4dAJTXcGGVs@smile.fi.intel.com>
References: <20240214172752.3605073-1-andriy.shevchenko@linux.intel.com>
 <CAKPOu+-Xy1E_bZMDJu8YQB_s235k3k3GcbeNNP=Vkn2aC1uk_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+-Xy1E_bZMDJu8YQB_s235k3k3GcbeNNP=Vkn2aC1uk_w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 09:53:48AM +0100, Max Kellermann wrote:
> On Thu, Feb 15, 2024 at 9:49 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > The wordpart.h header is collecting APIs related to the handling
> > parts of the word (usually in byte granularity). The upper_*_bits()
> > and lower_*_bits() are good candidates to be moved to there.
> 
> Sigh. This was actually a copy of my patch which I submitted a week
> before yours. https://lore.kernel.org/lkml/20240209164027.2582906-34-max.kellermann@ionos.com/

But it was not standalone and the series has issues AFAICS.
Nevertheless, I like it!

In any case the wordpart.h is only in Kees' tree, hence can't be applied
separately right now, so if you continue with a series it's technically can't
be applied before v6.9-rc1.


-- 
With Best Regards,
Andy Shevchenko



