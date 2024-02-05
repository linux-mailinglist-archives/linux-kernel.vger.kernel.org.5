Return-Path: <linux-kernel+bounces-52730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4A1849BFB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A54A12852CD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE7120DD0;
	Mon,  5 Feb 2024 13:36:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8312C18F;
	Mon,  5 Feb 2024 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707140205; cv=none; b=QupQGimMS76rBmdWLjtes4IpJUwtvuSvSqtrNn02eSZdW7I1o8DHhQATrnbfMVdmuCMXz1yY0bHQnwLWKOWHmRW13n/KdkZ6xXl76UItanaDESv6JSTvtNasviA6h6HbSLtUqxboM9et5XOkA3f7atwKuiNMSs/HTgxjJrcddRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707140205; c=relaxed/simple;
	bh=FvQJ1OssakCkef4t00u3cYzZ+nC2ToWNqUXrj/BrNZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QweKk8AlB/KvGttzcvoMT77Nn2oruLRbaqOZuF3QdZu/FWKLFY2SQ4etmCWCkDw5sv2Cbc33gHhHuauY4U6KB8X1P4qRPYSR/xS/HxMyJHkscrlBh0xbb3LowxHJVrgg9xFqX/bnu45jVaUgSEbvy7xHMYS2ZadKE2IUi4yXjJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="429061"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="429061"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:36:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="909299375"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="909299375"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:36:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rWyXm-000000024en-0CSF;
	Mon, 05 Feb 2024 14:57:50 +0200
Date: Mon, 5 Feb 2024 14:57:49 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kees Cook <keescook@chromium.org>, Richard Weinberger <richard@nod.at>,
	linux-um@lists.infradead.org, Justin Stitt <justinstitt@google.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>, kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 4/4] um: Convert strscpy() usage to 2-argument style
Message-ID: <ZcDbTbith7oTbNiT@smile.fi.intel.com>
References: <20240205122916.it.909-kees@kernel.org>
 <20240205123525.1379299-4-keescook@chromium.org>
 <CAMuHMdWOKEYvGKRUmii5CqtaM-RAM_4SZC5gds=00+KUYyu+MA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWOKEYvGKRUmii5CqtaM-RAM_4SZC5gds=00+KUYyu+MA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 05, 2024 at 01:50:14PM +0100, Geert Uytterhoeven wrote:
> On Mon, Feb 5, 2024 at 1:36 PM Kees Cook <keescook@chromium.org> wrote:

..

> > +#define strscpy(dst, src)      sized_strscpy(dst, src, sizeof(dst))
> 
> (dst), (src)

No need.

-- 
With Best Regards,
Andy Shevchenko



