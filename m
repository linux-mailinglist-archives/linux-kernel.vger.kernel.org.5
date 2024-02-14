Return-Path: <linux-kernel+bounces-64931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 817BC8544CD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF131F23F8A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057F012B99;
	Wed, 14 Feb 2024 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Kb9fd5bo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9EF12B88
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902062; cv=none; b=ZiX+V10DHZm9JwKVT0KLXtSNBAdzcLZAxguDsBtj8PzgXsEd/kMbxwsFg0rwDP15F8GBUTDDVSahwCFf22JcxIRyfS8agxXe+3nnCtbuQrMsZ82+LNwPNhqOZvMuvkSb29rCR0aCNp9fZO+K7RbUwXPqX08nc597B+RafEI0/I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902062; c=relaxed/simple;
	bh=FCqel5Ig8UY5Wl9vfQwDc+Lv9aJAAZMTCLf1omkhISg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=huVBexyEzHmHMr1WVK3refvl9r2memWh9YQskXUjsvuLcJM77QIB3keD0EYAysuaeysSemWepweXHJKmMWCJiPasQ3Y+xUYx6TOqM65HEna9436Fe1OXLNb4JYL/oyKUcR6oJK0fDC0ZB8Zd2CsTlFRZb8kNJUd6IccWpeuoSVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Kb9fd5bo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41E7kSMi028193;
	Wed, 14 Feb 2024 09:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=mN6QB+qDuCSV/tY61bkNRVg4z8putKLkJFG2Mvkny5M=; b=Kb
	9fd5bo2LCELAUvCC2dMtIKu8WOhnVzzOGlCZF2AxK31lD5l4YZgBUHYnph6ILhgo
	5KLOEcq994bDOXAY76NZ6a3Uq65AQ1Tkfea3KnIzVPcYgFiF0c6OQiPWOFkVtm7k
	hs9DnMOqglx6HBTrXVy7MJUfGCJ4h0LHNot9k8jJK9mGbNzaVkWS5tLO9FPkhtud
	2lBSsT7kW/CFQvcY2gF8hY6uGhwElYOISpBMXZQPEkPEI+E6hNZT9cj3k5UKf4tH
	ODbKiCDpkqko6ph5inxL0MT4HnqlaPW8bp0M9kopNFhcY+McVOVTxnIsPzBDpsiA
	lNFecHMe22795e7gQV9Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w8nt40ftc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 09:14:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41E9E43C018123
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 09:14:04 GMT
Received: from [10.214.66.164] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 14 Feb
 2024 01:14:00 -0800
Message-ID: <64ed46f4-459c-63b0-a69e-81353e9fcbc9@quicinc.com>
Date: Wed, 14 Feb 2024 14:43:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V7 2/2] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED
 for shmem
Content-Language: en-US
From: Charan Teja Kalla <quic_charante@quicinc.com>
To: Hugh Dickins <hughd@google.com>
CC: <akpm@linux-foundation.org>, <willy@infradead.org>,
        <markhemm@googlemail.com>, <rientjes@google.com>, <surenb@google.com>,
        <shakeelb@google.com>, <fvdl@google.com>, <quic_pkondeti@quicinc.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Minchan Kim
	<minchan@kernel.org>
References: <cover.1676378702.git.quic_charante@quicinc.com>
 <631e42b6dffdcc4b4b24f5be715c37f78bf903db.1676378702.git.quic_charante@quicinc.com>
 <2d56e1dd-68b5-c99e-522f-f8dadf6ad69e@google.com>
 <eeeba374-9247-96fd-c9f5-8cba8761f1b9@quicinc.com>
 <aa4352d8-a549-32e5-874f-1cfee2a5b3e@google.com>
 <e8e85d7d-edf1-7a8b-8cfe-9976dd9cfb0b@quicinc.com>
In-Reply-To: <e8e85d7d-edf1-7a8b-8cfe-9976dd9cfb0b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uBZl48d6zItMtwy452DnHye9QeYlVuuc
X-Proofpoint-ORIG-GUID: uBZl48d6zItMtwy452DnHye9QeYlVuuc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 mlxlogscore=471 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402140071

Hello Hugh,

Based on offline discussion with some folks in the list, it seems that
this syscall can be helpful. This patch might have forgotten and I hope
this ping helps in resurrecting this thread.

On 5/18/2023 6:16 PM, Charan Teja Kalla wrote:
> On 5/17/2023 5:02 PM, Hugh Dickins wrote:
>>> Sure, will include those range calculations for shmem pages too.
>> Oh, I forgot this issue, you would have liked me to look at V8 by now,
>> to see whether I agree with your resolution there.  Sorry, no, I've
>> not been able to divert my concentration to it yet.
>>
>> And it's quite likely that I shall disagree, because I've a history of
>> disagreeing even with myself on such range widening/narrowing issues -
>> reconciling conflicting precedents is difficult 🙁
>>
> If you can at least help by commenting which part of the patch you
> disagree with, I can try hard to convince you there:) .
> 
>>> Please let me know if I'm missing something where I should be counting
>>> these as NR_ISOLATED.
>> Please grep for NR_ISOLATED, to see where and how they get manipulated
>> already, and follow the existing examples.  The case that sticks in my
>> mind is in mm/mempolicy.c, where the migrate_pages() syscall can build
>> up a gigantic quantity of transiently isolated pages: your syscall can
>> do the same, so should account for itself in the same way.

Based on the grep, it seems almost all the call stacks that isolates the
folios is for migrating the pages where after migration the NR_ISOLATED
is decremented (in migrate_folio_done()). The call paths are(compaction,
memory hotplug, mempolicy).

The another call path is reclaim where we isolate 'nr' pages belongs to
a pgdat, account/unaccount them in NR_ISOLATED across the reclaim.

I think it is easy to account for the above call paths as we know "which
folio corresponds to which pgdat".

Where as in this patch, we are isolating a set of folios(can corresponds
to different nodes) and relying on the reclaim_pages() to do the swap
out. It is straightforward to account NR_ISOLATED while isolating, but
it requires unaccounting changes in the shrink_folio_list() where folio
is being freed after swap out.  Doing so requires changes in all the
code places(eg: shrink_inactive_list()), where it now requires to
account NR_ISOLATED while isolating and the shrink_folio_list()
unaccounts it.

So, accounting NR_ISOLATED requires changes in other code places where
this patch has not touched.

If isolating a large amount of pages and not being recorded in
NR_ISOLATED is really a problem, then may I please know your opinion on
isolating(with out accounting) and reclaiming in small batches? The
batch size can be considered as SWAP_CLUSTER_MAX of pages.

> I had a V8 posted without this into accounting. Let me make the changes
> to account for the NR_ISOLATED too.

Thanks,
Charan

