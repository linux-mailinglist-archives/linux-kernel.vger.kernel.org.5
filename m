Return-Path: <linux-kernel+bounces-153599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD988AD02D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 189F6B251D1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDF615252E;
	Mon, 22 Apr 2024 15:04:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2FE15217D;
	Mon, 22 Apr 2024 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713798287; cv=none; b=m5tRTjbGiS2SkahlpXi27334WHa1MwwkEiAkDBUdjAU9nIwz43aji0e3Mov7u0dXsQzIWqa//Z0Kg6ak+C3XQOkGMk1F7wHvEJAU2waJjYXgOFFEgmNg7V7uml8u+ETSmyvtTEk9Zg/R2tviRFh/WSmysBWmo4nzSXzWZexVqvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713798287; c=relaxed/simple;
	bh=5JG6CEJSC/3L87Wa3KY55TPd29wx7na1hq4gOaYVRe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bi6F135X01vki+TOUOSaxQBzeAtQUkUxK4s1d1cOf/r0TObHQqeB2Fkg5IVwg4h779Z5I5xCOuVlO0HAKyyRThQFJZUKSM66OudfWtq8J1vQUg4LAvTkBihzupI+XDnRgLCQgr+xOCNEsDBQjudsHxKo7is6wXG0HU70huce8hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FDFC113CC;
	Mon, 22 Apr 2024 15:04:45 +0000 (UTC)
Message-ID: <f196c736-dbfe-4ca0-995b-1720bf530edf@xs4all.nl>
Date: Mon, 22 Apr 2024 17:04:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux Kernel Bugs] KASAN: slab-use-after-free Read in
 cec_queue_msg_fh and 4 other crashes in the cec device (`cec_ioctl`)
Content-Language: en-US, nl
To: "Yang, Chenyuan" <cy54@illinois.edu>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "jani.nikula@intel.com" <jani.nikula@intel.com>,
 "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
 "mchehab@kernel.org" <mchehab@kernel.org>, "Zhao, Zijie"
 <zijie4@illinois.edu>, "Zhang, Lingming" <lingming@illinois.edu>
References: <PH7PR11MB57688E64ADE4FE82E658D86DA09EA@PH7PR11MB5768.namprd11.prod.outlook.com>
 <f985d664-d907-48ed-9b3d-dc956c178b88@xs4all.nl>
 <526380BE-57AC-493D-A7B0-B8F0ECC0FE0A@illinois.edu>
 <f1855145-9562-4bef-800f-43bcacff6fc8@xs4all.nl>
 <2e5f1e92-7fad-4a74-b375-1e194ff08ce6@xs4all.nl>
 <F8D4A291-8CFB-4A25-B296-3CA07B56F459@illinois.edu>
 <49a68c10-9549-4fd8-b929-d4c7a9c8debf@xs4all.nl>
 <PH7PR11MB5768B0BC3C042A6EA4EC1EF0A0542@PH7PR11MB5768.namprd11.prod.outlook.com>
 <7E36CBBD-F2AD-4D98-8D4E-F52E62C3E812@illinois.edu>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <7E36CBBD-F2AD-4D98-8D4E-F52E62C3E812@illinois.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Chenyuan,

My apologies for the delay, I missed your email.

On 26/02/2024 13:27, Yang, Chenyuan wrote:
> Hi Hans,
> 
> Thank you for your continued efforts in investigating this bug and implementing the new patch!
> 
> Regarding the two warnings, they have been addressed by this new patch and are no longer reproducible. Additionally, I conducted a 48-hour fuzzing test on the CEC driver, which has successfully eliminated the previous hanging issue.
> 
> One thing to note that the system will now log timeout events:
> ```
> [ 2281.265385][ T2034] cec-vivid-001-vid-out0: transmit timed out
> [ 2282.994510][ T2017] cec-vivid-000-vid-cap0: transmit timed out
> [ 2283.063484][ T2050] cec-vivid-002-vid-out0: transmit timed out
> [ 2283.073468][ T2065] cec-vivid-003-vid-cap0: transmit timed out
> [ 2283.373518][ T2033] cec-vivid-001-vid-cap0: transmit timed out
> [ 2285.113544][ T2018] cec-vivid-000-vid-out0: transmit timed out
> [ 2285.193502][ T2050] cec-vivid-002-vid-out0: transmit timed out
> [ 2285.193570][ T2065] cec-vivid-003-vid-cap0: transmit timed out
> [ 2285.513570][ T2033] cec-vivid-001-vid-cap0: transmit timed out
> ```

Is this happening all the time, or just once in a (long?) while?

Regards,

	Hans

