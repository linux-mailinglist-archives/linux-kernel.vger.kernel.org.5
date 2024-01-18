Return-Path: <linux-kernel+bounces-29835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49809831431
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DECE01F23648
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9B511CB3;
	Thu, 18 Jan 2024 08:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cRh78Q+N"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56D411C80;
	Thu, 18 Jan 2024 08:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564936; cv=none; b=tqrhJZIa+caE2s1V2lEzXDYJJcgPIGWas5fzvuVvb3qdzfftSlAtEmNved60zC6Nnc2L6vaqGaLAHUQ2gcd/dtOKvj60kfOrSKMFVCnAu88IDxoZiCwOjasSz/rIwS5IqPUYx5DN/eUGLUekBFtfeaZGRh3vrcM/jCGwZz+WWFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564936; c=relaxed/simple;
	bh=OALzICepfRDRFg9fUGRC5iG9WOyOuoZA3htK7BIML9k=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=FG2VaPWrZ+jBGH+89gdZm25c4NZIDdd1YScYxHeG9E+9GM7DIQDxxEKsL+oJ5DTgA/uhVOEsRC8DYMKP0gojVMPApGexGLAmkbL70HAawGGtAMpest5jkyfUwCBuiYZOrHg0h55j3xj2Z+qKx4K+tely4+p1doMq/xM+j3gT5SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cRh78Q+N; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705564934; x=1737100934;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OALzICepfRDRFg9fUGRC5iG9WOyOuoZA3htK7BIML9k=;
  b=cRh78Q+NAjacPhFH8pqA1vz54x+qd7J5Ceycod87SIHWylKc6ppz3do/
   6OG9O1TDGYdhKgkUQQD55BaV+yHAurW70TMx+WCGxCVeqJe7qsAJKBwJ0
   X/hihTOZzSJJkt8GLs3WLdOgP5+hOcoTitwP80YLTtkumMx6TLgnT7FZb
   e9Zd7DZvD+2ZqRTHuK8kzuUnoZA/1cwuQamBX/StHNWFZ2AyEOvRmonVg
   AbvueTm4HoYecrA0oRZzwQitLqGllLqNGrH7fDlwt0orbLwTNGO8ZwQSl
   tTfP+1qrAa2U6Lg/vmp3EcEiXoHzeq5Dx4wzH4UCu3vbbJ+LI+cBunI0r
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="390825917"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="390825917"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 00:02:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="33032144"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.245.82.157])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 00:02:10 -0800
Date: Thu, 18 Jan 2024 09:02:05 +0100
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: linan666@huaweicloud.com
Cc: song@kernel.org, shli@fb.com, neilb@suse.com, zlliu@suse.com,
 linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
 yangerkun@huawei.com
Subject: Re: [PATCH v2 3/3] md: sync blockdev before stopping raid or
 setting readonly
Message-ID: <20240118090205.00000212@linux.intel.com>
In-Reply-To: <20240117093707.2767209-4-linan666@huaweicloud.com>
References: <20240117093707.2767209-1-linan666@huaweicloud.com>
	<20240117093707.2767209-4-linan666@huaweicloud.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jan 2024 17:37:07 +0800
linan666@huaweicloud.com wrote:

> From: Li Nan <linan122@huawei.com>
> 
> Commit a05b7ea03d72 ("md: avoid crash when stopping md array races
> with closing other open fds.") added sync_block before stopping raid and
> setting readonly. Later in commit 260fa034ef7a ("md: avoid deadlock when
> dirty buffers during md_stop.") it is moved to ioctl. array_state_store()
> was ignored. Add sync blockdev to array_state_store() now.
> 
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  drivers/md/md.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 2c793992a604..aea39598457c 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -4477,6 +4477,7 @@ array_state_store(struct mddev *mddev, const char *buf,
> size_t len) {
>  	int err = 0;
>  	enum array_state st = match_word(buf, array_states);
> +	bool clear_md_closing = false;
>  
>  	/* No lock dependent actions */
>  	switch (st) {
> @@ -4511,6 +4512,16 @@ array_state_store(struct mddev *mddev, const char
> *buf, size_t len) spin_unlock(&mddev->lock);
>  		return err ?: len;
>  	}
> +
> +	/* we will call set readonly or stop raid, sync blockdev */
> +	if (st == clear || (mddev->pers && (st == readonly ||
> +	    st == inactive || (st == read_auto && md_is_rdwr(mddev))))) {
> +		err = mddev_sync_blockdev(mddev);
> +		if (err)
> +			return err;
> +		clear_md_closing = true;
> +	}
> +

Please reorganize it a little for readability:
I think if no mddev->pers we don't need to consider sync_blockdev at all. If
personality is there we can probably check for read-write. If it is not
read-write then nothing to sync. What about that:

if (mddev->pers && md_is_rdwr(mddev) &&
    (st == clear || st == readonly || st == inactive || st == read_auto)) 

Please note that I didn't test it so please let me know if you see issue in
proposed logic.
I think that we may be able to include it in "/* No lock dependent actions */"
switch. Please consider it too:

case clear:
case readonly:
case inactive:
case read_auto:
    if(!mddev->pers || !md_is_rdwr(mddev))
          break;
    err = mddev_sync_blockdev(mddev);
    if (err)
        return err;
    clear_md_closing = true;
    
>  	err = mddev_lock(mddev);
>  	if (err)
>  		return err;
> @@ -4523,6 +4534,8 @@ array_state_store(struct mddev *mddev, const char *buf,
> size_t len) break;
>  	case clear:
>  		err = do_md_stop(mddev, 0, NULL);
> +		if (!err)
> +			clear_md_closing = false;
>  		break;
>  	case readonly:
>  		if (mddev->pers)
> @@ -4585,6 +4598,8 @@ array_state_store(struct mddev *mddev, const char *buf,
> size_t len) sysfs_notify_dirent_safe(mddev->sysfs_state);
>  	}
>  	mddev_unlock(mddev);
> +	if (clear_md_closing)
> +		clear_bit(MD_CLOSING, &mddev->flags);

Please add spaces before and after if.

>  	return err ?: len;
>  }
>  static struct md_sysfs_entry md_array_state =

Thanks,
Mariusz

