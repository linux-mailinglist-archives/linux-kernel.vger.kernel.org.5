Return-Path: <linux-kernel+bounces-46772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C8F8443E7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA891C2594B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DBC12BF1B;
	Wed, 31 Jan 2024 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cfof2/Py"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A34112BEA3
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706717775; cv=none; b=aINdyw0ypp526iAQ2Cv35pTRcsyGAeSdC0r/ku2GDisvsXj/Pw1JsOsoktCJvo90OayyXzErev1lvKrWzceVn4tjXNTjU5DNVtozN+uIFgmeD5QfcL+5/8RteXnVcBw1PCsdTYkDWEsYCtcxoOKCFqQs05EcFrSDmXDBEWXUCu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706717775; c=relaxed/simple;
	bh=K4w2eD/Nw/bnRNiHzH+0J+mC5KbxK0RVGfacbJGGFkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VYGLeDMuvCOao+Rx5pB1Zk8WawqazDIKdL9NtkA51NGDGOOTJFD31bJGI3h2vDxnEIIPtOpRS8jYiu5YLTjWPhdKePM5IMZrwBjdtH9zIfWl5NlnpPNQVW3gaQAiNjTjUTe1HNETEsftna765Vqq5HnehvbnMS2SRLWaANK+474=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cfof2/Py; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40VAo2O0000809;
	Wed, 31 Jan 2024 16:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=WH5563ZO/RykTFOvNA8lFlTzHQix3H8A3XzmjIxPtso=; b=cf
	of2/Pyi25/1lRRoukGm8rwPudWKNOo8vQhA5eYU2T+KnOwgXipFM4kJD/XdF7v7b
	KcbCGlYLu/pl9qlIRZ8QyTQNBME7YWdJUQ85v1JgLN/iDjY4vrqls34RoK3MSeDv
	yzXEcVRx15fi8BqFuxmz7qZEwrHRj4B8QHEOYYZyZk7hBDVZHP5KbtgV7Zjcn3Wb
	teRgx93W8/7vZAbxe86o9l7CRfG3xbgn2dCJmgkmr8lWJf9jJVRyoGrIY1HUiEG5
	PVSb0KHuIppQ5bP8RTwXEU+UjACJDCc2//MIWtLeXNJtkBGES3jwOKubUuwSI8vo
	7v2FMI5S07cepXJzPt5g==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyjas136x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 16:16:04 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40VGG3us003374
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 16:16:03 GMT
Received: from [10.216.17.229] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 08:16:01 -0800
Message-ID: <ce6c33d4-e3c5-0b5d-aab8-e0ec57dcfe6c@quicinc.com>
Date: Wed, 31 Jan 2024 21:45:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] devcoredump: Remove the mutex serialization
Content-Language: en-US
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
CC: <linux-kernel@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki"
	<rafael@kernel.org>,
        Jose Souza <jose.souza@intel.com>
References: <20240126151121.1076079-1-rodrigo.vivi@intel.com>
 <20240126151121.1076079-2-rodrigo.vivi@intel.com>
 <e356adc5-937f-08ba-68bc-975ef96d6332@quicinc.com>
 <ZbkW-kJ8DTgCZphm@intel.com>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <ZbkW-kJ8DTgCZphm@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ctKI9J-jygvgF7m8e12EmhecpB3f_QCf
X-Proofpoint-ORIG-GUID: ctKI9J-jygvgF7m8e12EmhecpB3f_QCf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_09,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310125



On 1/30/2024 9:04 PM, Rodrigo Vivi wrote:
> On Tue, Jan 30, 2024 at 05:32:24PM +0530, Mukesh Ojha wrote:
>>
>>
>> On 1/26/2024 8:41 PM, Rodrigo Vivi wrote:
>>> The commit 01daccf74832 ("devcoredump : Serialize devcd_del work")
>>> introduced the mutex to protect the case where mod_delayed_work
>>> could be called before the delayed work even existed.
>>>
>>> Instead, we can simply initialize the delayed work before the device
>>> is added, so the race condition doesn't exist at first place.
>>>
>>> The mutex_unlock is very problematic here. Although mod_delayed_work
>>> is async, we have no warranty that the work is not finished before
>>> the mutex_unlock(devcd->mutex), and if that happen 'devcd' is used
>>> after freed.
>>
>> I agree, Mutex is bad and last time there was only a situation of UAF from
>> disable_store() and that can not occur as it keeps its ref, so
>> we went ahead with the change.,
> 
> my concern was with:
> 
> flush_delayed_work(&devcd->del_wk);
> mutex_unlock(&devcd->mutex);
> 
> at devcd_free().
> 
> flush_work always wait for the work to finish it's execution,
> which will delete the device.
> The with the release, the devcd should be gone soon and
> this is at risk of the UAF, no?
> 
> maybe I'm missing something.

