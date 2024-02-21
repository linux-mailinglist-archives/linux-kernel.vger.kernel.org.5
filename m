Return-Path: <linux-kernel+bounces-74612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B5385D6CF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8463F1C21A0D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE133FE54;
	Wed, 21 Feb 2024 11:26:43 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F3B3FE3D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708514802; cv=none; b=RGRaIz+Td7Rjyidq2K5uQ/VGpF/W5Pa9JTke7LHaIweoJ6hVlFeJrJDJH+MYjgDLGz89kKVsn/23dki2qb5DFnJVwrnZYA4yyVLONB2UuUCezx50Xb8+JLv2x7d4xQ9x0p6/cSIqWjMaO90r934nsv8XYjBrXSc4QMOax54O61E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708514802; c=relaxed/simple;
	bh=0b8SeCdjbW0gI8qK6TzdaaI5mEtgC9wamMalUHNEG2o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bDl7G2zPV41bHNPhjHeVMap30W92TurDTDTgAKgAEwQ1Dkm3/wL3hJnWCtwEIeHSCSZ57s+zaZ1awG7JalXs2B/MljzNtz4jqSf0PlqUy+D8tQAeLNaw50FcAFavwwUaNFyXy64OkkCHdlYYHGm4CqIRSYYbjsVdVnjd5qvqPMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rckk2-0008Rw-D4; Wed, 21 Feb 2024 12:26:22 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rckjz-0021oc-6E; Wed, 21 Feb 2024 12:26:19 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rckjz-0005aF-0M;
	Wed, 21 Feb 2024 12:26:19 +0100
Message-ID: <38fda6619769da7240517982adfe734cb653ff5e.camel@pengutronix.de>
Subject: Re: [PATCH v6 0/6] reset: gpio: ASoC: shared GPIO resets
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Banajit Goswami
 <bgoswami@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, Konrad
 Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  "Rafael J. Wysocki" <rafael@kernel.org>, Viresh
 Kumar <viresh.kumar@linaro.org>, Frank Rowand <frowand.list@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chris Packham
 <chris.packham@alliedtelesis.co.nz>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Sean Anderson <sean.anderson@seco.com>
Date: Wed, 21 Feb 2024 12:26:19 +0100
In-Reply-To: <7ae0567d-e5d3-4e00-98f7-5139d5879f75@linaro.org>
References: <20240129115216.96479-1-krzysztof.kozlowski@linaro.org>
	 <7ae0567d-e5d3-4e00-98f7-5139d5879f75@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mi, 2024-02-21 at 10:44 +0100, Krzysztof Kozlowski wrote:
> On 29/01/2024 12:52, Krzysztof Kozlowski wrote:
> > Hi,
> >=20
> > Dependencies / Merging
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 1. Depends on !GPIOLIB stub:
> >    https://lore.kernel.org/all/20240125081601.118051-3-krzysztof.kozlow=
ski@linaro.org/
> >=20
> > 2. Patch #2 (cpufreq: do not open-code of_phandle_args_equal()) and pat=
ch #4
> >    (reset: Instantiate reset GPIO controller for shared reset-gpios) de=
pend on OF
> >    change (patch #1).
>=20
>=20
> Hi Philipp,
>=20
> I got acks from GPIO folks. The also provided stable tag with dependency:
> https://lore.kernel.org/all/20240213101000.16700-1-brgl@bgdev.pl/
> (which BTW already is in mainline, so you could just merge Linus' tree
> into your next branch)

Thanks.

> Can you take entire patchset?

I've picked up 1-4. Patches 5-6 can go independently via ASoC, right?

regards
Philipp

