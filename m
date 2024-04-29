Return-Path: <linux-kernel+bounces-162963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 862488B62C5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D3C1F21BAB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5A213B5BB;
	Mon, 29 Apr 2024 19:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnC8DoqY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED71839FD;
	Mon, 29 Apr 2024 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419863; cv=none; b=r8dDJw5pPYtfRzg+KV5kx5fI6/72986KQphT8TnDbAhUOSVOPR1ULaFbflxZZaCoz3MojPBXwURD2rNdJRnDLlnE+fdJFhRziGNmrWEHMyQ1D0KpCimzc+FNVRC6RlFOn/xJEH1CTD8O6m7d3KwrCN6jYEQjhrsxPUUUyhNL6vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419863; c=relaxed/simple;
	bh=RzBcr/M0OG2ERiXaSIPD48X4gSHEuscyRDmi4DDnPE4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QgEJBPDEUQCBoV3qKaDDQRD+2cJHdZC5Th4/wpYXhplDoOuSHQXZN0vgXnw0CVFPqUBZiojVN7GGHMSAIdxQdparPYuiNz1d7eGxLPU8fIkg3X2HT2OlxjUt1UzoKD20W1KCAUW2fgbIQMm7wAa4W8UvNq0JD4TUIgBbos9yCO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnC8DoqY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334C5C113CD;
	Mon, 29 Apr 2024 19:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714419863;
	bh=RzBcr/M0OG2ERiXaSIPD48X4gSHEuscyRDmi4DDnPE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FnC8DoqYmhDVkzDzoBc9a0KEisxngdm0n85nFoEdAKoGCw2DeCny7xnCFSnx1joDn
	 T7mTF328jGvnREvujV8YQdRxcZvFE+3c5Gbf5nlAXTx3+og/Ge1jzXtLCftLPy1Kha
	 gkafGNVkDgpE8VDyRSjr9MvKIg83YRpOIM5i4yaWIqy+Dvcqu5yX3buadxPxePztFt
	 WOeIX+K+BRd7DweGxEdd5VAWHumNSxycUcrdEfGsUyO1XKBqj7cX056HV6cX/f6WXb
	 dDJLQiLnvFxskhy2GpmnZtYa6RD3VW5uFWWB6T5gou8JcUzSeyHRgTF62uL6qoW6NA
	 QJrQlikvWF5nw==
Date: Mon, 29 Apr 2024 20:44:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrew Hepp <andrew.hepp@ahepp.dev>
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: mcp9600: Fix temperature reading for
 negative values
Message-ID: <20240429204409.73b4d676@jic23-huawei>
In-Reply-To: <C96CEE0A-920C-4BDD-9689-058B2E6D4B29@ahepp.dev>
References: <20240424185913.1177127-1-dima.fedrau@gmail.com>
	<Ziy8DsMCeAGK79E7@debian-BULLSEYE-live-builder-AMD64>
	<20240427195758.GA3350@debian>
	<20240428144606.5b3d9a7e@jic23-huawei>
	<C96CEE0A-920C-4BDD-9689-058B2E6D4B29@ahepp.dev>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 28 Apr 2024 14:46:39 -0400
Andrew Hepp <andrew.hepp@ahepp.dev> wrote:

> Hi all,
>=20
> On Apr 28, 2024, at 9:46=E2=80=AFAM, Jonathan Cameron <jic23@kernel.org> =
wrote:
>=20
> > Agreed - by my reading the original patch is correct. Maybe it would act
> > as cleaner 'documentation' to have the sign_extend32() for the cold jun=
ction be
> > from bit 12 rather than 15, but I'm not sure it's worth the effort.
> >=20
> > Andrew, would be great if you can review this fix in case we are all mi=
ssing
> > something! =20
>=20
> I also agree that Dimitri=E2=80=99s original patch appears correct per th=
e data sheet.
>=20
> I think of the cold junction register as a 16 bit 2s complement signed in=
teger,=20
> despite the limited range. I like sign extending it from bit 15 rather th=
an from 12.
>=20
> I applied Dimitri=E2=80=99s patch and stuck a dev board in my icebox.
>=20
> Before patch:
>     # cat /sys/bus/iio/devices/iio:device0/in_temp_raw=20
>     65222
>     # cat /sys/bus/iio/devices/iio:device0/in_temp_ambient_raw
>     65256
>=20
> After patch:
>     # cat /sys/bus/iio/devices/iio:device0/in_temp_raw
>     -260
>     # cat /sys/bus/iio/devices/iio:device0/in_temp_ambient_raw
>     -212
>=20
> Looks good to me! Thanks for the patch Dimitri, and thanks to all for the=
 review!
>=20
> Andrew
That definitely deserves a Tested-by tag so I added one. Hope you don't min=
d!

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

