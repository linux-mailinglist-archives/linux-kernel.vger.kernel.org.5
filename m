Return-Path: <linux-kernel+bounces-84503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF9986A790
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1B128CF57
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF18A208CF;
	Wed, 28 Feb 2024 04:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ph7xNvBw"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEEB208A8
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 04:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709094156; cv=none; b=aub0f+CKwJvg6GvWUarSVh3eu33VTdXISbOsbg6wx95DbdcLHu0/9s0wF9QRvaq/jUwUFY4CYcsMHamoizxpxhn1OSKYLUrjBBwPLnOaZNcwZ+Je9OUbLxzQY7jLIkoqOtFxUIW3IYu8ISVrMOG0fSL5oUm/di6p3yaE8M4W3So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709094156; c=relaxed/simple;
	bh=TEzZZdvRS1ldfmiCsmKe0vokTc3UQd/MbWxqQlImwaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aLj20rxCGFsXfQxH4ZVAgX4pHjcf/JzvMtfUic0mo3Q+SuKxg8LTuMWgZPRMBusrNcjVmEsby6oizG2guE+NXhfndBvfx7r2GEW5pWFIbZ3JXKlXdsrD8lpVOouZFy0eI2XzvAQmmdMNGPheVwJTP0W98KwQw1FDbjKGODIZX7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ph7xNvBw; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41S4MO8o088288;
	Tue, 27 Feb 2024 22:22:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709094144;
	bh=uOMXxiLvdKL4AtXcYa6qxw/0JHnggNcnG64J5RnQQLs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Ph7xNvBwh0dZFGGU4+pvLBLEd+xZlaXU4/SxQ+mKwyxWMWcJ+ajx5a1XH3ut/C6yJ
	 Pq3Roo0GJ4whIR1GB+afmNI2Icakam/fRrqnKp2j941bPoaYTSh+On8U7KPEKI+TzS
	 cCBlGgXjr1tmVzWdUrCcDecyHopBGJMatHUok8pk=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41S4MOgC016064
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Feb 2024 22:22:24 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Feb 2024 22:22:24 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Feb 2024 22:22:24 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41S4MK5R111529;
	Tue, 27 Feb 2024 22:22:21 -0600
Message-ID: <a555943a-45d0-4e8e-ad25-682638cfcff7@ti.com>
Date: Wed, 28 Feb 2024 09:52:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [GIT PULL 2/2] ARM/arm64: defconfig: Updates for v6.9 for TI K2/K3
 platforms
Content-Language: en-US
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm-soc
	<arm@kernel.org>, SoC <soc@kernel.org>
CC: Tero Kristo <kristo@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>
References: <e7e984db-47b9-404a-9471-5d2ed0effe1d@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <e7e984db-47b9-404a-9471-5d2ed0effe1d@ti.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------9fx309zh3wgVxU6L6u2LMj0K"
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--------------9fx309zh3wgVxU6L6u2LMj0K
Content-Type: multipart/mixed; boundary="------------ZCdoKbjb0TEaZdVZTsgy4z18";
 protected-headers="v1"
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
 arm-soc <arm@kernel.org>, SoC <soc@kernel.org>
Cc: Tero Kristo <kristo@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>
Message-ID: <a555943a-45d0-4e8e-ad25-682638cfcff7@ti.com>
Subject: [GIT PULL 2/2] ARM/arm64: defconfig: Updates for v6.9 for TI K2/K3
 platforms
References: <e7e984db-47b9-404a-9471-5d2ed0effe1d@ti.com>
In-Reply-To: <e7e984db-47b9-404a-9471-5d2ed0effe1d@ti.com>

--------------ZCdoKbjb0TEaZdVZTsgy4z18
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd3=
3d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3=
-config-for-v6.9

for you to fetch changes up to 02b645583e26f38261711f2a8b36c5db06862527:

  arm64: defconfig: Enable Wave5 Video Encoder/Decoder (2024-02-21 23:41:=
39 +0530)

----------------------------------------------------------------
TI K2/K3 defconfig updates for v6.9

- Enable Wave5 encoder/decoder driver present on multiple K3 SoCs
- Enable K2 boards via multi_v7_defconfig to move away from keystone
  specific defconfig.

----------------------------------------------------------------
Andrew Davis (1):
      ARM: multi_v7_defconfig: Add more TI Keystone support

Brandon Brnich (1):
      arm64: defconfig: Enable Wave5 Video Encoder/Decoder

 arch/arm/configs/multi_v7_defconfig | 16 ++++++++++
 arch/arm64/configs/defconfig        |  1 +
 2 files changed, 17 insertions(+)

--------------ZCdoKbjb0TEaZdVZTsgy4z18--

--------------9fx309zh3wgVxU6L6u2LMj0K
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEyRC2zAhGcGjrhiNExEYeRXyRFuMFAmXetPsFAwAAAAAACgkQxEYeRXyRFuPG
NQf9Hmj4ji1Z/XzFGIS8bGCbXDhVaJCRfpv4aJsnia5rWQvsGUiifFq2p/MqQ0fzbBdZNC1ZSVRy
HNn/Ww4jU6rQvbUetQU99SECUKVyap/3wOUKmIGoyX1Dg9eYRR1/03oOqO6r1L5ySsJ9eRLnrMIY
a/yAKlsBrsoExMvw2gRQGFfUlzkdIP+yVlfsqqCBHUY1beWaIdlBGfZXCMrY2kMJ1JFfK36h88lt
k9/VFaOCFgm9JGyVVI8In+Jj8NqfyaZGsu3w92qA982zCIrAr1KgOl3FpH8CINjbPzU7Vt9EKGpX
V/D+sjCoP45JjADL+EXgHb9tLKzKEDR14Tts3Fvt8Q==
=+QhN
-----END PGP SIGNATURE-----

--------------9fx309zh3wgVxU6L6u2LMj0K--

