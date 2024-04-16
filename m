Return-Path: <linux-kernel+bounces-147181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0568A70A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D52285907
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FFE13B7AC;
	Tue, 16 Apr 2024 15:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iYx1ySOU"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5012D13AA59;
	Tue, 16 Apr 2024 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282828; cv=none; b=bhmnBDJfWcqPVD3zHs3zRL3iOzjhfj0gDINtlt1D/jtXVQI2SIsaYs/N3C7/GQOZmjkd2UNUgCF9f701ClUljFji1A0sD+nU6gYqN5ilp1faGMKh5Mnt83pnjF4wnuEOH2yGpcLzA983BwVDo+EJC5XYD66uTUmXIeJPfvrgisE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282828; c=relaxed/simple;
	bh=9bq8yrtQK9l1i0+gE8ENhkGDnD4PPiMZHJ7vhwh/RsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JetB5cOtUqSbAgmMmnoccMUUKD58NDjbbIMc2fLme7rJhR1TEIZbm9htue1jg94BdlZyoUqZ9Q1NZ6f53TI5DIg9impg5DFpV7oHcYGlQH0ixRuJd7Us39vcsUMmMRlcgLwHMnc2sCZKicr6MEzmW++WijS192wQwP3wzPNuIOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iYx1ySOU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43GFqHc3006661;
	Tue, 16 Apr 2024 15:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ahwo9ygXLQPCBFtu1iJRpeFoiFvLTQacsCaUnSPP0Ks=;
 b=iYx1ySOUoceuxXKwor+p7dQ0GWGHPhOtoYP/hcb3nKMwY7FmdKBO++cZzzq1b57hASw4
 a/Bjw5dvCYCHwtEtFPRcO1FHpO6mnHdMvFo+szLsWU2xLk5ajV5UkfEtltW1fbVIkZ4Y
 FTTVTk19MgP3jSOM5HfWYTM/okv86x6A4W6e5FKaav9u8LsbXOWVPgtO/i8JGEIDLI9d
 dxs65E/EOvVPhzua5aSRFLRGIvifXfrgAPQlmNKOZYkp9DP2GAbuQQRZ4vocxJu4I5Ns
 waPr5V9yUyRBuYf/uxLZbErNJthVxj7B+fK/tz6bq/T+/wjwGLYvxbiqMzFzb5qjF4uH ug== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhvbgg08b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 15:53:45 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43GFri1p009295;
	Tue, 16 Apr 2024 15:53:44 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhvbgg087-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 15:53:44 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43GFl7gr015862;
	Tue, 16 Apr 2024 15:53:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5vm6w08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 15:53:43 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43GFrbTs17039840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 15:53:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5C1520040;
	Tue, 16 Apr 2024 15:53:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74ABB2004B;
	Tue, 16 Apr 2024 15:53:37 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 16 Apr 2024 15:53:37 +0000 (GMT)
Date: Tue, 16 Apr 2024 17:53:36 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        frankja@linux.ibm.com, nrb@linux.ibm.com, nsg@linux.ibm.com,
        borntraeger@de.ibm.com, hca@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, david@redhat.com
Subject: Re: [PATCH v1 0/2] s390/mm: fix improper use of
 __storage_key_init_range
Message-ID: <Zh6fAG5sQHQ564mJ@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240416114220.28489-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416114220.28489-1-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BKcx-THJItvXurArp0MEw8DP_czU-NGu
X-Proofpoint-ORIG-GUID: InaTEFXBxA9QVPmQsrYoVtEBR_5DXgIG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_13,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 mlxlogscore=633 mlxscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404160097

On Tue, Apr 16, 2024 at 01:42:18PM +0200, Claudio Imbrenda wrote:
>  arch/s390/mm/gmap.c        | 2 +-
>  arch/s390/mm/hugetlbpage.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks!

