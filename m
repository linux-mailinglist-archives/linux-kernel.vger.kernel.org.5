Return-Path: <linux-kernel+bounces-72593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06B885B5B2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D30CF1C22AF3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D635D8E0;
	Tue, 20 Feb 2024 08:44:17 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61A35D743;
	Tue, 20 Feb 2024 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418656; cv=none; b=g2aP9hRJG9F1kipbSPitVfCI7buZt11hWRJnSPzCONJ5JH9xCglIllHucJBcAO5Vn91JaT92qC5iwBN+7oe1uEz+TDqq6DvBtUD2nUzsjX+mQzzIGfaCk27dLFqrY+XpwbdWYYjWAROt/n+fyoAmuAKYqcuT+Q+jc3N/22QE7Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418656; c=relaxed/simple;
	bh=IxVU2SCDQRM0JjhXwZUQggrxGpJLFlrsAUrWea6VEMc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RSVchrfMuDfA5C1sq2nhnNj+PAw9YxYSNPpraaFmd04cjYEvqLbvTBchhmj+vv220qhLBumsBp5VcyTb6y9+o1CLdcY6BY4Jlbs8O4+8kFqMlU6eLQbiFs65Sx1R41x/h1rRxEI20bBFgikno1ZVuplcloQQZSE4BmVl/tLuk5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from msexch01.omp.ru (10.188.4.12) by msexch02.omp.ru (10.188.4.13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 20 Feb
 2024 11:44:02 +0300
Received: from msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753]) by
 msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753%5]) with mapi id 15.02.1258.012;
 Tue, 20 Feb 2024 11:44:02 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Ryusuke Konishi <konishi.ryusuke@gmail.com>, "linux-nilfs@vger.kernel.org"
	<linux-nilfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Alexey Khoroshilov <khoroshilov@ispras.ru>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, "Sergey
 Shtylyov" <s.shtylyov@omp.ru>, Karina Yankevich <k.yankevich@omp.ru>, "Andrey
 Rusalin" <a.rusalin@omp.ru>, Sergey Yudin <s.yudin@omp.ru>, "Valentin
 Perevozchikov" <v.perevozchikov@omp.ru>
Subject: Re: [PATCH 5.10/5.15/6.1 0/1] nilfs2: fix WARNING in
 nilfs_dat_prepare_end()
Thread-Topic: [PATCH 5.10/5.15/6.1 0/1] nilfs2: fix WARNING in
 nilfs_dat_prepare_end()
Thread-Index: AQHaWp0R4KNZ2UzvN0KJYOohjPpIcLES/EMy
Date: Tue, 20 Feb 2024 08:44:02 +0000
Message-ID: <5abcb44deb604258aff4cd02c3ca90a3@omp.ru>
References: <20240208144224.438146-1-r.smirnov@omp.ru>
In-Reply-To: <20240208144224.438146-1-r.smirnov@omp.ru>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: msexch02.omp.ru, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 2/20/2024 6:44:00 AM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: InTheLimit
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 8 Feb 2024 17:42:41 +0300, Roman Smirnov wrote:
> Syzkaller reports WARNING in nilfs_dat_prepare_end() in 5.10, 5.15 and 6.=
1
> stable releases. The problem has been fixed in upstream:
> https://syzkaller.appspot.com/bug?extid=3D5d5d25f90f195a3cfcb4
>
> The problem can also be fixed in versions 5.10, 5.15 and 6.1 by the
> following patch.
>
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
>=20
> Link: https://syzkaller.appspot.com/bug?extid=3D325e6b0a1e7cf9035cc0
> Link: https://syzkaller.appspot.com/bug?extid=3Dbebf30d67ea2569f0fd3
>=20
> Ryusuke Konishi (1):
>  nilfs2: replace WARN_ONs for invalid DAT metadata block requests
>
>  fs/nilfs2/dat.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)

Sorry to bother you, do you have any comments on the patch?

