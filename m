Return-Path: <linux-kernel+bounces-146833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FE18A6B92
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9784F1F22792
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDD412BF3A;
	Tue, 16 Apr 2024 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="qzyu3HDw"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B613512BF17;
	Tue, 16 Apr 2024 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272216; cv=none; b=WbAz8wMOjASHFIRjWR+5aYKstCRre24B5EfrhbNmHMFJD3/PjTdBAeNbBu6/xHfqn8CCvXWBa9aAmRJJdynJZnhaOveu0bh8EW+bQ5gvghj+hBPOt1cjRaweNDV8Yf3FmJhSQ+Jx739HtQBG3XYiI2hIM2/010y5li0l3IJr/2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272216; c=relaxed/simple;
	bh=MMQ3grICziFyYiJYeHdgPY+a770lc7HcR4L+n90Xu8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l9fRKSViV2O19EK+eHxSQfSeF/I4VzFvP/YJfqzJha0w1OiJSuQNGmpT8FvBsnR1xNH4HevPYIM0n2OcU6hCq2iw/lQ8AFVsIcf1Oh+RtxVkx4g67hhp9ifCziqqNUrSWnqvFJW2OTXkjpElvA/M5Ri8TyWPUGAHz0WAEVNNiNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=qzyu3HDw; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713272196; x=1713876996; i=parker@finest.io;
	bh=wL/KAbcH2tXEiPNBgmqFulNL95RAhinmWk+wtvoRBYc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qzyu3HDwk11sejv9EGlNAhtNrYsCXI0YD+LGDjygQGXJd9I3a792NvuTfWgqTaPS
	 FvrOK/jFufSR2pF0CgEx+fuZV+zMnmts0cQ2c4R1XDtcHCjgLVQf3LcTg/n/NCv26
	 svSH//IdMVMZVHRx1I0qXRkyq9SDGDTMbWpbK10s/f9s8cx65q8XpJFop5JrC5E0f
	 XVL0vYK2b4psEH0nwoMZszzLlbt0PPDCMiR+AostreDLJQEPkpxIanXQCIZ7HaTF4
	 hdvIPOaFiwKa5FtZTO1EudSfu5WbnxECLNjl+Ea4Ksjhc6Y2G1AwIWW87HcRW4yYa
	 k36hjt/Ed71axIKckw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LsSYo-1su9aF3AFs-00udVd; Tue, 16 Apr
 2024 14:56:35 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v3 0/8] serial: exar: add Connect Tech serial cards to Exar driver
Date: Tue, 16 Apr 2024 08:55:27 -0400
Message-ID: <cover.1713270624.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:10U5Sb675CI7WDlz1l0p6GFG/u98AGH61P8kQoCcaEFMUXDTwdw
 /JNxfxDNGYjim5/F8Cz6yzstmR0rlIdO5JHBNVNn4cGg59oa3psi2lQXw7qgu2jfPeLNAV2
 08J5IWGdg0ybsotCfYORDiXJPbtgP8rmP1NsRqjjzA6XlHKQoJ4HkpIs5pGsz/h/HfjAPzM
 Or78+RwwQWzXJZ7uWCdEA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZVF0042suao=;qazLWPJ4GIcXFx+vT2hDiqx9AP/
 PBtGww9i0xm0z3/KxVBz7SrlCkCWwXU+hAnI1iUUIf9O4V6YbBekMk6LWAUlvMNVMLoaxigvp
 sn/hiP26FwRGCjBKJhQKbARzINBaIo1X6vCSbUjQ/AaO0XF1mhFTVVqg1hX7cgvEt0k6XNOUb
 TfMN3V7QviOp2Ci9AxUkW/uxBWgbAl/koKWvt+uyvlkJAevBFlIjyld4eN5pGJuLmHmMpz9Co
 /Go8HxrKylqIvnTHPNQ6gCWBBOzDXjDxhfctxFZpuhQRcztPOG0WpcpsF9VMkEicYp1YqYE+i
 kZevMwtUqtU7b3qXoH2xbBkZL6jNJJYOrl6eYgH1zFGVL9V/rR1VlNPhAx8yzqLqIkEkcma7y
 Cq1nE0iEWnG0x31LhsLWV4ihgjP71BMU5ZxPPIz/E0MJEUCKv3USbPjU7kx/3nBo7YAUzwBl6
 MfT8ktk/dfJ5uqAUSGH9JgzpTnTbzWQf/Xx5vfsJEaKm7H/+/Eb9kF9Imu35GStWNirn6aIEo
 BmBn8VWNjnBVaDkrcKfk/H7nc9r5v6i2eytrDxZHs80B7dw8PPLhmw17iKjZEr+FhQI6wmKrh
 TaZQLtpvhvQ5TKUM8UuVLTsnKltwgVIuZRTffU7DVTGXxPP/booS6sXdeBm2GCufcXg0fitUn
 LTvbqoBjNFpsKJ5mneaoIZEK+Dgk3LGWwdYpzXesgieO2CXo4rUP1+1q7ClOfx3lBE8YIxqAk
 30vdRHCCoCdVIBTU1iV36EpTXs6R/rFVjQGUwOIlVviqIe/YSTie2g=

From: Parker Newman <pnewman@connecttech.com>

Hello,
These patches add proper support for most of Connect Tech's (CTI) Exar
based serial cards. Previously, only a subset of CTI's cards would work
with the Exar driver while the rest required the CTI out-of-tree driver.
These patches are intended to phase out the out-of-tree driver.

I am new to the mailing lists and contributing to the kernel so please
let me know if I have made any mistakes or if you have any feedback.

Changes in v2:
- Put missing PCI IDs in 8250_exar.c instead of pci_ids.h
- Split large patch into smaller ones

Changes in v3:
- Refactored patches to be easier to follow (based on feedback of v2)
- Patch specific changes listed in corresponding patch

Thank you,

Parker Newman (8):
  serial: exar: adding missing CTI and Exar PCI ids
  serial: exar: remove old Connect Tech setup
  serial: exar: added a exar_get_nr_ports function
  serial: exar: add optional board_init function
  serial: exar: moved generic_rs485 further up in 8250_exar.c
  serial: exar: add CTI cards to exar_get_nr_ports
  serial: exar: add CTI specific setup code
  serial: exar: fix: fix crash during shutdown if setup fails

 drivers/tty/serial/8250/8250_exar.c | 1079 +++++++++++++++++++++++++--
 1 file changed, 1013 insertions(+), 66 deletions(-)


base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
=2D-
2.43.2


