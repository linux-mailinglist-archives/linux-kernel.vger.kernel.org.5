Return-Path: <linux-kernel+bounces-37715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BEB83B44E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0761C24339
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24798135409;
	Wed, 24 Jan 2024 21:55:18 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A281353FE;
	Wed, 24 Jan 2024 21:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706133317; cv=none; b=B/dYVmSicFVc+u6H+DGwiqAS8b7uEsTbpi/082OA4QE4X9MYSF6f/zH6nC7szl6KODHvzZxgCoMstxyKTtaNoPQyhPwCs6zRNBSelbbgayNtjWjapnIbhb3hfcUB06JJMMYdXuj5GUKiQxwCMWiHsT+kyNa/ID/VZNpIqiLb05M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706133317; c=relaxed/simple;
	bh=309aYL4WHgnoj7cp3YCClCX/HORT29FwxxqIu388QIM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MytwKrReNPe5jQJ3ZfQ0i783KajgsL5oTh2Foa3H3zk+BWf6A0GC6E54W2UMpFe/r44JxNQ4Zj8d7lI/hnSwGMoIQSJnX/M6pu0uBjodD0b03A4O5MSkgg0Szw/GzopnjCU+ScpxqPz/W9UKt1UO1pakD+i/BUL211RBFsRXVew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b68f75.dsl.pool.telekom.hu [::ffff:81.182.143.117])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000070DBE.0000000065B1873B.0018A6D1; Wed, 24 Jan 2024 22:55:07 +0100
Message-ID: <4dbee9d8524da296b185ba0fe6827249c93eebd6.camel@irl.hu>
Subject: Re: [PATCH 0/2] ALSA: hda: Move component binding support into
 separate library
From: Gergo Koteles <soyer@irl.hu>
To: Richard Fitzgerald <rf@opensource.cirrus.com>, tiwai@suse.com,
  shenghao-ding@ti.com
Cc: perex@perex.cz, linux-kernel@vger.kernel.org,
  linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
  patches@opensource.cirrus.com
Date: Wed, 24 Jan 2024 22:55:07 +0100
In-Reply-To: <20240124112607.77614-1-rf@opensource.cirrus.com>
References: <20240124112607.77614-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Richard,

On Wed, 2024-01-24 at 11:26 +0000, Richard Fitzgerald wrote:
> The Cirrus Logic amplifiers are currently paired with Realtek HDA codecs.
> But they could be used with other codecs. To prepare for this, these two
> patches move the manager side of the component binding out of the Realtek
> driver into a library module.
>=20
> The first patch tweaks the CS35L41 code so that it is not hardcoded to
> CS35L41, and changes the TAS2781 handling so that it re-uses that code
> instead of having a near-identical copy of it.
>=20
> Can someone please test that these two patches don't break TAS2781?
> I have checked that they should work in theory but I don't have hardware
> to test on.
>=20

It works on a Lenovo Yoga 7 14ARB7 laptop.

Tested-by: Gergo Koteles <soyer@irl.hu>

Regards,
Gergo

> Richard Fitzgerald (2):
>   ALSA: hda: realtek: Re-work CS35L41 fixups to re-use for other amps
>   ALSA: hda: realtek: Move hda_component implementation to module
>=20
>  MAINTAINERS                   |   1 +
>  sound/pci/hda/Kconfig         |   4 +
>  sound/pci/hda/Makefile        |   2 +
>  sound/pci/hda/hda_component.c | 169 ++++++++++++++++++++++++++
>  sound/pci/hda/hda_component.h |  59 +++++++++
>  sound/pci/hda/patch_realtek.c | 217 ++++------------------------------
>  6 files changed, 261 insertions(+), 191 deletions(-)
>  create mode 100644 sound/pci/hda/hda_component.c
>=20


