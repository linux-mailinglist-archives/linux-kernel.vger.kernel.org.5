Return-Path: <linux-kernel+bounces-78229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E72F861081
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1658E1F22C79
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB86A7B3DE;
	Fri, 23 Feb 2024 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VURsqpMD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AF67A725;
	Fri, 23 Feb 2024 11:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688200; cv=none; b=VAdAzv5NbQZpn8XNIuNmYjP1PC1r61rglnn8KqUnNOX6Z4qOChJ6SxSyBbAf8X53Xw2BwPb/xNtG0NCCIN120NGDQYCUdtdbYkgjkFphfFVKTpB44DFJhukx13YU/FrM3yXihT6qRuId4p/ODInU1LGcnVNIrNDGY3OO/cIxeSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688200; c=relaxed/simple;
	bh=rD5j6z4UXyN4KDu0BktxVBBRuPzEK0pA5vDMoVfxJxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rL/Ub5DX/GpYP0MeyBkfHiC8ounYHrTmE4FlAnNq6b1FlcVhSzxjEmsnYqO+wlGKqDha9T8il99d+rBMMZoyHA2aAMoiS8bPZcryn05+S8KJqByof7m0vFb1Eo8OPHsWy7m0RMwgFbe+io1EcoCa0nn5Z2Zl5B5edFM8/u5J/XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VURsqpMD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NBFOfj031519;
	Fri, 23 Feb 2024 11:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=5ir3WNsd+5toDv8bs5/TXD7VZCLRGGsdWGLbCSN2DQQ=; b=VU
	RsqpMDg2z7IahFTQ3pAbMaie1xgwwrMJE11nSYunFEZpkCfiMjOB5DWVfdW/Ai3Q
	wkHRKl1n9aRBTJ2als03nLsHR+pZfXPlILQFNf+nsSnR+d6Pw+SgKJVArJto2efJ
	vy1dvd8CYR57bACkpxk37U3mn4FeXbpv2o8LS9wwpHsg4Nh08LLE6DfTqm+60zny
	jJH+ndEFLua8ofEKyIw9jcIpo81cL+OeXI0z2lmCYArxYewMrWrfEtDXRy2OUJEE
	mtfaZMkqdW1VWKNPMWMXPg//QjIcHJBjYDtL9HK87nwc4V/ho+GJNK5YknD6YitC
	QlwigPvVYMBoH7xEcZcA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wekverxjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 11:36:16 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NBaFkL023154
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 11:36:15 GMT
Received: from [10.217.218.85] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 03:36:10 -0800
Message-ID: <d2f40e2d-cbbd-41f9-9aa6-41d0f251ffda@quicinc.com>
Date: Fri, 23 Feb 2024 17:05:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: f_fs: Fix NULL pointer dereference in
 ffs_epfile_async_io_complete()
To: Greg KH <gregkh@linuxfoundation.org>
CC: <brauner@kernel.org>, <axboe@kernel.dk>, <jack@suse.cz>,
        <jlayton@kernel.org>, <keescook@chromium.org>, <peter@korsgaard.com>,
        <hayama@lineo.co.jp>, <dmantipov@yandex.ru>,
        <quic_linyyuan@quicinc.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_jackp@quicinc.com>
References: <20240223054809.2379-1-quic_selvaras@quicinc.com>
 <2024022302-routine-schematic-b4fd@gregkh>
Content-Language: en-US
From: Selvarasu Ganesan <quic_selvaras@quicinc.com>
In-Reply-To: <2024022302-routine-schematic-b4fd@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vbfXIqZrfokxrUvaLB29KADRC0BcAcxR
X-Proofpoint-ORIG-GUID: vbfXIqZrfokxrUvaLB29KADRC0BcAcxR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230083


