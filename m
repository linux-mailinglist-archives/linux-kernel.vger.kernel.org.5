Return-Path: <linux-kernel+bounces-165262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A088B8A36
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B693B2127B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E7D524DC;
	Wed,  1 May 2024 12:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CZCwmCS+"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E194F217
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567407; cv=none; b=fzub6CSONHXWlR6jWiuT9C/VgymvG7f5bOPoDDjGKCy0kA2l6r/RX8m0t6nA8iFgEE1/ULjyy7cEGX95ayv6+i5in/wUdYmHV0KKbFoWVmxS0M0zfP6M30XluKvmcUr44q4rxRVN7baJunGyrlgXEWYFG1ZkyuHxTO2jUvFORYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567407; c=relaxed/simple;
	bh=Oh9u3SNuwMwGqWyLQSKkUBfpCoy4o6zvBIRMSN50Stk=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pxK0HrJAJTC4p3yhahQa8wCZ7ueN1+8kltA0XsUjo8KrTyuRgf5QRwEmUu19hB5qW4oX8jvBEsSnDz+0HZOUshmNhUjJ5dDMLryMAoheIQrBPqg5VSaukrprAaUwG+F4dmhFyxZ96ZwmaBCGmOze6rLVUt0kPk639iewkLuvUF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CZCwmCS+; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 441Ch0BJ092358;
	Wed, 1 May 2024 07:43:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714567380;
	bh=9zeGrx8/g53vdKI8P01kUnQCeIDP16OwD9S+bvjYXGY=;
	h=Date:From:To:CC:Subject;
	b=CZCwmCS+mH9dMvmQZnAzdlJ3iJJmsDg8gQPDJ1+yIIwvqBcWnIkYTZjWoqasBZ0F4
	 jQsM4Tlfz4wzcd1uHp04EXrHwPHjxRbY7IIyZfxfMrlVHo/ciXcByI2/b/7HHW9aaB
	 ppsQIV+42U4XKf6RtiU54kXW2KbrlpwHTKr/QLzo=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 441Ch0Tg033740
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 1 May 2024 07:43:00 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 1
 May 2024 07:43:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 1 May 2024 07:43:00 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 441Ch0VL019428;
	Wed, 1 May 2024 07:43:00 -0500
Date: Wed, 1 May 2024 07:43:00 -0500
From: Nishanth Menon <nm@ti.com>
To: Arnd <arnd@arndb.de>, Olof <olof@lixom.net>, SoC <soc@kernel.org>
CC: <arm@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony
 Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/3] soc: ti: Driver updates for v6.7
Message-ID: <20240501124300.i5jzeugdlrlnfg22@undrafted>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4bwlrw3hplnu7m6d"
Content-Disposition: inline
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--4bwlrw3hplnu7m6d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please pull:

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-driv=
er-soc-for-v6.10

for you to fetch changes up to ddbf3204f600a4d1f153498f618369fca352ae00:

  soc: ti: wkup_m3_ipc: Send NULL dummy message instead of pointer message =
(2024-04-09 11:11:59 -0500)

----------------------------------------------------------------
TI SoC driver updates for v6.10

Generic Cleanups/Fixes:
- wkup_m3_ipc: Minor optimization to send NULL dummy message instead of emp=
ty pointer message
- ti_sci: Register restart handler unconditionally

----------------------------------------------------------------
Andrew Davis (3):
      firmware: ti_sci: Use devm_register_restart_handler()
      firmware: ti_sci: Unconditionally register reset handler
      soc: ti: wkup_m3_ipc: Send NULL dummy message instead of pointer mess=
age

 drivers/firmware/ti_sci.c    | 24 ++++++------------------
 drivers/soc/ti/wkup_m3_ipc.c |  7 ++-----
 2 files changed, 8 insertions(+), 23 deletions(-)

--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--4bwlrw3hplnu7m6d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmYyOM4ACgkQ3bWEnRc2
JJ2hLw/+MSZSJd2W4TJrESZMjQ7LFyuZ+JwQMpxpN7J6XAI9wzdlYnVb0SXSYP4+
LScuaoEx4z8k/7tYP89WIaTxHMOb4xWsYKO7J51NVOmZm+k5vCL27Pt8JiPUULSH
Xiigv7PXBO0F99JdWXM96m09YnHqRf1Xds4tdZRRgs46My5akbM9TtUnk73wnTTv
R+UaVFlcPgDjYFDfd3RwGtKhlgmY/XeT8RSZeIkNvkQC0pXyRF3OS/wl0qj5qsB8
SAVP9vuyAb4D2YomWJOSabqiCfQihp8ShrBxhJhF8Zy4cv2wACdl8+D5k42qe2hA
reabZGiNYPEVZAFrz4hFOUF1wOUWlVbrkwvNXQE2AvjZSXVI0KUETWKeHttZ1xZ2
T8/cKWXeqZKA71lBeNRoa/+DxyCEFZStG5Rfrw2LNrsWywEH2FI+gIwxWebJu60g
rchT7XhdvdwoxAIGNb7PpogM6dlN0IpmvoNdRjFlzMUMRd2TgjxykV46JfOuNmi2
2bpXjLXC1KnCC9GJcPgFjTTdRo27/Gp7b5MJKxyQSTCfVf5hKVhjFmjmsNv4TQ+L
1BuK/XiuBB92ZTST0P5iFFxqgMmsJf7F4WwbBiSCf0w+9+COhJJ1tYY+cKxGnKsV
wuGOu7kF293N9UrH8QL7yiIdCbIDj+RJvlRZhS5YDcymNFFs2Zs=
=TNtR
-----END PGP SIGNATURE-----

--4bwlrw3hplnu7m6d--

