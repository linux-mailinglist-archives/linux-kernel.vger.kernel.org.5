Return-Path: <linux-kernel+bounces-13209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 395F082012B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 20:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CAF41C21952
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 19:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9620712E72;
	Fri, 29 Dec 2023 19:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dPi6bE+r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2292F12E44;
	Fri, 29 Dec 2023 19:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BTIWaVa013888;
	Fri, 29 Dec 2023 19:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=J3eS5bDnSos7ysUiTU5ykNlo718JRz72hO5XekH6WfM=;
 b=dPi6bE+r1Xouurm9nQW9ote0HhNS/tqIaPZ3nAg6bEMM7RdBCy94nivliixH/aw7WnQB
 5yP2nvnSmnNRTnrbw1zYUcvYdelGP2sNqjLKix/Y9AUjsflspllD6fmzMJ3ulJmREGVF
 qqHxP4VyfCA+askEk924VEOflpfVWPse1a9Ymtu9RnIrNCKHI1xP3lYLDD+wj3THzRAd
 M4R0TM4wlrO0hIIrAVlICkWBGr3kFO/xMpHPv8WvENChNQCn1TyR7PXHB1mkhjEnexwD
 KuFJySBAsfiLTg/sDgaUSdyuT/Yyfbuti0MIrApkD4D57ozMtn4QXczv/lG9AMBpFX82 dA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3va3fu8q0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Dec 2023 19:14:57 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BTJEvpW028058;
	Fri, 29 Dec 2023 19:14:57 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3va3fu8q0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Dec 2023 19:14:57 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BTG955t008302;
	Fri, 29 Dec 2023 19:14:56 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3v6ck26m25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Dec 2023 19:14:56 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BTJEuS863045964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 19:14:56 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59D3E58058;
	Fri, 29 Dec 2023 19:14:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D111F58057;
	Fri, 29 Dec 2023 19:14:55 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 Dec 2023 19:14:55 +0000 (GMT)
Message-ID: <e32077de-b159-4a7b-89a3-e1925239142f@linux.ibm.com>
Date: Fri, 29 Dec 2023 14:14:55 -0500
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
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <0879141d-462c-7e94-7c87-7a5b5422b8ed@landley.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y6eSWf-VkW_26zwfMq9tfrKvvNMM_ug3
X-Proofpoint-ORIG-GUID: 3UUtt-e5-9_VNJM8V50AVMIQ4E8SX2im
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
 definitions=2023-12-29_08,2023-12-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312290154



On 12/29/23 13:35, Rob Landley wrote:
> On 12/29/23 10:39, Stefan Berger wrote:> On 12/21/23 17:58, Askar Safin wrote:
>>> Hi, Rob. And Stefan.
>>>
>>> First of all, this patch got to linux-next (
>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?qt=author&q=Stefan+Berger
>>> ), so it seems it soon will be in mainline.
>>>
>>> On Thu, Dec 21, 2023 at 12:24 PM Rob Landley <rob@landley.net> wrote:
>>>> Can you build tmpfs on a nommu system? Last I checked the plumbing expects swap,
>>>> but it's been a while...
>>> Okay, I agree, let's not remove ramfs.
>>>
>>> Still, I don't like this (already applied) patch. init= and rdinit=
>>> are two different options,
> 
> Because they control two different things which are often used at the same time.
> (Debian has an initramfs that hands off to the final root filesystem, for
> example. Hence the initramfs-tools package that runs every time apt-get updates
> the kernel.)
> 
> So being able to specify rdinit= to intercept the ramfs layer or init= to
> intercept the root= layer made sense, because they did different things.
> 
> But the only reason to specify anything nontrivial for the initramfs
> _filesystem_ mount properties is because you intend to stay there. They don't
> get used together.
> 
>>> and this is good.
> 
> Eh, not really. Strange legacy decision we're now stuck with. The kernel only
> ever runs one init task per boot. If init= was _also_ checked to see which file
> to run out of initramfs (and the plumbing still justs silently fails and moves
> on if it's not found) then the debian script would have been forced to do INIT=
> or similar to override the overmounted root's init task separately from initrd's
> init task, making it clear a script (not the kernel) is making that decision.
> 
> But that would have been a user-visible change, and when initramfs was going in
> they were trying to avoid user-visible changes that would force sysadmins to
> learn new stuff because the plumbing changed out from under them. (Like the
> change you're proposing now would.)
> 
>>> So, I think we should
>>> have two different options. Analogously they should be rootfstype= and
>>> rdrootfstype=.
> 
> You can't have a root= type of initramfs or tmpfs. The specified values can't
> overlap. The plumbing I wrote responds to specific values but otherwise leaves
> it for later users.
> 
>>> https://salsa.debian.org/kernel-team/initramfs-tools/-/blob/cf964bfb4362019fd7fba1e839e403ff950dca8e/init#L103
>>>
>>> As you can see, this shell script parses /proc/cmdline and assumes
>>> that rootfstype= always applies to real root.
> 
> The script is running _in_ the initramfs, which is already loaded and running at
> that point. Meaning the _kernel_ will not parse root= at that point, userspace
> has to do it.
> 
>>> So, if someone sets
>>> rootfstype= to tmpfs or ramfs, this will likely break this script.
> 
> Which was the same 10 years ago?
> 
> The script is running in a context where initramfs is not persistent, so
> overriding it to be a tmpfs has no benefit. (I mean you _can_... Nobody does,
> because we're gonna switch_root off of it.)
> 
> And once code _is_ running in initramfs, the kernel's internal root= automounter
> will never run. The initramfs code can parse /proc/cmdline to use the same
> arguments as the kernel, or it could much more easily use the "any unrecognized
> arguments get set as environment variables in PID 1" and use ROOT= or similar,
> like many scripts do.
> 
> Modifying kernel code that NEVER RUNS in the case you're pointing out seems
> silly to me.
> 
> That said, the code I wrote is doing a strstr to see if the argument's there,
> but doesn't care what ELSE is there, so it could easily be
> "rootfstype=tmpfs,ext4" and have the userspace script also filter the argument
> for just what it's interested in, since at that point it's NOT THE KERNEL DOING IT.

It's a bit tricky that this particular option, that can support a 
comma-separated list, is shared between kernel and user space and user 
space does not already filter-out what is not relevant for it.

> 
>> Setting the kernel boot command line option rootfstype= to tmpfs or
>> ramfs was possible so far and that's what the documentation and code
>> supported so far as well. The bug surfaced when root= was provided, in
>> which case it was ignored.
> 
> No, as I explained when I wrote the initmpfs code in 2013 when you say root= you
> are explicitly requesting the kernel mount a second file system over rootfs

 From the perspective of needing xattr support in initramfs it's 
unfortunately not so obvious what the filesystem type of the kernel's 
rootfs (presumably the 1st file system) has to do with the option given 
for the 2nd filesystem. Though the Debian scripts are the bigger problem 
it seems. However, for those one could argue that the Debian scripts 
could be updated and for as long as they are not able to filter-out the 
tmpfs or ramfs options we are interested in one cannot pass these 
options or a comma-separated list on systems that run the current Debian 
scripts.

> (that's what root= MEANS), and thus don't bother making it a (more expensive)
> tmpfs because it's not sticking around.

That's true unless you want to use IMA signature enforcement in the 
initramfs already and tmpfs is now required.

    Stefan

