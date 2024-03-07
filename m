Return-Path: <linux-kernel+bounces-96297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2928759DC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 669491F22EE9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1F613BAFA;
	Thu,  7 Mar 2024 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EqFn8JHe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AE91EF13
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 22:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709848903; cv=none; b=gDyWd2miGIyO1OI9CdhehyXk4qv3iWmxgH9taMCy7qMFBG9+8xSkvN5tucntALngkOtorKppRW0hNmfKbcXBVDWdya6ouiz2IXv7ZInBWo0lGXWFsC5WYklGHADmmMjIZ3DtySFuQVa7kY/9/FjwqpBt1wbgCau5UeVgc9oNrsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709848903; c=relaxed/simple;
	bh=nDeOjZWqj/4+jb6Q9hD/6xFbGYGNpR7zTPy2r3dn57g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5f9DYGz+nom3eu6URhP4BVCABBGg6easq0zLbQbhjtnaQurgZxarYfAiySuBdPlgsHsN+ggQxzp9AbjvDIj3ZsPlsOv+/kzsW7BJEb4gti+f11HEdXFYDLBU7B+Qq/0FcOczE6rb+1nIBtVluowBFqqmVjHUFZ+v3BsmSRATPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EqFn8JHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05EAC433C7;
	Thu,  7 Mar 2024 22:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709848903;
	bh=nDeOjZWqj/4+jb6Q9hD/6xFbGYGNpR7zTPy2r3dn57g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EqFn8JHeYhX4kS+gSxhubKKoP0X3sPqDJw3a7cWjQuxBApQzJ3ApObGSgh090u9DB
	 oXAI0ug0USae+Cvvvwj+taY90e1m8pOyrgrQeDeoxPLkluzLzb9WV/uHkYpBAr+GX2
	 0mA5MLq8yAIwqnUWe7ZqCJtGvPOzaQ2BFtcjUeuw=
Date: Thu, 7 Mar 2024 22:01:40 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: John Garry <john.g.garry@oracle.com>
Cc: mcgrof@kernel.org, russ.weight@linux.dev, rafael@kernel.org,
	linux-kernel@vger.kernel.org, masahiroy@kernel.org
Subject: Re: [PATCH v2] firmware_loader: Use init_utsname()->release
Message-ID: <2024030757-trickily-tuesday-bfcc@gregkh>
References: <20240223153121.440763-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223153121.440763-1-john.g.garry@oracle.com>

On Fri, Feb 23, 2024 at 03:31:21PM +0000, John Garry wrote:
> Instead of using UTS_RELEASE, use init_utsname()->release, which means
> that we don't need to rebuild the code just for the git head commit
> changing.

But you are now exchanging build "convience" with code complexity and
runtime checking.  Which is better, and which is "provable"?

> Note: As mentioned by Masahiro in [0], when CONFIG_MODVERSIONS=y it
> could be possible for a driver to be built as a module with a different
> kernel baseline and so use a different UTS_RELEASE from that baseline. So
> now using init_utsname()->release could lead to a change in behaviour
> in this driver. However, considering the nature of this driver and how it
> would not make sense to build it as an external module against a different
> tree, this change should not have any effect on users.

This is not a "driver", it's the firmware core so this does not make
sense.



> 
> [0] https://lore.kernel.org/lkml/CAK7LNAQ_r5yUjNpOppLkDBQ12sDxBYQTvRZGn1ng8D1POfZr_A@mail.gmail.com/
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
> Changes in v2:
> - moved note into commit log and tweaked slightly
> - add Luis' RB tags, thanks
> 
> Also verified against fw loader selftest - it seems to show no regression
> from baseline, however the baeline sometimes hangs (and also does with
> this patch).
> 
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index 3c67f24785fc..9a3671659134 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -38,7 +38,7 @@
>  #include <linux/zstd.h>
>  #include <linux/xz.h>
>  
> -#include <generated/utsrelease.h>
> +#include <linux/utsname.h>
>  
>  #include "../base.h"
>  #include "firmware.h"
> @@ -471,9 +471,9 @@ static int fw_decompress_xz(struct device *dev, struct fw_priv *fw_priv,
>  static char fw_path_para[256];
>  static const char * const fw_path[] = {
>  	fw_path_para,
> -	"/lib/firmware/updates/" UTS_RELEASE,
> +	"/lib/firmware/updates/", /* UTS_RELEASE is appended later */
>  	"/lib/firmware/updates",
> -	"/lib/firmware/" UTS_RELEASE,
> +	"/lib/firmware/", /* UTS_RELEASE is appended later */
>  	"/lib/firmware"
>  };
>  
> @@ -496,7 +496,7 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
>  	size_t size;
>  	int i, len, maxlen = 0;
>  	int rc = -ENOENT;
> -	char *path, *nt = NULL;
> +	char *path, *fw_path_string, *nt = NULL;
>  	size_t msize = INT_MAX;
>  	void *buffer = NULL;
>  	dev_err(device, "%s suffix=%s\n", __func__, suffix);
> @@ -511,6 +511,12 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
>  	if (!path)
>  		return -ENOMEM;
>  
> +	fw_path_string = __getname();
> +	if (!fw_path_string) {
> +		__putname(path);
> +		return -ENOMEM;
> +	}
> +
>  	wait_for_initramfs();
>  	for (i = 0; i < ARRAY_SIZE(fw_path); i++) {
>  		size_t file_size = 0;
> @@ -521,16 +527,32 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
>  		if (!fw_path[i][0])
>  			continue;
>  
> +		len = snprintf(fw_path_string, PATH_MAX, "%s", fw_path[i]);
> +		if (len >= PATH_MAX) {
> +			rc = -ENAMETOOLONG;
> +			break;
> +		}
> +
> +		/* Special handling to append UTS_RELEASE */

You don't really document why you want to do that here, and ick:

> +		if ((fw_path[i] != fw_path_para) && (fw_path[i][len - 1] == '/')) {
> +			len = snprintf(fw_path_string, PATH_MAX, "%s%s",
> +					fw_path[i], init_utsname()->release);

You now have a "rule" where a trailing / means we add the UTS_RELEASE to
it, how is anyone going to remember that if they want to add a new path
to the array above?

this is going to be a maintenance nightmare, sorry.

greg k-h

