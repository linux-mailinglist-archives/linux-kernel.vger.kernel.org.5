Return-Path: <linux-kernel+bounces-95540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C06C874F1E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999382817B7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFB612BEB1;
	Thu,  7 Mar 2024 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="lBx1+QuJ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78F384FD5;
	Thu,  7 Mar 2024 12:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709814742; cv=none; b=qlrHjZF5gfMHB129LSyAWWqP2IoxSWOf210cWLZpG6im0mcsxbpDRKZ/wH/+4QTofWegGoXm0PSqWYJDQ20yNU069sTvF5x7u2OzfIF9J3u8Fx54earuwfFVlU9Ep75b/KRcRVbzS6RN5tyUW48IHEQlcqYJ0AChMc3b94KyOaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709814742; c=relaxed/simple;
	bh=CnKV7YkmwKVN45OVgq9HMp191oP0lkB4cDHb6peK+T4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qSXw9glSI9pQzgAlZWw01fjMjQRLCoYzV23qVcUHioZC0HVjAXzgiDk9IEn3fvtI04niI/Hp8XJ3kLK8YOx/xl3LthwwB8UvrfrVCjtioVkV7NSWpGB2J32Y6dVJTbGOLtyTmvsS4k7e3p+6CmBWYuyk9U5TOBXTK9pp7uauiK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=lBx1+QuJ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1709814736;
	bh=CnKV7YkmwKVN45OVgq9HMp191oP0lkB4cDHb6peK+T4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lBx1+QuJTEVHApTpCCDU+EV1Aykxe0USdn1M5qeFxUu86nOmkjduBDq8dT3o7qXpm
	 oS8/qBbiILsQJC5KQx/qJRP/+1Rtwj+Mvna+PmMaQHKiOOUzj3K4BfsAnCXpYBeO5i
	 sIHi1sZKR2G1jRkcILr1PE7EJZw85kHZ0/HyQZD5Je+4MUjufb3f6fIkyubjPbz8re
	 /xYRYrDhHsNlHZi8hwJ5D8xkg2qXwM8ii3IePd37e1Jh7QAPge7a0+jwCSZNdI+ZOe
	 Y4f3knEgXbFr14hWz3pvmzLU64Pzxk2jZ5fbpD4Fd7BcqwRmHFTOSol/RnqeVlE3F0
	 mpc6I8Pch7Hkg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tr7wZ6z4Xz4wc8;
	Thu,  7 Mar 2024 23:32:14 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dawei Li <set_pte_at@outlook.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>
Cc: "npiggin@gmail.com" <npiggin@gmail.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-ide@vger.kernel.org"
 <linux-ide@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-wireless@vger.kernel.org"
 <linux-wireless@vger.kernel.org>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>, "linux-serial@vger.kernel.org"
 <linux-serial@vger.kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] powerpc: macio: Make remove callback of macio driver
 void returned
In-Reply-To: <TYTP286MB356472357994D5EA49E2F5E3CA212@TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB232391520CB471E7C8D6EA84CAD19@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
 <3dc29701-239f-4a3b-b571-b9732975bd73@csgroup.eu>
 <TYTP286MB356472357994D5EA49E2F5E3CA212@TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM>
Date: Thu, 07 Mar 2024 23:32:14 +1100
Message-ID: <87bk7qnrxt.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dawei Li <set_pte_at@outlook.com> writes:
> Hi Christophe,
>
> On Tue, Feb 20, 2024 at 04:12:17PM +0000, Christophe Leroy wrote:
>> Hi Michael,
>>=20
>> ping ?
>>=20
>> Le 01/02/2023 =C3=A0 15:36, Dawei Li a =C3=A9crit=C2=A0:
>> > Commit fc7a6209d571 ("bus: Make remove callback return void") forces
>> > bus_type::remove be void-returned, it doesn't make much sense for any
>> > bus based driver implementing remove callbalk to return non-void to
>> > its caller.
>> >=20
>> > This change is for macio bus based drivers.
>> >=20
>> > Signed-off-by: Dawei Li <set_pte_at@outlook.com>
>>=20
>> This patch is Acked , any special reason for not applying it ?
>>=20
>> Note that it now conflicts with commit 1535d5962d79 ("wifi: remove=20
>> orphaned orinoco driver") but resolution is trivial, just drop the=20
>> changes to that file.
>
> Thanks for picking it up, hardly believe that it's been one year.
>
> Michael,
>
> I will respin V4 if it's needed.

No that's fine, I'll sort it out.

cheers

