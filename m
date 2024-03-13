Return-Path: <linux-kernel+bounces-102325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E109387B0BB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59CDC1F23909
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7A25D732;
	Wed, 13 Mar 2024 18:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GGrGMGms"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59545D465;
	Wed, 13 Mar 2024 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352831; cv=none; b=i+5fN+R47GcJ1mz/ofF46ZNG2SSVO/Jks8u1EtGoolnIuZs97e5DSZuazOH6N3pV9zk2iFz0ALK69fKeJuY5iSp6I1iJpP0Kz1UkGEBO0KusISxsXQUjxJyxGrBS2wUM7bkUPHiAzJKKkxas4lDgO3YbY0F+OP20hg8WeFtLmfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352831; c=relaxed/simple;
	bh=f/qJOGVVS1Gvd2NRKATjXvuXafoO/6F/AH489rQFkPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bz9rQoMssql1FgkBE+PgUPr1ekG1pQ5La9qr9B5RI0vR2hCoaYRCg0MC/pytS5TBCsm3Dc//T8GKEkM+DLNLZSGU7AfeX+rYjH4QpzKUXcd2JOyhZ7077V0bbVpChcJZzmngOAzn2JZaorXp7Iqgxj2sSPCTXQWiEHW1WhQGYU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GGrGMGms; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42DGLFHN012921;
	Wed, 13 Mar 2024 18:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5ZxyfLrWJE3NWtW6iJbXxGrBK3/YAVcw7tJCTcEFdks=;
 b=GGrGMGms/HB8wx31h4+elQZ/zwa1MXLNrwyzLf6PXjbnvj5kkU4bKS+n7Dpv5lqxlfsX
 CrqkJ43PhlZGcwT1CW/1yD5wkY7U3UwQH/cs3YSACQJIAQEpLC7glsfYYtirg3njv34D
 Z+lyPwM9plgduuHyfkgnLy9Uhz8EZW3VhPLnl606On+3ewm0MjTvzJRuHD9nmTEmbsjr
 7alWYHKW0RB+kkR1Rh4Px6QJ85bVmjKOz2LqiblnvRvejUIj7q0s6j2U5t+Lr9frPoSb
 OnTP7qDQF/ks0g5XCn+UXj1vj27xdKZk4fSu4m8IFWzEvr8jQQtb37z/ym2ygoFaHw10 QQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wue9ttuq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 18:00:27 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42DFZZYS015477;
	Wed, 13 Mar 2024 18:00:26 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws2fyyrnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 18:00:26 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42DI0Nid31785284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 18:00:25 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9FD158083;
	Wed, 13 Mar 2024 18:00:21 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8DA358060;
	Wed, 13 Mar 2024 18:00:20 +0000 (GMT)
Received: from [9.61.156.225] (unknown [9.61.156.225])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Mar 2024 18:00:20 +0000 (GMT)
Message-ID: <37d91598-0198-49e1-1008-6028ad78c1e5@linux.ibm.com>
Date: Wed, 13 Mar 2024 14:00:20 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 4/5] s390/vfio-ap: Add write support to sysfs attr
 ap_config
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
        agordeev@linux.ibm.com, gor@linux.ibm.com
References: <20240306140843.10782-1-jjherne@linux.ibm.com>
 <20240306140843.10782-5-jjherne@linux.ibm.com>
 <0389f521-e9e2-43d4-8d78-87695853a536@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <0389f521-e9e2-43d4-8d78-87695853a536@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1FkFoXoVKYBuOBEOhjMyy5jnM77_GG3w
X-Proofpoint-GUID: 1FkFoXoVKYBuOBEOhjMyy5jnM77_GG3w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403130137

On 3/11/24 2:15 PM, Anthony Krowiak wrote:
> 
> On 3/6/24 9:08 AM, Jason J. Herne wrote:
>> Allow writing a complete set of masks to ap_config. Doing so will
>> cause the vfio-ap driver to replace the vfio-ap mediated device's entire
>> state with the given set of masks. If the given state cannot be set, then
> 
> 
> Just a nit, but it will not replace the vfio_ap mdev's entire state; it 
> will replace the masks that comprise the matrix and control_domain 
> attributes which comprise the guest's AP configuration profile (or the 
> masks identifying the adapters, domains and control domains which a 
> guest has permission to access). The guest_matrix attribute may or may 
> not match the masks written via this sysfs interface.
> 
> 

Fixed in v3.

