Return-Path: <linux-kernel+bounces-116925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BE788A536
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A7C29FCEB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513F917A391;
	Mon, 25 Mar 2024 11:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z6Yzd1cB"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63C5145B21;
	Mon, 25 Mar 2024 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711365454; cv=none; b=XqETfuTrNjSya53HMMihs3NQlO7Cfdd35iS7vSc5bsf2AeX/aIljM4+Wk7rYEiwzh6rNCp3DHUoJ/TAjSdr9MmFb6XMQvTpBb1u2o8ymG1U28i03OWQCsGdEWmkSywrRoqA3/MFtk0xENapUWyw+5+HuDLR/1mo+dTlEfYTlN2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711365454; c=relaxed/simple;
	bh=WrEa33cBZx15hEBju/7B9wRVX0eMhydoPuVy5Q1YmdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeB0XAoTjYlgVGebOC2rhuhlBM7Y1W9DtceesGcmreuJ2rBkl412oKk9oKMIQK9UoANEdJnhP6gN/DjOQ+18bta11TXlQiXTOAuzQnhv46f8Bdaat+GQwixsjLtPhBRqfrimzehdKf3sBPDibGqXwsiHwhNfsb2RA05iaLW7gvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z6Yzd1cB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42PABpYj018665;
	Mon, 25 Mar 2024 11:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=gnlObX30DW5far9dp1Z99mKsThU4aayO+Gtb5tKOmSI=;
 b=Z6Yzd1cBtfCsA+QXnMdad8suUWDjqfS6kHIuWJHefO4QmTufqbLsVMMKn+g3dTk69wQ0
 1JRBa36VohbinjvUr69kB9bxqMX2lXO9YgiMTOfjPz0Fjx9Z5gdI9gZ3Y5BmjH/RSJzX
 mk4fmWuchs4dO3zZkWzIHqMH0ZPTHHv5KSTOvSdvQoYZXa0P+mCfXbVYGdYoxS5KKbUl
 ulj0k9se7l0i6KNxCvi2CDizfnA81CCuEBQ7EXZginqQirQrwijhrmdDK1cVgk+AQTo7
 KY60o1/FReCzxVlL4ABo7R3S1yBnC0E8JnmyG4RzWHjoF7Swvk/9jww5cU05/7OERkoa uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x2g8f26c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 11:16:59 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42PBGxxW020737;
	Mon, 25 Mar 2024 11:16:59 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x2g8f26c6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 11:16:59 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42PAUVRs016605;
	Mon, 25 Mar 2024 11:16:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x29dts0yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 11:16:58 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42PBGrdd49414524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 11:16:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFB6D20049;
	Mon, 25 Mar 2024 11:16:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0819120040;
	Mon, 25 Mar 2024 11:16:52 +0000 (GMT)
Received: from osiris (unknown [9.171.70.91])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 25 Mar 2024 11:16:51 +0000 (GMT)
Date: Mon, 25 Mar 2024 12:16:50 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>, Guenter Roeck <linux@roeck-us.net>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/1] mm: vmalloc: Bail out early in find_vmap_area() if
 vmap is not init
Message-ID: <20240325111650.16056-A-hca@linux.ibm.com>
References: <20240323141544.4150-1-urezki@gmail.com>
 <ZgC38GfEZYpYGUU9@infradead.org>
 <20240325093959.9453-B-hca@linux.ibm.com>
 <ZgFNVtp3EsJRaSN0@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgFNVtp3EsJRaSN0@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EjOA8Cp1wiUgikrGT4ebHRtCz_cnePdL
X-Proofpoint-ORIG-GUID: KiB6oDil0a2tliOO39RSi9iLVP9OPhLD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=475 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250062

On Mon, Mar 25, 2024 at 06:09:26PM +0800, Baoquan He wrote:
> On 03/25/24 at 10:39am, Heiko Carstens wrote:
> > On Sun, Mar 24, 2024 at 04:32:00PM -0700, Christoph Hellwig wrote:
> > > On Sat, Mar 23, 2024 at 03:15:44PM +0100, Uladzislau Rezki (Sony) wrote:
> ......snip
> > > I guess this is ok as an urgend bandaid to get s390 booting again,
> > > but calling find_vmap_area before the vmap area is initialized
> > > seems an actual issue in the s390 mm init code.
> > > 
> > > Adding the s390 maintainers to see if they have and idea how this could
> > > get fixed in a better way.
> > 
> > I'm going to push the patch below to the s390 git tree later. This is not a
> > piece of art, but I wanted to avoid to externalize vmalloc's vmap_initialized,
> > or come up with some s390 specific change_page_attr_alias_early() variant where
> > sooner or later nobody remembers what "early" means.
> > 
> > So this seems to be "good enough".
..
> > Add a slab_is_available() check to change_page_attr_alias() in order to
> > avoid early calls into vmalloc code. slab_is_available() is not exactly
> > what is needed, but there is currently no other way to tell if the vmalloc
> > code is initialized or not, and there is no reason to expose
> > e.g. vmap_initialized from vmalloc to achieve the same.
> 
> If so, I would rather add a vmalloc_is_available() to achieve the same.
> The added code and the code comment definitely will confuse people and
> make people to dig why.

So after having given this a bit more thought I think Uladzislau's patch is
probably the best way to address this.

It seems to be better that the vmalloc code would just do the right thing,
regardless how early it is called, instead of adding yet another
subsystem_xyz_is_available() call.

Alternatively this could be addressed in s390 code with some sort of
"early" calls, but as already stated, sooner or later nobody would remember
what "early" means, and even if that would be remembered: would that
restriction still be valid?

