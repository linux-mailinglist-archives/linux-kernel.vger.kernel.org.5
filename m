Return-Path: <linux-kernel+bounces-64203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C181A853BD0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41631C268CB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3101860B80;
	Tue, 13 Feb 2024 20:02:44 +0000 (UTC)
Received: from tux.runtux.com (tux.runtux.com [176.9.82.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B135FF00;
	Tue, 13 Feb 2024 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.82.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707854563; cv=none; b=GGuBB4hEY0RcDPPIbCoempxqSTFCDq9MSrPPLjVJQL6nM2c3e1hutGisBIlWy6WX4VsR6vVa/EQOHj7Q+kqtB73dFz+rikmjATTcK/HECRvTsn3W0/OoMPc2yEQe4ODhzazt7ifAJmWEvVLWNmJDBo9LLFg5ZgkK4p+XN7jFzRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707854563; c=relaxed/simple;
	bh=vjvpAwZUezSPHWLePsPOo+4691Gb/2TBIccS5lD/9XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nd7Y9ZmgohVTH6nn/KR6Dmp8pbQk3P5SEnopvuqd7qlQNRmd0R9ER4r80X+Gp7b+0rf61ZGw/S3NIA4LwbKxP4rvMmuAy4AVLqUwSE5PEq0Tolz1RIClSknDBfKz5Sxhy0/MpSI982es3JxlbL8Ddl0nRh/FGBCDAGVrL/qkAMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=runtux.com; spf=pass smtp.mailfrom=runtux.com; arc=none smtp.client-ip=176.9.82.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=runtux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runtux.com
Received: from localhost (localhost [127.0.0.1])
	by tux.runtux.com (Postfix) with ESMTP id 44F7D6EFA5;
	Tue, 13 Feb 2024 21:02:39 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at tux.runtux.com
Received: from tux.runtux.com ([127.0.0.1])
	by localhost (tux2.runtux.com [127.0.0.1]) (amavisd-new, port 10026)
	with LMTP id q3_pjEGApcV9; Tue, 13 Feb 2024 21:02:36 +0100 (CET)
Received: from bee.priv.zoo (62-99-217-90.static.upcbusiness.at [62.99.217.90])
	(Authenticated sender: postmaster@runtux.com)
	by tux.runtux.com (Postfix) with ESMTPSA id DE5116EF5B;
	Tue, 13 Feb 2024 21:02:35 +0100 (CET)
Received: by bee.priv.zoo (Postfix, from userid 1002)
	id 78EBD469; Tue, 13 Feb 2024 21:02:35 +0100 (CET)
Date: Tue, 13 Feb 2024 21:02:35 +0100
From: Ralf Schlatterbeck <rsc@runtux.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] spi-mxs: Fix chipselect glitch
Message-ID: <20240213200235.htnvyy343qiw3kbv@runtux.com>
References: <20240202115330.wxkbfmvd76sy3a6a@runtux.com>
 <20240213170657.puwlx5pjl3odcs2k@runtux.com>
 <CAOMZO5CD7+E_BBH+oQ8HUdBeRFZxWW7s2uJgS5eaQAW_Fe4CNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAOMZO5CD7+E_BBH+oQ8HUdBeRFZxWW7s2uJgS5eaQAW_Fe4CNg@mail.gmail.com>
X-ray: beware
User-Agent: NeoMutt/20180716

On Tue, Feb 13, 2024 at 02:22:53PM -0300, Fabio Estevam wrote:
>=20
> On Tue, Feb 13, 2024 at 2:07=E2=80=AFPM Ralf Schlatterbeck <rsc@runtux.co=
m> wrote:
> > > ---
> > > For oscilloscope screenshots and a verbose explanation see my blog po=
st
> > > at https://blog.runtux.com/posts/2024/02/01/
>=20
> I suggest putting the link to your detailed explanation into the
> commit log as this is useful information.
>=20
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks for the review!

My blog post might go away at some point.
And I think when looking at the original patch (in the Fixes: line) it
is quite obvious that the file in question was overlooked during the
original change. So it was hard to find and I documented it but looking
at it in context should be pretty clear.

Thanks
Ralf
--=20
Dr. Ralf Schlatterbeck                  Tel:   +43/2243/26465-16
Open Source Consulting                  www:   www.runtux.com
Reichergasse 131, A-3411 Weidling       email: office@runtux.com

