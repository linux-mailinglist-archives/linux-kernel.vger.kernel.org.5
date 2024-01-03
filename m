Return-Path: <linux-kernel+bounces-15586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95730822E71
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442A6285E89
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C031A58C;
	Wed,  3 Jan 2024 13:33:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2317F19BCD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 0BD30626FAF6;
	Wed,  3 Jan 2024 14:33:02 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 6YkfTO33uBbK; Wed,  3 Jan 2024 14:33:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 409A5626FB0F;
	Wed,  3 Jan 2024 14:33:01 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 07_AODx7p-p6; Wed,  3 Jan 2024 14:33:01 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 1DDD6626FAF6;
	Wed,  3 Jan 2024 14:33:01 +0100 (CET)
Date: Wed, 3 Jan 2024 14:33:00 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: chengzhihao1 <chengzhihao1@huawei.com>
Cc: david oberhollenzer <david.oberhollenzer@sigma-star.at>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, 
	Tudor Ambarus <Tudor.Ambarus@linaro.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <391060208.195010.1704288780905.JavaMail.zimbra@nod.at>
In-Reply-To: <460eb02e-8937-282c-62c5-6ea606324b0e@huawei.com>
References: <20231228014112.2836317-1-chengzhihao1@huawei.com> <1145531757.175508.1703844362355.JavaMail.zimbra@nod.at> <13b259ca-b32f-a8d6-5e11-8bb38df72f5c@huawei.com> <642239519.177270.1703884138999.JavaMail.zimbra@nod.at> <a145fc68-9b0a-9794-48d2-b7ad79116833@huawei.com> <535616666.192239.1704228332389.JavaMail.zimbra@nod.at> <460eb02e-8937-282c-62c5-6ea606324b0e@huawei.com>
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
Thread-Index: DNjwXo0bUvQvI/5CY/TMFyMnZ1D/4Q==

----- Urspr=C3=BCngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
>> 2. Journal replay is also needed after a clean umount. The reason is tha=
t
>> UBIFS does no commit at umount time.
>=20
> I agree, there exists one situation that UBIFS replays journal even
> after clean umount.
>     P1      ubifs_bgt      umount
>   mkdir
>          run_bg_commit
>           c->cmt_state =3D COMMIT_RUNNING_BACKGROUND
>           do_commit
>            ubifs_log_start_commit(c, &new_ltail_lnum) // log start
>            up_write(&c->commit_sem)
>   touch
>    ubifs_jnl_update // new buds added
>                          cleanup_mnt
>                           deactivate_super
>                            fs->kill_sb
>                             generic_shutdown_super
>                              sync_filesystem
>                               ubifs_sync_fs
>                                ubifs_run_commit
>                                 wait_for_commit // wait bg commit,
> 'touch' won't be commited, it will be replayed in next mount

BTW: I was imprecise, sorry for that.
The issue is that even after a commit you need to replay the journal.

Thanks,
//richard

