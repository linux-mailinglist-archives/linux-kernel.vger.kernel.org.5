Return-Path: <linux-kernel+bounces-91162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F48870A6F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0CB51F2295F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D787CF03;
	Mon,  4 Mar 2024 19:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3K3cePX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529D17C6CE;
	Mon,  4 Mar 2024 19:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579567; cv=none; b=DOkRMtKO98IwyBIWuQD6uhwRjd0o9GwbHwyU8ws76XuSrRRi8thcmf9YlgZI+gTyitmhDX3D7lg12BQTukkQhx8cE1i0Pci2pTpyX5s7yZMDFVySu33xNonclePtWQISZyygHXvmZdKy4q/wcBZuQR3vY21GxP44cRuknHI9jeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579567; c=relaxed/simple;
	bh=QSR6I3jfyGK14va/ehCs0Hkla4STm7N1K8hQmaLZ2vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFkFzioUfxMPYsGfJC6/mlVvgPUfx/g2hx8RuOJc3Of0Bq3Vn0VFAPpDLRy6Y857MNe9VlHrSAT6fvoWLOdNEkqQomulu9jqoVxs9Gb922dzkh6R4CWfK6dEXnttENW7Um/5M98bHFIio/7RZXhYUa5l6r9l7CBgYzplipSQ9uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3K3cePX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81A0C433F1;
	Mon,  4 Mar 2024 19:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709579566;
	bh=QSR6I3jfyGK14va/ehCs0Hkla4STm7N1K8hQmaLZ2vU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V3K3cePXRCVXsXCvb7n4XR324l2knWT3B//QwHRnxH3SGSNoiu1nBKUjlHhL9FVOc
	 0DA+XmH20JE3yQiSRXFzz0EPYFT2P9VxCVT+ysoZrSzTvMBg0wqo1/wdH0r0Rhm09H
	 9K87SiXgwz4G1A4/56L00nNLSh4lV2pmIRRBXZLR4bfK0m6YXGjRCj4rMf+5+dPY4J
	 KV+NM51DEgIko7lHOoDBjDsUqISyzsOMGgCgvEK50HYzg620w0VwYvEkFihUjc2wxm
	 r1gZotlOTf85+UuGUU8RL6Ktqmoatub0Sx2yj7g7B2IKYZWu2YelPR30yoy6McvjY6
	 hDcWBbeYUGRVA==
Date: Mon, 4 Mar 2024 19:12:40 +0000
From: Mark Brown <broonie@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v3 0/2] ASoC: SOF: amd: Skip IRAM/DRAM size modification
 for Steam Deck OLED
Message-ID: <62b7add5-97b8-4f82-bf49-9d20d8a0407a@sirena.org.uk>
References: <20240220201623.438944-1-cristian.ciocaltea@collabora.com>
 <db53a405-362f-4c8d-82e2-49c001b29dd1@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yjcqeVw2x6rkxRWa"
Content-Disposition: inline
In-Reply-To: <db53a405-362f-4c8d-82e2-49c001b29dd1@collabora.com>
X-Cookie: He who hesitates is last.


--yjcqeVw2x6rkxRWa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 09:11:06PM +0200, Cristian Ciocaltea wrote:

> Could we get this queued for merging as v6.9 material?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--yjcqeVw2x6rkxRWa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXmHSgACgkQJNaLcl1U
h9CHcQf/QHAAawoaBLZYEmSJ6jjIXptEJvNjgLTRrIKFMDRoRGxUDsYLdiWjXIrq
QRG3QFAcwvQMdnh7plUQy6JPh0jxuN4DtXxsWHnOlVS4pKkyU+SDXQJWzcuxBX4/
9gMLYJDp7TTsm7HLaZm5YJ1y4NYnKXkTwy5IsaY4hssRQre+MZ+DsR28y82XhkOZ
xUCs+k3FcjRxngsF/7ceM2x9YjeRXlJDK3ux4LA3lNawdYYKKWoTvBQnlGQAbAeN
SDRgYBMcSAaWE030csrSbvO1Lf+boSaebTrM05GA5muz+MgbrY+8FxOgynQhWqsb
jBFGg8yN0BwJXxr0eh+R/YipeO6Ydw==
=NMer
-----END PGP SIGNATURE-----

--yjcqeVw2x6rkxRWa--