> 
> Best,
> Chenyuan
> 
> From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Date: Friday, February 23, 2024 at 8:44 AM
> To: Yang, Chenyuan <cy54@illinois.edu>, linux-media@vger.kernel.org <linux-media@vger.kernel.org>, linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> Cc: jani.nikula@intel.com <jani.nikula@intel.com>, syzkaller@googlegroups.com <syzkaller@googlegroups.com>, mchehab@kernel.org <mchehab@kernel.org>, Zhao, Zijie <zijie4@illinois.edu>, Zhang, Lingming <lingming@illinois.edu>
> Subject: Re: [Linux Kernel Bugs] KASAN: slab-use-after-free Read in cec_queue_msg_fh and 4 other crashes in the cec device (`cec_ioctl`)
> Hi Chenyuan,
> 
> Here is another patch for you to try. I think it is good for blocking CEC_ADAP_S_LOG_ADDRS
> ioctl calls, but if the filehandle is in non-blocking mode, I'm still not certain it
> is correct. But one issue at a time :-)
> 
> Regards,
> 
>         Hans
> 
> diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
> index 559a172ebc6c..a493cbce2456 100644
> --- a/drivers/media/cec/core/cec-adap.c
> +++ b/drivers/media/cec/core/cec-adap.c
> @@ -936,8 +936,7 @@ int cec_transmit_msg_fh(struct cec_adapter *adap, struct cec_msg *msg,
>           */
>          mutex_unlock(&adap->lock);
>          wait_for_completion_killable(&data->c);
> -       if (!data->completed)
> -               cancel_delayed_work_sync(&data->work);
> +       cancel_delayed_work_sync(&data->work);
>          mutex_lock(&adap->lock);
> 
>          /* Cancel the transmit if it was interrupted */
> @@ -1575,9 +1574,12 @@ static int cec_config_thread_func(void *arg)
>   */
>  static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
>  {
> -       if (WARN_ON(adap->is_configuring || adap->is_configured))
> +       if (WARN_ON(adap->is_claiming_log_addrs ||
> +                   adap->is_configuring || adap->is_configured))
>                  return;
> 
> +       adap->is_claiming_log_addrs = true;
> +
>          init_completion(&adap->config_completion);
> 
>          /* Ready to kick off the thread */
> @@ -1592,6 +1594,7 @@ static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
>                  wait_for_completion(&adap->config_completion);
>                  mutex_lock(&adap->lock);
>          }
> +       adap->is_claiming_log_addrs = false;
>  }
> 
>  /*
> diff --git a/drivers/media/cec/core/cec-api.c b/drivers/media/cec/core/cec-api.c
> index 67dc79ef1705..3ef915344304 100644
> --- a/drivers/media/cec/core/cec-api.c
> +++ b/drivers/media/cec/core/cec-api.c
> @@ -178,7 +178,7 @@ static long cec_adap_s_log_addrs(struct cec_adapter *adap, struct cec_fh *fh,
>                             CEC_LOG_ADDRS_FL_ALLOW_RC_PASSTHRU |
>                             CEC_LOG_ADDRS_FL_CDC_ONLY;
>          mutex_lock(&adap->lock);
> -       if (!adap->is_configuring &&
> +       if (!adap->is_claiming_log_addrs && !adap->is_configuring &&
>              (!log_addrs.num_log_addrs || !adap->is_configured) &&
>              !cec_is_busy(adap, fh)) {
>                  err = __cec_s_log_addrs(adap, &log_addrs, block);
> @@ -664,6 +664,8 @@ static int cec_release(struct inode *inode, struct file *filp)
>                  list_del_init(&data->xfer_list);
>          }
>          mutex_unlock(&adap->lock);
> +
> +       mutex_lock(&fh->lock);
>          while (!list_empty(&fh->msgs)) {
>                  struct cec_msg_entry *entry =
>                          list_first_entry(&fh->msgs, struct cec_msg_entry, list);
> @@ -681,6 +683,7 @@ static int cec_release(struct inode *inode, struct file *filp)
>                          kfree(entry);
>                  }
>          }
> +       mutex_unlock(&fh->lock);
>          kfree(fh);
> 
>          cec_put_device(devnode);
> diff --git a/include/media/cec.h b/include/media/cec.h
> index 10c9cf6058b7..cc3fcd0496c3 100644
> --- a/include/media/cec.h
> +++ b/include/media/cec.h
> @@ -258,6 +258,7 @@ struct cec_adapter {
>          u16 phys_addr;
>          bool needs_hpd;
>          bool is_enabled;
> +       bool is_claiming_log_addrs;
>          bool is_configuring;
>          bool must_reconfigure;
>          bool is_configured;
> 


