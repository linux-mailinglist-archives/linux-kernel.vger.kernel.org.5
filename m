Return-Path: <linux-kernel+bounces-118487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0B188BBA9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F6AFB21E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E34134412;
	Tue, 26 Mar 2024 07:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VUwNUj/N"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351951327ED
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 07:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711439363; cv=none; b=KbMHNzmInRNgwxzpVz+0Vh1WiQ5lHDVppLRhP+UPL1POU+tbcgVkS8GZOD4/f4Y8b82smtxnDiPNmZnKtqOghSqL1Pi97BAXSks3C3E3lT6STZ6wJCdgcPJq8weaCdTNXQddx5cCh+Ji9NeGYKnQpJ+Py5dUA9gsqmTop45NfBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711439363; c=relaxed/simple;
	bh=dqAd7OjWgTnqEHukNHnke5LzQbaeMMnCo0sdA+IjRgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4xczu/Z/vJB7mdLasaW1XLjUl4IuQTXnS8bJ93BfrPka4VgWU+RSUcFp8WP/SVewWCS8qtGn8A/lt3CWZeZnA/JcXoMT2k8imbkf+u4l+jJQhkVTQhD+wSZAPyMsdJgRxxyE/3N43FemPyu5rmXC7pFRH99liuorB7gyRQUJ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VUwNUj/N; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42Q6tssI023504;
	Tue, 26 Mar 2024 07:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=gEPa7TSHFvR3AVvnHhrhHVYWL2THauofyr9s2yjVDOM=;
 b=VUwNUj/N5mbbkhipigbjGgBOJhfgThMtm3ITv1mwe8Ht8ljQ+PwCF+tW3pZR23oZjH1/
 er/ZlFE3Ik7jEf/fn6BVuAYerDeJJSSKXLw30inF4SX0d0iiEKjy2FeYnHQu8F10LnkZ
 cnGqAiYX9s8wvC+fRSHZFBZjs25ovQDkaA/o3fTxPT4DBPp+IfvkH33HAy8pySgSJz8L
 lrXSGThL1xVtZzJbIn0Oo5a1bDIc8yRf+e5Jtxf63WbR2sMooVGgZ8qVyrpBtu4N6FjW
 ZylyD2sKSmd82wRpQ+BUuULwYwsrTd+GJOmscuJDEXNkgJK41zQ1CBHuqxZmskv2Os3w QA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x3kytrspm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 07:48:54 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42Q7msRU010276;
	Tue, 26 Mar 2024 07:48:54 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x3kytrspg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 07:48:54 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42Q5Odxj013343;
	Tue, 26 Mar 2024 07:48:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x29t0ek5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 07:48:52 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42Q7mm6k41288032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 07:48:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6C0720063;
	Tue, 26 Mar 2024 07:48:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 910AA20040;
	Tue, 26 Mar 2024 07:48:48 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 26 Mar 2024 07:48:48 +0000 (GMT)
Date: Tue, 26 Mar 2024 08:48:46 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>, Guenter Roeck <linux@roeck-us.net>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/1] mm: vmalloc: Bail out early in find_vmap_area() if
 vmap is not init
Message-ID: <20240326074846.6078-D-hca@linux.ibm.com>
References: <20240323141544.4150-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323141544.4150-1-urezki@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l-95GC7tIB-ygz7mEZ1DT2Lo93O7U3I3
X-Proofpoint-ORIG-GUID: HwrjB5_E5SYPjSoAcbidYfviQtVuDYhn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_04,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=638 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403260052

On Sat, Mar 23, 2024 at 03:15:44PM +0100, Uladzislau Rezki (Sony) wrote:
> During the boot the s390 system triggers "spinlock bad magic" messages
> if the spinlock debugging is enabled:
..
> Some background. It worked before because the lock that is in question
> was statically defined and initialized. As of now, the locks and data
> structures are initialized in the vmalloc_init() function.
> 
> To address that issue add the check whether the "vmap_initialized"
> variable is set, if not find_vmap_area() bails out on entry returning NULL.
> 
> Fixes: 72210662c5a2 ("mm: vmalloc: offload free_vmap_area_lock lock")
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 3 +++
>  1 file changed, 3 insertions(+)

Thanks for fixing this, and FWIW:
Acked-by: Heiko Carstens <hca@linux.ibm.com>

