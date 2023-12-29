Return-Path: <linux-kernel+bounces-13235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07850820189
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 22:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A5201F22F7F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 21:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2693214299;
	Fri, 29 Dec 2023 21:09:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C681428C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 21:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id F16556343B5F;
	Fri, 29 Dec 2023 22:08:59 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id rK-5C5k2T2LH; Fri, 29 Dec 2023 22:08:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 3E8EE6343B49;
	Fri, 29 Dec 2023 22:08:59 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0EugnY1wJAwv; Fri, 29 Dec 2023 22:08:59 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 1B1F36343B3A;
	Fri, 29 Dec 2023 22:08:59 +0100 (CET)
Date: Fri, 29 Dec 2023 22:08:59 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: chengzhihao1 <chengzhihao1@huawei.com>
Cc: david oberhollenzer <david.oberhollenzer@sigma-star.at>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, 
	Tudor Ambarus <Tudor.Ambarus@linaro.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <642239519.177270.1703884138999.JavaMail.zimbra@nod.at>
In-Reply-To: <13b259ca-b32f-a8d6-5e11-8bb38df72f5c@huawei.com>
References: <20231228014112.2836317-1-chengzhihao1@huawei.com> <1145531757.175508.1703844362355.JavaMail.zimbra@nod.at> <13b259ca-b32f-a8d6-5e11-8bb38df72f5c@huawei.com>
Subject: Re: [PATCH RFC 00/17] ubifs: Add filesystem repair support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: Add filesystem repair support
Thread-Index: AkgMz2JGx84iN/cShcb2uWeDWhTkSA==

----- Urspr=C3=BCngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
> I make UBIFS repair for two reasons:
>=20
> 1. There have been many inconsistent problems happened in our
> products(40+ per year), and reasons for most of them are unknown, I even
> can't judge the problem is caused by UBIFS bug or hardware exception.
> The consistent problems, for example, TNC points to an empty space, TNC
> points to an unexpected node, bad key order in znodes, dirty space of
> pnode becomes greater than LEB size, huge number in
> master->total_dead(looks like overflow), etc. I cannot send these bad
> images to find help, because the corporate policy. Our kernel version is
> new, and latest bugfixs in linux-mainline are picked in time. I have

Regarding company policy, we could implement a tool which dumps just UBIFS'
meta data (no data node content nor filenames). ext4 has such a tool to
exchange faulty filesystems.
Another option is, in case you want some else looking into the issue,
asking a contractor like me. Usually signing a NDA is not a big deal.

In any case, I'm keen to look into this issues. But I fear
we need more testing to find the root cause, if they are caused by UBIFS bu=
gs.

> looked though journal/recovery UBIFS subsystem dozens of times, the
> implementation looks good, except one problem[2]. And we have do many
> powercut/faul-injection tests for ubifs, and Zhaolong has published our
> fault-injection implementation in [3], the result is that
> journal/recovery UBIFS subsystem does look sturdy.

I came to the same conclusion after digging through the code more than once=
. :-)
=20
> 2. If there exists a fsck tool, user have one more option to deal with
> inconsistent UBIFS image. UBIFS is mainly applied in embeded system,
> making filesystem available is most important when filesystem becomes
> inconsistent in some situations.

This is the point where I'm more sceptical.
Please see my comments below.

> [1]
> https://linux-mtd.infradead.narkive.com/bfcHzD0j/ubi-ubifs-corruptions-du=
ring-random-power-cuts
>=20
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=3D218309
>=20
> [3] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=3D388034
>=20
> I'm not sure whether you prefer a fsck tool, in my opinion, fsck just
> provide a way for userspace to fix filesystem, user can choose invoke it
> or not according to the tool's limitations based on specific situation.
> But according to your following reply, I guess you can accept that UBIFS
> can have a fsck, and fsck should let user known which file is recovered
> incomplete, which file is old, rather than just make filesystem become
> consistent.

I see three different functions:

1. Online scrubbing

A feature which can check all UBIFS structures while UBIFS is mounted
and tell what's wrong. We have this already more or less ready, the chk_fs
debugfs knob.

2. Online repair

Like XFS online repair, this feature allows UBIFS to fix data structures by
*re-computing* them from other structures without loosing data nor violatin=
g
file contents consistency.
E.g. if a data node vanished, it can do nothing. Fixing the index tree
will make UBIFS no longer fail but userspace will be unhappy if a file
has suddenly a hole or is truncated.
On the other hand, a disconnected inode could be linked into a lost+found
folder or re-computing the LPT tree (I'm still not sure about the LPT).
Same for updating link counters, etc...

3. Offline repair

This is the classical fsck. It can do everything what 1) and 2) can do plus
dangerous operations like re-building the index tree by scanning for
UBIFS nodes on the media.

Re-building the index tree is dangerous because file *contents* can be
inconsistent later. If for example a whole LEB is lost, a file can
contain a mixture of old and new data blocks. For a text file this is
not always fatal. For a database it is.

But UBIFS itself will be consistent again, will mount and not render
read-only all of a sudden.

>>
>>> About why do we need it, how it works, what it can fix or it can not
>>> fix, when and how to use it, see more details in
>>> Documentation/filesystems/ubifs/repair.rst (Patch 17).
>> This needs to go into the cover letter.
> OK, thanks for reminding.
>>  =20
>>> Testing on UBIFS repair refers to
>>> https://bugzilla.kernel.org/show_bug.cgi?id=3D218327
>>>
>>> Whatever, we finally have a way to fix inconsistent UBFIS image instead
>>> of formatting UBI when UBIFS becomes inconsistent.
>> Fix in terms of making mount work again, I fear? As I said, most likely
>> the problem is now one layer above. UBIFS thinks everything is good but
>> userspace suddenly will see old/incomplete files.
>>
>> What I can think of is a tool (in userspace like other fscks) which
>> can recover certain UBIFS structures but makes very clear to the user wh=
at
>> the data is lost. e.g. that inode XY now misses some blocks or an old ve=
rsion
>> of something will be used.
>> But this isl nothing you can run blindly in production.
>=20
> Let me see.
>=20
> First, we have a common view, fsck tool is valuable for UBIFS, it just
> provide a way for user application to make UBIFS be consistent and
> available. Right?

Yes. David Oberhollenzer and I will happily help with implementing, testing=
 and
reviewing code.
=20
> Second, you concern odd/incomplete files are recovered just like I
> metioned in documentation(Limitations section), which still make
> application failed because the recovered file lost data or deleted file
> is recovered. So you suggested me that make a userspace fsck tool, and
> fsck can telll user which file is data lost, which file is recovered
> after deletion.
>=20
> The difficulty comes from second point,=C2=A0 how does fsck know a file i=
s
> recovered incomplete or old. Whether the node is existing, it is judged
> by TNC, but TNC could be damaged like I descibed in above. Do you have
> any ideas?

That's the problem what all fsck tools have in common.
The best we can do is offering safe and dangerous repair modes
plus a good repair report.

Long story short, I'm not opposed to the idea, I just want to make
sure that this new tool or feature is not used blindly, since
it cannot do magic.

Thanks,
//richard

