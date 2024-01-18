Return-Path: <linux-kernel+bounces-29765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DEA831323
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FDADB2389D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC690B66B;
	Thu, 18 Jan 2024 07:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iKA7nlHW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9488947A;
	Thu, 18 Jan 2024 07:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563338; cv=none; b=HaIu9sffC5rxgbUwAVigm7zbnpnEW6rDQDyhwWTlDr4mFNOQYAQRXO0Zst8YhvNXTTWLqTBd9pb2iQrLpHWS/3B8PQAlvs02jIbllPNksVPRuDLSR27pGI+ShQ1h0Wtb43885KVyP7arP9uQePNLCdv6uJeim3zSAEcxShjqKn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563338; c=relaxed/simple;
	bh=OX3x/t7S5eYlemp0ECxrgPOLlFI4fZcRLUMx0aAs7nI=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=o0MjZU7Tlj6lmtyow6RWWFOAcHPHfzU9QgfO8kYW+blL7/72SocnFWCnnvIVVp4mk4UP8G5x3mtuhYz2bvvP93wwrOeyiO5ftpaKPI4/Y8UbNGzHJctYlXNvdSnigjiadxVEcNOhnEfeLqBsH0l9APKBvk1FjdsD004e2g0Yqf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iKA7nlHW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705563336; x=1737099336;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OX3x/t7S5eYlemp0ECxrgPOLlFI4fZcRLUMx0aAs7nI=;
  b=iKA7nlHWLI9Q22jR603zMvvMhyViy6ILJuOPm7YQZQd7S2lheIt1K606
   AunPK/fnksvZa7kWdBZSSKKWW1eitXw5kJMekUSj23oKLhjGYmmLkz5D/
   wPuluL3YiKjUADTvk/iikXU+FFp/GCIfRGezE3/GQXphj3K70eTgkn0Is
   30+qhMj05laAbDe17irKF3YNK5apP9br6j2Z0LY5VEgfhZcmGgKdgj1Pi
   UxBxjMKfsegK18JQgxUAqqVnK4QaeP+ode3r6f/tW2x8IQVPPxL3AcwEf
   0yokM6o/d6zfxAQ5qvRvtOFMDU2Y5ZvyE7MK+Jz6XS0rLNkfpvRGdqtcS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="7067652"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="7067652"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 23:35:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="26391581"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.245.82.157])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 23:35:33 -0800
Date: Thu, 18 Jan 2024 08:35:25 +0100
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: linan666@huaweicloud.com
Cc: song@kernel.org, shli@fb.com, neilb@suse.com, zlliu@suse.com,
 linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
 yangerkun@huawei.com
Subject: Re: [PATCH v2 1/3] md: Don't clear MD_CLOSING when the raid is
 about to stop
Message-ID: <20240118083525.00002b15@linux.intel.com>
In-Reply-To: <20240117093707.2767209-2-linan666@huaweicloud.com>
References: <20240117093707.2767209-1-linan666@huaweicloud.com>
	<20240117093707.2767209-2-linan666@huaweicloud.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jan 2024 17:37:05 +0800
linan666@huaweicloud.com wrote:

> From: Li Nan <linan122@huawei.com>
> 
> The raid should not be opened anymore when it is about to be stopped.
> However, other processes can open it again if the flag MD_CLOSING is
> cleared before exiting. From now on, this flag will not be cleared when
> the raid will be stopped.
> 
> Fixes: 065e519e71b2 ("md: MD_CLOSING needs to be cleared after called
> md_set_readonly or do_md_stop") Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  drivers/md/md.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 9bdd57324c37..4bf821b89415 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -6254,7 +6254,15 @@ static void md_clean(struct mddev *mddev)
>  	mddev->persistent = 0;
>  	mddev->level = LEVEL_NONE;
>  	mddev->clevel[0] = 0;
> -	mddev->flags = 0;
> +	/*
> +	 * Don't clear MD_CLOSING, or mddev can be opened again.
> +	 * 'hold_active != 0' means mddev is still in the creation
> +	 * process and will be used later.
> +	 */
> +	if (mddev->hold_active)
> +		mddev->flags = 0;
> +	else
> +		mddev->flags &= BIT_ULL_MASK(MD_CLOSING);
>  	mddev->sb_flags = 0;
>  	mddev->ro = MD_RDWR;
>  	mddev->metadata_type[0] = 0;
> @@ -7728,6 +7736,12 @@ static int md_ioctl(struct block_device *bdev,
> blk_mode_t mode, 
>  	case STOP_ARRAY:
>  		err = do_md_stop(mddev, 0, bdev);
> +		if (!err)
> +			/*
> +			 * mddev has been stopped, keep flag the
> +			 * MD_CLOSING to prevent reuse.
> +			 */
> +			did_set_md_closing = false;

Hello Nan,
The meaning of the "did_set_md_closing" is to notify that MD_CLOSING was set in
this function, to know how to behave on error.
You gave it another meaning "Do not clear MD_CLOSING because we want it to stay"
Please consider how to solve this confusion. I see the comment you added but I
think we can have this solved better, maybe just name it as "clear_md_closing"?

Anyway it looks acceptable to me:
Acked-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>

Thanks,
Mariusz

