Return-Path: <linux-kernel+bounces-65187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82076854914
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D37928837E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3CA1B968;
	Wed, 14 Feb 2024 12:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Yg4IzNAj"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603AC1B958;
	Wed, 14 Feb 2024 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707913269; cv=none; b=sw1nAaJRXAfEjKHhYR1/ARS8YPlC878a+JIMBGEHlx0kZlaln6nO7Lza4Go5nIYUk3HwPF5vktzos9aszbHbVJ+YDc5HN8vM8nGwjuJ2CFNRfLX5p/C8iXEkg68TDd3rE9lIxSKNZGlErU69XRf4xWQrkueKM5Z+C5XW5XFKk2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707913269; c=relaxed/simple;
	bh=aIqkrOHtKqJDGMeDzYy3CfldpGmYtvA6DaHcAmqcblU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Se6gPl0mqDyD5RZRofRgojpfKPPIhVGY5tFBt5fZ3zZXjxC8jpkIfOYKuUDFSKjteRPWBgeDf25fFa82uh8dTygv8iHNpXI4pWU6jC/Z4Ilux1DJIblsVRdlC0uXpvWGXGbDE1BmcUcFAdwtNXVdtJpeLgZr9ksBDi574GjrrfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Yg4IzNAj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EC7pdZ007384;
	Wed, 14 Feb 2024 12:21:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=jX1r2vNiq7tijCHOf5ggnrNhX5LsSoM4ejl+DOG68kM=;
 b=Yg4IzNAjmsXY+5pXLyUq9xzHiv6XGRm76YinQXYKw44JIKP1a1YqywrmwBsOfx3m6RMt
 st3+ft+rtRqa5bb1a1mWshU9Y4k62Zzpb5xQcW6nF6ngHyHvVxRm0QhRILBlB9FsPG66
 F6GhnVei1cLWIZIOr7PnwUgC2x1UKxyRG4BOSc8BGgGNbEYvYsef1GEkvD+8RoDP1jWs
 TB+6dMowYSthJr7HeRwWh3H5FdLQtotg/G3uKngAeVqhYKSllz6PigoFFaiMCx1LU9KN
 geEjAkREnCtBLKrnkDS4SKtId5cVCHeP3R6iCH1XeeqvL1Zeja0KG2YqaDOTC0WWHGoM eA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8w8h88qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 12:21:04 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41EC7xEI007563;
	Wed, 14 Feb 2024 12:21:03 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8w8h88qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 12:21:03 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41EAQ2VM016203;
	Wed, 14 Feb 2024 12:21:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mymnphe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 12:21:02 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41ECKuNl63832360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 12:20:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D87B22004D;
	Wed, 14 Feb 2024 12:20:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A787520040;
	Wed, 14 Feb 2024 12:20:56 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 14 Feb 2024 12:20:56 +0000 (GMT)
Date: Wed, 14 Feb 2024 13:20:55 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Fangrui Song <maskray@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        ndesaulniers@google.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
Subject: Re: [PATCH 03/11] s390: vmlinux.lds.S: Explicitly handle '.got' and
 '.plt' sections
Message-ID: <20240214122055.6438-D-hca@linux.ibm.com>
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
 <20240207-s390-lld-and-orphan-warn-v1-3-8a665b3346ab@kernel.org>
 <CAFP8O3KHsjCWowDTBxOq7GQ3bdsA2tAMO5Y4YfKR374Dz_Z54g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFP8O3KHsjCWowDTBxOq7GQ3bdsA2tAMO5Y4YfKR374Dz_Z54g@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5a72m7GXjghwGqHKx0FzSGfFzrXD8YEy
X-Proofpoint-GUID: Oq-do3-waeoNosdhtVkGdgzEAWO5NxXG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_04,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=384 spamscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140095

On Mon, Feb 12, 2024 at 09:31:53PM -0800, Fangrui Song wrote:
> On Wed, Feb 7, 2024 at 4:15 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > +       ASSERT(SIZEOF(.got.plt) == 0, "Unexpected GOT/PLT entries detected!")
> > +       .plt : {
> > +               *(.plt)
> > +               *(.plt.*)
> > +               *(.iplt)
> > +               *(.igot .igot.plt)
> > +       }
> > +       ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
> > +
> 
> It seems that arches that drop .plt typically place input section
> description on one line. This saves vertical space.
> It's shorter to use one input section description to match multiple
> sections, e.g.
> 
>     *(.plt .iplt)

Yes, I'll change Nathan's patch so it looks like arm64:

	/*
	 * Sections that should stay zero sized, which is safer to
	 * explicitly check instead of blindly discarding.
	 */
	.plt : {
		*(.plt) *(.plt.*) *(.iplt) *(.igot .igot.plt)
	}

