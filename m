Return-Path: <linux-kernel+bounces-13758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3383820C2A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 18:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42151280DD2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 17:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063B28F6E;
	Sun, 31 Dec 2023 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="mOARG1PV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F77D8F40;
	Sun, 31 Dec 2023 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1704043773; x=1704302973;
	bh=hU+O3O0WZy59tVU9PtFRXLLdlxK59XaCKjJYfsYMEPY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=mOARG1PVmRQaf7Zhnnrdn7cfcZpEoJKtv2dOnFYbBACfCnhTkfEZ3xRcJ+hVp4ioZ
	 8anPHtZ+xlmHR1XZ26EJn6BsQSHyOO8XLJyzyud1naAxRxGeuc+h1BA4YOlOYIu0L5
	 RLceeNf7lGn7GJpdKbgtoUjIJQlf9wWiL979J/sco7XMtGTToJLaZTWzM2NZE4oZcd
	 PNafsdnxLdU525kXHVqPVpYTQq1GGLZx1wVNGIqAAXXkn72QW1o8DzextZyfP2wZ/C
	 FIZRGjFLULgkY+foKItIeiA7lhedDswK/FbwCl8S55cxdKvn49nSx7tlg6gjSh6mYk
	 GVlgmOEME0lHw==
Date: Sun, 31 Dec 2023 17:29:14 +0000
To: =?utf-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Larry Finger <Larry.Finger@lwfinger.net>, Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless 3/5] wifi: b43: Stop/wake correct queue in PIO Tx path when QoS is disabled
Message-ID: <87sf3iz3ff.fsf@protonmail.com>
In-Reply-To: <20231231103302.04cc37ae@barney>
References: <20231230045105.91351-1-sergeantsagara@protonmail.com> <20231230045105.91351-4-sergeantsagara@protonmail.com> <cb9dcb49-ad94-40df-9f01-a28df3daf6c3@lwfinger.net> <877ckvwk5v.fsf@protonmail.com> <ca357d13-7da9-490f-9e69-4674c6ede057@lwfinger.net> <874jfzutm5.fsf@protonmail.com> <20231231103302.04cc37ae@barney>
Feedback-ID: 26003777:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, 31 Dec, 2023 10:33:02 +0100 Michael B=C3=BCsch <m@bues.ch> wrote:
> [[PGP Signed Part:Undecided]]
> On Sun, 31 Dec 2023 00:02:32 +0000
> Rahul Rameshbabu <sergeantsagara@protonmail.com> wrote:
>
>> > Unfortunately, it is very difficult to get the parameters for fwcutter=
 from an
>> > x86 binary. Some of the other architectures are easier. =20
>>=20
>> Just tried this with the x86 binary just because and ran into extraction
>> issues as expected. I could not find other architecture options from
>> Broadcom's download page, but I may not have been looking well enough...
>>=20
>>   =E2=9D=AF b43-fwcutter ./wlc_hybrid.o_shipped
>>   Sorry, the input file is either wrong or not supported by b43-fwcutter=
.
>>   This file has an unknown MD5sum 6889dbd24abf8006de5cc6eddd138518.
>
> b43-fwcutter works only on known files. It has a table of hashes of these=
 files.
>
> But there is a script that can be used to create a hash table entry for a=
 .o file:
> https://bues.ch/cgit/b43-tools.git/plain/fwcutter/mklist.py
>
> This probably doesn't work on x86 binaries, though.
> But maybe by reading the script you can get an idea how this works.

Thanks for the pointer. I will take a look and follow up with you and
Larry with the b43-dev mailing list CCed. If we can get QoS working on
bcm4331, then I can send a revert for the disablement patch.

--
Thanks,

Rahul Rameshbabu


