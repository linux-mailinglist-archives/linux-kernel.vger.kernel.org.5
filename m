Return-Path: <linux-kernel+bounces-2622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD22815F92
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC081C21E1F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE904439B;
	Sun, 17 Dec 2023 14:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxKILIAX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3B14437D;
	Sun, 17 Dec 2023 14:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E69C433C7;
	Sun, 17 Dec 2023 14:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702822260;
	bh=232ebC+aydld8uM75OIYPmde9ImqL+FqL1VcnhiVjpA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZxKILIAXFzTlwS/4DOuv/wVlUowtJedCGqk2s6NXk5X6ZwwsngBhdQjpPO4MmiE+W
	 cBZGf9wwdaTOiz8W/f1LSEwmUvnUJQJGB/WRG4+g+87rsghCcHY1yvaPAkLMa6r41w
	 Tzm/QL+xffCiokGQSDu/h83abPBC6zZDYcuELYJ+l3rHuzSvbE5DWajtVIlmRjYYxj
	 LnZeDJAIKEAH8Pnos0xFiElP2jXkN/bBhMJkhmN7v8/ywc5H5xT5UWzRqz0RivpfzB
	 LIEBhRZphWR00Bo0aOM8G80GLku81bwcgQ09FuPMbv9G34CyC0uuP8pu3rwYem2BgH
	 7enq8KH7SpTLw==
Date: Sun, 17 Dec 2023 14:10:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?TcOlcnRlbg==?= Lindahl <marten.lindahl@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH 0/2] Introduce new iio resolution standard attribute
Message-ID: <20231217141046.4cf3e34e@jic23-huawei>
In-Reply-To: <20231212-vcnl4000-ps-hd-v1-0-1c62a95828c0@axis.com>
References: <20231212-vcnl4000-ps-hd-v1-0-1c62a95828c0@axis.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Dec 2023 13:43:03 +0100
M=C3=A5rten Lindahl <marten.lindahl@axis.com> wrote:

> This patch introduces a new IIO standard attribute to set the bit
> resolution of the data *_raw readings dynamically using sysfs.
>=20
> The VCNL4040/4200 proximity/ambient light sensors support 12-bit
> (default) and 16-bit ADC resolutions. This can be dynamically changed,
> so to support this with the standard iio channel configuration a new iio
> attribute should be added.
>=20
> The VCNL4040 devices will use this for setting proximity high definition
> (16-bit resolution).
>=20
> Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>

Hi M=C3=A5rten,

What is the use case?  We've had lots of devices capable of doing this
sort of resolution change, but never yet come up with a reason to do so for
the sysfs interfaces on the basis the overhead of the sysfs interfaces is
high enough the best bet is almost always to use the highest available reso=
lution
and don't worry that the read takes a little longer.

Jonathan

> ---
> M=C3=A5rten Lindahl (2):
>       iio: core: Introduce resolution standard attribute
>       iio: light: vcnl4000: Add ps high definition for vcnl4040
>=20
>  drivers/iio/industrialio-core.c |  1 +
>  drivers/iio/light/vcnl4000.c    | 87 +++++++++++++++++++++++++++++++++++=
+++++-
>  include/linux/iio/types.h       |  1 +
>  3 files changed, 87 insertions(+), 2 deletions(-)
> ---
> base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
> change-id: 20231212-vcnl4000-ps-hd-38d42abf9095
>=20
> Best regards,


