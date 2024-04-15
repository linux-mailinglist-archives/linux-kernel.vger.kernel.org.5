Return-Path: <linux-kernel+bounces-144428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2475A8A4651
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C55AB212DB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 00:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CA6ED8;
	Mon, 15 Apr 2024 00:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valvesoftware.com header.i=@valvesoftware.com header.b="CcgAb6vm"
Received: from us-smtp-delivery-172.mimecast.com (us-smtp-delivery-172.mimecast.com [170.10.133.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AE1363
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 00:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713140519; cv=none; b=rNskJy7KHXW4HFJ/RQdSuzHif0qCXRNsltAUIq7CTEZ/sDGSHp+ZlHAX9DTMgEpoBLOP9/CAFonNsCy9V1uy8oDauumrDTXNFkRxSlYCl/N8kpk2j+iXVvslLaD/JscSngEU2vY7Y98yAVbr8fz1Tul9inQCRALzVw/joog+k0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713140519; c=relaxed/simple;
	bh=fxlv8FmJM5auEJL0Zvy87zZ+pJvT6TOixKP9qok45EQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Yl5Apm03wVhJx3DKZRBZcb7bShUc92Hs1TZw5z24O3AdG8sM3Uy5ao866uKRFEjLs8cQCnQaOpu4Q/SbDr3A8KTcd2JCpuwOOuLpg6fXzgoumFqAmquPK3UXWezfIVkHC/GU6OBF5iIo5QrhARkkriTZqjnghSW1OBI3VvZ4al4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=valvesoftware.com; spf=pass smtp.mailfrom=valvesoftware.com; dkim=pass (1024-bit key) header.d=valvesoftware.com header.i=@valvesoftware.com header.b=CcgAb6vm; arc=none smtp.client-ip=170.10.133.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=valvesoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valvesoftware.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valvesoftware.com;
	s=mc20150811; t=1713140515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WBZBlXLRr8bNCY1UIk6T1jSX979O1QOnktwa6Dz9jug=;
	b=CcgAb6vmwOLA1ZGZ29Ala8T+avmq8clyj5vZwwwbSamalueVYL4rL9+TggsBxDV7ZXCtqn
	vI4bdhDGiIlWZILWRxmP2QXK76W1e6uJUBWvZgtGBSZ/RDfnNhu8n6TGF9vy7oEXA8ZS7q
	cZ6Zw6bbNZ/5U9O2wePjEaA3Fcmyt5c=
Received: from smtp-01-blv1.valvesoftware.com
 (smtp-01-blv1.valvesoftware.com [208.64.203.181]) by relay.mimecast.com
 with ESMTP with STARTTLS (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384)
 id us-mta-246-7O_j_iWVPoqthI1I-eYxHg-1; Sun, 14 Apr 2024 20:21:54 -0400
X-MC-Unique: 7O_j_iWVPoqthI1I-eYxHg-1
Received: from antispam.valve.org ([172.16.1.107])
	by smtp-01-blv1.valvesoftware.com with esmtp (Exim 4.93)
	(envelope-from <pgriffais@valvesoftware.com>)
	id 1rwA6b-003F8U-Cl
	for linux-kernel@vger.kernel.org; Sun, 14 Apr 2024 17:21:53 -0700
Received: from antispam.valve.org (127.0.0.1) id h3hpi20171sh for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 17:21:53 -0700 (envelope-from <pgriffais@valvesoftware.com>)
Received: from mail2.valvemail.org ([172.16.144.23])
	by antispam.valve.org ([172.16.1.107]) (SonicWall 10.0.15.7233)
	with ESMTP id o202404150021530031966-5; Sun, 14 Apr 2024 17:21:53 -0700
Received: from [172.16.36.169] (172.16.36.169) by mail2.valvemail.org
 (172.16.144.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 14 Apr
 2024 17:21:52 -0700
Message-ID: <8f6e2d69-b4df-45f3-aed4-5190966e2dea@valvesoftware.com>
Date: Sun, 14 Apr 2024 17:21:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Increase Default vm_max_map_count to Improve Compatibility with
 Modern Games
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, David Hildenbrand
	<david@redhat.com>, Oleksandr Natalenko <oleksandr@natalenko.name>,
	<linux-kernel@vger.kernel.org>, <vincentdelor@free.fr>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <566168554.272637693.1710968734203.JavaMail.root@zimbra54-e10.priv.proxad.net>
 <13499186.uLZWGnKmhe@natalenko.name>
 <1a91e772-4150-4d28-9c67-cb6d0478af79@redhat.com>
 <ugjnhfiwuoslupkbmrrbbxxdosotzpqjfljebzj4dkuibmf6sr@kuew2qemsen4>
From: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
In-Reply-To: <ugjnhfiwuoslupkbmrrbbxxdosotzpqjfljebzj4dkuibmf6sr@kuew2qemsen4>
X-ClientProxiedBy: mail1.valvemail.org (172.16.144.22) To mail2.valvemail.org
 (172.16.144.23)
X-Mlf-DSE-Version: 6871
X-Mlf-Rules-Version: s20240405180538; ds20230628172248;
	di20240404161241; ri20160318003319; fs20240313174141
X-Mlf-Smartnet-Version: 20210917223710
X-Mlf-Envelope-From: pgriffais@valvesoftware.com
X-Mlf-Version: 10.0.15.7233
X-Mlf-License: BSV_C_AP____
X-Mlf-UniqueId: o202404150021530031966
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: valvesoftware.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable



On 4/12/24 10:18 AM, Liam R. Howlett wrote:
>=20
> Adding Pierre-Loup to cc list.
>=20
>=20
> * David Hildenbrand <david@redhat.com> [691231 23:00]:
>> On 02.04.24 09:34, Oleksandr Natalenko wrote:
>>> Hello.
>>>
>>> On st=C5=99eda 20. b=C5=99ezna 2024 22:05:34, CEST vincentdelor@free.fr=
 wrote:
>>>> Hello,
>>>>
>>>> I am writing to highlight an issue impacting many Linux users, especia=
lly those who enjoy modern gaming. The current default setting of `vm_max_m=
ap_count` at 65530 has been linked to crashes or launch failures in several=
 contemporary games.
>>>>
>>>> To address this, I have opened a detailed bug report (218616 =E2=80=93=
 Increase Default vm_max_map_count to Improve Gaming Experience on Linux) a=
vailable at: 218616 =E2=80=93 Increase Default vm_max_map_count to Improve =
Gaming Experience on Linux (kernel.org) .
>>>>
>=20
> This is change is getting more traction as distributions switch to a
> higher number of VMAs.  I feel we need to educate them as to what this
> really means and why it is unnecessary and wrong.
>=20
>>>>
>>>> We have identified that several modern games such as Hogwarts Legacy, =
Star Citizen, and others experience crashes or fail to start on Linux due t=
o the default `vm_max_map_count` being set to 65530. These issues can be mi=
tigated by increasing the `vm_max_map_count` value to over 1048576, which h=
as been confirmed to resolve the crashes without introducing additional bug=
s related to map handling.
>>>>
>>>> This issue affects a wide range of users and has been noted in distrib=
utions like Fedora and Pop!_OS, which have already adjusted this value to a=
ccommodate modern gaming requirements.
>>>>
>>>> For reference, here is the change for Fedora:
>>>> https://fedoraproject.org/wiki/Changes/IncreaseVmMaxMapCount
>>>>
>>>> Here is a list of games affected by this low value in vm_max_map_count=
 as reported to Valve:
>>>>
>>>> THE FINALS
>>>> https://github.com/ValveSoftware/Proton/issues/7317#issuecomment-19748=
37850
>>>>
>>>> Hogwarts Legacy
>>>> https://github.com/ValveSoftware/Proton/issues/6510#issuecomment-14227=
81100
>>>>
>>>> DayZ
>>>> https://github.com/ValveSoftware/Proton/issues/3899#issuecomment-13043=
97069
>>>>
>>>> Counter-Strike 2
>>>> https://github.com/ValveSoftware/Proton/issues/2704#issuecomment-17051=
99788
>>>>
>>>>
>=20
> Most of these do not have the vma information available anymore, if it
> was there (expired pastebin links, etc).
>=20
> ...
>=20
>>>>
>>>> **Affected Games:**
>>>> - Hogwarts Legacy
>>>> - Star Citizen
>>>> - THE FINALS
>>>> - DayZ
>>>> - Counter-Strike 2
>>>> - Payday 2
>>>> - (and potentially others)
>>>>
>>>> **References:**
>>>> - Fedora's change documentation: https://fedoraproject.org/wiki/Change=
s/IncreaseVmMaxMapCount
>>>> - Various user reports and confirmations on gaming performance improve=
ment with increased `vm_max_map_count`.
>=20
> Absolutely not.  This will do nothing for performance.  The game may run
> vs not run, but it won't get faster.

It's possible / likely the user was confused about the performance=20
impact, here. The reason we make that change is to enable affected games=20
to run at all, that would otherwise crash when they reach the limit.

>=20
> ...
>=20
>>
>> Using a high VMA count usually implies that the application is doing
>> something suboptimal. Having many VMAs can degrade performance of MM
>> operations and result in memory waste.
>>
>> Running into VMA limits usually implies that the application is not
>> optimized and should handle things differently. Likely, the memory alloc=
ator
>> is doing something "bad" (e.g., mmap()+munmap() instead of MADV_DONTNEED=
)
>> and should be optimized.
>>
>=20
> To be clear, what you are doing here is akin to adding more memory to
> your system when there is a memory leak.  This is not the solution you
> should be pushing.  Ironically, this is using more memory and performing
> worse than it should.  At best, the limit increase is a workaround for
> buggy programs.
>=20
> At worst, you are enabling bad things to keep happening and normalising
> poor programming choices.  Please put pressure on the applications that
> clearly have issues.

We don't get to prescribe what those applications do. The fact of the=20
matter is that there are several high-performance memory allocators in=20
wide use by game applications that make heavy internal use of mmap(),=20
and that using hundreds of thousands of different memory mappings is=20
well supported on the platform those applications were written for. (or=20
mapping regions with different permissions, which results in different=20
regions after platform translation to Linux happens within Wine)

Pointing out that there exists one game that doesn't happen to do that=20
is not terribly useful for the purpose of this discussion.

The problem statement seems pretty simple - distributions that want to=20
support those usecases out of the box can make that change, like we've=20
done for years on SteamOS. On those that don't, users of those=20
applications will have to discover and learn to apply the change by hand=20
after having a likely sub-par experience trying to get their game up and=20
running.

I've yet to hear a specific downside of making the change other than a=20
real concern about DoS of kernel memory in another discussion - it seems=20
to me like there is much lower hanging fruit for DoSing a Linux system=20
you have shell access to, at the moment.

Thanks,
  - Pierre-Loup

>=20
> To put this into perspective, normal applications on Linux use in the
> 100s.  Insane applications (chromium) use 1000 to 2000. The heavier user
> is Android and that uses in the 1000s regularly (usually topping out at
> around 3000). You are allowing one process to use over 65,530 vmas.
>=20
> Again, this is per process.
>=20
> Currently, if you run Wolfenstein II: The New Colossus (proton game),
> there are 4 proton processes with 115, 104, 99, and 24 vmas.  I wanted a
> newer example, but steam (or nvidia) is having A Day on my gaming PC and
> won't start.
>=20
> You are enabling (and normalising across multiple popular distributions)
> a change from less than 120 to 1048576.  That is an increas of ~870x
> of virtual memory areas - not tiny chunks of memory, areas that can span
> large amounts of memory.  Assuming the *best* scenario in the buggy
> programs, you'd use 65531 vmas - that is still a multiple of 546x the
> number used by wolfenstein's largest thread.
>=20
>> I don't think we should be raising the limit for everybody out there.
>=20
> If there is an underlying technical reason for needing this number of
> vmas, then it isn't provided.  I'm going to guess it's DRM/anti-cheat
> that needs fixing.
>=20
> I'd like the problem to please be fixed and not hide it.  You are at a
> performance disadvantage with the current approach - and enabling others
> to do the same.
>=20
> Thank you,
> Liam
>=20


