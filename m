Return-Path: <linux-kernel+bounces-153327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DACB48ACCA5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9227A281670
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CB51474D8;
	Mon, 22 Apr 2024 12:14:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D748146D61;
	Mon, 22 Apr 2024 12:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713788061; cv=none; b=S5gn3+6HNmkyimG7S4VLZ6VdO/FGioAr8Ar3u7bvm7CtuX78HAWrPGE47TMXu/CZp8cIVq4RxZGkUVIueyGmaEgb5gVDzl50FPVl1jshULQS+Ryu5NqK1bjctuUdxXHGxSGlOALW4CM/iP/4wha71ysrso1DedBJV4IHnOVwZSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713788061; c=relaxed/simple;
	bh=X1T3/xYzPELvu5Xll7A3YXl6h754gstCmtUvhhI86ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DoAabeYB7df4RBq9A7pZzgH5X6GRW+pZXvpFx8juUpBRZWkqjln0GqQ6P/cFKdik9A0ic5bpKkyjHdCog21MnLbTtEpdOyfSWEYXXMbsU6sjHVYQc1l/v7XWH/EZq07cepf20+95EYq3ue24cxjjAjpzf2QjxmzukVSOqJoWSHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE78C32782;
	Mon, 22 Apr 2024 12:14:19 +0000 (UTC)
Message-ID: <966f5847-d007-4425-a902-1e1c05a820ae@xs4all.nl>
Date: Mon, 22 Apr 2024 14:14:17 +0200
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "Yang, Chenyuan" <cy54@illinois.edu>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jani.nikula@intel.com" <jani.nikula@intel.com>,
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
 <87le59s8wi.wl-tiwai@suse.de>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <87le59s8wi.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Takashi,

On 19/04/2024 16:51, Takashi Iwai wrote:
> On Mon, 26 Feb 2024 13:27:16 +0100,
> Yang, Chenyuan wrote:
>>
>> Hi Hans,
>>
>> Thank you for your continued efforts in investigating this bug and implementing the new patch!
>>
>> Regarding the two warnings, they have been addressed by this new patch and are no longer reproducible. Additionally, I conducted a 48-hour fuzzing test on the CEC driver, which has successfully eliminated the previous hanging issue.
>>
>> One thing to note that the system will now log timeout events:
>> ```
>> [ 2281.265385][ T2034] cec-vivid-001-vid-out0: transmit timed out
>> [ 2282.994510][ T2017] cec-vivid-000-vid-cap0: transmit timed out
>> [ 2283.063484][ T2050] cec-vivid-002-vid-out0: transmit timed out
>> [ 2283.073468][ T2065] cec-vivid-003-vid-cap0: transmit timed out
>> [ 2283.373518][ T2033] cec-vivid-001-vid-cap0: transmit timed out
>> [ 2285.113544][ T2018] cec-vivid-000-vid-out0: transmit timed out
>> [ 2285.193502][ T2050] cec-vivid-002-vid-out0: transmit timed out
>> [ 2285.193570][ T2065] cec-vivid-003-vid-cap0: transmit timed out
>> [ 2285.513570][ T2033] cec-vivid-001-vid-cap0: transmit timed out

>> ```
>>
>> Best,
>> Chenyuan
> 
> Hi Hans,
> 
> how is the current status of this bug fix?  It seems that the thread
> stalled, and I wonder how we can go further.
> 
> I'm asking it because CVE-2024-23848 was assigned and we've been asked
> about the bug fix.

