Return-Path: <linux-kernel+bounces-80725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82392866BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0738EB23434
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F7B1C6B8;
	Mon, 26 Feb 2024 08:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b="sEZNcyx+"
Received: from mail-108-mta2.mxroute.com (mail-108-mta2.mxroute.com [136.175.108.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBF71CD1E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708934859; cv=none; b=swhVraNFAghbHCLIwHzEDO+MvDYaFwvxP6heKNv9XxPP+H7GpFbRXdkN2nD6qKfzrex9xSUwyWzufnsOyPEL0sjqjHCSBeSI85xpQRBWBQIIfIKuFPPcCTwIAI33gD1fKfLmzByGDN3OkfrhVq6pHevWqGSDsZrVLjGlx6FkpZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708934859; c=relaxed/simple;
	bh=vootlFZEOCE6TAnINZHO7Mf4LKTaoH3ugeK6Qs3CUAA=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=g8vMYqTlaDke2SOy4lyeMjokcqJHKOTJ4g0RfZzke+jhSl0oI5+CQH1I0kQzjHMp0cH43Bpbja8mApEuTQdlY7/alLiVMejnR+xu2b0Z2PMbOXR5tJt9DkAApnT/2Afcr3Ffq7/Zs1UgNQ/5VaLmP5vhqGBuYxQsmATyW1OxLLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org; spf=pass smtp.mailfrom=damenly.org; dkim=pass (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b=sEZNcyx+; arc=none smtp.client-ip=136.175.108.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=damenly.org
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta2.mxroute.com (ZoneMTA) with ESMTPSA id 18de46fbcc10000466.011
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 26 Feb 2024 08:02:24 +0000
X-Zone-Loop: d2604e651812055684c4dfeb04a2122b0acb4637cce9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=damenly.org
	; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	In-reply-to:Date:Subject:Cc:To:From:References:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=vootlFZEOCE6TAnINZHO7Mf4LKTaoH3ugeK6Qs3CUAA=; b=sEZNcyx+9xwbQ2Hj3nG0BrFCWo
	Cl0Gdg3VTloKvT6KTQiJYdZJzJUnW8c+MT0aiEHLpqEVxGxjH2F9XEoZLFvgNcEI4tPEhKSGeRKEl
	6Z1ZV3mLM5MWxbD4zj7ib0DVtfMa/iq1GXicidru0prBO4KgkMeZNBVSHjejhqqiklR5AEqfbpPgQ
	cMYQBJafFeHFDmZR/in2k0F9gDFV88UXjKB9R8g5w5i0Oac1xzRW8X4obuQnegQakzdDgJqTIig9N
	y29u7sny994l2uLV5DO19IZkw+sMyyzwoiO3hYSv8IRmkBottCu5wDUFM6x5F8N/Btas44Au6bCLZ
	Boge0k9w==;
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <Zb2wxIpf7uYV6Vya@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
 <528ce926-6f17-c1ea-8e77-c7d5d7f56022@huaweicloud.com>
 <ZcE4mGXCDwjqBXgf@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
 <1fdbfcf8-1ee9-4079-e84e-6e2c1121491b@huaweicloud.com>
 <ZcGuRIrZJaEtXjPh@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
 <CAPhsuW6arbEmRUK3xG1XVjra3BtSx9_wFe+QKDBbTgb3DgYXig@mail.gmail.com>
 <ZcVhA_IqXH2Pg79t@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
 <CAPhsuW6VqSRUsB2oQ+Hmf-0+2gfKHgN1skvvUwDmqDOxJvEKtA@mail.gmail.com>
User-agent: mu4e 1.7.5; emacs 28.2
From: Su Yue <l@damenly.org>
To: Song Liu <song@kernel.org>
Cc: Benjamin Marzinski <bmarzins@redhat.com>, Yu Kuai
 <yukuai1@huaweicloud.com>, mpatocka@redhat.com, heinzm@redhat.com,
 xni@redhat.com, blazej.kucman@linux.intel.com, agk@redhat.com,
 snitzer@kernel.org, dm-devel@lists.linux.dev, jbrassow@f14.redhat.com,
 neilb@suse.de, shli@fb.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v5 00/14] dm-raid/md/raid: fix v6.7 regressions
Date: Mon, 26 Feb 2024 15:58:02 +0800
In-reply-to: <CAPhsuW6VqSRUsB2oQ+Hmf-0+2gfKHgN1skvvUwDmqDOxJvEKtA@mail.gmail.com>
Message-ID: <34tfodss.fsf@damenly.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Id: l@damenly.org


On Fri 09 Feb 2024 at 14:37, Song Liu <song@kernel.org> wrote:

> On Thu, Feb 8, 2024 at 3:17=E2=80=AFPM Benjamin Marzinski=20
> <bmarzins@redhat.com> wrote:
>>
> [...]
>> >
>> > I am not able to get reliable results from=20
>> > shell/lvconvert-repair-raid.sh
>> > either. For 6.6.0 kernel, the test fails. On 6.8-rc1 kernel,=20
>> > the test fails
>> > sometimes.
>> >
>> > Could you please share more information about your test=20
>> > setup?
>> > Specifically:
>> > 1. Which tree/branch/tag are you testing?
>> > 2. What's the .config used in the tests?
>> > 3. How do you run the test suite? One test at a time, or all=20
>> > of them
>> > together?
>> > 4. How do you handle "test passes sometimes" cases?
>>
>> So, I have been able to recreate the case where=20
>> lvconvert-repair-raid.sh
>> keeps failing. It happens when I tried running the reproducer=20
>> on a virtual
>> machine made using a cloud image, instead of one that I=20
>> manually
>> installed. I'm not sure why there is a difference. But I can=20
>> show you
>> how I can reliably recreate the errors I'm seeing.
>>
>>
>> Create a new Fedora 39 virtual machine with the following=20
>> commands (I'm
>> not sure if it is possible to reproduce this on a machine using=20
>> less
>> memory and cpus, but I can try that if you need me to. You=20
>> probably also
>> want to pick a faster Fedora Mirror for the image location):
>> # virt-install --name repair-test --memory 8192 --vcpus 8=20
>> --disk size=3D40
>> --graphics none --extra-args "console=3DttyS0" --osinfo
>> detect=3Don,name=3Dfedora-unknown --location
>> https://download.fedoraproject.org/pub/fedora/linux/releases/39/Server/x=
86_64/os/
>>
>
> virt-install doesn't work well in the my daily dev server. I=20
> will try on a
> different machine.
>
>> Install to the whole virtual drive, using the default LVM=20
>> partitioning.
>> Then ssh into the VM and run the following commands to setup=20
>> the
>> lvm2-testsuite and 6.6.0 kernel:
>>
> [...]
>
>>
>> Rerun the lvm2-testsuite with the same commands as before:
>>
>> # mount -o remount,dev /tmp
>
> This mount trick helped me run tests without a full image (use
> CONFIG_9P_FS to reuse host file systems instead). Thanks!
>
>> # cd ~/lvm2
>> # make check T=3Dlvconvert-repair-raid.sh
>>
>> This fails about 20% of the time, usually at either line 146 or=20
>> 164. You
>> can check by running the following command when the test fails.
>
> However, I am seeing lvconvert-repair-raid.sh passes all the=20
> time
> with both 6.6 kernel and 6.8+v5 patchset. My host system is
> CentOS 8.
>

shell/lvconvert-repair-raid.sh fails for SLES 15SP5 + upstream=20
lvm2 +
v6.8+v5 patchset but not with v6.6 kernel.

--
Su

> I guess we will have to run more tests.
>
> DM folks, please also review the set. We won't be able to ship=20
> the
> dm changes without your thorough reviews.
>
> Thanks,
> Song

