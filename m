Return-Path: <linux-kernel+bounces-147814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 875D08A7A00
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1259B22BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15366FBE;
	Wed, 17 Apr 2024 01:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valvesoftware.com header.i=@valvesoftware.com header.b="QsduHai2"
Received: from us-smtp-delivery-172.mimecast.com (us-smtp-delivery-172.mimecast.com [170.10.133.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D31463A9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 01:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713315877; cv=none; b=bYPtYss/Fji/P/vOLErOI/wXcKmKLTMxyLRTYYi3cGdzx939Rz4ma8Wa4VLUgncKYq4CVKpu70qjD3w//WsdpCuMePNZDggPHTDLYFn3TKk8gRRQUp96TBS+IUEZHlWr5eC/EkxvFAJ+PQnVyLPNy9xoHrpA6RCKLRuRYlUHOq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713315877; c=relaxed/simple;
	bh=N1lT+mJnL86zFdSUyURXCrmGq386bNILco2Zo9yPtvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HxNV6F/6BDC2VWRBOr9Cm+cqh0ZtZRF2Cgn15reJXucCRROEnmQXHBtehd8p6FrD5P1bfDWdigNxADAIQTbCcsEdIQiQhuZDFVSH0vdDp6tVhy2YUtP25RhulirSeUC2YSYn+Y3F7EYKrHcLLBKS+aAqyfEvuzMlXED6/Z009AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=valvesoftware.com; spf=pass smtp.mailfrom=valvesoftware.com; dkim=pass (1024-bit key) header.d=valvesoftware.com header.i=@valvesoftware.com header.b=QsduHai2; arc=none smtp.client-ip=170.10.133.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=valvesoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valvesoftware.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valvesoftware.com;
	s=mc20150811; t=1713315873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6FeMTOebIWiBtUZKkliwaGESMMJVIbyv1q51gFBv61g=;
	b=QsduHai2Ny5AYGAWfF8MhHL//wDu2pn8zgRlXuzErku8vausMchVnWI133rRDK7PM4O2d5
	sYHJbX6pD/1yMdr5N08R4wD4kqlUObKTQFgVjY4zZiAKjJoho2C2oNBLN6O4uvHU8lSF5H
	QGX6vNP0h9WBEQ5ikk5fR/xKKAsYsI8=
Received: from smtp-01-blv1.valvesoftware.com
 (smtp-01-blv1.valvesoftware.com [208.64.203.181]) by relay.mimecast.com
 with ESMTP with STARTTLS (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384)
 id us-mta-644-_lge5XsdP6-W0TcXhEoWVQ-1; Tue, 16 Apr 2024 21:04:32 -0400
X-MC-Unique: _lge5XsdP6-W0TcXhEoWVQ-1
Received: from antispam.valve.org ([172.16.1.107])
	by smtp-01-blv1.valvesoftware.com with esmtp (Exim 4.93)
	(envelope-from <pgriffais@valvesoftware.com>)
	id 1rwtix-00CDi0-N9
	for linux-kernel@vger.kernel.org; Tue, 16 Apr 2024 18:04:31 -0700
Received: from antispam.valve.org (127.0.0.1) id h3sg1u0171sq for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:04:31 -0700 (envelope-from <pgriffais@valvesoftware.com>)
Received: from mail2.valvemail.org ([172.16.144.23])
	by antispam.valve.org ([172.16.1.107]) (SonicWall 10.0.15.7233)
	with ESMTP id o202404170104310062776-5; Tue, 16 Apr 2024 18:04:31 -0700
Received: from [172.16.36.23] (172.16.36.23) by mail2.valvemail.org
 (172.16.144.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 16 Apr
 2024 18:04:31 -0700
Message-ID: <8360ec33-65f1-497f-8230-665b4328e1c0@valvesoftware.com>
Date: Tue, 16 Apr 2024 18:04:30 -0700
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
 <8f6e2d69-b4df-45f3-aed4-5190966e2dea@valvesoftware.com>
 <ht35j3ig4reppggvpcjpjc7gotg6ndrjwvwfiqvxrwrtr4iauh@kw46hnsliy5l>
From: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
In-Reply-To: <ht35j3ig4reppggvpcjpjc7gotg6ndrjwvwfiqvxrwrtr4iauh@kw46hnsliy5l>
X-ClientProxiedBy: mail1.valvemail.org (172.16.144.22) To mail2.valvemail.org
 (172.16.144.23)
X-Mlf-DSE-Version: 6871
X-Mlf-Rules-Version: s20240412180756; ds20230628172248;
	di20240404161241; ri20160318003319; fs20240313174141
X-Mlf-Smartnet-Version: 20210917223710
X-Mlf-Envelope-From: pgriffais@valvesoftware.com
X-Mlf-Version: 10.0.15.7233
X-Mlf-License: BSV_C_AP____
X-Mlf-UniqueId: o202404170104310062776
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: valvesoftware.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable



On 4/15/24 12:57 PM, Liam R. Howlett wrote:
> * Pierre-Loup A. Griffais <pgriffais@valvesoftware.com> [240414 20:22]:
>>
>>
> ...
>=20
>>>
>>> To be clear, what you are doing here is akin to adding more memory to
>>> your system when there is a memory leak.  This is not the solution you
>>> should be pushing.  Ironically, this is using more memory and performin=
g
>>> worse than it should.  At best, the limit increase is a workaround for
>>> buggy programs.
>>>
>>> At worst, you are enabling bad things to keep happening and normalising
>>> poor programming choices.  Please put pressure on the applications that
>>> clearly have issues.
>>
>> We don't get to prescribe what those applications do. The fact of the ma=
tter
>> is that there are several high-performance memory allocators in wide use=
 by
>> game applications that make heavy internal use of mmap(), and that using
>> hundreds of thousands of different memory mappings is well supported on =
the
>> platform those applications were written for. (or mapping regions with
>> different permissions, which results in different regions after platform
>> translation to Linux happens within Wine)
>=20
> Thank you for the information on the situation that causes the kernel to
> use such a large number of vmas.
>=20
> The mmap operations will run faster if there are significantly less
> vmas.  Having such a large number of objects will cause the faulting of
> information into the memory to be slower, and that would hold true for
> all platforms.
>=20
> If this is for high-performance, then it would be unlikely that it was
> designed to run with 65,530 objects to search.  It is also odd that
> there are several allocators running into the same issue. If I were to
> guess, the allocators are trying to bypass the operating systems use of
> memory and implement another way of tracking it specific to your usecase
> for speed.  It sounds like it is being translated incorrectly and
> causing a monster data structure to track it on the kernel side.
>=20
> If it's a translation layer in wine making a decision on how to
> translate a particular set of calls then it could be fixed, or at least
> examined for inefficiencies.

I mentioned translation because it can play a role if the original=20
mappings contain regions with different permissions, as it would need to=20
translate those into several different mappings on Linux, but I wouldn't=20
expect it's really having a meaningful effect. By and large, I think=20
those mappings are coming as-is through the app.

>=20
> Either way, the performance will be sub-optimal on the page fault path
> (probably the most common) and any other path that uses such a large
> number of vmas.
>=20
>>
>> Pointing out that there exists one game that doesn't happen to do that i=
s
>> not terribly useful for the purpose of this discussion.
>=20
> I provided the data I could collect reasonably quickly, but the scale of
> the difference was the important part of my statement.
>=20
>>
>> The problem statement seems pretty simple - distributions that want to
>> support those usecases out of the box can make that change, like we've d=
one
>> for years on SteamOS. On those that don't, users of those applications w=
ill
>> have to discover and learn to apply the change by hand after having a li=
kely
>> sub-par experience trying to get their game up and running.
>=20
> This number of vmas is indicating an issue with the utilisation of the
> virtual memeory areas.  Increasing the limit is allowing the game to
> run, but it will not be performant. It is unfortunate that the solution
> was to increase the value.

Games don't necessarily care if mmap() (and ensuing faults) is a bit=20
slower than the fastest case. Doing such an operation is already=20
considered a relatively slow path and would likely happen on a resource=20
loading thread instead of the hot main loop.

>=20
>>
>> I've yet to hear a specific downside of making the change other than a r=
eal
>> concern about DoS of kernel memory in another discussion - it seems to m=
e
>> like there is much lower hanging fruit for DoSing a Linux system you hav=
e
>> shell access to, at the moment.
>=20
> Poor performance is the downside. The specific downside is the overly
> large data structure that the kernel has to navigate on every page fault
> or any other vma operation.  This isn't specific to changing the number,
> but to the fact that it needed to be changed in the first place.
>=20
> Is there an upper limit of vmas that you have seen?  Can you provide a
> copy of the mappings when you see this for testing?  This works out to a
> 5 level maple tree.

I don't really know of an upper limit. I can provide a contrasting=20
anecdote that seems to use a fair amount of mappings - running the title=20
`Hogwarts Legacy` after having loaded into interactive gameplay in the=20
initial area:

plagman@redcore:~$ cat /proc/2009007/maps | wc -l
27217

Here's a copy of /proc/maps if you're curious:

https://www.dropbox.com/scl/fi/rf970vdxoexsx8u1otufl/hogwarts_maps?rlkey=3D=
ws8uwz9ivjo6rh0y9h15nsbna&dl=3D0

I'm guessing there is a guard page after all of those mmap()ed=20
mini-arenas the allocator creates, effectively doubling the mapping count.

Thanks,
  - Pierre-Loup

>=20
> Thanks,
> Liam
>=20


