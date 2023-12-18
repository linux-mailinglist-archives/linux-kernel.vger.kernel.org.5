Return-Path: <linux-kernel+bounces-3771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E638F8170C1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800C61F22910
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0BB1D13A;
	Mon, 18 Dec 2023 13:46:03 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F87129EF7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 13:46:02 +0000 (UTC)
Received: from rdvivi-mobl4 (unknown [192.55.55.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 8A0B9C433C8;
	Mon, 18 Dec 2023 13:46:00 +0000 (UTC)
Date: Mon, 18 Dec 2023 08:45:58 -0500
From: Rodrigo Vivi <rodrigo.vivi@kernel.org>
To: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Badal Nilawar <badal.nilawar@intel.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] fault-inject: Include linux/types.h by default.
Message-ID: <ZYBNDXoVO7LB_S0d@rdvivi-mobl4>
References: <20230816134748.979231-1-himal.prasad.ghimiray@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816134748.979231-1-himal.prasad.ghimiray@intel.com>

On Wed, Aug 16, 2023 at 07:17:48PM +0530, Himal Prasad Ghimiray wrote:
> Functions should_fail_alloc_page, should_failslab, and __should_failslab
> are declared irrespective of CONFIG_FAULT_INJECTION. These functions use
> bool and gfp_t types, which are treated as unknown when
> CONFIG_FAULT_INJECTION is disabled because the inclusion of linux/types.h
> is missing.
> 
> Fixes: 6ff1cb355e62 ("[PATCH] fault-injection capabilities infrastructure")

gentle ping on this one. we'd like to be able to include fault-inject.c
without adding extra includes that should be taken care by the
fault-inject.h itself.

> 
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Badal Nilawar <badal.nilawar@intel.com>
> Cc: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Qi Zheng <zhengqi.arch@bytedance.com>
> Cc: linux-kernel@vger.kernel.org

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>

> Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> ---
>  include/linux/fault-inject.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/fault-inject.h b/include/linux/fault-inject.h
> index 481abf530b3c..f83ab2b6cd08 100644
> --- a/include/linux/fault-inject.h
> +++ b/include/linux/fault-inject.h
> @@ -2,9 +2,10 @@
>  #ifndef _LINUX_FAULT_INJECT_H
>  #define _LINUX_FAULT_INJECT_H
>  
> +#include <linux/types.h>
> +
>  #ifdef CONFIG_FAULT_INJECTION
>  
> -#include <linux/types.h>
>  #include <linux/debugfs.h>
>  #include <linux/configfs.h>
>  #include <linux/ratelimit.h>
> -- 
> 2.25.1
> 

