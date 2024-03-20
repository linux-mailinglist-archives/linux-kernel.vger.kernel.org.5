Return-Path: <linux-kernel+bounces-109062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8907E881428
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8041F2383C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65B64DA1A;
	Wed, 20 Mar 2024 15:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=acm.org header.i=@acm.org header.b="2SdLnNxr"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C71352F65;
	Wed, 20 Mar 2024 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710947262; cv=none; b=fok19+Fh4lpnoTDPhkM6CdqVZZHe6k9OFkjmDRZl4qMDTEk3OUEvWZBov8eKO50DfPsEDeGxeB1oKwqPHdLkGABKb81FvLdvSzDHV1wa/O0hCW225hOQMPzaRnpBZdZ84W72LdxGPW4GnoThMgtCY7MdNLgMIP2AQ6B464wgujc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710947262; c=relaxed/simple;
	bh=J2+qebABR/z0yguhZ49xBiOt0NpXQ/kv3UPwhTnJqfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WR+6wMJW00a0ZPrzGtcuE+vjySWNUzcvwzxNCcCHFzYmh6UhAagxetz/bBi1O90TX3lZrVmpR1FYC6/1a3xq6IaSqmifocm37pKkIJegdpKCmoXcJAD+PDQCQF/DT9Pn7ZWmskPRLStymGWx9UiLcoPTfu02ZQKl+di28yEPhNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=2SdLnNxr; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V0Blp51SfzlgVnY;
	Wed, 20 Mar 2024 15:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1710947252; x=1713539253; bh=J2+qebABR/z0yguhZ49xBiOt
	0NpXQ/kv3UPwhTnJqfI=; b=2SdLnNxrpHBRDs7CDHYLGfeKp6Z1WiEkgyzEdh19
	dwqts6EfzztU28UCzUKLIq0lM6EgcKzT65DKpQY9x0jf+NBqxLYdWXTFfe/Q61tN
	vboXO3kEU3Wsw3gjxbagPaIsjbbFkUVWIjz8xo8JIDow5Q2uoO5S0ueQVzFmCMGz
	r76ad1M6a2qjJSJIiSRs7VvSiE5AQbGby1SLxTVG2T61L6WZWyxFrzUmbz/X4d9r
	chs0jRazbMTi6l3Go4r3xCiRF4rUXMpBoNgXjrkUQSgKLL3VIKaXEJa6keOMUfxK
	ZuAPryGLd4RZpmGrFcuH2XtSIvj58lzvqDAzSAktPPT5nQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6BUGIIHmrgRk; Wed, 20 Mar 2024 15:07:32 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V0Bll2FtKzlgVnW;
	Wed, 20 Mar 2024 15:07:31 +0000 (UTC)
Message-ID: <75b91ed1-6b80-4e03-b586-0bd58e81aba0@acm.org>
Date: Wed, 20 Mar 2024 08:07:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: core: Make scsi_lib KUnit tests modular for real
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mike Christie <michael.christie@oracle.com>,
 "James E . J . Bottomley" <jejb@linux.ibm.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <48ca5e827ca420bbdbabb1643e2179dc95c9e0b7.1710849638.git.geert@linux-m68k.org>
 <d1a1b0b8-41f1-4ead-b393-d8d2f099b0c4@acm.org>
 <CAMuHMdWzD1OR8qj8oHfUgQ9GMtrD8y69G+A+ONdVm0vTCvYe=w@mail.gmail.com>
 <0d41ae1a-f6aa-4377-b8a3-7fcf067f99ac@acm.org>
 <CAMuHMdVig-cm7KPi76ow9-xyZ55z4YgYrx6QuO9V5A0ni7HxDA@mail.gmail.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAMuHMdVig-cm7KPi76ow9-xyZ55z4YgYrx6QuO9V5A0ni7HxDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 3/20/24 01:08, Geert Uytterhoeven wrote:
> On Tue, Mar 19, 2024 at 6:01=E2=80=AFPM Bart Van Assche <bvanassche@acm=
org> wrote:
>> run SCSI kunit tests is available below. And if there is a desire to r=
un
>> SCSI tests on the target system, how about adding triggers in sysfs fo=
r
>> running kunit tests? The (GPL v2) Samsung smartphone kernel supports
>> this but I have not yet checked whether their implementation is
>> appropriate for the upstream kernel.
>=20
> That would require all tests to be built-in, reducing the amount of mem=
ory
> (if any remains at all) available to the real application.

It would be great if it would be possible to convert scsi_lib_test.c
into a kernel module without exporting the functions that are being
tested. Exporting functions from scsi_lib.c only because these are
called from code in scsi_lib_test.c is not desired. More tests may be
added in the future into scsi_lib_test.c. If that would result in
exporting every static scsi_lib.c function that would make the SCSI core
harder to maintain than necessary.

Thanks,

Bart.

