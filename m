Return-Path: <linux-kernel+bounces-52731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A864C849BFC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D56F1F24C77
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197241CD07;
	Mon,  5 Feb 2024 13:36:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE222C183;
	Mon,  5 Feb 2024 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707140207; cv=none; b=eUZyUwgAt/tGi10Amz6al+khY0YeFwyYmQFkQAwp5O6I4ovuz7A/50KsD1XftpqD2xZRt5Tpt2FV1myf2wUHg5kxDZI7QIXO1Y7UZwMZ9Yxvp5endvSbTRMEDMPfl9mNRAePQqt4w3KgmR8znTP2tMXXw4bPPonbR+UC42UbP7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707140207; c=relaxed/simple;
	bh=PmAHzwqnL4Kx/N4PGMPc+L9Ultx6FammUGHWT9PCE7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvgKVeF6xYuvYVVsd6yBc2e4R8XlWZEuOGxbTxXkoYOcuxf8ptw/DvSs0NsHYH9KjUL6JBmAXNB3SVZdnU/VgKe2RE7/l9GkmOsfeBzNZzfVCOQRiBp3XKH4p/rYj6anlLSfy8mNfm2VIIXryCh2M+rXETZsLRUFXh6mxw3AeY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="429082"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="429082"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:36:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="909299407"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="909299407"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:36:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rWyX4-000000024e4-2Lle;
	Mon, 05 Feb 2024 14:57:06 +0200
Date: Mon, 5 Feb 2024 14:57:06 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Justin Stitt <justinstitt@google.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>, kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH v2 3/4] string: Allow 2-argument strscpy_pad()
Message-ID: <ZcDbIleAJcipUk5E@smile.fi.intel.com>
References: <20240205122916.it.909-kees@kernel.org>
 <20240205123525.1379299-3-keescook@chromium.org>
 <CAMuHMdXnW0ycz4y0m6d2yb_cAB4pjLmpveVBnL4sLNATtm388A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXnW0ycz4y0m6d2yb_cAB4pjLmpveVBnL4sLNATtm388A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 05, 2024 at 01:48:51PM +0100, Geert Uytterhoeven wrote:
> On Mon, Feb 5, 2024 at 1:36 PM Kees Cook <keescook@chromium.org> wrote:

..

> > +#define __strscpy_pad1(dst, src, size) sized_strscpy_pad(dst, src, size)
> 
> (dst) etc.

Makes a little sense here. Are you expecting, e.g., dst to be 'a, b' (w/o
quotes where a and b are expressions)?

..

> > +#define strscpy_pad(dst, src, ...)     \
> > +       CONCATENATE(__strscpy_pad, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
> 
> Likewise,

Ditto.

-- 
With Best Regards,
Andy Shevchenko



