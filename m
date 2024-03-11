Return-Path: <linux-kernel+bounces-98532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC00877B96
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5641F1C2034A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A8512E48;
	Mon, 11 Mar 2024 08:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PisB96aa"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CF712B70
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710145070; cv=none; b=vDfF66WzUsLHOfSxmusAn7eA7jXNH2lzneqqaQin1NnLq1b8vABcJ1//raH5zGCH0rPUrCW8JW+jLxVIwZYywGyrgiUbYL+XeX5XBDhjpn7x1Hk3Cz5zo2eU2xgHUl2r2yFUeVWhWUL1yfTu8bGlg6nQfNmeAO+br3q8m9iFAV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710145070; c=relaxed/simple;
	bh=m1fQ2UlKJYrIhYEsV9snpND9AtrXOdk71ETIefhjfW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hr8UO+TD67GdoxmU5gaEKkTizCqGapipNxqZnGp6b7ykYc0YPRRMSQ2CYWmK1yVCb6nA6Tz06c/h7Aw8gmoPQPbcmKLir3F/ALta2LRnHZaBnjHvojaF/WUK9TPg5nGiDXaddAayeMZtX30nJKJuvHtSHI0wrUkcMMFDWePVOaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PisB96aa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42B74wlU005037;
	Mon, 11 Mar 2024 08:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Hcp6eEMzpC930Ztzxwb++L0eluwabU2RKzsvkdv2/sw=;
 b=PisB96aacZ6wWGfC/A8SHJlxJPWLZYyvHmXyjnlXCNiVv1tJKlBPP7+znGtqYzPHLi3P
 Adn3gtOCKZM0JG6okErizbOYKrru5dMMcbrilVUPJbvoXb4Di2UHyiaWpUQBYQzuuPmZ
 VpjLmxiwS3E2obcDYL9Y7iUhykPakkHYb8WXPCwVBqmtACidhP8rUQvuUulrPlj/wXK2
 aCslp8AUYzCG98qh/z1JjWbE4LvbbfxQQiBMq5WRiFhZxkLMhYtUvb1TGzKfKAla89Fc
 BdASilh/QKPQvaGZu9vBehHGEzIayS3dAKKJJZCYdCcVXaNhTah/JvcRD7/FWcueGf3U +A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wsw8n12pt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 08:17:29 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42B8HTBD032685;
	Mon, 11 Mar 2024 08:17:29 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wsw8n12pm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 08:17:29 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42B6fO0b018112;
	Mon, 11 Mar 2024 08:17:28 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws23syhrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 08:17:28 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42B8HPj848169234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 08:17:27 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1B7458062;
	Mon, 11 Mar 2024 08:17:25 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67F7E5805C;
	Mon, 11 Mar 2024 08:17:23 +0000 (GMT)
Received: from [9.124.31.199] (unknown [9.124.31.199])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Mar 2024 08:17:23 +0000 (GMT)
Message-ID: <f14bf408-8a6d-4213-b922-82f1e8782609@linux.ibm.com>
Date: Mon, 11 Mar 2024 13:47:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] sched/balancing: Rename load_balance() =>
 sched_balance_rq()
Content-Language: en-US
To: Ingo Molnar <mingo@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20240308111819.1101550-1-mingo@kernel.org>
 <20240308111819.1101550-6-mingo@kernel.org>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20240308111819.1101550-6-mingo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 44UmGPByuVhL7ZydeLctZhkoqrplsEtN
X-Proofpoint-ORIG-GUID: yvEIeQ86c-XttdndvOP7G60PcmqLR-S5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_04,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 mlxlogscore=817 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110062



On 3/8/24 4:48 PM, Ingo Molnar wrote:
> Standardize scheduler load-balancing function names on the
> sched_balance_() prefix.
> 
> Also load_balance() has become somewhat of a misnomer: historically
> it was the first and primary load-balancing function that was called,
> but with the introduction of sched domains, it's become a lower
> layer function that balances runqueues.
> 
> Rename it to sched_balance_rq() accordingly.

nit: Can this be sched_balance_rqs()? since load balancing happens 
between two runqeueus.


> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> ---

Though one would have been familiar with names(for someone started recently),
given the correct behaviour and historical context helps why the name changes are making sense. 

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>


