Return-Path: <linux-kernel+bounces-13631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB798209BB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 06:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C2B0B2122E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 05:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2D617D3;
	Sun, 31 Dec 2023 05:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="yMOHqcuL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6801391
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 05:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1703999023; x=1704258223;
	bh=QrNUfX8Rb1OX00fG4mbQo/eO3Y707VvS2aAOdZZ/lzQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=yMOHqcuLGdg9TI29jGJ3y5pPcVC0kbKrn6FmEnZBmpzCoRVtwNbxkRP0iVn/U/l+U
	 tyIVwr8r+yW1Csy2VOEfQktIfwNFDRs9rHxFCjpS37wEPSMiP6QJk/szkRPAvhCoUf
	 Mv8D1LNUgVnrSZqO36lRNQgGcuY7kVPOggl5SIuBrYivULR7aa1MunmfWueJq/3jBe
	 EVZ+sGA76TxJS24XjFOh7RgUbdm03OypkalkxGDqNWW5YCkBJuR36qX69dnhlDHh/9
	 l2vlxIKTyO45Ku+5lY9HfxT1dMTyu6u3eU7PGBKsrDs2+LltlIBk00RSHC5fc7gDcG
	 pPZ5snfCb6jRQ==
Date: Sun, 31 Dec 2023 05:03:27 +0000
To: Kalle Valo <kvalo@kernel.org>, Larry Finger <Larry.Finger@lwfinger.net>, =?utf-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>, Julian Calaby <julian.calaby@gmail.com>
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org, Rahul Rameshbabu <sergeantsagara@protonmail.com>
Subject: [PATCH wireless v2 0/4] wifi: b43: Various QoS-related fixes
Message-ID: <20231231050300.122806-1-sergeantsagara@protonmail.com>
Feedback-ID: 26003777:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Recently acquired a MacBookPro8,3 (early 2011), which has a bcm4331 card.
Noticed some issues with the wireless driver, specifically related to QoS, =
when
using this device.

Out of the box, applications like ssh appear to not work with the device wh=
en
QoS is enabled. This series attempts to improve the out-of-box experience w=
hile
cleaning up some fundamental issues in the driver when QoS is disabled, eit=
her
by the related kernel parameter or the newly introduced QoS disablement
function.

Running FW 784.2 during testing.

Log:
    [   11.661972] b43-phy0: Loading firmware version 784.2 (2012-08-15 21:=
35:19)
    [   11.919942] b43-phy0: Loading firmware version 784.2 (2012-08-15 21:=
35:19)
    [   13.717460] [drm] amdgpu kernel modesetting enabled.
    [   13.717705] amdgpu: Virtual CRAT table created for CPU
    [   13.717719] amdgpu: Topology: Add CPU node
    [   13.776896] NET: Registered PF_PACKET protocol family
    [   15.234058] b43-phy0: Loading firmware version 784.2 (2012-08-15 21:=
35:19)
    [   15.319388] wlp3s0b1: authenticate with 1c:87:2c:6f:f4:e0
    [   15.333239] wlp3s0b1: send auth to 1c:87:2c:6f:f4:e0 (try 1/3)
    [   15.341672] wlp3s0b1: authenticated
    [   15.341921] wlp3s0b1: associate with 1c:87:2c:6f:f4:e0 (try 1/3)
    [   15.346912] wlp3s0b1: RX AssocResp from 1c:87:2c:6f:f4:e0 (capab=3D0=
x411 status=3D0 aid=3D3)
    [   15.347255] wlp3s0b1: associated

Link: https://lore.kernel.org/linux-wireless/20231230045105.91351-1-sergean=
tsagara@protonmail.com/

Rahul Rameshbabu (4):
  wifi: b43: Stop/wake correct queue in DMA Tx path when QoS is disabled
  wifi: b43: Stop/wake correct queue in PIO Tx path when QoS is disabled
  wifi: b43: Stop correct queue in DMA worker when QoS is disabled
  wifi: b43: Disable QoS for bcm4331

 drivers/net/wireless/broadcom/b43/b43.h  | 16 ++++++++++++++++
 drivers/net/wireless/broadcom/b43/dma.c  |  4 ++--
 drivers/net/wireless/broadcom/b43/main.c | 16 +++++++++-------
 drivers/net/wireless/broadcom/b43/pio.c  |  6 +++---
 4 files changed, 30 insertions(+), 12 deletions(-)

--=20
2.42.0