I missed this reply, so I will take another look at the patch. Too many emails :-(

Two other patches relating to this I have just posted:

https://patchwork.linuxtv.org/project/linux-media/patch/2b043325-14c0-4e63-ae9c-0d685d96fd98@xs4all.nl/
https://patchwork.linuxtv.org/project/linux-media/patch/f17f961b-3a19-48da-941a-c8970d9e1786@xs4all.nl/

Regards,

	Hans

> 
> 
> Thanks!
> 
> Takashi
> 
>>
>> From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
>> Date: Friday, February 23, 2024 at 8:44 AM
>> To: Yang, Chenyuan <cy54@illinois.edu>, linux-media@vger.kernel.org <linux-media@vger.kernel.org>, linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
>> Cc: jani.nikula@intel.com <jani.nikula@intel.com>, syzkaller@googlegroups.com <syzkaller@googlegroups.com>, mchehab@kernel.org <mchehab@kernel.org>, Zhao, Zijie <zijie4@illinois.edu>, Zhang, Lingming <lingming@illinois.edu>
>> Subject: Re: [Linux Kernel Bugs] KASAN: slab-use-after-free Read in cec_queue_msg_fh and 4 other crashes in the cec device (`cec_ioctl`)
>> Hi Chenyuan,
>>
>> Here is another patch for you to try. I think it is good for blocking CEC_ADAP_S_LOG_ADDRS
>> ioctl calls, but if the filehandle is in non-blocking mode, I'm still not certain it
>> is correct. But one issue at a time :-)
>>
>> Regards,
>>
>>         Hans
>>
>> diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
>> index 559a172ebc6c..a493cbce2456 100644
>> --- a/drivers/media/cec/core/cec-adap.c
>> +++ b/drivers/media/cec/core/cec-adap.c
>> @@ -936,8 +936,7 @@ int cec_transmit_msg_fh(struct cec_adapter *adap, struct cec_msg *msg,
>>           */
>>          mutex_unlock(&adap->lock);
>>          wait_for_completion_killable(&data->c);
>> -       if (!data->completed)
>> -               cancel_delayed_work_sync(&data->work);
>> +       cancel_delayed_work_sync(&data->work);
>>          mutex_lock(&adap->lock);
>>
>>          /* Cancel the transmit if it was interrupted */
>> @@ -1575,9 +1574,12 @@ static int cec_config_thread_func(void *arg)
>>   */
>>  static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
>>  {
>> -       if (WARN_ON(adap->is_configuring || adap->is_configured))
>> +       if (WARN_ON(adap->is_claiming_log_addrs ||
>> +                   adap->is_configuring || adap->is_configured))
>>                  return;
>>
>> +       adap->is_claiming_log_addrs = true;
>> +
>>          init_completion(&adap->config_completion);
>>
>>          /* Ready to kick off the thread */
>> @@ -1592,6 +1594,7 @@ static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
>>                  wait_for_completion(&adap->config_completion);
>>                  mutex_lock(&adap->lock);
>>          }
>> +       adap->is_claiming_log_addrs = false;
>>  }
>>
>>  /*
>> diff --git a/drivers/media/cec/core/cec-api.c b/drivers/media/cec/core/cec-api.c
>> index 67dc79ef1705..3ef915344304 100644
>> --- a/drivers/media/cec/core/cec-api.c
>> +++ b/drivers/media/cec/core/cec-api.c
>> @@ -178,7 +178,7 @@ static long cec_adap_s_log_addrs(struct cec_adapter *adap, struct cec_fh *fh,
>>                             CEC_LOG_ADDRS_FL_ALLOW_RC_PASSTHRU |
>>                             CEC_LOG_ADDRS_FL_CDC_ONLY;
>>          mutex_lock(&adap->lock);
>> -       if (!adap->is_configuring &&
>> +       if (!adap->is_claiming_log_addrs && !adap->is_configuring &&
>>              (!log_addrs.num_log_addrs || !adap->is_configured) &&
>>              !cec_is_busy(adap, fh)) {
>>                  err = __cec_s_log_addrs(adap, &log_addrs, block);
>> @@ -664,6 +664,8 @@ static int cec_release(struct inode *inode, struct file *filp)
>>                  list_del_init(&data->xfer_list);
>>          }
>>          mutex_unlock(&adap->lock);
>> +
>> +       mutex_lock(&fh->lock);
>>          while (!list_empty(&fh->msgs)) {
>>                  struct cec_msg_entry *entry =
>>                          list_first_entry(&fh->msgs, struct cec_msg_entry, list);
>> @@ -681,6 +683,7 @@ static int cec_release(struct inode *inode, struct file *filp)
>>                          kfree(entry);
>>                  }
>>          }
>> +       mutex_unlock(&fh->lock);
>>          kfree(fh);
>>
>>          cec_put_device(devnode);
>> diff --git a/include/media/cec.h b/include/media/cec.h
>> index 10c9cf6058b7..cc3fcd0496c3 100644
>> --- a/include/media/cec.h
>> +++ b/include/media/cec.h
>> @@ -258,6 +258,7 @@ struct cec_adapter {
>>          u16 phys_addr;
>>          bool needs_hpd;
>>          bool is_enabled;
>> +       bool is_claiming_log_addrs;
>>          bool is_configuring;
>>          bool must_reconfigure;
>>          bool is_configured;
>>


