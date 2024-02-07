Return-Path: <linux-kernel+bounces-56210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02B084C763
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010F71C20619
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A5D224CA;
	Wed,  7 Feb 2024 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GnkNsfFm"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B580420DCC
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298359; cv=none; b=paLAGLqAE3SwAj5ioM3peJmBcjPrndc4yJDQW9NvAnRYljwKFpcTkHaJFP3mL6fZmUGUNw776O/inV4RNOEeYtFDZ52santO9e7emB4suj38E09QCKC33nSAilAtAJ7N1K86gUAXhM++/gUkVh+Ami1yTJas47mHpqygCzO7zbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298359; c=relaxed/simple;
	bh=gCB0UcHb6qylodQJW7kwMHN8wVeTKb1KA6xEZW4xp9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p1zW09I6YHLFmVGJCe1nyRwCdKlfS2n2U/dkNTaFVDuSwPVw+/DNM8WPdp/d6/xG53E7juX9vvCAw2pigNwFy6f62Cj+5Zl4PbLvm49b6x56ZOBHQqhyenZqt3SrrBLoteVCDe9YkSljpG68mLUkyMrhX4yi/RNB176iRhTvNCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GnkNsfFm; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55ee686b5d5so467036a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707298355; x=1707903155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6UcXcnxreNPZ0+lBZNHI7oVubogo1HeEr+FyK2euNzk=;
        b=GnkNsfFmBfrB6fKK0IgfwvRAMQtSU5ITeTOTYjH43Pg6LJ9/mYlDfm9nX8ujnlGX2v
         Jq3WR5gmcw+c6M2r57en44LFn14WRjT9dYHGsitY4yNr1Xf6gsBbuAJNQRz4MsCzq8lL
         895HJd7bmz/ZpmjoePDSUsn8X7TQeMeBzriamvxeRU7AiHvCJ+SAnHysHc6+tTt+3s7b
         fWv/LFO4ITXhuTaAIs7sA2iYF51QBbiaXk+zKFNWj+zIL9wn1muU8+z7ecl7bujMTDdz
         Vo5Xvgc0uyasxpDv0jTJV89tkmKrL2vljBlUivwqLZG0ZGN2BWZFTE/gCOpuz3XseleS
         motw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707298355; x=1707903155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6UcXcnxreNPZ0+lBZNHI7oVubogo1HeEr+FyK2euNzk=;
        b=HVtfWpbxHNs3FGgBdsXH1OoE4oDsq8JrAAqJCJ0KMRPKdw74EqxJtzE2LVWhxJ5sVG
         nhj/UMpd5/LZqGG0bxDRziKB11YNNCRBiwR3N9oILnh2d93GwrKfiLdniKipMikTAu4w
         QSvcCrt7JszV0Z+rbQx1bVORz4g2VuwI87UxEIJyFUqr9zv3hWzL3iV8Pl7h5n9YSr9T
         Q9QS213Sww1sM7fMByaJsW9+IN2j4alvT+ULog+NYDCy/v2vKqmRacIw6vLlfRBaXKPu
         rdOIkbYgByT5yEk2rLMegIfL8PzvpMHIvcBkgljL/UDtGCtRALA6LyvRaMCl0tVqs6il
         25CQ==
X-Gm-Message-State: AOJu0YzzMMVMAadjrGEjcZDwwDtLUucoV2FQ0aSs7bhal6J8L58Dyvbu
	c7Jq5ZqvR6a4Fcg0qgQHwjy9QlKGY/LMk58T8RhivpUyLwysJxj3RGDWVgJDGAo=
X-Google-Smtp-Source: AGHT+IGm4noXnf+W2a3cctx/ARsa6HZtNSbpbfpE5rhLWAtrga16pBWnrMX5TtjHV8LYxxcOQrhEVQ==
X-Received: by 2002:a17:906:4691:b0:a38:7541:36f6 with SMTP id a17-20020a170906469100b00a38754136f6mr810040ejr.21.1707298354981;
        Wed, 07 Feb 2024 01:32:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUixUh7Sy14PL292x1SBMSh/XJB29tAE5aoidPm3S/uZt32EwsI5F2apCjoCBnZeJpXSXowFvlkhpL/jEBOAsdmZuLORVwIRwHQ2Ii+Heu/qfreN0CeSIvI1Y/k313LpqedUDsXRuQNFTX8o4zI6xeH1dQAmbxKVW/QHr3oZqcMF3MVbccQdtN0ty1l41XkPNrt78wBBhX48q5n8wbqE1Npj+ofMqbgynMrJylSFvBZaUy88KUQ7skZDpzaYX57A4thYn/bIWDZc5VLERIqDAwkB51ZccUrn7QZbtFo1yyYqLvp0EMplItjo3Pp4R1za6g1yEwm7+kPumM3/UpB3RSipI/Ma0L/3UlOmS6MbgviH4YUJudyRJE35ZaKUgrLxcWdDxWEkukKy8dIBfKjZyQrdNVc1EZHR/7Xa/GQMRC6JXZDr+5N0QVVL/XU
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id qo9-20020a170907874900b00a388e24f533sm122336ejc.148.2024.02.07.01.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:32:34 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tony Lindgren <tony@atomide.com>,
	Judith Mendez <jm@ti.com>
Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julien Panis <jpanis@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 00/14] can: m_can: Optimizations for m_can/tcan part 2
Date: Wed,  7 Feb 2024 10:32:06 +0100
Message-ID: <20240207093220.2681425-1-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Marc, Simon, Martin and everyone,

