Return-Path: <linux-kernel+bounces-13747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7B9820BED
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 17:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09CE1C214E4
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 16:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AF48835;
	Sun, 31 Dec 2023 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q7vxMbXV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346E663B5;
	Sun, 31 Dec 2023 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BVFKdOv029190;
	Sun, 31 Dec 2023 16:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=I6YRMpT8hVQvu0ki6ZvCuFJGsETjq2y5ZsyPbvoVG7k=;
 b=Q7vxMbXVwyD5Yachvp29CEpiMMMW8l40JZWqOcZVLj+6tKlvaUP3k/BEOUoUQO0OwRET
 RzUkDo+9/zlzV0B4cL4UGba04cnh4wjkw/ud61xh6J7k/04mOqd475vLDJ4Sqnqr3RAi
 LG+V+9FqeIZ2JUfD71T5TZdhwE7i1CfQTS5pfuCnFiwZjy9AkNhM/0xfYATlX66XDBQW
 g59NfqqH4rleLYgT54qieMn2ut4vd3xSqc2wp/cCqyFafVu8vzqsdI4/7/5kDr3IzCWG
 23pY1OXwyNMxP1zAhp3OF99h1Mf+F54REQWYsmB4fwvgURAkbxfPMU46oSbbfC++Fl4L Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vaded821c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 Dec 2023 16:03:29 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BVG3Til023460;
	Sun, 31 Dec 2023 16:03:29 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vaded8215-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 Dec 2023 16:03:29 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BVCPBIS027261;
	Sun, 31 Dec 2023 16:03:28 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vawhsubq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 Dec 2023 16:03:28 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BVG3Rk613238788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 Dec 2023 16:03:27 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 873485805E;
	Sun, 31 Dec 2023 16:03:27 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAF5E58054;
	Sun, 31 Dec 2023 16:03:26 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 31 Dec 2023 16:03:26 +0000 (GMT)
Message-ID: <8b85253d-dd75-42e4-9a05-dafb3618269c@linux.ibm.com>
Date: Sun, 31 Dec 2023 11:03:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rootfs: Fix support for rootfstype= when root= is
 given
Content-Language: en-US
To: Rob Landley <rob@landley.net>, Askar Safin <safinaskar@gmail.com>
Cc: gregkh@linuxfoundation.org, initramfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        zohar@linux.ibm.com
References: <CAPnZJGDcNwPLbzC99qNQ+bRMwxPU-Z0xe=TD6DWQU=0MNyeftA@mail.gmail.com>
 <d4b227de-d609-aef2-888b-203dbcf06707@landley.net>
 <CAPnZJGBeV-E_AN8GnTfkaJvRtBmCeMYYCt+O0XMsc3kDULRuKg@mail.gmail.com>
 <fb776d99-1956-4e1b-9afc-84f27ca40f46@linux.ibm.com>
 <0879141d-462c-7e94-7c87-7a5b5422b8ed@landley.net>
 <e32077de-b159-4a7b-89a3-e1925239142f@linux.ibm.com>
 <fcb45898-0699-878f-0656-f570607fbed4@landley.net>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <fcb45898-0699-878f-0656-f570607fbed4@landley.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RvlU3A7eBkiAo6HjFMC2p6fIruSQ70AT
X-Proofpoint-GUID: XVVh32Ldz-OoNWI5Igy-ZRhNWgfuauK3
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-31_08,2023-12-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312310132



