Return-Path: <linux-kernel+bounces-147446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EC18A7454
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D681F2207D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D52137777;
	Tue, 16 Apr 2024 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ifIZpPfR"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C71137773;
	Tue, 16 Apr 2024 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713294382; cv=none; b=dV8mMG4v/Or3+SuEziOazvwraCOtTDUKdAAFmQ7vpOrGLSr2O5Nht4hnl4IOfWIFt9/M4qCzhzGrq60WlbbWDIxCrxySEbM8gUqpDiWwJ8vpJgEfoLRkt52m/oHl9hsFum0gKpjGBDn68F+xo/rX0vM1deg+O4Ut5Mx/DIP2g50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713294382; c=relaxed/simple;
	bh=JV74h6ugmWJWllAEo9CVzy4KzXEpE6XFPH27SRlteCw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZBo9/y1Pbmv3bLw23u1apuwSDzfaPvBkFgBAdORna/U0aOdewaS49HzAIW4cl5aNrw56Ds7URqYexsmMNLeo7R0JE/Vbj0QLOlY6mAGISd3MJfmpHSX0Gway/gKpo9Ky7wZzEbKJ3rCTMRbT21GQ3hVmtGVWzIAZZ5OceOAOzxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ifIZpPfR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43GJ3x3s007178;
	Tue, 16 Apr 2024 19:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ZXEajgVpQqjjiKL7gWWqFW9gr9jf3cJKxB2S+A5ihvE=;
 b=ifIZpPfRNDUlUSueY+mz25om9I+G9S4F1y84xT74HTIyOFWDfryljZGJj8BP6R0IfbWn
 qzPk+4Okm9M8XDOhRdTiHhP+EjXjWQCdR8dv59FmYSkYu/LlVHy28uUkGO4nQ0mpnmF5
 Wjxce3ujQ+9ZHY2XI4+KaHHj8DHsSTDsN45Qbj2EqU+/TuqnxWokOyYpVVR+cX17AsNf
 0SOQnvvqcoxZZ6Ecis03AyoUTqb6zpEKgSMZw1ZO7PMr978IeNvTNL/xchaBHgo4+EDW
 Jwcj/Zwi16rHxDKOOZ1e1WYTwEoGofkAHpQGP3wpRkAILV267WWp5BdupZfWPvFXBPBV aA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhy56804q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 19:05:54 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43GJ5rYq009266;
	Tue, 16 Apr 2024 19:05:53 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhy56804p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 19:05:53 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43GI9DZQ027323;
	Tue, 16 Apr 2024 19:05:53 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg4s004u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 19:05:53 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43GJ5obU40042812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 19:05:52 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 594865805E;
	Tue, 16 Apr 2024 19:05:50 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B54CD58064;
	Tue, 16 Apr 2024 19:05:49 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.41.175])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Apr 2024 19:05:49 +0000 (GMT)
Message-ID: <254ee35d6534089e99f7396582572606f24ff3a2.camel@linux.ibm.com>
Subject: Re: [RFC 2/2] ima: Fix detection of read/write violations on
 stacked filesystems
From: Mimi Zohar <zohar@linux.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Stefan Berger <stefanb@linux.ibm.com>,
        Amir Goldstein
 <amir73il@gmail.com>, linux-integrity@vger.kernel.org,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        roberto.sassu@huawei.com, Christian Brauner <brauner@kernel.org>
Date: Tue, 16 Apr 2024 15:05:49 -0400
In-Reply-To: <CAJfpeguzh6VzhdnwOPf_hM4x0FbsK8hhZp=VK4kWpCYn0xeBCg@mail.gmail.com>
References: <20240412140122.2607743-1-stefanb@linux.ibm.com>
	 <20240412140122.2607743-3-stefanb@linux.ibm.com>
	 <CAOQ4uxjDQO91cjA0sgyPStkwc_7+NxAOhyve94qUvXSM3ytk1g@mail.gmail.com>
	 <89b4fb29-5906-4b21-8b5b-6b340701ffe4@linux.ibm.com>
	 <CAJfpeguctirEYECoigcAsJwpGPCX2NyfMZ8H8GHGW-0UyKfjgg@mail.gmail.com>
	 <b74a9a3edc52d96a7a34d6ba327fdb2a5a79a80d.camel@linux.ibm.com>
	 <CAJfpegvPwpS5_S4qrrVbeC1RovP8jeNuDCYLbdcZ_XDFgfgftQ@mail.gmail.com>
	 <52645fb25b424e10e68f0bde3b80906bbf8b9a37.camel@linux.ibm.com>
	 <CAJfpegsHJ1JsM3SxNk5gnUM+aucqOqNm3RTrsYgePkcQYR4EEw@mail.gmail.com>
	 <e052c1b5d2aa29b3a1f3a8086af4fb8a94c4d318.camel@linux.ibm.com>
	 <CAJfpeguzh6VzhdnwOPf_hM4x0FbsK8hhZp=VK4kWpCYn0xeBCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0cE_8gVBjb0xU08ZcWZVEk4g120-Dq2F
X-Proofpoint-ORIG-GUID: HdahjFhZZ3X1Rggzms1FFm8K0iBNvr4p
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
 definitions=2024-04-16_16,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=945 clxscore=1015 lowpriorityscore=0 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404160120

On Tue, 2024-04-16 at 16:46 +0200, Miklos Szeredi wrote:
> On Tue, 16 Apr 2024 at 14:18, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > Originally there was a single measureent unless the filesystem was mounted with
> > SB_I_VERSION.  With commit a2a2c3c8580a ("ima: Use i_version only when
> > filesystem supports it") this changed to always re-measure the file if the
> > filesystem wasn't mounted with SB_I_VERSION.
> 
> Does the i_version get stored and compared only while the inode is in memory?
> 
> In that case I think it should be possible to support a version number
> for the overlay inode.

i_version was insufficient to detect a file change for overlay.  Commit
b836c4d29f27 ("ima: detect changes to the backing overlay") also compares the
i_ino and s_dev as well.  Refer to 
https://lore.kernel.org/lkml/20231025143906.133218-1-zohar@linux.ibm.com/.

Here in this patch set we need to detect IMA read/write violations, based on the
i_readcount/i_writecount.  If an overlay file is opened for read, but the
backing file is already opened for write, the file measurement is
meaningless.  An "open-writers" violation needs to be generated; and the IMA
measurement list needs to be invalidated.

thanks,

Mimi