Before your patch, the only place where flush_delayed_work()
used was devcd_free() and that is getting called from disabled_store()
is taking its own reference and due to which above UAF issue would not
happen from above path.

> 
> 
>>
>>>
>>> Cc: Mukesh Ojha <quic_mojha@quicinc.com>
>>> Cc: Johannes Berg <johannes@sipsolutions.net>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Rafael J. Wysocki <rafael@kernel.org>
>>> Cc: Jose Souza <jose.souza@intel.com>
>>> Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
>>> ---
>>>    drivers/base/devcoredump.c | 97 +++-----------------------------------
>>>    1 file changed, 6 insertions(+), 91 deletions(-)
>>>
>>> diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
>>> index 678ecc2fa242..0e26b1273920 100644
>>> --- a/drivers/base/devcoredump.c
>>> +++ b/drivers/base/devcoredump.c
>>> @@ -25,47 +25,6 @@ struct devcd_entry {
>>>    	struct device devcd_dev;
>>>    	void *data;
>>>    	size_t datalen;
>>> -	/*
>>> -	 * Here, mutex is required to serialize the calls to del_wk work between
>>> -	 * user/kernel space which happens when devcd is added with device_add()
>>> -	 * and that sends uevent to user space. User space reads the uevents,
>>> -	 * and calls to devcd_data_write() which try to modify the work which is
>>> -	 * not even initialized/queued from devcoredump.
>>> -	 *
>>> -	 *
>>> -	 *
>>> -	 *        cpu0(X)                                 cpu1(Y)
>>> -	 *
>>> -	 *        dev_coredump() uevent sent to user space
>>> -	 *        device_add()  ======================> user space process Y reads the
>>> -	 *                                              uevents writes to devcd fd
>>> -	 *                                              which results into writes to
>>> -	 *
>>> -	 *                                             devcd_data_write()
>>> -	 *                                               mod_delayed_work()
>>> -	 *                                                 try_to_grab_pending()
>>> -	 *                                                   del_timer()
>>> -	 *                                                     debug_assert_init()
>>> -	 *       INIT_DELAYED_WORK()
>>> -	 *       schedule_delayed_work()
>>> -	 *
>>> -	 *
>>> -	 * Also, mutex alone would not be enough to avoid scheduling of
>>> -	 * del_wk work after it get flush from a call to devcd_free()
>>> -	 * mentioned as below.
>>> -	 *
>>> -	 *	disabled_store()
>>> -	 *        devcd_free()
>>> -	 *          mutex_lock()             devcd_data_write()
>>> -	 *          flush_delayed_work()
>>> -	 *          mutex_unlock()
>>> -	 *                                   mutex_lock()
>>> -	 *                                   mod_delayed_work()
>>> -	 *                                   mutex_unlock()
>>> -	 * So, delete_work flag is required.
>>> -	 */
>>> -	struct mutex mutex;
>>> -	bool delete_work;
>>>    	struct module *owner;
>>>    	ssize_t (*read)(char *buffer, loff_t offset, size_t count,
>>>    			void *data, size_t datalen);
>>> @@ -125,13 +84,8 @@ static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
>>>    	struct device *dev = kobj_to_dev(kobj);
>>>    	struct devcd_entry *devcd = dev_to_devcd(dev);
>>> -	mutex_lock(&devcd->mutex);
>>> -	if (!devcd->delete_work) {
>>> -		devcd->delete_work = true;
>>> -		mod_delayed_work(system_wq, &devcd->del_wk, 0);
>>> -	}
>>> -	mutex_unlock(&devcd->mutex);
>>> -
>>> +	/* This file needs to be closed before devcd can be deleted */
>>> +	mod_delayed_work(system_wq, &devcd->del_wk, 0);
>>>    	return count;
>>>    }
>>> @@ -158,12 +112,7 @@ static int devcd_free(struct device *dev, void *data)
>>>    {
>>>    	struct devcd_entry *devcd = dev_to_devcd(dev);
>>> -	mutex_lock(&devcd->mutex);
>>> -	if (!devcd->delete_work)
>>> -		devcd->delete_work = true;
>>> -
>>>    	flush_delayed_work(&devcd->del_wk);
>>> -	mutex_unlock(&devcd->mutex);
>>>    	return 0;
>>>    }
>>> @@ -173,30 +122,6 @@ static ssize_t disabled_show(const struct class *class, const struct class_attri
>>>    	return sysfs_emit(buf, "%d\n", devcd_disabled);
>>>    }
>>> -/*
>>> - *
>>> - *	disabled_store()                                	worker()
>>> - *	 class_for_each_device(&devcd_class,
>>> - *		NULL, NULL, devcd_free)
>>> - *         ...
>>> - *         ...
>>> - *	   while ((dev = class_dev_iter_next(&iter))
>>> - *                                                             devcd_del()
>>> - *                                                               device_del()
>>> - *                                                                 put_device() <- last reference
>>> - *             error = fn(dev, data)                           devcd_dev_release()
>>> - *             devcd_free(dev, data)                           kfree(devcd)
>>> - *             mutex_lock(&devcd->mutex);
>>> - *
>>> - *
>>> - * In the above diagram, It looks like disabled_store() would be racing with parallely
>>> - * running devcd_del() and result in memory abort while acquiring devcd->mutex which
>>> - * is called after kfree of devcd memory  after dropping its last reference with
>>> - * put_device(). However, this will not happens as fn(dev, data) runs
>>> - * with its own reference to device via klist_node so it is not its last reference.
>>> - * so, above situation would not occur.
>>> - */
>>> -
>>>    static ssize_t disabled_store(const struct class *class, const struct class_attribute *attr,
>>>    			      const char *buf, size_t count)
>>>    {
>>> @@ -308,13 +233,7 @@ static void devcd_remove(void *data)
>>>    {
>>>    	struct devcd_entry *devcd = data;
>>> -	mutex_lock(&devcd->mutex);
>>> -	if (!devcd->delete_work) {
>>> -		devcd->delete_work = true;
>>> -		/* XXX: Cannot flush otherwise the mutex below will hit a UAF */
>>> -		mod_delayed_work(system_wq, &devcd->del_wk, 0);
>>> -	}
>>> -	mutex_unlock(&devcd->mutex);
>>> +	flush_delayed_work(&devcd->del_wk);
>>>    }
>>>    /**
>>> @@ -365,16 +284,15 @@ void dev_coredumpm(struct device *dev, struct module *owner,
>>>    	devcd->read = read;
>>>    	devcd->free = free;
>>>    	devcd->failing_dev = get_device(dev);
>>> -	devcd->delete_work = false;
>>> -	mutex_init(&devcd->mutex);
>>>    	device_initialize(&devcd->devcd_dev);
>>>    	dev_set_name(&devcd->devcd_dev, "devcd%d",
>>>    		     atomic_inc_return(&devcd_count));
>>>    	devcd->devcd_dev.class = &devcd_class;
>>> -	mutex_lock(&devcd->mutex);
>>> +	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
>>> +	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
>>
>> Last time, we discussed [1] here, involves a assumption
>> about timeout can not happen before device_add() succeeds.
>> It is rare but it is there.
>>
>> https://lore.kernel.org/all/87ilr15ekx.ffs@tglx/
> 
> hmm... I couldn't imagine a case where a device_add could
> take longer then 5 minutes, at least not without other bigger
> problems...
> 
> I'm wondering that multiple subsequent calls of dev_coredumpm()
> would fail to find the failing_device with the class_find_device
> and all, but maybe I'm overthinking here or missing something else.

There are two issue here which is described here,

1.

/*
  *
  *
  *        cpu0(X)                                 cpu1(Y)
  *
  *        dev_coredump() uevent sent to user space
  *        device_add()  ======================> user space process Y 
reads the
  *                                              uevents writes to devcd fd
  *                                              which results into 
writes to
  *
  *                                             devcd_data_write()
  *                                               mod_delayed_work()
  *                                                 try_to_grab_pending()
  *                                                   del_timer()
  *
  *       INIT_DELAYED_WORK()
  *       schedule_delayed_work()
  *


2.

  *
  *
  *      disabled_store()
  *        devcd_free()
  *          flush_delayed_work()
  *                                   devcd_data_write()
  *                                   mod_delayed_work()
  *
  *

But i think, we can further optimize the existing change to only protect
delete_work flag,


diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 7e2d1f0d903a..af2448da00f4 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -126,12 +126,14 @@ static ssize_t devcd_data_write(struct file *filp, 
struct kobject *kobj,
  	struct devcd_entry *devcd = dev_to_devcd(dev);

  	mutex_lock(&devcd->mutex);
-	if (!devcd->delete_work) {
-		devcd->delete_work = true;
-		mod_delayed_work(system_wq, &devcd->del_wk, 0);
+	if (devcd->delete_work) {
+		mutex_unlock(&devcd->mutex);
+		goto out;
  	}
+	devcd->delete_work = true;
  	mutex_unlock(&devcd->mutex);
-
+	mod_delayed_work(system_wq, &devcd->del_wk, 0);
+out:
  	return count;
  }

@@ -161,9 +163,9 @@ static int devcd_free(struct device *dev, void *data)
  	mutex_lock(&devcd->mutex);
  	if (!devcd->delete_work)
  		devcd->delete_work = true;
-
-	flush_delayed_work(&devcd->del_wk);
  	mutex_unlock(&devcd->mutex);
+	flush_delayed_work(&devcd->del_wk);
+
  	return 0;
  }

@@ -361,7 +363,6 @@ void dev_coredumpm(struct device *dev, struct module 
*owner,
  		     atomic_inc_return(&devcd_count));
  	devcd->devcd_dev.class = &devcd_class;

-	mutex_lock(&devcd->mutex);
  	dev_set_uevent_suppress(&devcd->devcd_dev, true);
  	if (device_add(&devcd->devcd_dev))
  		goto put_device;
@@ -377,15 +378,13 @@ void dev_coredumpm(struct device *dev, struct 
module *owner,
  		              "devcoredump"))
  		dev_warn(dev, "devcoredump create_link failed\n");

-	dev_set_uevent_suppress(&devcd->devcd_dev, false);
-	kobject_uevent(&devcd->devcd_dev.kobj, KOBJ_ADD);
  	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
  	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
-	mutex_unlock(&devcd->mutex);
+	dev_set_uevent_suppress(&devcd->devcd_dev, false);
+	kobject_uevent(&devcd->devcd_dev.kobj, KOBJ_ADD);
  	return;
   put_device:
  	put_device(&devcd->devcd_dev);
-	mutex_unlock(&devcd->mutex);
   put_module:
  	module_put(owner);
   free:


-Mukesh
> 
>>
>> -Mukesh
>>
>>>    	dev_set_uevent_suppress(&devcd->devcd_dev, true);
>>>    	if (device_add(&devcd->devcd_dev))
>>>    		goto put_device;
>>> @@ -392,15 +310,12 @@ void dev_coredumpm(struct device *dev, struct module *owner,
>>>    	dev_set_uevent_suppress(&devcd->devcd_dev, false);
>>>    	kobject_uevent(&devcd->devcd_dev.kobj, KOBJ_ADD);
>>> -	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
>>> -	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
>>>    	if (devm_add_action(dev, devcd_remove, devcd))
>>>    		dev_warn(dev, "devcoredump managed auto-removal registration failed\n");
>>> -	mutex_unlock(&devcd->mutex);
>>>    	return;
>>>     put_device:
>>> +	cancel_delayed_work(&devcd->del_wk);
>>>    	put_device(&devcd->devcd_dev);
>>> -	mutex_unlock(&devcd->mutex);
>>>     put_module:
>>>    	module_put(owner);
>>>     free:

