Return-Path: <linux-kernel+bounces-144933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D258A4CDB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02641C21DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4107C5FB9D;
	Mon, 15 Apr 2024 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y9t0b9/4"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498085C902;
	Mon, 15 Apr 2024 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178052; cv=none; b=TCSTMYH0o2s5V1MM6Q9GkzGVzo6ZptDmUbJMDRR3dZkDNybo5aC1OgogAzrL4fk2ZE1xQRa83k2dOVi/pqkqCThLJdqDd4noEN5aPlUR+Q8UfKvaJ0PoQfI7qkePe2Wen38PTbGfMLfeA0ezln1HtTFH1ynF0Dq6cIwfu62wwMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178052; c=relaxed/simple;
	bh=sM57OrdBMlq6mSQ271RB40hI+kb24Xhf/r/TQj3621c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cDn6CMT7YylV7lccIoSZ71VyMgetzNkHkj2EEo2szuzyorRP3zrRUmV1KgTvrYW49unNRAtD0K2Pza3UFRFfb42d8D6XloP1oFIJjDDDnl5Gv0iAYFNwoFs4KtDDJz71bj0JF9gDBN4RP/2n73seOQyf8nOTHLMUbxZCbInsGfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y9t0b9/4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43FAPwNP007206;
	Mon, 15 Apr 2024 10:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=izukePj7qKr6gY0xKoLwkB3RdpI+c2fhsvXajnnQpWc=;
 b=Y9t0b9/4v70ENv3WjAVkyAukvFr0+/6z35MqKa4vWjc2jFixFRzqjvcG9Yx0Hfms/BGj
 6Whr9Cn7aujHFDAUBQpeKk+tECvqPH/kacdBq0tZz5iEM2iSOvZXHogDSLxh2FbV3yB4
 J8DY3dglH+Dw/JxtpoXn4JkDWH0+ANcfWzk3UVyhL7OIcsL/DcnCkRI+qr7neB0HbOhL
 WsYabHfBEuCkBbJj30FepjSvMY9FHERl7ButI6ySzMgFrPdrpQrcqt8L7cBuGsz+aOIf
 UC8LG45+UN+V38pipJv+uyxYoqtZO/oSMf3c9CfkHn0NtlC6n0WL5jR8pSIRd068UhQ8 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xfhr0knat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 10:47:18 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43FAlHAR005807;
	Mon, 15 Apr 2024 10:47:17 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xfhr0knar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 10:47:17 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43F9aBEL015836;
	Mon, 15 Apr 2024 10:47:16 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5vky7a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 10:47:16 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43FAlDMP41288204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 10:47:15 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E63558061;
	Mon, 15 Apr 2024 10:47:13 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B5FC5805A;
	Mon, 15 Apr 2024 10:47:13 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.175.164])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Apr 2024 10:47:13 +0000 (GMT)
Message-ID: <b74a9a3edc52d96a7a34d6ba327fdb2a5a79a80d.camel@linux.ibm.com>
Subject: Re: [RFC 2/2] ima: Fix detection of read/write violations on
 stacked filesystems
From: Mimi Zohar <zohar@linux.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Stefan Berger <stefanb@linux.ibm.com>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-integrity@vger.kernel.org,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        roberto.sassu@huawei.com, Christian Brauner <brauner@kernel.org>
Date: Mon, 15 Apr 2024 06:47:12 -0400
In-Reply-To: <CAJfpeguctirEYECoigcAsJwpGPCX2NyfMZ8H8GHGW-0UyKfjgg@mail.gmail.com>
References: <20240412140122.2607743-1-stefanb@linux.ibm.com>
	 <20240412140122.2607743-3-stefanb@linux.ibm.com>
	 <CAOQ4uxjDQO91cjA0sgyPStkwc_7+NxAOhyve94qUvXSM3ytk1g@mail.gmail.com>
	 <89b4fb29-5906-4b21-8b5b-6b340701ffe4@linux.ibm.com>
	 <CAJfpeguctirEYECoigcAsJwpGPCX2NyfMZ8H8GHGW-0UyKfjgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SAjWQQo82Ay_X2W-sjQR3qzkt7YINlDc
X-Proofpoint-GUID: 3oM75Vj4n_Epg8pi0VHRj0J6aXMDQvm4
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
 definitions=2024-04-15_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxlogscore=924 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1011
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404150070

On Mon, 2024-04-15 at 10:09 +0200, Miklos Szeredi wrote:
> On Fri, 12 Apr 2024 at 21:09, Stefan Berger <stefanb@linux.ibm.com> wrote:
> 
> > I was hoping that this would be sufficiently generic to work with
> > potential future stacked filesystems as well that would need to also
> > provide support for D_REAL_FILEDATA.
> 
> I also have very bad feelings from IMA digging in the internals of overlayfs.
> 
> We should strive to get rid of remaining d_real() instances, not add more.
> 
> On a related note, D_REAL_METADATA was apparently added for IMA
> (commit 11b3f8ae7081 ("fs: remove the inode argument to ->d_real()
> method")), but there's no current user.  What's up with this?


It's queued in 
https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ next-
integrity branch and should be linux-next.

thanks,

Mimi