>> no changes are made to the vfio-ap mediated device.
>>
>> The format of the data written to ap_config is as follows:
>> {amask},{dmask},{cmask}\n
>>
>> \n is a newline character.
>>
>> amask, dmask, and cmask are masks identifying which adapters, domains,
>> and control domains should be assigned to the mediated device.
>>
>> The format of a mask is as follows:
>> 0xNN..NN
>>
>> Where NN..NN is 64 hexadecimal characters representing a 256-bit value.
>> The leftmost (highest order) bit represents adapter/domain 0.
> 
> 
> I won't reject giving an r-b for the above, but could be more 
> informative; maybe more along the lines of how this is described in all 
> documentation:
> 

Leaving as is. It gets the point across.

> Where NN..NN is 64 hexadecimal characters comprising a bitmap containing 
> 256 bits. Each bit, from left
> 
> to right, corresponds to a number from 0 to 255. If a bit is set, the
> 
> corresponding adapter, domain or control domain is assigned to the 
> vfio_ap mdev.
> 
> You could also mention that setting an adapter or domain number greater 
> than the maximum allowed for
> 
> for the system will result in an error.
> 
> 

I feel like the description is long enough for a commit message. Maybe 
this would be more at home in the doc patch.

>>
>> For an example set of masks that represent your mdev's current
>> configuration, simply cat ap_config.
>>
>> This attribute is intended to be used by an mdevctl callout script
>> supporting the mdev type vfio_ap-passthrough to atomically update a
>> vfio-ap mediated device's state.
>>
>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c     | 172 ++++++++++++++++++++++++--
>>   drivers/s390/crypto/vfio_ap_private.h |   6 +-
>>   2 files changed, 162 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>> b/drivers/s390/crypto/vfio_ap_ops.c
>> index 259130347d00..c382e46f620f 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -1106,19 +1106,22 @@ static void vfio_ap_mdev_unlink_adapter(struct 
>> ap_matrix_mdev *matrix_mdev,
>>       }
>>   }
>> -static void vfio_ap_mdev_hot_unplug_adapter(struct ap_matrix_mdev 
>> *matrix_mdev,
>> -                        unsigned long apid)
>> +static void vfio_ap_mdev_hot_unplug_adapters(struct ap_matrix_mdev 
>> *matrix_mdev,
>> +                        unsigned long *apids)
>>   {
>>       struct vfio_ap_queue *q, *tmpq;
>>       struct list_head qlist;
>> +    unsigned long apid;
>>       INIT_LIST_HEAD(&qlist);
>> -    vfio_ap_mdev_unlink_adapter(matrix_mdev, apid, &qlist);
>> -    if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm)) {
>> -        clear_bit_inv(apid, matrix_mdev->shadow_apcb.apm);
>> -        vfio_ap_mdev_update_guest_apcb(matrix_mdev);
>> +    for_each_set_bit_inv(apid, apids, AP_DEVICES) {
>> +        vfio_ap_mdev_unlink_adapter(matrix_mdev, apid, &qlist);
>> +
>> +        if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm))
>> +            clear_bit_inv(apid, matrix_mdev->shadow_apcb.apm);
>>       }
>> +    vfio_ap_mdev_update_guest_apcb(matrix_mdev);
> 
> 
> I wouldn't do the hot plug unless at least one of the APIDs in the apids 
> parameter is assigned to matrix_mdev->shadow_apcb. The 
> vfio_ap_mdev_update_guest_apcb function calls the 
> kvm_arch_crypto_set_masks function which takes the guest's VCPUs out of 
> SIE, copies the apm/aqm/adm from matrix_mdev->shadow_apcb to the APCB in 
> the SIE state description, then restores the VCPUs to SIE. If no changes 
> have been made to matrix_mdev->shadow_apcb, then it doesn't make sense 
> to impact the guest in such a manner. So maybe something like this:
> 
> if (bitmap_intersects(apids, matrix_mdev->shadow_apcb.apm, AP_DEVICES))
> 
>          vfio_ap_mdev_update_guest_apcb(matrix_mdev)
> 

Fixed in v3.

