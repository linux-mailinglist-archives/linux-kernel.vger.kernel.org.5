Return-Path: <linux-kernel+bounces-163673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8E88B6E34
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2FC1B210D1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0893013D628;
	Tue, 30 Apr 2024 09:20:04 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C80127E3F;
	Tue, 30 Apr 2024 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468803; cv=none; b=C/CCA3P9FoN6KARpQfh6yFXlKiJtwOh3vdmYIAKpHu6eE3/fZOEBnQI/afY+TtnsauAShB/6IiTAvPj3lO1+ZSibmDsVZNwJWE/WlIE4JyUMi/ID4iQRMse3m8lhzBlxsTPX798jzTRK6VB1a7Re+Fzps5knrrDBxOp24yV5XsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468803; c=relaxed/simple;
	bh=dbDHJ4rWVH/u6iJ4V5hPVrSwoNqEatmwKmR5Txwe1I4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rIrFeufLoUYdX3EtJ+ilJENa5yQ+7P6LK0V4VqDigVy64ffqmIfu5SWAsIrC+DHByDfH0YIedE3bQzX0rnocBSLydu4T7d8reqksL9kAuTJ7THN4ewHCgmpPKygX4lUhtbBbeOsvIoiZgFY9VxqSqFjYAouyXeO1WGVnLxoKxNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VTF4V0FMPzccVR;
	Tue, 30 Apr 2024 17:18:50 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (unknown [7.185.36.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 593D718007D;
	Tue, 30 Apr 2024 17:19:57 +0800 (CST)
Received: from [10.67.111.172] (10.67.111.172) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 17:19:57 +0800
Message-ID: <37581090-ae63-46c4-98c1-76e9138e6b6e@huawei.com>
Date: Tue, 30 Apr 2024 17:19:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] media: dvb-usb: Fix unexpected infinite loop in
 dvb_usb_read_remote_control()
Content-Language: en-US
To: Sean Young <sean@mess.org>
CC: <mchehab@kernel.org>, <linux-media@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240412135256.1546051-1-zhengyejian1@huawei.com>
 <5c0359c7-502f-fe8b-c1ee-3470b36b586c@huawei.com>
 <ZjCl97Ww6NrzJQCB@gofer.mess.org>
From: Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <ZjCl97Ww6NrzJQCB@gofer.mess.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500012.china.huawei.com (7.185.36.15)

On 2024/4/30 16:04, Sean Young wrote:
> On Mon, Apr 29, 2024 at 07:24:21PM +0800, Zheng Yejian wrote:
>> On 2024/4/12 21:52, Zheng Yejian wrote:
>>> Infinite log printing occurs during fuzz test:
>>>
>>>     rc rc1: DViCO FusionHDTV DVB-T USB (LGZ201) as ...
>>>     ...
>>>     dvb-usb: schedule remote query interval to 100 msecs.
>>>     dvb-usb: DViCO FusionHDTV DVB-T USB (LGZ201) successfully initialized ...
>>>     dvb-usb: bulk message failed: -22 (1/0)
>>>     dvb-usb: bulk message failed: -22 (1/0)
>>>     dvb-usb: bulk message failed: -22 (1/0)
>>>     ...
>>>     dvb-usb: bulk message failed: -22 (1/0)
>>>
>>> Looking into the codes, there is a loop in dvb_usb_read_remote_control(),
>>> that is in rc_core_dvb_usb_remote_init() create a work that will call
>>> dvb_usb_read_remote_control(), and this work will reschedule itself at
>>> 'rc_interval' intervals to recursively call dvb_usb_read_remote_control(),
>>> see following code snippet:
>>>
>>>     rc_core_dvb_usb_remote_init() {
>>>       ...
>>>       INIT_DELAYED_WORK(&d->rc_query_work, dvb_usb_read_remote_control);
>>>       schedule_delayed_work(&d->rc_query_work,
>>>                             msecs_to_jiffies(rc_interval));
>>>       ...
>>>     }
>>>
>>>     dvb_usb_read_remote_control() {
>>>       ...
>>>       err = d->props.rc.core.rc_query(d);
>>>       if (err)
>>>         err(...)  // Did not return even if query failed
>>>       schedule_delayed_work(&d->rc_query_work,
>>>                             msecs_to_jiffies(rc_interval));
>>>     }
>>>
>>> When the infinite log printing occurs, the query callback
>>> 'd->props.rc.core.rc_query' is cxusb_rc_query(). And the log is due to
>>> the failure of finding a valid 'generic_bulk_ctrl_endpoint'
>>> in usb_bulk_msg(), see following code snippet:
>>>
>>>     cxusb_rc_query() {
>>>       cxusb_ctrl_msg() {
>>>         dvb_usb_generic_rw() {
>>>           ret = usb_bulk_msg(d->udev, usb_sndbulkpipe(d->udev,
>>>                              d->props.generic_bulk_ctrl_endpoint),...);
>>>           if (ret)
>>>             err("bulk message failed: %d (%d/%d)",ret,wlen,actlen);
>>>             ...
>>>         }
>>>     ...
>>>     }
>>>
>>> By analyzing the corresponding USB descriptor, it shows that the
>>> bNumEndpoints is 0 in its interface descriptor, but
>>> the 'generic_bulk_ctrl_endpoint' is 1, that means user don't configure
>>> a valid endpoint for 'generic_bulk_ctrl_endpoint', therefore this
>>> 'invalid' USB device should be rejected before it calls into
>>> dvb_usb_read_remote_control().
>>>
>>> To fix it, iiuc, we can add endpoint check in dvb_usb_adapter_init().
>>>
>>> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
>>> ---
>>>    drivers/media/usb/dvb-usb/dvb-usb-init.c | 8 ++++++++
>>>    1 file changed, 8 insertions(+)
>>>
>>> Hi, I'm not very familiar with USB driver, and I'm not sure the
>>> type check is appropriate or not here. Would be any device properties
>>> that allow 'generic_bulk_ctrl_endpoint' not being configured, or would
>>> it be configured late after init ? :)
>>>
>>
>> Kindly ping :)
>> Hi, Mauro, would you mind taking a look at this code ?
>>
>> --
>> Thanks,
>> Zheng Yejian
>>
>>> diff --git a/drivers/media/usb/dvb-usb/dvb-usb-init.c b/drivers/media/usb/dvb-usb/dvb-usb-init.c
>>> index fbf58012becd..48e7b9fb93dd 100644
>>> --- a/drivers/media/usb/dvb-usb/dvb-usb-init.c
>>> +++ b/drivers/media/usb/dvb-usb/dvb-usb-init.c
>>> @@ -104,6 +104,14 @@ static int dvb_usb_adapter_init(struct dvb_usb_device *d, short *adapter_nrs)
>>>    	 * sometimes a timeout occurs, this helps
>>>    	 */
>>>    	if (d->props.generic_bulk_ctrl_endpoint != 0) {
>>> +		ret = usb_pipe_type_check(d->udev, usb_sndbulkpipe(d->udev,
>>> +					  d->props.generic_bulk_ctrl_endpoint));
>>> +		if (ret)
>>> +			goto frontend_init_err;
>>> +		ret = usb_pipe_type_check(d->udev, usb_rcvbulkpipe(d->udev,
>>> +					  d->props.generic_bulk_ctrl_endpoint));
>>> +		if (ret)
>>> +			goto frontend_init_err;
>>>    		usb_clear_halt(d->udev, usb_sndbulkpipe(d->udev, d->props.generic_bulk_ctrl_endpoint));
>>>    		usb_clear_halt(d->udev, usb_rcvbulkpipe(d->udev, d->props.generic_bulk_ctrl_endpoint));
>>>    	}
>>
> 
> Thank you for your patch.
> 
> I think your change looks good. The only comment I have is that the same
> check should be done for generic_bulk_ctrl_endpoint_response as well; the
> usb_clear_halt() should be done as well, I think.
> 

