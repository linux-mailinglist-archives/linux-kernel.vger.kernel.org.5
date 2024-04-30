Return-Path: <linux-kernel+bounces-163741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99558B6F10
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B42282F73
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AB0129E7E;
	Tue, 30 Apr 2024 10:05:56 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9B41292C8;
	Tue, 30 Apr 2024 10:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714471556; cv=none; b=RwMyuSfzAeP4n66gaaBwCFf4Kb4JWQ/LnDWfrlz1aGQBfWTVdU7/FAA6l+mUWBWW3UEE72CkvfWxEYrS88eG1XAHp8Ow7aeUSEpQojW08E4PQhfuvFBvuoWdqMlPHdur3gdOp0uzJptWdt6FYbyILi+AVvPv/TGx/zuzdyiBIK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714471556; c=relaxed/simple;
	bh=dhe9uYcPlH3P2B5i3QKvhg+jgfj9ROJsg9EOJ6MfKYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GQGbdSCQwm92x01bthju9tGELJzA/mOyp69IVE2bPC+9u7AaNhE6vUmM9oanjOwKg1RzCOhm6fXLY3kmzLy9rUileve4KBVdmgaR4LGSJLj4/V18KIO19F4Vmx0LEfaDAf7C1a6Wm25iOaP/syE1OyhGkX4ClfE8vstGrPNQhd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VTG3b5NwDz1ymXf;
	Tue, 30 Apr 2024 18:03:07 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (unknown [7.185.36.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 46AF9140109;
	Tue, 30 Apr 2024 18:05:45 +0800 (CST)
Received: from [10.67.111.172] (10.67.111.172) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 18:05:45 +0800
Message-ID: <83a05d49-6367-9bdd-0702-940e32b072a4@huawei.com>
Date: Tue, 30 Apr 2024 18:05:44 +0800
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
	<linux-kernel@vger.kernel.org>, Zheng Yejian <zhengyejian1@huawei.com>
References: <20240412135256.1546051-1-zhengyejian1@huawei.com>
 <5c0359c7-502f-fe8b-c1ee-3470b36b586c@huawei.com>
 <ZjCl97Ww6NrzJQCB@gofer.mess.org>
 <37581090-ae63-46c4-98c1-76e9138e6b6e@huawei.com>
 <ZjC7rXU7ViaH60_S@gofer.mess.org>
From: Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <ZjC7rXU7ViaH60_S@gofer.mess.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500012.china.huawei.com (7.185.36.15)

On 2024/4/30 17:36, Sean Young wrote:
> On Tue, Apr 30, 2024 at 05:19:56PM +0800, Zheng Yejian wrote:
>> Thanks for your suggestion!
>> Do you mean the following change? If it is ok, I'll send a v2!
>>
>> diff --git a/drivers/media/usb/dvb-usb/dvb-usb-init.c b/drivers/media/usb/dvb-usb/dvb-usb-init.c
>> index fbf58012becd..2a8395d6373c 100644
>> --- a/drivers/media/usb/dvb-usb/dvb-usb-init.c
>> +++ b/drivers/media/usb/dvb-usb/dvb-usb-init.c
>> @@ -23,6 +23,23 @@ static int dvb_usb_force_pid_filter_usage;
>>   module_param_named(force_pid_filter_usage, dvb_usb_force_pid_filter_usage, int, 0444);
>>   MODULE_PARM_DESC(force_pid_filter_usage, "force all dvb-usb-devices to use a PID filter, if any (default: 0).");
>>
>> +static int dvb_usb_clear_halt(struct dvb_usb_device *d, u8 endpoint)
> 
> I don't think this is a good function name; we are checking that the
> endpoint is correct and also clearing halts.
> 
> How about: dvb_usb_check_bulk_endpoint()

Sure, I'll do it in v2!

--
Thank,
Zheng Yejian

> 
> Looks good otherwise
> 
> Sean
> 
>> +{
>> +       if (endpoint) {
>> +               int ret;
>> +
>> +               ret = usb_pipe_type_check(d->udev, usb_sndbulkpipe(d->udev, endpoint));
>> +               if (ret)
>> +                       return ret;
>> +               ret = usb_pipe_type_check(d->udev, usb_rcvbulkpipe(d->udev, endpoint));
>> +               if (ret)
>> +                       return ret;
>> +               usb_clear_halt(d->udev, usb_sndbulkpipe(d->udev, endpoint));
>> +               usb_clear_halt(d->udev, usb_rcvbulkpipe(d->udev, endpoint));
>> +       }
>> +       return 0;
>> +}
>> +
>>   static int dvb_usb_adapter_init(struct dvb_usb_device *d, short *adapter_nrs)
>>   {
>>          struct dvb_usb_adapter *adap;
>> @@ -103,10 +120,12 @@ static int dvb_usb_adapter_init(struct dvb_usb_device *d, short *adapter_nrs)
>>           * when reloading the driver w/o replugging the device
>>           * sometimes a timeout occurs, this helps
>>           */
>> -       if (d->props.generic_bulk_ctrl_endpoint != 0) {
>> -               usb_clear_halt(d->udev, usb_sndbulkpipe(d->udev, d->props.generic_bulk_ctrl_endpoint));
>> -               usb_clear_halt(d->udev, usb_rcvbulkpipe(d->udev, d->props.generic_bulk_ctrl_endpoint));
>> -       }
>> +       ret = dvb_usb_clear_halt(d, d->props.generic_bulk_ctrl_endpoint);
>> +       if (ret)
>> +               goto frontend_init_err;
>> +       ret = dvb_usb_clear_halt(d, d->props.generic_bulk_ctrl_endpoint_response);
>> +       if (ret)
>> +               goto frontend_init_err;
>>
>>          return 0;
>>
>> --
>> Thanks,
>> Zheng Yejian
>>
>>> Thanks
>>>
>>> Sean
>>


