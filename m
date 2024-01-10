Return-Path: <linux-kernel+bounces-22465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05777829E11
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CC028A9DD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7874CDE0;
	Wed, 10 Jan 2024 15:56:32 +0000 (UTC)
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749FA4C3C4;
	Wed, 10 Jan 2024 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id CF337776; Wed, 10 Jan 2024 09:47:46 -0600 (CST)
Date: Wed, 10 Jan 2024 09:47:46 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Li zeming <zeming@nfschina.com>
Cc: serge@hallyn.com, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: =?utf-8?Q?capability?=
 =?utf-8?B?OiBSZW1vdmUgdW5uZWNlc3Nhcnkg4oCYMOKAmQ==?= values from ret
Message-ID: <20240110154746.GA92832@mail.hallyn.com>
References: <20231228030854.11689-1-zeming@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228030854.11689-1-zeming@nfschina.com>

On Thu, Dec 28, 2023 at 11:08:54AM +0800, Li zeming wrote:
> The ret variable is assigned when it does not need to be defined, as it
> has already been assigned before use.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>

This is true, so the patch would fine now.  But it has not always been
the case, and a future patch could add code at the start which makes it
no longer true.  While I'd hope we would easily catch that, I'm just not
sure it's worth it.  In fact I'm curious - does the compiler recognize
this situation and optimize the = 0 away?

> ---
>  kernel/capability.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/capability.c b/kernel/capability.c
> index dac4df77e376e..ed8a983e21da4 100644
> --- a/kernel/capability.c
> +++ b/kernel/capability.c
> @@ -140,7 +140,7 @@ static inline int cap_get_target_pid(pid_t pid, kernel_cap_t *pEp,
>   */
>  SYSCALL_DEFINE2(capget, cap_user_header_t, header, cap_user_data_t, dataptr)
>  {
> -	int ret = 0;
> +	int ret;
>  	pid_t pid;
>  	unsigned tocopy;
>  	kernel_cap_t pE, pI, pP;
> -- 
> 2.18.2

