Return-Path: <linux-kernel+bounces-13041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3BB81FED1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 11:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FC5C1C22CC7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DB910A1F;
	Fri, 29 Dec 2023 10:06:10 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E0110A09
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8DB196343B36;
	Fri, 29 Dec 2023 11:06:03 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id W5C9DOrgUFB0; Fri, 29 Dec 2023 11:06:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id B7F466343B3C;
	Fri, 29 Dec 2023 11:06:02 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id W8mcbDZFkA7d; Fri, 29 Dec 2023 11:06:02 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8365E6343B36;
	Fri, 29 Dec 2023 11:06:02 +0100 (CET)
Date: Fri, 29 Dec 2023 11:06:02 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: chengzhihao1 <chengzhihao1@huawei.com>
Cc: david oberhollenzer <david.oberhollenzer@sigma-star.at>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, 
	Tudor Ambarus <Tudor.Ambarus@linaro.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <1145531757.175508.1703844362355.JavaMail.zimbra@nod.at>
In-Reply-To: <20231228014112.2836317-1-chengzhihao1@huawei.com>
References: <20231228014112.2836317-1-chengzhihao1@huawei.com>
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
Thread-Index: dDGyRRcFTNJRSeVoML57/54HOrx0FA==

----- Urspr=C3=BCngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
> An: "david oberhollenzer" <david.oberhollenzer@sigma-star.at>, "richard" =
<richard@nod.at>, "Miquel Raynal"
> <miquel.raynal@bootlin.com>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Tu=
dor Ambarus" <Tudor.Ambarus@linaro.org>
> CC: "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-mtd" <linux-mtd=
@lists.infradead.org>
> Gesendet: Donnerstag, 28. Dezember 2023 02:40:55
> Betreff: [PATCH RFC 00/17] ubifs: Add filesystem repair support

Thanks a lot for sharing this.
Below you find some thoughts that came into my mind while skimming over the
patch series.

> UBIFS repair provides a way to fix inconsistent UBIFS image(which is
> corrupted by hardware exceptions or UBIFS realization bugs) and makes
> filesystem become consistent, just like fsck tools(eg. fsck.ext4,
> fsck.f2fs, fsck.fat, etc.) do.

I don't fully agree. The tool makes UBIFS mount again but you still have lo=
st data
and later userspace might fail because file no longer contain what the appl=
ication
expected.
So my fear is that we're just shifting the problem one layer up.

UBIFS never had a fsck for reasons. UBIFS tries hard to not become inconsis=
tent,
by maintaining a data journal for example.
It can fail of course by hardware issues. e.g. if the underlying MTD loses =
bits,
but there is nothing UBIFS can do except something like storing duplicates
of data like BTRFS does.

And finally, the biggest pain point, it can fail due to bugs in UBIFS itsel=
f.
In my opinion bugs should get addressed by improving our test infrastructur=
e
instead of working around.

> About why do we need it, how it works, what it can fix or it can not
> fix, when and how to use it, see more details in
> Documentation/filesystems/ubifs/repair.rst (Patch 17).

This needs to go into the cover letter.
=20
> Testing on UBIFS repair refers to
> https://bugzilla.kernel.org/show_bug.cgi?id=3D218327
>=20
> Whatever, we finally have a way to fix inconsistent UBFIS image instead
> of formatting UBI when UBIFS becomes inconsistent.

Fix in terms of making mount work again, I fear? As I said, most likely
the problem is now one layer above. UBIFS thinks everything is good but
userspace suddenly will see old/incomplete files.

What I can think of is a tool (in userspace like other fscks) which
can recover certain UBIFS structures but makes very clear to the user what
the data is lost. e.g. that inode XY now misses some blocks or an old versi=
on
of something will be used.
But this isl nothing you can run blindly in production.

Thanks,
//richard