On 12/30/23 12:08, Rob Landley wrote:
> On 12/29/23 13:14, Stefan Berger wrote:>> That said, the code I wrote is doing a
> strstr to see if the argument's there,
>>> but doesn't care what ELSE is there, so it could easily be
>>> "rootfstype=tmpfs,ext4" and have the userspace script also filter the argument
>>> for just what it's interested in, since at that point it's NOT THE KERNEL DOING IT.
>>
>> It's a bit tricky that this particular option, that can support a
>> comma-separated list, is shared between kernel and user space and user
>> space does not already filter-out what is not relevant for it.
> 
> Debian's code sometimes has bugs, especially their initramfs stuff doesn't get a
> lot of scrutiny:
> 
> https://lkml.iu.edu/hypermail/linux/kernel/1705.2/05611.html
> https://lkml.iu.edu/hypermail/linux/kernel/1705.3/01182.html
> https://lkml.org/lkml/2017/9/13/651#:~:text=Debian's
> 
> But they're pretty good about fixing bugs pointed out to them:
> 
> https://salsa.debian.org/kernel-team/initramfs-tools/-/commit/49e4a0555f51
> 
> The kernel having more capabilities here than Debian's userspace does isn't new,
> it's what gives debian's userspace the opportunity to gain new capabilities.
> 
> Although in this case, the patch in question still isn't in lkml 5 years later
> because Debian development is much more responsive than linux-kernel:
> 
> https://lkml.iu.edu/hypermail/linux/kernel/2302.2/05597.html
> 
>>>> Setting the kernel boot command line option rootfstype= to tmpfs or
>>>> ramfs was possible so far and that's what the documentation and code
>>>> supported so far as well. The bug surfaced when root= was provided, in
>>>> which case it was ignored.
>>>
>>> No, as I explained when I wrote the initmpfs code in 2013 when you say root= you
>>> are explicitly requesting the kernel mount a second file system over rootfs
>>
>>  From the perspective of needing xattr support in initramfs it's
>> unfortunately not so obvious what the filesystem type of the kernel's
>> rootfs (presumably the 1st file system) has to do with the option given
>> for the 2nd filesystem. Though the Debian scripts are the bigger problem
>> it seems.
> 
> Ping Ben if initramfs-tools needs updating?
> 
> I've been following the initramfs xattr support threads forever:
> 
> https://lkml.iu.edu/hypermail/linux/kernel/2207.3/06939.html
> 
> I'm happy to add new format support to toybox cpio if anybody comes to an
> agreement on what that should be, but last time there was "as long as we're here
> 32 bit timestamps" and "sparse file support could be" and various bikeshedding...
> 
> Was there a new thread I didn't get cc'd on? The last I have is... July 2022 I
> think?
> 
>> However, for those one could argue that the Debian scripts
>> could be updated and for as long as they are not able to filter-out the
>> tmpfs or ramfs options we are interested in one cannot pass these
>> options or a comma-separated list on systems that run the current Debian
>> scripts.
> 
> You can argue that current userspace does not take full advantage of the
> existing kernel API, sure.
> 
>>> (that's what root= MEANS), and thus don't bother making it a (more expensive)
>>> tmpfs because it's not sticking around.
>>
>> That's true unless you want to use IMA signature enforcement in the
>> initramfs already and tmpfs is now required.
> 
> I agree that if you want to add a new requirement, you may need to modify userspace.
> 
> Let me see if I understand your problem: it sounds like debian's initramfs-tools
> overloads the root= and rootfstype= arguments parsed by the kernel to have a
> second meaning (the kernel uses them for one thing, you want to use them for
> something else, and there's currently a semantic gap between the two.)

My intention is to be able to pass rootfstype= to the kernel and have it 
interpreted correctly in the presence of root=, which currently does not 
work. User space tools that interpret the value of rootfstype= as if 
this option belonged to user space is not helpful, though it should be 
easy to teach the user space scripts to strip a leading 'tmpfs,' or 
'ramfs,' from the rootfstype value and let them interpret the rest.

> 
> You want to add a new capability requiring a new build dependency in the
> initramfs-tools package because it's doing new stuff, but there cannot be any
> OTHER changes made to initramfs-tools, so the kernel should change its existing
> semantics instead.

I haven't even thought of what would need to be added to Debian's 
initramfs-tools package since my primary goal was to enable tmpfs for 
the initramfs on OpenBMC where we then read the xattr values from a file 
and write them into the filesystem because cpio format doesn't carry 
them. Also, I didn't expect that any user space tools would try to 
handle a kernel command line option as if it was theirs.

> 
> You can't NOT provide root=, and you can't provide initramfstype=tmpfs...

I only know about rootfstype= ( 
https://github.com/torvalds/linux/blob/master/init/do_mounts.c#L128 ). 
If currently handling of rootfstype= in presence of root= is not 
considered a bug and we should introduce initramfstype= instead, we 
could do that. But doesn't this become a bit confusing if rootfstype= 
can be passed when root= is absent but then initramfstype= must be used 
when root= is present?

This is 'our' patch describing the issue: 
https://github.com/torvalds/linux/blob/master/init/do_mounts.c#L128

> either, and those are the two existing ways to tell rootfs to be tmpfs instead
> of ramfs. You'd like to add a third way to specify the same thing.

Do you have a link to initramfstype= handling in kernel code?


   Stefan
> 
> Do I have that right?
> 
>>      Stefan
> 
> Rob

