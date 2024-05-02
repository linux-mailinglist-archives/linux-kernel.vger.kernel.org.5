Return-Path: <linux-kernel+bounces-166497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C518B9B78
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B66CD1F21AB8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCDB84A3F;
	Thu,  2 May 2024 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DHXEplGZ"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773FEC8F3;
	Thu,  2 May 2024 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714655912; cv=none; b=tjAi5Dv0zUdh/0zkDen+HwWWBOfTbNacXk3V9EV5+8sCNpbKsGjEFwgrTWZhKek0OcHpNKXlI2jnveJHbbkmJqMQOytbdFe2uxdDinK2OOQI0ZhTTmeoLkGXIje8KJN7fyBT9qSsSUIYf6ZtRtgn9ytsxJXLtHhydK4HfHjI2zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714655912; c=relaxed/simple;
	bh=Bpw6E9degoi8gZxzY0FT2XijVicqw22P7pA9Yn93K4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKrGOU3Cxk7WeIl3P+2ToGA2O3Qf4eD2Flzl+mG+lQvLcSj9gUSYR7ky83Thnp5tqr2LZhY9hBPiQhuYwUQZu2pdDONnm/4Beb1WEOhhzVGpVHMwtRLJMigHMS3nxkgj/qfNwhIWZJHfqXIv6Y91SKYmYk2wOBQycDTaSfU+qaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DHXEplGZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 442Cv9LJ029749;
	Thu, 2 May 2024 13:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=XN99BF71thSSfY5SqQDfuMkL/hrnNQt2dqkH+sfTj0o=;
 b=DHXEplGZp8ioVYGbxto3cHIrNbtkQtbgZ69TPO1EY+gOzkpUe0PM1anwWjrkg4j0R11a
 +C65LwsOt8WD+1Sc4KXksTzPM8jWm44QxSgnmekpykUJ/bfXaGbJow810I6ROEdHRYZS
 FZVWzmsOlSk25ZriqurIieEFkI9YTgGmrAo6JGfVxzLsG1F/Li2q4Dr0pBHfo0iE0eA9
 AQAPWat0P5PZniLPh9rFW5DfbUaqNNJzbWC2XdP+xk0SvPK2/bqAE3E2pWMVLoyeY255
 GBTVR4RbxgUU6gTGeCpolYkg1QX8lVQAUnJxBtENnO0og3j56uEz4zfBxfAyN9VM6aRf Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xvb9mr30n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 13:18:15 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 442DDQ0U028210;
	Thu, 2 May 2024 13:18:14 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xvb9mr30k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 13:18:14 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 442AnYYc001450;
	Thu, 2 May 2024 13:18:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xsbpu8bj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 13:18:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 442DIA9w51446098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 May 2024 13:18:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF0F220040;
	Thu,  2 May 2024 13:18:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1E062004E;
	Thu,  2 May 2024 13:18:09 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  2 May 2024 13:18:09 +0000 (GMT)
Date: Thu, 2 May 2024 15:18:08 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Barry Song <21cnbao@gmail.com>, David Hildenbrand <david@redhat.com>,
        Lance Yang <ioworker0@gmail.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v5] mm/rmap: do not add fully unmapped large folio to
 deferred split list
Message-ID: <ZjOSkPc8f5u5J6m5@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240426190253.541419-1-zi.yan@sent.com>
 <ZjJCdodEf4CBa1N7@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <5FAD7FB6-4AC0-4427-B56E-4942A95DB68C@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5FAD7FB6-4AC0-4427-B56E-4942A95DB68C@nvidia.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BhJXFo5jULS1X6MGd4EQvaIkCzsPI8zC
X-Proofpoint-GUID: 1BuLqmGV0xhRbwjDw_Q2SRtfZ5-i6DOQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_02,2024-05-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405020085

On Wed, May 01, 2024 at 09:38:24AM -0400, Zi Yan wrote:
Hi Zi,
> @@ -1557,9 +1557,8 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>                  * page of the folio is unmapped and at least one page
>                  * is still mapped.
>                  */
> -               if (folio_test_anon(folio) &&
> -                   list_empty(&folio->_deferred_list) &&
> -                   partially_mapped)
> +               if (folio_test_anon(folio) && partially_mapped &&
> +                   list_empty(&folio->_deferred_list))
>                         deferred_split_folio(folio);
>         }

That helps.

> Best Regards,
> Yan, Zi

Thanks!

