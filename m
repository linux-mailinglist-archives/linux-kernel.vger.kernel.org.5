Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88DF7D3707
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjJWMl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjJWMlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:41:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9E5FD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 05:41:48 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NCe8k0004395;
        Mon, 23 Oct 2023 12:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Kp4OxFjE+FNYxFP92ePUQAsNGdfB5oDi+bfX/2aSlG8=;
 b=NDhF3RVzXINMlX3BGNkO5+V0MLiwvzYju0K6dRFK2Upsl25vISSbUgynybCJs8itA4ml
 XGnf8JFhzyTbuFhzt4mWw0Gd0uSIIyY1qzPUCPJY11VrjLx4NVbg8kktXgRFFiF+icNe
 8V8dyo4+iCCseHM5TZIPUOl5T5Vtomfi6jVovLqLAhUyzwymhPaemhUa3MaejMX+35oX
 rTv1olKcts5/YYPuwb6RfElYnkIpFyzehfa5/pbDdlZPK/2S7KXSc4MaCUJFO0UsH31a
 ulZrRtLE9S+twQB+td+OiE0yF9GoIMHBd4L+sMU2bvJKUHk4SXNY2Gc73+05RqpMIiyW eg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv7u3vb0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 12:41:27 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39NCfQvp015397
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 12:41:26 GMT
Received: from [10.216.32.116] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 23 Oct
 2023 05:41:22 -0700
Message-ID: <a0c294e1-f76a-6382-ee0f-f1d75ac9d781@quicinc.com>
Date:   Mon, 23 Oct 2023 18:11:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] firmware_loader: Abort new fw load request once
 firmware core knows about reboot
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     <russell.h.weight@intel.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <1696482420-1329-1-git-send-email-quic_mojha@quicinc.com>
 <ZTF+QLjm8ceL9a00@bombadil.infradead.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <ZTF+QLjm8ceL9a00@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S-A4xjP8BQ-hbobYPks-LefGI3xoG19X
X-Proofpoint-ORIG-GUID: S-A4xjP8BQ-hbobYPks-LefGI3xoG19X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230109
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2023 12:36 AM, Luis Chamberlain wrote:
> On Thu, Oct 05, 2023 at 10:37:00AM +0530, Mukesh Ojha wrote:
>> There could be following scenario where there is a ongoing reboot
>> is going from processA which tries to call all the reboot notifier
>> callback and one of them is firmware reboot call which tries to
>> abort all the ongoing firmware userspace request under fw_lock but
>> there could be another processB which tries to do request firmware,
>> which came just after abort done from ProcessA and ask for userspace
>> to load the firmware and this can stop the ongoing reboot ProcessA
>> to stall for next 60s(default timeout) which may not be expected
>> behaviour everyone like to see, instead we should abort any firmware
>> load request which came once firmware knows about the reboot through
>> notification.
>>
>>        ProcessA                             ProcessB
>>
>> kernel_restart_prepare
>>    blocking_notifier_call_chain
>>     fw_shutdown_notify
>>       kill_pending_fw_fallback_reqs
>>        __fw_load_abort
>>         fw_state_aborted	               request_firmware
>>           __fw_state_set                 firmware_fallback_sysfs
>> ...                                       fw_load_from_user_helper
>> ..                                         ...
>> .                                          ..
>>                                              usermodehelper_read_trylock
>>                                               fw_load_sysfs_fallback
>>                                                fw_sysfs_wait_timeout
>> usermodehelper_disable
>>   __usermodehelper_disable
>>    down_write()
>>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>> Changes from v2: https://lore.kernel.org/lkml/1696431327-7369-1-git-send-email-quic_mojha@quicinc.com/
>>   - Renamed the flag to fw_abort_load.
>>
>> Changes from v1: https://lore.kernel.org/lkml/1694773288-15755-1-git-send-email-quic_mojha@quicinc.com/
>>   - Renamed the flag to fw_load_abort.
>>   - Kept the flag under fw_lock.
>>   - Repharsed commit text.
>>
>>   drivers/base/firmware_loader/fallback.c | 6 +++++-
>>   drivers/base/firmware_loader/firmware.h | 1 +
>>   drivers/base/firmware_loader/main.c     | 1 +
>>   3 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
>> index bf68e3947814..a162020e98f2 100644
>> --- a/drivers/base/firmware_loader/fallback.c
>> +++ b/drivers/base/firmware_loader/fallback.c
>> @@ -57,6 +57,10 @@ void kill_pending_fw_fallback_reqs(bool only_kill_custom)
> 
> This routine uses a bool for only_kill_custom for when the events we
> should kill ar ecustom or not. Piggy backing on it to assume that the
> negative of value represents a shutdown is abusing the semantics
> and muddies the waters. So to avoid that, just extend the arguments
> to kill_pending_fw_fallback_reqs() for a new bool shutdown, that allows
> the code to be clearer and the intent is kept clear.

Let me understand what does 'only_kill_custom' do,

1. It gets called from reboot notifier where it's default value is 
false. So, the intention here is to kill all the ongoing request along
with !buf->need_uevent ?

commit c4b768934be613fb882e4e4090946218d76c8e1b
Author: Luis R. Rodriguez <mcgrof@kernel.org>
Date:   Tue May 2 01:31:03 2017 -0700

     firmware: share fw fallback killing on reboot/suspend

     We kill pending fallback requests on suspend and reboot,
     the only difference is that on suspend we only kill custom
     fallback requests. Provide a wrapper that lets us customize
     the request with a flag.

     This also lets us simplify the #ifdef'ery over the calls.

     Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

2. The second call is from fw_pm_notify() which is only
interested in aborting non-uevent calls.

And in this patch since, we are calling it from reboot which is the 
first case, so piggybacking on the 'only_kill_custom' would be fine for 
this patch. However, if you think we should rename this
'only_kill_custom' to something like its inverse 'kill_all' and reverse 
the below check to be more meaningful now ?

    		if (kill_all || !fw_priv->need_uevent)

> 
>>   		if (!fw_priv->need_uevent || !only_kill_custom)
>>   			 __fw_load_abort(fw_priv);
>>   	}
>> +
>> +	if (!only_kill_custom)
>> +		fw_abort_load = true;
>> +
>>   	mutex_unlock(&fw_lock);
>>   }
>>   
>> @@ -86,7 +90,7 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
>>   	}
>>   
>>   	mutex_lock(&fw_lock);
>> -	if (fw_state_is_aborted(fw_priv)) {
>> +	if (fw_abort_load || fw_state_is_aborted(fw_priv)) {
> 
> However, do we really need this ? Could we just use:
> 
> if (system_state == SYSTEM_HALT ||
>      system_state == SYSTEM_POWER_OFF ||
>      system_state == SYSTEM_RESTART ||
>      fw_state_is_aborted(fw_priv))
> 
> ?

There is slight window where system_state is not yet set and other
reboot notifiers after firmware one are running with ongoing
request_firmware().

-Mukesh

> 
>    Luis
