Return-Path: <linux-kernel+bounces-159187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F94C8B2A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E16E2812C0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B75415535E;
	Thu, 25 Apr 2024 21:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XO8Yqbl7"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047F2152E19;
	Thu, 25 Apr 2024 21:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079348; cv=none; b=TMANQxtFycWO/z23euRMH7LvAd/bYVkbB7zPgM+2XMYUZovKxzxcphywJ6YV2KZWcxoL5XKAi9M6t3g01pp+CvHTLMIwH4Y0n8zUe2pjC29UijFmTC4svlBKT+KCeRdAETWxgQmyTl/us348cjdwdX53LmfCmox5YwCMu+QpYGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079348; c=relaxed/simple;
	bh=yerrk0rdVucOk+EbK40MqtQVv2YDm0HaAjFWfFyK+zM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bJ3q20jCPiNY/Svlgq0XEtRX+CPTZ1GDxd2BGdDR+K9bT9mEW/tAS6NErZwO4CVMF6lo2uqWqvm81mW0fIbXV8QdOf0ZYxifvchsifuecURyloIEcjZwZKq5QXaEOIkcL8kWMWsezDXPNMdae44MZFJkyChtQ2ms/D0YAhSdUuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=XO8Yqbl7; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714079343;
	bh=HQ9mB3jJnTd7oaYs4J8bO4Q3lVS9XIz5rOMtPQW1/vY=;
	h=Date:From:To:Cc:Subject:From;
	b=XO8Yqbl7a3MRXgF8A0uYLRp/RGrKxdy/aktwyFujFVgB1QkiyIk6ZDRKaba72QV3E
	 VSjYnPYYSYT2fm7rHCXM0XzxH9UzzHo9FtgIuIZQzrtn0orPEwByx4Uvtf/ueRtf+s
	 +oR8rFPGTgetl6J4Y/avDY/l/UWW19DAU/cbB/7JKiQ3BKk5gF/5d9OMZ1q/jtnFHI
	 K5ue4X6P1fnHxCEQ/V7+Dkpy5LsjRBIrkZtZ2emCHe23u+hijantsT3CjspH/RtDrx
	 UuLGcgCdl1lwdQ2PDnGEJlkj9m7ZXV5ogRQXPInmiOrFWN9plDXL0EnyLTIeqoYRmt
	 FLsmF1yC3YmCQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VQT4H1Jvwz4wny;
	Fri, 26 Apr 2024 07:09:02 +1000 (AEST)
Date: Fri, 26 Apr 2024 07:09:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
 <johan.hedberg@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the bluetooth tree
Message-ID: <20240426070902.0cfa1282@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xuqiCR+9hBizTPSexM=cJfu";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/xuqiCR+9hBizTPSexM=cJfu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  2d7a4bf4bae8 ("Bluetooth: qca: fix NULL-deref on non-serdev suspend")
  4405182b7a15 ("Bluetooth: hci_sync: Use advertised PHYs on hci_le_ext_cre=
ate_conn_sync")
  5a0265dc7990 ("Bluetooth: hci_sync: Using hci_cmd_sync_submit when removi=
ng Adv Monitor")
  5e7d1e242697 ("Bluetooth: qca: set power_ctrl_enabled on NULL returned by=
 gpiod_get_optional()")
  9c049d8a7595 ("Bluetooth: Fix type of len in {l2cap,sco}_sock_getsockopt_=
old()")
  a3aca621101b ("Bluetooth: MGMT: Fix failing to MGMT_OP_ADD_UUID/MGMT_OP_R=
EMOVE_UUID")
  aec46cd4ebff ("Bluetooth: qca: fix invalid device address check")
  d19d765596e7 ("Bluetooth: hci_event: Fix sending HCI_OP_READ_ENC_KEY_SIZE=
")
  df5efbdaa7d5 ("Bluetooth: btusb: mediatek: Fix double free of skb in core=
dump")
  e10bb8abb81e ("Bluetooth: qca: fix NULL-deref on non-serdev setup")
  e4e20e0a1700 ("Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0bda:=
0x4853")
  f33b1c9d33d9 ("Bluetooth: btusb: Fix triggering coredump implementation f=
or QCA")

--=20
Cheers,
Stephen Rothwell

--Sig_/xuqiCR+9hBizTPSexM=cJfu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYqxm4ACgkQAVBC80lX
0Gzy2QgApkpdfoVxTe+5lNjXPtlQ2Dpr+PvilgyHzg0cJoeWkubP2OSmadyTD7AR
70+NPIy/uQDPkYB0xpp1jGTessV++eiZd7+lNDzK+dQ4s1XQbkgm8zeBAcPn/rew
gBsAv26kr/VvH2bh6iQC5abjFkW/gdARtspwNYI8jOzh+zrZOiiowe8OsJ6NvrFg
w1q7TGtunMMGFIpJWIdOFREMn5RdgJUOexTNN4iyZ4FqVVP8uSkful3pLocvGWr5
/vdbrp+a2slxafulizTU7R/XHb5IR/+VYFh2gFoj+5LnEziq0ivAHxdNEnHfQPoY
GnomAD9oCTR88pdh101JHcTPclZ3Cw==
=1RjI
-----END PGP SIGNATURE-----

--Sig_/xuqiCR+9hBizTPSexM=cJfu--

