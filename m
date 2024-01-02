Return-Path: <linux-kernel+bounces-14808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB098222B3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763B02840E4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D6616421;
	Tue,  2 Jan 2024 20:45:39 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C563E16402
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 92C7B626FAFD;
	Tue,  2 Jan 2024 21:45:33 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id c26r3h03Ykk4; Tue,  2 Jan 2024 21:45:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id B57AE626FAFC;
	Tue,  2 Jan 2024 21:45:32 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bn0u2smvcOuc; Tue,  2 Jan 2024 21:45:32 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 914E4626FAFB;
	Tue,  2 Jan 2024 21:45:32 +0100 (CET)
Date: Tue, 2 Jan 2024 21:45:32 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: chengzhihao1 <chengzhihao1@huawei.com>
Cc: david oberhollenzer <david.oberhollenzer@sigma-star.at>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, 
	Tudor Ambarus <Tudor.Ambarus@linaro.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <535616666.192239.1704228332389.JavaMail.zimbra@nod.at>
In-Reply-To: <a145fc68-9b0a-9794-48d2-b7ad79116833@huawei.com>
References: <20231228014112.2836317-1-chengzhihao1@huawei.com> <1145531757.175508.1703844362355.JavaMail.zimbra@nod.at> <13b259ca-b32f-a8d6-5e11-8bb38df72f5c@huawei.com> <642239519.177270.1703884138999.JavaMail.zimbra@nod.at> <a145fc68-9b0a-9794-48d2-b7ad79116833@huawei.com>
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
Thread-Index: zanHUD2ShtmoWAAG/yLjSang7Pf/kw==

----- Urspr=C3=BCngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
> I come up with another way to implement fsck.ubifs:
>=20
> There are three modes:
>=20
> 1. common mode(no options): Ask user whether to fix as long as a problem
> is detected.

Makes sense.

> 2. safe mode(-a option): Auto repair as long as no data/files lost(eg.
> nlink, isize, xattr_cnt, which can be corrected without dropping nodes),
> otherwise returns error code.

Makes sense.
=20
> 3. dangerous mode(-y option): Fix is always successful, unless
> superblock is corrupted. There are 2 situations:

Please not use "-y". Usually "-y" stands for "answer yes to all questions".
But selecting names for command line flags is currently my least concern.
=20
>   a) TNC is valid: fsck will print which file is dropped and which
> file's data is dropped

Sounds also good.
=20
>   b) TNC is invalid: fsck will scan all nodes without referencing TNC,
> same as this patchset does

I'd make this a distinct mode.
It can be used to rebuild index and LEB property trees.
This is basically a "drop trees and rebuild" mode.

>=20
> Q1: How do you think of this method?

Sounds good so far.
=20
> Q2: Mode 1, 2 and 3(a) depend on journal replaying, I found
> xfs_repair[1] should be used after mounting/unmounting xfs (Let kernel
> replay journal), if UBIFS does so, there is no need to copy recovery
> subsystem into userspace, but user has to mount/unmount before doing
> fsck. I found e2fsck has copied recovery code into userspace, so it can
> do fsck without mounting/unmounting. If UBIFS does so, journal replaying
> will update TNC and LPT, please reference Q3(1). Which method do you
> suggest?

UBIFS is a little special regarding the journal.

1. The journal is not an add-on like it is on many other file systems,
you have to replay it to get a consistent file system.
2. Journal replay is also needed after a clean umount. The reason is that
UBIFS does no commit at umount time.

So IMHO you need to have journal replay code in your tool in any case.
You can copy it from the kernel implementation and add more checks.
While the kernel code also tries to be fast, fsck should be more paranoid.
Ideally the outcome is a libubifs or such which can be derived from the
kernel source while building mtd-utils.

> Q3: If fsck drops or updates a node(eg. dentry lost inode, corrected
> inode) in mode 1,2 and 3(a), TNC/LPT should be updated. There are two
> ways updating TNC and LPT:
>=20
>   1) Like kernel does, which means that mark dirty TNC/LPT for
> corresponding branches and do_commit(). It will copy much code into
> userspace, eg. tnc.c, lpt.c, tnc_commit.c,
> lpt_commit.c. I fear there exists risks. For example, there is no space
> left for new index nodes, gc should be performed? If so, gc/lpt gc code
> should be copied too.
>=20
>   2) Rebuild new TNC/LPT based on valid nodes. This way is simple, but
> old good TNC could be corrupted, it means that powercut during fsck may
> let UBIFS image must be repaired in mode 3(b) but it could be repaired
> in mode 2\3(a) before invoking fsck.
>=20
> Which way is better?

Since you need to do a full journal replay anyway and power-cut awareness
is one of your requirements, I fear the only option is 1).

Thanks,
//richard

