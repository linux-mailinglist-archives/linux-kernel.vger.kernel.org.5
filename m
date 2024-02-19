Return-Path: <linux-kernel+bounces-71575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A44E085A73B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C958A1C22822
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CAB39FC1;
	Mon, 19 Feb 2024 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LFCePNxG"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92B539AC6
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355968; cv=none; b=bTeq+17ezkAW5h7dMSVUHcQEa0Y3E0pP9Q3208Pz1PlH/lB2XKB7wykA/fHSKRiwxmMcGYbcwXhrnmmOLFOdAMZ8HVYp30GEncnuZ41Extlg/bQkObSu5etPMgi+drmGGvc1YjlahVNZoCSs50Uxz2VYTaHWVAl1crtu9lpuwLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355968; c=relaxed/simple;
	bh=2ftRL6ak6vNWy26XU5huffGC5jlMFBcle07fPPhlgMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rzs7pFYiPWFCQWr/woC7Qm/hmA2KToyYHsnv5OuDBpgrEVfCwO80LukdPavTCmWGZoOzBODUNDP4Ay7gL+IjMqLHe/33T6xdzTr6zlFBCtItE8d9cptNtu3pjcyxa3woWi37bARysVESfzFVIxs8grQe//J8vgotpWkhltvL5ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LFCePNxG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JF0tbI026387;
	Mon, 19 Feb 2024 15:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=yVGjdmY5iAHugXQNWJ8/Fw9WYRlDYQRwbAMRx27rxPM=;
 b=LFCePNxGdnySouVA2yXL6+Qi29ZtkUS0RrO4zeIIXkC5MKTbZfm3D3/y99NCVTJ3w0tS
 a37pdUHXfxHvlO3DwsLcUuHUinFkATgQ4PpASTzDUNJVCYKw+XYjSHDkWaWgGSKq6m/C
 XoxVAMiakJQEkWGndQnoDd2DzdrTxfRvCzOOC7X7BojSJdAqupCGynyYvQpk4fsmM7To
 V+AAijx5SCNKa9wv/PLm0TYtmNlMkZT2xupyasxf9fkRQ7lxkgfFzSoYTuPL7CxRWdCX
 BKNHF454FR8E7NXmsrli1LPvQJsBqQpBTRyyPU7+WsOLL+GscJ0oy9bce53DoU5FXYfa gA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wc81bb45x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 15:18:49 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41JF13sD027418;
	Mon, 19 Feb 2024 15:18:49 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wc81bb44f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 15:18:48 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41JDGDt5014406;
	Mon, 19 Feb 2024 15:18:47 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9u29dws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 15:18:47 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41JFIibA16450056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 15:18:47 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD66558067;
	Mon, 19 Feb 2024 15:18:44 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28C1858052;
	Mon, 19 Feb 2024 15:18:36 +0000 (GMT)
Received: from [9.109.245.191] (unknown [9.109.245.191])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Feb 2024 15:18:33 +0000 (GMT)
Message-ID: <3a64efcc-9a9d-4973-92f8-d76899f01868@linux.ibm.com>
Date: Mon, 19 Feb 2024 20:48:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mm/mempolicy: Avoid the fallthrough with MPOLD_BIND
 in mpol_misplaced.
Content-Language: en-US
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Aneesh Kumar <aneesh.kumar@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen
 <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Ben Widawsky <ben.widawsky@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz
 <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>
References: <9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com>
 <bf7e6779f842fb65cf7bb9b2c617feb2af271cb7.1708097962.git.donettom@linux.ibm.com>
 <ZdNDQUZrhz5kfR2f@tiehlicka>
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <ZdNDQUZrhz5kfR2f@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: U-OLzk4O98MX92nF8yp1-quPYt5Up4G6
X-Proofpoint-GUID: NJ0Rt-lau9wYBECklNCSjEcuji-DF5vn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_11,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402190114


On 2/19/24 17:32, Michal Hocko wrote:
> On Sat 17-02-24 01:31:34, Donet Tom wrote:
>> We will update MPOL_PREFERRED_MANY in the follow up patch. This change
>> is required for that.
> Why is it a separate patch then? Does it make review of the next patch
> easier? If so make it explicit in the changelog.

Hi Michal

In this patch there is no functional changes. This is just re-arrangement of code. Patch 3 is the actual fix .It will not look nice if we mix these patches. As you said it is easy for reviewing also. That's why we kept it as a separate patch.

Thanks
Donet Tom

>
>> Signed-off-by: Aneesh Kumar K.V (IBM) <aneesh.kumar@kernel.org>
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> ---
>>   mm/mempolicy.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>> index 8478574c000c..73d698e21dae 100644
>> --- a/mm/mempolicy.c
>> +++ b/mm/mempolicy.c
>> @@ -2515,7 +2515,15 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
>>   				break;
>>   			goto out;
>>   		}
>> -		fallthrough;
>> +
>> +		if (node_isset(curnid, pol->nodes))
>> +			goto out;
>> +		z = first_zones_zonelist(
>> +				node_zonelist(thisnid, GFP_HIGHUSER),
>> +				gfp_zone(GFP_HIGHUSER),
>> +				&pol->nodes);
>> +		polnid = zone_to_nid(z->zone);
>> +		break;
>>   
>>   	case MPOL_PREFERRED_MANY:
>>   		/*
>> -- 
>> 2.39.3