v7 is a rebase on v6.8. During my am62 tests I discovered some problems
which are fixed with this update.

@Simon: I had to remove most of your reviews again, due to a few
fixes I made.

The series implements many small and bigger throughput improvements and
adds rx/tx coalescing at the end.

Based on v6.8-rc1. Also available at
https://gitlab.baylibre.com/msp8/linux/-/tree/topic/mcan-optimization/v6.8?ref_type=heads

Best,
Markus

Changes in v7:
- Rebased to v6.8-rc1
- Fixed NULL pointer dereference in m_can_clean() on am62 that happened
  when doing ip link up, ip link down, ip link up
- Fixed a racecondition on am62 observed with high throughput tests.
  netdev_completed_queue() was called before netdev_sent_queue() as the
  interrupt was processed so fast. netdev_sent_queue() is now reported
  before the actual sent is done.
- Fixed an initializing issue on am62 where active interrupts are
  getting lost between runs. Fixed by resetting cdev->active_interrupts
  in m_can_disable_all_interrupts()
- Removed m_can_start_fast_xmit() because of a reordering of operations
  due to above mentioned racecondition

Changes in v6:
- Rebased to v6.6-rc2
- Added two small changes for the newly integrated polling feature
- Reuse the polling hrtimer for coalescing as the timer used for
  coalescing has a similar purpose as the one for polling. Also polling
  and coalescing will never be active at the same time.

Changes in v5:
- Add back parenthesis in m_can_set_coalesce(). This will make
  checkpatch unhappy but gcc happy.
- Remove unused fifo_header variable in m_can_tx_handler().
- Rebased to v6.5-rc1

Changes in v4:
- Create and use struct m_can_fifo_element in m_can_tx_handler
- Fix memcpy_and_pad to copy the full buffer
- Fixed a few checkpatch warnings
- Change putidx to be unsigned
- Print hard_xmit error only once when TX FIFO is full

Changes in v3:
- Remove parenthesis in error messages
- Use memcpy_and_pad for buffer copy in 'can: m_can: Write transmit
  header and data in one transaction'.
- Replace spin_lock with spin_lock_irqsave. I got a report of a
  interrupt that was calling start_xmit just after the netqueue was
  woken up before the locked region was exited. spin_lock_irqsave should
  fix this. I attached the full stack at the end of the mail if someone
  wants to know.
- Rebased to v6.3-rc1.
- Removed tcan4x5x patches from this series.

Changes in v2:
- Rebased on v6.2-rc5
- Fixed missing/broken accounting for non peripheral m_can devices.

previous versions:
v1 - https://lore.kernel.org/lkml/20221221152537.751564-1-msp@baylibre.com
v2 - https://lore.kernel.org/lkml/20230125195059.630377-1-msp@baylibre.com
v3 - https://lore.kernel.org/lkml/20230315110546.2518305-1-msp@baylibre.com/
v4 - https://lore.kernel.org/lkml/20230621092350.3130866-1-msp@baylibre.com/
v5 - https://lore.kernel.org/lkml/20230718075708.958094-1-msp@baylibre.com
v6 - https://lore.kernel.org/lkml/20230929141304.3934380-1-msp@baylibre.com

Markus Schneider-Pargmann (14):
  can: m_can: Start/Cancel polling timer together with interrupts
  can: m_can: Move hrtimer init to m_can_class_register
  can: m_can: Write transmit header and data in one transaction
  can: m_can: Implement receive coalescing
  can: m_can: Implement transmit coalescing
  can: m_can: Add rx coalescing ethtool support
  can: m_can: Add tx coalescing ethtool support
  can: m_can: Use u32 for putidx
  can: m_can: Cache tx putidx
  can: m_can: Use the workqueue as queue
  can: m_can: Introduce a tx_fifo_in_flight counter
  can: m_can: Use tx_fifo_in_flight for netif_queue control
  can: m_can: Implement BQL
  can: m_can: Implement transmit submission coalescing

 drivers/net/can/m_can/m_can.c          | 551 ++++++++++++++++++-------
 drivers/net/can/m_can/m_can.h          |  34 +-
 drivers/net/can/m_can/m_can_platform.c |   4 -
 3 files changed, 439 insertions(+), 150 deletions(-)

-- 
2.43.0


