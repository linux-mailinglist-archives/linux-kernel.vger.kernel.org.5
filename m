Return-Path: <linux-kernel+bounces-25336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A865B82CDC4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 17:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2361C21165
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 16:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D29B4C9D;
	Sat, 13 Jan 2024 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJq2aJdk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DA24C65;
	Sat, 13 Jan 2024 16:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929E8C433C7;
	Sat, 13 Jan 2024 16:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705164396;
	bh=VUclddjcZSmohXUG3CiQi1jaoQVq1DeF2h3vDJ15cM0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=gJq2aJdkcuDG9gBOJkweuzqeMhuqAU2QPyebUb1kQqVYfhyYvlge5Y6HWGGnexmXf
	 4010MJ57Uqa8naU4hMWlZ4HRMmnYs8QUK5C73K0bXtYvYhxm1cVdY1lF3pbtKWv54I
	 rgPFo60mMj2vxShOfggXIfIsmG95e/tSdAaJgFxPLeTVedFt+QSy8LUceWpHdDuItv
	 tYiNNOWKV7CfGN5zlAKkB5l4WPleLnLT7iYgdEjNM+UI5rqlAUleTW8j/+F5TDj3T/
	 VvmEKMYVatzICO7F25ETsEd/+G7JS3I6/TQjOAE4sxMLtjdToqXuOcy65Ul1P1J1um
	 SpfrazZltzCTw==
From: Kalle Valo <kvalo@kernel.org>
To: Michael =?utf-8?Q?B=C3=BCsch?= <m@bues.ch>
Cc: Yang Li <yang.lee@linux.alibaba.com>,  Larry.Finger@lwfinger.net,
  linux-wireless@vger.kernel.org,  b43-dev@lists.infradead.org,
  linux-kernel@vger.kernel.org,  Abaci Robot <abaci@linux.alibaba.com>
Subject: wireless: cleanup patches
References: <20231220011209.127586-1-yang.lee@linux.alibaba.com>
	<20231220102307.7dd1f187@barney>
Date: Sat, 13 Jan 2024 18:46:32 +0200
In-Reply-To: <20231220102307.7dd1f187@barney> ("Michael =?utf-8?Q?B=C3=BCs?=
 =?utf-8?Q?ch=22's?= message of
	"Wed, 20 Dec 2023 10:23:07 +0100")
Message-ID: <87mst989lj.fsf_-_@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Michael B=C3=BCsch <m@bues.ch> writes:

> On Wed, 20 Dec 2023 09:12:09 +0800
> Yang Li <yang.lee@linux.alibaba.com> wrote:
>
>> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D7783
>
> This link is not publicly accessible.
>
>> a/drivers/net/wireless/broadcom/b43legacy/dma.c +++
>> b/drivers/net/wireless/broadcom/b43legacy/dma.c @@ -174,8 +174,8 @@
>> static struct b43legacy_dmaring *priority_to_txring( {
>>  	struct b43legacy_dmaring *ring;
>>=20=20
>> -/*FIXME: For now we always run on TX-ring-1 */
>> -return dev->dma.tx_ring1;
>> +	/*FIXME: For now we always run on TX-ring-1 */
>> +	return dev->dma.tx_ring1;
>>=20=20
>>  	/* 0 =3D highest priority */
>>  	switch (queue_priority) {
>
> Thanks for your patch.
>
> But actually, I am kind of annoyed by the constant stream of whitespace
> fixing and dead code removal and other trivial changes to this legacy
> driver.
>
> It does not improve the code to add two tabs to this _ancient_ code.
>
> And I can already see the next patch coming that removes the dead code
> after this FIXME return. And then the next patch will come to remove
> this function altogether, and so on and so on.
>
> This driver has a _lot_ of such code, because it is based on reverse
> engineered knowledge with many many unknowns.
>
> IMO this just creates additional maintenance work and pressure on our
> maintainers for no good reason.

Yeah, the cleanup patches are a problem. Even more so that there can be
people who deliberately try to submit compromised code:

https://lore.kernel.org/lkml/202105051005.49BFABCE@keescook/

brtfs has a pretty good summary about their feelings towards cleanup
patches:

https://btrfs.readthedocs.io/en/latest/dev/Developer-s-FAQ.html#how-not-to-=
start

Johannes and me have been talking that we should write something similar
for wireless. Maybe we should start by adding that link to our
documentation :)

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

