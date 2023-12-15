Return-Path: <linux-kernel+bounces-1258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 418F9814C81
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C441F213C4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEF33A8D8;
	Fri, 15 Dec 2023 16:08:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2183A8C3;
	Fri, 15 Dec 2023 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="380291053"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="380291053"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 08:08:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="898189055"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="898189055"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 08:08:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rEAjf-00000006AFZ-3TgL;
	Fri, 15 Dec 2023 18:08:23 +0200
Date: Fri, 15 Dec 2023 18:08:23 +0200
From: Andy Shevchenko <andy@kernel.org>
To: tanzirh@google.com
Cc: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nick DeSaulniers <nnn@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v2 2/2] lib/string: shrink lib/string.i via IWYU
Message-ID: <ZXx594P0pdS8vpVt@smile.fi.intel.com>
References: <20231214-libstringheader-v2-0-0f195dcff204@google.com>
 <20231214-libstringheader-v2-2-0f195dcff204@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214-libstringheader-v2-2-0f195dcff204@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 14, 2023 at 09:06:13PM +0000, tanzirh@google.com wrote:
> This diff uses an open source tool include-what-you-use (IWYU) to modify
> the include list changing indirect includes to direct includes.
> IWYU is implemented using the IWYUScripts github repository which is a tool that is
> currently undergoing development. These changes seek to improve build times.
> 
> This change to lib/string.c resulted in a preprocessed size of
> lib/string.i from 26371 lines to 5259 lines (-80%) for the x86
> defconfig.

> Link: https://github.com/ClangBuiltLinux/IWYUScripts
> 
> Signed-off-by: Tanzir Hasan <tanzirh@google.com>

Tag block should not have blank line(s).

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
> +#include <asm/rwonce.h>
> +#include <linux/linkage.h>
> +#include <linux/stddef.h>
> +#include <vdso/limits.h>
> +#include <linux/string.h>
> +#include <linux/ctype.h>
>  #include <asm/unaligned.h>
> -#include <asm/byteorder.h>
>  #include <asm/word-at-a-time.h>
>  #include <asm/page.h>

My gosh, this becomes unreadable!

Please make sure you go with groups of headers from more generic to more
particular, i.e.

linux/*

asm/*

vdso/*

BUT, why the heck vdso? It should be rather uapi/ or regular linux/.

-- 
With Best Regards,
Andy Shevchenko



