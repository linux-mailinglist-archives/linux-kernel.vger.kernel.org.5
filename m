Return-Path: <linux-kernel+bounces-5518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04948818B99
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294D61C2492F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919071CF95;
	Tue, 19 Dec 2023 15:51:26 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9291D542;
	Tue, 19 Dec 2023 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2501826"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="2501826"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 07:51:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="841919777"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="841919777"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 07:50:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rFcMd-00000007IkS-34jQ;
	Tue, 19 Dec 2023 17:50:35 +0200
Date: Tue, 19 Dec 2023 17:50:35 +0200
From: Andy Shevchenko <andy@kernel.org>
To: tanzirh@google.com
Cc: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nick DeSaulniers <nnn@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3 1/2] kernel.h: removed REPEAT_BYTE from kernel.h
Message-ID: <ZYG7y0A0lzzN0GqR@smile.fi.intel.com>
References: <20231218-libstringheader-v3-0-500bd58f0f75@google.com>
 <20231218-libstringheader-v3-1-500bd58f0f75@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218-libstringheader-v3-1-500bd58f0f75@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 18, 2023 at 06:44:47PM +0000, tanzirh@google.com wrote:
> This patch creates wordpart.h and includes it in asm/word-at-a-time.h
> for the all architectures. WORD_AT_A_TIME_CONSTANTS depends on kernel.h
> because of REPEAT_BYTE. Moving this to another header and including it
> where necessary allows us to not include the bloated kernel.h. Making
> this implicit dependancy on REPEAT_BYTE explicit allows for later
> improvements in the lib/string.c inclusion list.

...

>  #include <linux/kernel.h>
> +#include <linux/wordpart.h>

Expected is to get rid of kernel.h completely.
For instance, in arch/arm/include/asm/word-at-a-time.h case this
should become:

#include <linux/bitops.h>
#include <linux/wordpart.h>

(Briefly looking the same is for include/asm-generic/word-at-a-time.h)

And so on...

...

> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -39,13 +39,6 @@

> -/**
> - * REPEAT_BYTE - repeat the value @x multiple times as an unsigned long value
> - * @x: value to repeat
> - *
> - * NOTE: @x is not checked for > 0xff; larger values produce odd results.
> - */
> -#define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))

Okay, we don't back include because we changing all the users at once.

...

> +++ b/include/linux/wordpart.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

> +/*
> + * Copyright (C) 2023 Google LLC <tanzirh@google.com>
> + */

Can be on a single line.

Is it? Personally I skip this from the split headers, but I'm not your lawyer.

-- 
With Best Regards,
Andy Shevchenko



