Return-Path: <linux-kernel+bounces-69960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF828590D7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385762827A8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3077D3E0;
	Sat, 17 Feb 2024 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WN1jiU2y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787B77C6DB;
	Sat, 17 Feb 2024 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708186829; cv=none; b=ZDzaJpuz06o+W+wDO6TlpsyvaOklLLq3WcWxe514/vTY+rrNkEteTCUQPqJjwmPwqNgVE62MJ5Dz6YmnFXBnrLeT2+gIbaq2On6wGWxCA9+ZiVmgHgmHP+LvXkrnyuFIScZ3O88Yi6TFMcxwr1QKGeg5qUzNBnnWR80mouwtArE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708186829; c=relaxed/simple;
	bh=pinq5hJ41Wz3DzVBX9u6x2N9ZPrqhuJR0IdquEK3YuI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RUhPwHc85xvh48HQsWrvGtimbVOzXqTGfMFvUyvPilZDa9zS2em1pV9P9qbdnx4dAIzYajxdj/j6dzO2GQGC0YdM+PV4Yd3pHPSrSgUxsuZwG9niYOnARXNVaVidZK1TuUngt8Iu6jJPsOBjxzksstZWBXPDiM4Ij1C2X4kuimM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WN1jiU2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853C5C433C7;
	Sat, 17 Feb 2024 16:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708186829;
	bh=pinq5hJ41Wz3DzVBX9u6x2N9ZPrqhuJR0IdquEK3YuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WN1jiU2yBqMjqJfbIuz2kzJlq7oSN/6cZY1QrbEXNDMckrfF3fiEkJwk88/arbiKd
	 4z3bqFXNKrHdtFFJUUTxDJ2M0B3sTfZ9t8/rTBMrjnaInQI9xvgfPdGep/q9sQXimK
	 h2XkRSCiqtvjIB7xzzBQZajg9cxpcWlXTRCZ4OexvTYWVzUVf1mqZNHnf0dwSfnUJ/
	 MQq40GF95Vo5TADjaFozy+wh5QR7b2MA4A31lHJEp5sxtkrTsHEHiqbqSF6zb+HGpT
	 CwVhHBd9pBjcqI2FAjNfHKWIqxkVDxKdd7AtB4iZoZHACH7nI/yNRYRoibFtpBo2/b
	 SSb9eiAk6KSzg==
Date: Sat, 17 Feb 2024 16:20:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
 devicetree@vger.kernel.org, Julien Stephan <jstephan@baylibre.com>
Subject: Re: [PATCH v4 2/2] iio: adc: ad7380: new driver for AD7380 ADCs
Message-ID: <20240217162014.17033d64@jic23-huawei>
In-Reply-To: <CAMknhBGg0hHXrd3K92tgHHTnfbk7dLAMvtTSZff1P-C3=9nFaw@mail.gmail.com>
References: <20240110-ad7380-mainline-v4-0-93a1d96b50fa@baylibre.com>
	<20240110-ad7380-mainline-v4-2-93a1d96b50fa@baylibre.com>
	<CAMknhBGg0hHXrd3K92tgHHTnfbk7dLAMvtTSZff1P-C3=9nFaw@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Feb 2024 14:34:01 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On Wed, Jan 10, 2024 at 2:29=E2=80=AFPM David Lechner <dlechner@baylibre.=
com> wrote:
> >
> > This adds a new driver for the AD7380 family ADCs.
> >
> > The driver currently implements basic support for the AD7380, AD7381,
> > AD7383, and AD7384 2-channel differential ADCs. Support for additional
> > single-ended and 4-channel chips that use the same register map as well
> > as additional features of the chip will be added in future patches.
> > =20
>=20
> Hi Jonathan,
>=20
> We have some additional features to add to this driver we are working
> on that look like they might affect userspace. Can we hold off on
> sending this one to Greg for 6.9? That way we will have more time to
> sort that out without having to worry about breaking userspace.

Ok. Hopefully rebasing my tree won't cause others too many downstream
problems. Generally I only do this if there is an invalid tag or similar
that must be fixed.  There is normally a window of a weekish
between me picking it up and pushing out for linux-next to pick up and
hopefully issues like this get spotted in that window.
Ah well, sometimes things don't work out how we would like them to.

Dropped the 3 patches (original driver and a fix) from the togreg branch.

Jonathan

