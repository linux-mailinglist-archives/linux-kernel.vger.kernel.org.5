Return-Path: <linux-kernel+bounces-61846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EACD885175D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295F31C2114E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE8B3B791;
	Mon, 12 Feb 2024 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U+/QJb0K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD993B297
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707749643; cv=none; b=GYseEp11QpVIVeJnO3VuKEYjvS9/q6PFLM9xsVKTpW3GjDCpcXuINm15eqoL06Ae7PBpn2+yyDZ1hu0n5hx2kMyHCgz7CBLiJlgEJYtN7BiHfmxr31o1JAq/HK3r0WK+C+PzNB9kXOurgenfjg9n4AxaMcmzK0FsY5puV+1pRk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707749643; c=relaxed/simple;
	bh=NkwRjZxa0/AtcMo1/jowb91fxYW5bjzaFfRIJf9CD1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4RY/+sN1CwuS/0jB2kmMr+MEEHXTSFDEZlvCFY/7yDJFHEiofj0M/vXxNNs3xb+axczrR4tqDt04QhScwb+sN/1IATBMKid4boWIB2NnoZpf09CWmAp5v1UNpIrEwSOECVovNG2d95CuGlzSM0/Kkwn26hct1T8LQ0RZ4XSgZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U+/QJb0K; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707749641; x=1739285641;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NkwRjZxa0/AtcMo1/jowb91fxYW5bjzaFfRIJf9CD1c=;
  b=U+/QJb0KTe/PKY4JBQTcVN96WLE+oPyKeCpAgtEF5XuwlT1XH0Ollcyn
   Z3Wo0q5pcuIiUethJytxqC1Yiz9GYx5eeEDZ+8PxETtN4qZKfXrVXBFey
   +3UKak5HjbQdVrzuAfYJzBMysJoK8UHgyPecrrcWo2ST3xYjz8FXH6dja
   tTa8n8bg5UrIPVQy/+k3lupqg8+8ps0u/ILR3HOOlu1V6ihmnaEA5mkGb
   TTrmEKwSb+i5F8w4i3tWqdfGKuHbzrr1mbK04UXPUYyO3LgDPcw6H20A7
   5/vaNlpNW3Kkdygczef1PM4z752TnB0Hj6txRJ7cZcXR+AG0luFMduLG7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1850455"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="1850455"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 06:54:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="2582267"
Received: from rvarada-mobl.amr.corp.intel.com (HELO [10.212.76.202]) ([10.212.76.202])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 06:54:00 -0800
Message-ID: <83c8bfa3-4377-4198-b48e-351f9a9f63ed@linux.intel.com>
Date: Mon, 12 Feb 2024 08:49:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soundwire: fix double free of pointer
Content-Language: en-US
To: Daniil Dulov <d.dulov@aladdin.ru>, Vinod Koul <vkoul@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240211150937.4058-1-d.dulov@aladdin.ru>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240211150937.4058-1-d.dulov@aladdin.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/24 09:09, Daniil Dulov wrote:
> If sdw_ml_sync_bank_switch() returns error not on the first iteration,
> it leads to freeing prevously freed memory. So, set the pointer to NULL
> after each successful bank switch.
> 
> Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
> ---
>  drivers/soundwire/stream.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 304ff2ee7d75..d650e6f0f8e7 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -833,6 +833,7 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
>  				"multi link bank switch failed: %d\n", ret);
>  			goto error;
>  		}
> +		bus->defer_msg.msg = NULL;
>  
>  		if (multi_link)
>  			mutex_unlock(&bus->msg_lock);

Not following what the issue is...

On success, sdw_ml_sync_bank_switch() frees the buffers with

	if (bus->defer_msg.msg) {
		kfree(bus->defer_msg.msg->buf);
		kfree(bus->defer_msg.msg);
		bus->defer_msg.msg = NULL;
	}

So if there is an issue on the second iteration, then the loop will
detect already freed memory in the previous iteration and skip it:

                /* Check if bank switch was successful */
		ret = sdw_ml_sync_bank_switch(bus);
		if (ret < 0) {
			dev_err(bus->dev,
				"multi link bank switch failed: %d\n", ret);
			goto error;
		}

error:
	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
		bus = m_rt->bus;
		if (bus->defer_msg.msg) { <<<< TEST FOR FREED MEMORY
			kfree(bus->defer_msg.msg->buf);
			kfree(bus->defer_msg.msg);
			bus->defer_msg.msg = NULL;
		}
	}

It could very well be that I need more coffee on this post-SuperBowl
Monday morning, but I just don't see the problem.

