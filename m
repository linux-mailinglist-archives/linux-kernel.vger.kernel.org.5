Return-Path: <linux-kernel+bounces-41868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C04F83F900
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080D2281520
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FFA2EB1D;
	Sun, 28 Jan 2024 18:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="lxF8NAYQ"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8AA2E64F;
	Sun, 28 Jan 2024 18:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706465181; cv=none; b=JGgL4AFG3vk3n6Dt/Lg1RHfh2cS8AfAVWR08at/niDVADdsa3Bmt7qBjiu/sutzqeVwIWS0g5ud8UHl2A2HDfrOjUfOwA1U8eVlDJuUecOgUpKOSQeJ1QeN1Ljz2pKLFtPJbP3keVn9ag29GaYMv7d0TiWf7izJRdYKVV3MbWCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706465181; c=relaxed/simple;
	bh=FtmQA5VLzpRyOURP1pEGDKv6HjrVhjrwbslF9OnywoQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=JARZ/v1CyDIjJL2lwZkGXx7llbT2TORBe+5Kp2FRznjzYOAvE+lpYEXre6pRqTSoU55aveE7kTNP8+da7kOchkXiYydo9TKEZEzDBvv8xVnH9jeULNrfGq129kqdyts4pah1B7ZUZxoWCogprNu4lRmKpkh8HbCJV1F+YBnIwwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=lxF8NAYQ; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g3UtZfHsaHF+F1LjF+H3KyxBStiMSrgKhAoXtLNAUb4=; b=lxF8NAYQ2xiYnVxFLKwnoQRDuf
	C8fAJCv5AVyXSA9zghwGx3I4Tp5IgLhracq14tzduNyxiTOLqir9YGW216Ln/vi4sC772a/krMtsd
	+gUR9gnX7/y6X5XwHFfptoxWj9HUspD5K3dGPXsdNr7Ur9CLVtsnuP0FEEkZXe7UDYYqDWk2jr4LD
	C3m/cnVKfxaIdTBPiNL9vHSDPZyS80Rdev/dqDqxai9duy8fOw5jyp6jYd/6iZEQ3mrUTfJ/SvI3J
	Af0AAGh2rZUtlSph92QP2V/ddzHz56O9xQv7BwHpl8Yzw2aHJE5Va/MWY2yS93o/GkD0r0qcqpThf
	2e6yf8Pg==;
Received: from p200300c2070939001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:709:3900:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1rU92b-008qDZ-MH; Sun, 28 Jan 2024 18:33:57 +0100
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rU92a-00BO9d-29;
	Sun, 28 Jan 2024 18:33:56 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	johan@kernel.org,
	jirislaby@kernel.org,
	andreas@kemnade.info,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Adam Ford <aford173@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	tomi.valkeinen@ideasonboard.com,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@gmail.com>,
	robh@kernel.org,
	hns@goldelico.com
Subject: [RFC PATCH v2 0/3] bluetooth/gnss: GNSS support for TiWi chips
Date: Sun, 28 Jan 2024 18:33:49 +0100
Message-Id: <20240128173352.2714442-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of these chips have GNSS support. In some vendor kernels
a driver on top of misc/ti-st can be found providing a /dev/tigps
device which speaks the secretive Air Independent Interface (AI2) protocol.

To be more compatible with userspace send out NMEA by default but
allow a more raw mode by using a module parameter.

This was tested on the Epson Moverio BT-200.

Changes since V1:
- Set up things for NMEA output
- Powerup/down at open()/close()
- split out logic between drivers/bluetooth and drivers/gnss
- leave out drivers/misc/ti-st driver removal to avoid
  filling up mailboxes during the iterations, this series is
  still a proof that it is not needed, will take the brush after
  this series is accepted.

Andreas Kemnade (3):
  gnss: Add AI2 protocol used by some TI combo chips.
  bluetooth: ti-st: Add GNSS subdevice for TI Wilink chips
  gnss: Add driver for AI2 protocol

 drivers/bluetooth/hci_ll.c   |  81 ++++++
 drivers/gnss/Kconfig         |  13 +
 drivers/gnss/Makefile        |   3 +
 drivers/gnss/ai2.c           | 523 +++++++++++++++++++++++++++++++++++
 drivers/gnss/core.c          |   1 +
 include/linux/gnss.h         |   1 +
 include/linux/ti_wilink_st.h |   8 +
 7 files changed, 630 insertions(+)
 create mode 100644 drivers/gnss/ai2.c

-- 
2.39.2


