Return-Path: <linux-kernel+bounces-145718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BA38A59F7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6EB81F212FF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06694154BFC;
	Mon, 15 Apr 2024 18:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XyTaOYy4"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F259E13666E;
	Mon, 15 Apr 2024 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206125; cv=none; b=RGznKpGwv8wxna1L0AojoFsPE6WVOEhCx20HtUJxxwDwmYVLpbLkRHSDZgZdsbr5VlGVf/B9ZdghmX9L/NUVU/985yXpeQTk8GbmCq3+9HhRnFFJ6HmF0mFbgGI2h9L9yOS/LPcDNNr2qWqDqLhYyVIre8AP62w681x6bHgUdHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206125; c=relaxed/simple;
	bh=aMpLn34rgN3Wu7qR0MHV/hkCetkhm4GVgtqnR3BnptI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iMGNlkwqcc0i5t5wPnJMghcePjG7Z4PWY7Oj+as0/63p6uXMESTAp2rzUv5exMhG2xXhBy3nBQ0pYHm+INFD6vc3M2daGuwa6ZoiGR8ZHA5up/9oUAtK/pKR19uF8AOcXtZpU5ayW9iZ6tuM70gDxSt8a6a68dfgreRcUjfFs4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XyTaOYy4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43FHOUsW006406;
	Mon, 15 Apr 2024 18:35:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=D5i5HVxEBVh4tmqqQG3dAXHenBgT7Vw/0+SyVXK1vbw=;
 b=XyTaOYy4PxQELlKiYptJO1fr6d5zu3QMk3l2auMOCrp2iZ3YFDzWhAbW48RY+3hWidvO
 psCcKflFMSEOP/3uAPzEBKbLrN7XVintNIYuI8kzb5i2/l+NRWWSAR0EhUQZiJVcE7zF
 9YJ+NqyRaWMRPH16D16WA/OTwnFJkLBgcKE1V1DX5qhxOSHxDzo/Qo3P6uFcJoS2fkGc
 kcUpcOgMVwJfdDt+eAUCK+JDYFLR7WTER/3MoFX7wXgwdoj0OZu6wLIfQFBgcFuM8Dng
 MZe2tIxOkTqXcJ+7Pn8ZRRUsS35HYut4AO2OnbBLSNQhieEVC8sUnztr8OfXYQhfG8ni /g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xh7xpr7f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 18:35:07 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43FIZ6pJ011059;
	Mon, 15 Apr 2024 18:35:06 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xh7xpr7f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 18:35:06 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43FHNDRV011164;
	Mon, 15 Apr 2024 18:35:05 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xg73292ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 18:35:05 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43FIZ3oq9831124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 18:35:05 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C8165805C;
	Mon, 15 Apr 2024 18:35:03 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0490758058;
	Mon, 15 Apr 2024 18:35:02 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.watson.ibm.com (unknown [9.31.110.109])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Apr 2024 18:35:01 +0000 (GMT)
Message-ID: <52645fb25b424e10e68f0bde3b80906bbf8b9a37.camel@linux.ibm.com>
Subject: Re: [RFC 2/2] ima: Fix detection of read/write violations on
 stacked filesystems
From: Mimi Zohar <zohar@linux.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Stefan Berger <stefanb@linux.ibm.com>,
        Amir Goldstein
 <amir73il@gmail.com>, linux-integrity@vger.kernel.org,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        roberto.sassu@huawei.com, Christian Brauner <brauner@kernel.org>
Date: Mon, 15 Apr 2024 14:34:56 -0400
In-Reply-To: <CAJfpegvPwpS5_S4qrrVbeC1RovP8jeNuDCYLbdcZ_XDFgfgftQ@mail.gmail.com>
References: <20240412140122.2607743-1-stefanb@linux.ibm.com>
	 <20240412140122.2607743-3-stefanb@linux.ibm.com>
	 <CAOQ4uxjDQO91cjA0sgyPStkwc_7+NxAOhyve94qUvXSM3ytk1g@mail.gmail.com>
	 <89b4fb29-5906-4b21-8b5b-6b340701ffe4@linux.ibm.com>
	 <CAJfpeguctirEYECoigcAsJwpGPCX2NyfMZ8H8GHGW-0UyKfjgg@mail.gmail.com>
	 <b74a9a3edc52d96a7a34d6ba327fdb2a5a79a80d.camel@linux.ibm.com>
	 <CAJfpegvPwpS5_S4qrrVbeC1RovP8jeNuDCYLbdcZ_XDFgfgftQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: P4YbifeBC878fdZOryHn8Fupjdc1zeUs
X-Proofpoint-ORIG-GUID: ErHeamn1iAxmoNK9_tHWbWoVqE6zMJ7H
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_15,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404150122

On Mon, 2024-04-15 at 14:57 +0200, Miklos Szeredi wrote:
> On Mon, 15 Apr 2024 at 12:47, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > It's queued in
> > https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/
> > next-
> > integrity branch and should be linux-next.
> 
> Is there a document about ima/evm vs. overlayfs?

Not yet.
> 
> What exactly is it trying to achieve and how?

Although "Changes to the underlying filesystems while part of a mounted overlay
filesystem are not allowed.", from an integrity perspective these changes might
affect overlay files.  So they need to be detected and possibly re-measured, re-
appraised, and/or re-audited [1, 2].

Saying, "If the underlying filesystem is changed, the behavior of the overlay is
undefined, though it will not result in a crash or deadlock." does not address
the concerns about the integrity of the overlay file being accessed.

Initially we disabled EVM on overlay, since calculating the overlay EVM HMAC,
could result in taking an invalid HMAC value and making it valid.  Stefan's EVM
patch set addresses this by only copying up the EVM portable & immutable
signature [3, 4].

Lastly, if a file is being opened for read, but is already opened for write, or
the reverse, the file measurement is meaningless.  A violation is audited and
the IMA measurement list is invalidated.  This patch set similarly addresses the
case where the underlying file is already opened for write and the overlay file
is being opened for read.


[1] Commit 18b44bc5a672 ("ovl: Always reevaluate the file signature for IMA")
forced signature re-evaulation on every file access.

[2] Commit b836c4d29f27 (ima: detect changes to the backing overlay file)

[3] 
https://lore.kernel.org/linux-integrity/20231219175206.12342-1-zohar@linux.ibm.com/

[4] 
https://lore.kernel.org/linux-integrity/20240223172513.4049959-1-stefanb@linux.ibm.com/

thanks,

Mimi