Thanks for your suggestion!
Do you mean the following change? If it is ok, I'll send a v2!

diff --git a/drivers/media/usb/dvb-usb/dvb-usb-init.c b/drivers/media/usb/dvb-usb/dvb-usb-init.c
index fbf58012becd..2a8395d6373c 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb-init.c
+++ b/drivers/media/usb/dvb-usb/dvb-usb-init.c
@@ -23,6 +23,23 @@ static int dvb_usb_force_pid_filter_usage;
  module_param_named(force_pid_filter_usage, dvb_usb_force_pid_filter_usage, int, 0444);
  MODULE_PARM_DESC(force_pid_filter_usage, "force all dvb-usb-devices to use a PID filter, if any (default: 0).");

+static int dvb_usb_clear_halt(struct dvb_usb_device *d, u8 endpoint)
+{
+       if (endpoint) {
+               int ret;
+
+               ret = usb_pipe_type_check(d->udev, usb_sndbulkpipe(d->udev, endpoint));
+               if (ret)
+                       return ret;
+               ret = usb_pipe_type_check(d->udev, usb_rcvbulkpipe(d->udev, endpoint));
+               if (ret)
+                       return ret;
+               usb_clear_halt(d->udev, usb_sndbulkpipe(d->udev, endpoint));
+               usb_clear_halt(d->udev, usb_rcvbulkpipe(d->udev, endpoint));
+       }
+       return 0;
+}
+
  static int dvb_usb_adapter_init(struct dvb_usb_device *d, short *adapter_nrs)
  {
         struct dvb_usb_adapter *adap;
@@ -103,10 +120,12 @@ static int dvb_usb_adapter_init(struct dvb_usb_device *d, short *adapter_nrs)
          * when reloading the driver w/o replugging the device
          * sometimes a timeout occurs, this helps
          */
-       if (d->props.generic_bulk_ctrl_endpoint != 0) {
-               usb_clear_halt(d->udev, usb_sndbulkpipe(d->udev, d->props.generic_bulk_ctrl_endpoint));
-               usb_clear_halt(d->udev, usb_rcvbulkpipe(d->udev, d->props.generic_bulk_ctrl_endpoint));
-       }
+       ret = dvb_usb_clear_halt(d, d->props.generic_bulk_ctrl_endpoint);
+       if (ret)
+               goto frontend_init_err;
+       ret = dvb_usb_clear_halt(d, d->props.generic_bulk_ctrl_endpoint_response);
+       if (ret)
+               goto frontend_init_err;

         return 0;

--
Thanks,
Zheng Yejian

> Thanks
> 
> Sean


