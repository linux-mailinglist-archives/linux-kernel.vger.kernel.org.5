Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA8479C236
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbjILCH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238288AbjILCCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:02:33 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29C8179D99
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:33:36 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BMcqCO020075;
        Mon, 11 Sep 2023 22:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=aNgBgv9OnusrgebcCk0iaXwksweRjqepyQABV/DjNqw=;
 b=PwaMAhcI1hdAEASKo1Xa3u6bPYA4CWN6otLl3pg1VdrwLR5jeEdBK9Dv3e17WyvzGBjU
 5RjMNSeuGQkUOAkR6206W2MqxnTqpcoau6AYosSTci2NhggIbXyNbEeCI5/0MXvYzT4R
 ojUXX5EQQQkwtDOFj5tDY+qVxT/dayLncY/n87OxpGVNQg8NWoXtcsg/Rei+jsD544pj
 uwNYq1pwURodbT3wxTsZKFOi5XH7w8lvl/lZ9mDNVisWP1GfkZ9KUJrjs+4/PFf4d2ts
 ymCKrEShbvju6DJ7FSZjUJsvdDhd/hK0FEtxX6yTIr03DnVOppfZtrHoJmQ6l9DJxU3X Zw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2a9qj5wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 22:40:44 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38BKc2tv002304;
        Mon, 11 Sep 2023 22:40:43 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t158jwxa4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 22:40:43 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38BMeguT20906448
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 22:40:43 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E07675805D;
        Mon, 11 Sep 2023 22:40:42 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A255158052;
        Mon, 11 Sep 2023 22:40:42 +0000 (GMT)
Received: from [9.61.88.151] (unknown [9.61.88.151])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 11 Sep 2023 22:40:42 +0000 (GMT)
Message-ID: <73ba1505-d619-466e-981a-badb2658e6cb@linux.ibm.com>
Date:   Mon, 11 Sep 2023 17:40:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] fsi: sbefifo: Validate pending user write
To:     Joel Stanley <joel@jms.id.au>, eajames@linux.ibm.com
Cc:     jk@ozlabs.org, alistair@popple.id.au, linux-fsi@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20230907221016.2978802-1-ninad@linux.ibm.com>
 <20230907221016.2978802-3-ninad@linux.ibm.com>
 <CACPK8XcUkwNS85Ept62xyCabELHO9xTdMYvxVg2W+GZfAxTa3A@mail.gmail.com>
Content-Language: en-US
From:   Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <CACPK8XcUkwNS85Ept62xyCabELHO9xTdMYvxVg2W+GZfAxTa3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FCy-hNz47PhGTfzDvErvaY40I0Xkr7hN
X-Proofpoint-ORIG-GUID: FCy-hNz47PhGTfzDvErvaY40I0Xkr7hN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_18,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309110207
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On 9/11/23 00:52, Joel Stanley wrote:
> On Thu, 7 Sept 2023 at 22:10, Ninad Palsule <ninad@linux.ibm.com> wrote:
>> This commit fails user write operation if previous write operation is
>> still pending.
>>
>> As per the driver design write operation only prepares the buffer, the
>> actual FSI write is performed on next read operation. so if buggy
>> application sends two back to back writes or two parallel writes then
>> that could cause memory leak.
> The driver already has this code:
Yes, I have improved the comment.
>
>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>>   drivers/fsi/fsi-sbefifo.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
>> index b771dff27f7f..824e2a921a25 100644
>> --- a/drivers/fsi/fsi-sbefifo.c
>> +++ b/drivers/fsi/fsi-sbefifo.c
>> @@ -874,6 +874,12 @@ static ssize_t sbefifo_user_write(struct file *file, const char __user *buf,
>>
>>          mutex_lock(&user->file_lock);
>>
>> +       /* Previous write is still in progress */
>> +       if (user->pending_cmd) {
>> +               mutex_unlock(&user->file_lock);
>> +               return -EALREADY;
> That's an unusual return code. I guess it makes sense in this context.
>
> It's good to fix the potential memory leak, and we should add code to
> catch that case.
>
> This will change the behaviour of the character device from "overwrite
> the previous operation" to "reject operation until a read is
> performed". Do you think there's existing code that depends on the old
> behaviour?
I do not see any issue with this rejection. I thought user may wants to 
send reset while command is hung but that case is not valid as pending 
command will hold the lock. User can always close the connection and 
reopen if required. How do I find if this could cause the regression?
>
>> +       }
>> +
>>          /* Can we use the pre-allocate buffer ? If not, allocate */
>>          if (len <= PAGE_SIZE)
>>                  user->pending_cmd = user->cmd_page;
>> --
>> 2.39.2
>>
