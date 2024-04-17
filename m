Return-Path: <linux-kernel+bounces-149187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0830F8A8CF8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71882888C7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A143FBB3;
	Wed, 17 Apr 2024 20:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="sLatIE9L"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60AE60262;
	Wed, 17 Apr 2024 20:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713385928; cv=none; b=mZLXggDQRsI+bKRA/HFvBBCkLarGgpcyUwponLEbLYMdjMhgbDbudsjqL0SILFiPF2Kk63pnu7kFpnjaC/1wais4cU2uCmliRz/AfB68xLr06arl9FTBv24Ah0gD4Nc+bmlJ9sfD1KFe7TlEq3p+BSURlv7riM16Pru0hY6Wemo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713385928; c=relaxed/simple;
	bh=snUlQ8CUBvwt6t0rQcr2fBcuXmMSzuXKMUaznWhkeSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F2LqG7UG75VP7W7tO2GDhx6Mmgiw4w1x6GqOFtdTL+LgdyjvAKbfPXbQ0lz+PJt4y081BGBAdAX8zupXC92taOJ0sp4FPykLuNlyJ+DPJhIwnWFjLbFjoEGlQl3JZioTf9asBPCJCdwjkbQhDDMZsSNwwx6aM7VpoRy3CK7QK/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=sLatIE9L; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713385914; x=1713990714; i=parker@finest.io;
	bh=zvVys0faffVpris9ppwK6fTUXrOggQ+stC07pDGKPks=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sLatIE9LDzt0WajpvGCr4uskAHe/yyqH7XaRP37DRUobo+hvSNb6CQO7y5FIq76y
	 ovjTtYK+Q6wKcD6yuTvhy/nLvpysCsmjwDwWpSb1tCbuGYvnguxdgRJB2ipBY99lC
	 MR6j4wCNLgAzxhYj4w8Afx1Ov52+5+VskoNOrOAMKOuUPfsRXiRZkQys4lqEXo8LX
	 xAqM0nugCcJHS6wRf5zNHA+AixlwwAaugGXJQ6J6pHX8R7ImExDfIRu2HxbNHord7
	 nswKP1iRNUjEGBXqurPasK3uQzIA2CQVYlHU+igbsXnSdkS79T3jolAFIcd8UV40c
	 dBf871M7BxpRP5MnWA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MbS8j-1sZ0bI3p7Z-00brjB; Wed, 17 Apr
 2024 22:31:54 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v4 0/7] serial: exar: add Connect Tech serial cards to Exar driver
Date: Wed, 17 Apr 2024 16:31:22 -0400
Message-ID: <cover.1713382717.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pxhcMpEC6sD5WyFezOqtCU6EWMiMS1pMpoe2ZSE50fqA/DSe0UI
 Shv36TiDEyzj94uGFXp3V0hgfQcbZ+rwgcatCxQhNqL/6l1r1IfxZdkho3BJUFIFpz75zd2
 xHfW96in4DiY/0uJb/l6klgwdEYroQZ8rU9cJO1IerAEM+BnwDK+ZErHjPpZ/qUXztYuJj+
 YFbax3Q9XmqiQMj8uEaMw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bayDW9b21A8=;KlaPduv0NnbVVEkA3q2/aYIF2hD
 BMy+RMfabRkxmR32Agv4r7Zl/XmcI7NwlhPg3Gs+njDfVsmRd89m8xP1WgNihHc6xINq+kn0Q
 WED5pjvaOpUaBK7TizoFbRCw/UOQsKcCDkpl5iYjdkHirODtktMB+jIVSOZPfnqGsouQpgn4+
 REezCQS6d2n7WwH4tEKgNOK4hEEwPAAxgP1iMuc6TkaKIEo8cdvw9wCpeNjEiC8voILAXRxXN
 /b1mYdK4dfV8hG8HRoSSA1+ydbAEboakoJyjuSwObTFstqBRwlWfUzWM9KJOqqUbNOtImmwJ1
 w1daMUTIYHWNhtQDbW3TcITw6FnEM1G4WCzWEzHZBxQ+hdlK3oxr0dBsI4qdCtrARUD3X8nV9
 YeuhNFAwDSsnqoGr2/3Vd2cYikxFyGwk76EEEC1TDm5/lIDLHVipHTQ34WI2H+d/ySY8jqGN+
 9wUOOv0zdJDU5G4LZ7jYVw0dowCNaYu0RuOJKylbaGs5qU94sgk6UE0A7R0OnY4SNqbPotqsO
 jKApFAQWFRHVYajJyjI0NmMN7q2WpAfas1F7fkZ4M9pqwtJO4ibMjdpVdz1q8tH6DO5D5t10Y
 uCgahT/KNZFnFzG9hEXxDgaVdK/SeupV5jD7ezdwS+4BLVhlm77Il91s4WDdok6pJW34eqfqB
 ossMACyyESD3wVWCKwNntYJgHbFPOsQV5yNlvXAUC1Pa9UQkwxR8q02z6kAuAog+fSbnM3afs
 ubSYOrJPMSxlKt2PeyrUPlJtUNjHZnAsONNoiMX4QfiwiZNRIiLPd0=

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

Changes in v4:
- Rebased to tty-testing branch
- Removed v3 patch 8/8, "bug" didn't happen in current driver
- Patch specific changes listed in corresponding patch

Thank you,

Parker Newman (7):
  serial: exar: remove old Connect Tech setup
  serial: exar: added a exar_get_nr_ports function
  serial: exar: add optional board_init function
  serial: exar: moved generic_rs485 further up in 8250_exar.c
  serial: exar: add CTI cards to exar_get_nr_ports
  serial: exar: add CTI specific setup code
  serial: exar: fix checkpach warnings

 drivers/tty/serial/8250/8250_exar.c | 981 ++++++++++++++++++++++++++--
 1 file changed, 916 insertions(+), 65 deletions(-)


base-commit: b86ae40ffcf5a16b9569b1016da4a08c4f352ca2
=2D-
2.43.2