> 
>>       vfio_ap_mdev_reset_qlist(&qlist);
>> @@ -1128,6 +1131,15 @@ static void 
>> vfio_ap_mdev_hot_unplug_adapter(struct ap_matrix_mdev *matrix_mdev,
>>       }
>>   }
>> +static void vfio_ap_mdev_hot_unplug_adapter(struct ap_matrix_mdev 
>> *matrix_mdev,
>> +                        unsigned long apid)
>> +{
>> +    DECLARE_BITMAP(apids, AP_DEVICES);
> 
> 
> I'm not sure about this, but should the apids bitmap be zeroed out?
> 
> memset(apids, 0, sizeof(apids));
> 

I would think it is not needed, but I do see precent in other code so it 
is better to be safe here I think. I'll add this for v3. I'll use 
bitmap_zero, however, instead of memeset.

>> +
>> +    set_bit_inv(apid, apids);
>> +    vfio_ap_mdev_hot_unplug_adapters(matrix_mdev, apids);
>> +}
>> +
>>   /**
>>    * unassign_adapter_store - parses the APID from @buf and clears the
>>    * corresponding bit in the mediated matrix device's APM
>> @@ -1288,19 +1300,22 @@ static void vfio_ap_mdev_unlink_domain(struct 
>> ap_matrix_mdev *matrix_mdev,
>>       }
>>   }
>> -static void vfio_ap_mdev_hot_unplug_domain(struct ap_matrix_mdev 
>> *matrix_mdev,
>> -                       unsigned long apqi)
>> +static void vfio_ap_mdev_hot_unplug_domains(struct ap_matrix_mdev 
>> *matrix_mdev,
>> +                       unsigned long *apqis)
>>   {
>>       struct vfio_ap_queue *q, *tmpq;
>>       struct list_head qlist;
>> +    unsigned long apqi;
>>       INIT_LIST_HEAD(&qlist);
>> -    vfio_ap_mdev_unlink_domain(matrix_mdev, apqi, &qlist);
>> -    if (test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm)) {
>> -        clear_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm);
>> -        vfio_ap_mdev_update_guest_apcb(matrix_mdev);
>> +    for_each_set_bit_inv(apqi, apqis, AP_DOMAINS) {
>> +        vfio_ap_mdev_unlink_domain(matrix_mdev, apqi, &qlist);
>> +
>> +        if (test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm))
>> +            clear_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm);
>>       }
>> +    vfio_ap_mdev_update_guest_apcb(matrix_mdev);
> 
> 
> Same comment here as for vfio_ap_mdev_hot_unplug_adapters function.
> 
> 

Fixed in v3.

>>       vfio_ap_mdev_reset_qlist(&qlist);
>> @@ -1310,6 +1325,15 @@ static void 
>> vfio_ap_mdev_hot_unplug_domain(struct ap_matrix_mdev *matrix_mdev,
>>       }
>>   }
>> +static void vfio_ap_mdev_hot_unplug_domain(struct ap_matrix_mdev 
>> *matrix_mdev,
>> +                       unsigned long apqi)
>> +{
>> +    DECLARE_BITMAP(apqis, AP_DOMAINS);
> 
> 
> See comment/question in vfio_ap_mdev_hot_unplug_adapter function.
> 
> 
Fixed in v3.
>> +
>> +    set_bit_inv(apqi, apqis);
>> +    vfio_ap_mdev_hot_unplug_domains(matrix_mdev, apqis);
>> +}
>> +
>>   /**
>>    * unassign_domain_store - parses the APQI from @buf and clears the
>>    * corresponding bit in the mediated matrix device's AQM
>> @@ -1577,10 +1601,132 @@ static ssize_t ap_config_show(struct device 
>> *dev, struct device_attribute *attr,
>>       return idx;
>>   }
>> +/* Number of characters needed for a complete hex mask representing 
>> the bits in ..  */
>> +#define AP_DEVICES_STRLEN    (AP_DEVICES/4 + 3)
>> +#define AP_DOMAINS_STRLEN    (AP_DOMAINS/4 + 3)
>> +#define AP_CONFIG_STRLEN    (AP_DEVICES_STRLEN + 2 * AP_DOMAINS_STRLEN)
>> +
>> +static int parse_bitmap(char **strbufptr, unsigned long *bitmap, int 
>> nbits)
>> +{
>> +    char *curmask;
>> +
>> +    curmask = strsep(strbufptr, ",\n");
>> +    if (!curmask)
>> +        return -EINVAL;
>> +
>> +    bitmap_clear(bitmap, 0, nbits);
>> +    return ap_hex2bitmap(curmask, bitmap, nbits);
>> +}
>> +
>> +static int ap_matrix_length_check(struct ap_matrix_mdev *matrix_mdev)
> 
> 
> We're not really checking the matrix length here, we're checking whether 
> any set bits exceed that maximum value, so maybe something like:
> 
> ap_matrix_max_bitnum_check(struct ap_matrix_mdev *matrix_mdev)?
> 
> Not critical though.
> 
> 

Renaming to ap_matrix_overflow_check for v3. That name is more concise 
in my opinion.