On 2/23/2024 11:28 AM, Greg KH wrote:
> On Thu, Feb 22, 2024 at 09:48:09PM -0800, Selvarasu Ganesan wrote:
>> In scenarios of continuous and parallel usage of multiple FFS interfaces
>> and concurrent adb operations (e.g., adb root, adb reboot), there's a
>> chance that ffs_epfile_async_io_complete() might be processed after
>> ffs_epfile_release(). This could lead to a NULL pointer dereference of
>> ffs when accessing the ffs pointer in ffs_epfile_async_io_complete(), as
>> ffs is freed as part of ffs_epfile_release(). This epfile release is
>> part of file operation and is triggered when user space daemons restart
>> themselves or a reboot is initiated.
>>
>> Fix this issue by adding a NULL pointer check for ffs in
>> ffs_epfile_async_io_complete().
>>
>> [  9981.393115] Unable to handle kernel NULL pointer dereference at virtual address 00000000000001e0
>> [  9981.402854] Mem abort info:
>> ...
>> [  9981.532540] Hardware name: Qualcomm Technologies,
>> [  9981.540579] pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [  9981.548438] pc : ffs_epfile_async_io_complete+0x38/0x4c
>> [  9981.554529] lr : usb_gadget_giveback_request+0x30/0xd0
>> ...
>> [  9981.645057] Call trace:
>> [  9981.648282]  ffs_epfile_async_io_complete+0x38/0x4c
>> [  9981.654004]  usb_gadget_giveback_request+0x30/0xd0
>> [  9981.659637]  dwc3_gadget_endpoint_trbs_complete+0x1a8/0x48c
>> [  9981.666074]  dwc3_process_event_entry+0x378/0x648
>> [  9981.671622]  dwc3_process_event_buf+0x6c/0x288
>> [  9981.676903]  dwc3_thread_interrupt+0x3c/0x68
>> [  9981.682003]  irq_thread_fn+0x2c/0x8c
>> [  9981.686388]  irq_thread+0x198/0x2ac
>> [  9981.690685]  kthread+0x154/0x218
>> [  9981.694717]  ret_from_fork+0x10/0x20
>>
>> Signed-off-by: Selvarasu Ganesan <quic_selvaras@quicinc.com>
> 
> What commit id does this fix?  Should it go to stable kernels?

Fixes: 2e4c7553cd6f9 ("usb: gadget: f_fs: add aio support"). Yes it's
required to propagate to stable kernel as well.
> 
>> ---
>>   drivers/usb/gadget/function/f_fs.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
>> index be3851cffb73..d8c8e88628f9 100644
>> --- a/drivers/usb/gadget/function/f_fs.c
>> +++ b/drivers/usb/gadget/function/f_fs.c
>> @@ -849,7 +849,9 @@ static void ffs_epfile_async_io_complete(struct usb_ep *_ep,
>>   	usb_ep_free_request(_ep, req);
>>   
>>   	INIT_WORK(&io_data->work, ffs_user_copy_worker);
>> -	queue_work(ffs->io_completion_wq, &io_data->work);
>> +
>> +	if (ffs && ffs->io_completion_wq)
>> +		queue_work(ffs->io_completion_wq, &io_data->work);
> 
> What happens if ffs->io_compleation_wq goes away right after you test
> it but before you call queue_work()?
> 
> Where is the locking here to prevent that?
> 
> thanks,
> 
> greg k-h

Hi Greg,

Thank you for your feedback. I understand your concern about the
potential race condition with ffs->io_completion_wq. I’m considering
introducing a lock to protect this section of the code, but I wanted to
get your opinion on this.
In the f_fs.c driver, there are pre-existing locks. Would it be suitable 
to utilize these locks, or do you suggest the creation of a new lock 
specifically for ffs->io_completion_wq? We anticipate a performance 
impact if we use the existing lock, as it might be held by different
threads. What are your thoughts on this?"

Here’s what the code might look like with a new lock:

static void ffs_epfile_async_io_complete(struct usb_ep *_ep,
                                          struct usb_request *req)
{
...
spin_lock(&ffs->new_lock);
if (ffs && ffs->io_completion_wq)
     queue_work(ffs->io_completion_wq, &io_data->work);
spin_unlock(&ffs->new_lock);
...
}



static void ffs_data_put(struct ffs_data *ffs) {
..
destroy_workqueue(ffs->io_completion_wq);
kfree(ffs->dev_name);
spin_lock(&ffs->new_lock);
kfree(ffs);
spin_unlock(&ffs->new_lock);
..
}

Thanks,
Selva


