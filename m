Return-Path: <linux-kernel+bounces-5522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2708D818BA2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF101C248E1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2271CFB5;
	Tue, 19 Dec 2023 15:55:17 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257C11CF9A;
	Tue, 19 Dec 2023 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="399510696"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="399510696"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 07:55:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="776022066"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="776022066"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 07:55:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rFcR4-00000007InS-3Ndx;
	Tue, 19 Dec 2023 17:55:10 +0200
Date: Tue, 19 Dec 2023 17:55:10 +0200
From: Andy Shevchenko <andy@kernel.org>
To: tanzirh@google.com
Cc: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nick DeSaulniers <nnn@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v3 2/2] lib/string: shrink lib/string.i via IWYU
Message-ID: <ZYG83l5AW_zVw2aR@smile.fi.intel.com>
References: <20231218-libstringheader-v3-0-500bd58f0f75@google.com>
 <20231218-libstringheader-v3-2-500bd58f0f75@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218-libstringheader-v3-2-500bd58f0f75@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 18, 2023 at 06:44:48PM +0000, tanzirh@google.com wrote:
> This diff uses an open source tool include-what-you-use (IWYU) to modify
> the include list changing indirect includes to direct includes.
> IWYU is implemented using the IWYUScripts github repository which is a tool that is
> currently undergoing development. These changes seek to improve build times.
> 
> This change to lib/string.c resulted in a preprocessed size of
> lib/string.i from 26371 lines to 5263 lines (-80%) for the x86
> defconfig.

...

>  #define __NO_FORTIFY
>  #include <linux/types.h>
> -#include <linux/string.h>
> -#include <linux/ctype.h>
> -#include <linux/kernel.h>
> -#include <linux/export.h>
> +#include <linux/bits.h>
>  #include <linux/bug.h>
>  #include <linux/errno.h>
> -#include <linux/slab.h>

> -

Why this blank is removed?

> +#include <linux/linkage.h>
> +#include <linux/stddef.h>
> +#include <linux/string.h>
> +#include <linux/ctype.h>
>  #include <asm/unaligned.h>
> -#include <asm/byteorder.h>
> +#include <asm/rwonce.h>
>  #include <asm/word-at-a-time.h>
>  #include <asm/page.h>

Sort this group alphabetically as well.

> +#include <vdso/limits.h>

Just use linux/limits.h.

VDSO is a very special UAPI case. So it's even stricter rule
than for asm/ for using anything from there.

Expected result:

#include <linux/bits.h>
#include <linux/bug.h>
#include <linux/ctype.h>
#include <linux/errno.h>
#include <linux/limits.h>
#include <linux/linkage.h>
#include <linux/stddef.h>
#include <linux/string.h>
#include <linux/types.h>

#include <asm/page.h>
#include <asm/rwonce.h>
#include <asm/unaligned.h>
#include <asm/word-at-a-time.h>

-- 
With Best Regards,
Andy Shevchenko



