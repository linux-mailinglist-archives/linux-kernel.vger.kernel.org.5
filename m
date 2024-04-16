Return-Path: <linux-kernel+bounces-146767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 870D48A6A9A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7851F21670
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9541612AAE2;
	Tue, 16 Apr 2024 12:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sZ8Wn2Pk"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720521DFF0;
	Tue, 16 Apr 2024 12:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269917; cv=none; b=n0paR+JdmVrc/6/+mz5tl7gSkFAMlozxZGbVPH+KTe8DlKFKAwB07VdSrNdqCBieInQoSX4kUpL+4v8Ge/gZL/Fo5aZdH3CCl+U4Sr/2ByAHHgcCO3utQ4/X4Uh1avrve98d2v66ebzHa+66ipeVrMFzDJsJ6W4KrXOvhLyKt80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269917; c=relaxed/simple;
	bh=cvWIKbeUnvP57bXjt53Z0NbaRxeepsorfVlEBYvio2c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=eIP/WERI9/ic3EOq5IaqpSQvLk+Fe2fL84ayOXP54SQ7DFy1MbuMVrgnsM2QQCIPCpvyDgrFLPioI0H/SgMIopROdhWFtu7ScpoVzkgdSVfMhiuo4HTtTTJRYXbbkkPXjrAJgLiAUlo2CLbSFgb1or1sjsEqEvfSm2WCtLaiQyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sZ8Wn2Pk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43GCHao0013920;
	Tue, 16 Apr 2024 12:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=WL96dIFdwrfSeUs1UM3vLPDY/ZKkHY19krY1VdPDKKU=;
 b=sZ8Wn2Pk92GrLxhyYUq9ZMOPdU4hbeR+7q4O3wBflwpbzfagT/CkQ4FZrRHcWR24ZOUY
 VDCT1KZ3Bzro0E+merT20C0DcN7puQjSTp/Fwasd9glWQAkt7JWgAWsApYmmmN62zDY6
 bEPdhzwa6J3YEGLx7eLIZZmsCJnGdW+bBUQqFFhVGa2GOJbOtSnFjgJwegIIBszLSu5q
 dNfLR3Hxq8W2LBjuEQ8kLi5CLaCRhR60I2Sq2S+ZwDtkWjUI36ejwRml7iVFrB9AZZe2
 0EB78f2FCRhxInygoSwrnF+AujBqsmDKRm/yntAxWuQyE8olzCtolcjPlfI7m6GuE9g8 qw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhs700019-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 12:18:16 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43GCIFT3014238;
	Tue, 16 Apr 2024 12:18:15 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhs700018-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 12:18:15 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43G9GvYa015862;
	Tue, 16 Apr 2024 12:18:14 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5vm5v7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 12:18:14 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43GCIBPp66126236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 12:18:13 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C0D858061;
	Tue, 16 Apr 2024 12:18:11 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8526158043;
	Tue, 16 Apr 2024 12:18:10 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.56.73])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Apr 2024 12:18:10 +0000 (GMT)
Message-ID: <e052c1b5d2aa29b3a1f3a8086af4fb8a94c4d318.camel@linux.ibm.com>
Subject: Re: [RFC 2/2] ima: Fix detection of read/write violations on
 stacked filesystems
From: Mimi Zohar <zohar@linux.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Stefan Berger <stefanb@linux.ibm.com>,
        Amir Goldstein
 <amir73il@gmail.com>, linux-integrity@vger.kernel.org,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        roberto.sassu@huawei.com, Christian Brauner <brauner@kernel.org>
Date: Tue, 16 Apr 2024 08:18:09 -0400
In-Reply-To: <CAJfpegsHJ1JsM3SxNk5gnUM+aucqOqNm3RTrsYgePkcQYR4EEw@mail.gmail.com>
References: <20240412140122.2607743-1-stefanb@linux.ibm.com>
	 <20240412140122.2607743-3-stefanb@linux.ibm.com>
	 <CAOQ4uxjDQO91cjA0sgyPStkwc_7+NxAOhyve94qUvXSM3ytk1g@mail.gmail.com>
	 <89b4fb29-5906-4b21-8b5b-6b340701ffe4@linux.ibm.com>
	 <CAJfpeguctirEYECoigcAsJwpGPCX2NyfMZ8H8GHGW-0UyKfjgg@mail.gmail.com>
	 <b74a9a3edc52d96a7a34d6ba327fdb2a5a79a80d.camel@linux.ibm.com>
	 <CAJfpegvPwpS5_S4qrrVbeC1RovP8jeNuDCYLbdcZ_XDFgfgftQ@mail.gmail.com>
	 <52645fb25b424e10e68f0bde3b80906bbf8b9a37.camel@linux.ibm.com>
	 <CAJfpegsHJ1JsM3SxNk5gnUM+aucqOqNm3RTrsYgePkcQYR4EEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8cJAq3Bt05s6SuYHWYznc5KtABd67TTP
X-Proofpoint-ORIG-GUID: FXyRC813uLMlb__JUepONO2KtIp5beHn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_08,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160076

On Tue, 2024-04-16 at 10:05 +0200, Miklos Szeredi wrote:
> On Mon, 15 Apr 2024 at 20:35, Mimi Zohar <zohar@linux.ibm.com> wrote:
> 
> > Although "Changes to the underlying filesystems while part of a mounted overlay
> > filesystem are not allowed.", from an integrity perspective these changes might
> > affect overlay files.  So they need to be detected and possibly re-measured, re-
> > appraised, and/or re-audited [1, 2].
> 
> How are changes of non-overlay files detected?

Originally there was a single measureent unless the filesystem was mounted with
SB_I_VERSION.  With commit a2a2c3c8580a ("ima: Use i_version only when
filesystem supports it") this changed to always re-measure the file if the
filesystem wasn't mounted with SB_I_VERSION.

With commit db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version")
it's not directly accessing i_version.

thanks,

Mimi




