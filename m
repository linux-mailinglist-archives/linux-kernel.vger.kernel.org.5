Return-Path: <linux-kernel+bounces-12151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A980D81F09B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645AD28246A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD75E45C05;
	Wed, 27 Dec 2023 16:54:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F3C45030;
	Wed, 27 Dec 2023 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="3296718"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="3296718"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 08:53:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="951539808"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="951539808"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 08:53:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rIXAC-00000009T4e-2oGN;
	Wed, 27 Dec 2023 18:53:48 +0200
Date: Wed, 27 Dec 2023 18:53:48 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Tanzir Hasan <tanzirh@google.com>
Cc: Kees Cook <keescook@chromium.org>, Nick Desaulniers <nnn@google.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>, llvm@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v6 1/2] kernel.h: removed REPEAT_BYTE from kernel.h
Message-ID: <ZYxWnC5KEIx0XO5q@smile.fi.intel.com>
References: <20231226-libstringheader-v6-0-80aa08c7652c@google.com>
 <20231226-libstringheader-v6-1-80aa08c7652c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226-libstringheader-v6-1-80aa08c7652c@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 26, 2023 at 06:00:00PM +0000, Tanzir Hasan wrote:
> This patch creates wordpart.h and includes it in asm/word-at-a-time.h
> for all architectures. WORD_AT_A_TIME_CONSTANTS depends on kernel.h
> because of REPEAT_BYTE. Moving this to another header and including it
> where necessary allows us to not include the bloated kernel.h. Making
> this implicit dependency on REPEAT_BYTE explicit allows for later
> improvements in the lib/string.c inclusion list.

LGTM, and I hope this will not trigger CIs and other build checkers.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

...

> --- a/arch/powerpc/include/asm/word-at-a-time.h
> +++ b/arch/powerpc/include/asm/word-at-a-time.h
> @@ -4,8 +4,8 @@
>  /*
>   * Word-at-a-time interfaces for PowerPC.
>   */

> -

You can preserve this blank line...

> -#include <linux/kernel.h>
> +#include <linux/bitops.h>
> +#include <linux/wordpart.h>

...here.

>  #include <asm/asm-compat.h>
>  #include <asm/extable.h>

-- 
With Best Regards,
Andy Shevchenko



