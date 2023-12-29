Return-Path: <linux-kernel+bounces-13163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850CB820091
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3979A2847CA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C7712B61;
	Fri, 29 Dec 2023 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B50YTE3P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12461125D1;
	Fri, 29 Dec 2023 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BTEWnii000745;
	Fri, 29 Dec 2023 16:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=wbcLOjD/g4HQFnhKj1bNCq5O1tu+YtaxHZUwcKk3Rsc=;
 b=B50YTE3P+ltwHRtV9pdbXNh+3+ORJUo3V2XaPk/woyiuUiEWVSK0bTB8VjyuUPHVz8RH
 OZ0sXuDRVCZzkdidhwhYzdBgsjHEuGRB+odocA8zaYCmjBFPPlj3zV37UMUAtyxNVziS
 NdP4Cn6o63zNj+U1SinhP04jfXPWipXO1RtMh5moQUS8J6gUn+oVAJszHb+wmT8g0U2H
 EYJPQNFf00sZnLjYxqM4tjgqSMtsPmJdHjVGcozH7LMcsAN6Q7D7Q3zI3GXuyMlWfYKn
 t1G0/qOvI0kd6rMROY7ObwsOSigOINelR5PrEVgx1wXvzID0DbEyQHbIm5UeeIS/hTii 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v9yyfjh3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Dec 2023 16:39:19 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BTGMXte028567;
	Fri, 29 Dec 2023 16:39:18 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v9yyfjh3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Dec 2023 16:39:18 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BTFqk40016600;
	Fri, 29 Dec 2023 16:39:18 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3v6c3ke3vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Dec 2023 16:39:18 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BTGdHUM15663674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 16:39:17 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E86C058059;
	Fri, 29 Dec 2023 16:39:16 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2219A58061;
	Fri, 29 Dec 2023 16:39:15 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 Dec 2023 16:39:15 +0000 (GMT)
Message-ID: <fb776d99-1956-4e1b-9afc-84f27ca40f46@linux.ibm.com>
Date: Fri, 29 Dec 2023 11:39:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rootfs: Fix support for rootfstype= when root= is
 given
Content-Language: en-US
To: Askar Safin <safinaskar@gmail.com>, Rob Landley <rob@landley.net>
Cc: gregkh@linuxfoundation.org, initramfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        zohar@linux.ibm.com
References: <CAPnZJGDcNwPLbzC99qNQ+bRMwxPU-Z0xe=TD6DWQU=0MNyeftA@mail.gmail.com>
 <d4b227de-d609-aef2-888b-203dbcf06707@landley.net>
 <CAPnZJGBeV-E_AN8GnTfkaJvRtBmCeMYYCt+O0XMsc3kDULRuKg@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAPnZJGBeV-E_AN8GnTfkaJvRtBmCeMYYCt+O0XMsc3kDULRuKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kKDHc4NgNKVYGnuWe57kEubX-peY3s2Y
X-Proofpoint-GUID: cU7McnlYahldSoVWHrdOVhsr_YZLIby2
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-29_06,2023-12-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 clxscore=1011 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312290132



On 12/21/23 17:58, Askar Safin wrote:
> Hi, Rob. And Stefan.
> 
> First of all, this patch got to linux-next (
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?qt=author&q=Stefan+Berger
> ), so it seems it soon will be in mainline.
> 
> On Thu, Dec 21, 2023 at 12:24 PM Rob Landley <rob@landley.net> wrote:
>> Can you build tmpfs on a nommu system? Last I checked the plumbing expects swap,
>> but it's been a while...
> Okay, I agree, let's not remove ramfs.
> 
> Still, I don't like this (already applied) patch. init= and rdinit=
> are two different options, and this is good. So, I think we should
> have two different options. Analogously they should be rootfstype= and
> rdrootfstype=. rootfstype= should be read by kernel when deciding how
> to mount real root (i. e. not initramfs or initrd) only and
> rdrootfstype= when deciding how to mount initramfs only. This will
> make everything cleaner. Also note that userspace tools read
> rootfstype= and assume that it always applies to real root. For
> example, this is Debian's rdinit:
> 
> https://salsa.debian.org/kernel-team/initramfs-tools/-/blob/cf964bfb4362019fd7fba1e839e403ff950dca8e/init#L103
> 
> As you can see, this shell script parses /proc/cmdline and assumes
> that rootfstype= always applies to real root. So, if someone sets
> rootfstype= to tmpfs or ramfs, this will likely break this script.

Setting the kernel boot command line option rootfstype= to tmpfs or 
ramfs was possible so far and that's what the documentation and code 
supported so far as well. The bug surfaced when root= was provided, in 
which case it was ignored.

> 
> So, I think the code should look so:
> 
> +if (IS_ENABLED(CONFIG_TMPFS)) {
> +        if (!rd_root_fs_names) // We assume rd_root_fs_names is set
> by rdrootfstype=
> +                is_tmpfs = true; // Use tmpfs if rdrootfstype= is not
> set. To get all tmpfs benefits
> +        else if (rd_root_fs_names && !!strstr(rd_root_fs_names, "tmpfs"))
> +                is_tmpfs = true;
> +}
> 
> Yes, this will slightly break compatibility. I. e. this will make
> Linux always choose tmpfs if rdrootfstype= is not present. But I think

You may find someone who doesn't like this change, either, ...

> there is nothing wrong with it. If a user cares, he will set
> rdrootfstype= . And early boot code will become a lot more clean and
> logical.
> 
> Rob, do you agree? Stefan, do you agree? Then I will write a patch,

... but go ahead.

> with doc changes (currently I use gmail web interface, of course I
> will use git send-email when I sent actual patch)
> 

