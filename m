Return-Path: <linux-kernel+bounces-139776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC778A0791
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0C771C22E54
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D065B13C818;
	Thu, 11 Apr 2024 05:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="VjKA0nbb"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3C71C0DE7;
	Thu, 11 Apr 2024 05:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712813016; cv=none; b=q0ACXox/y1nON6Eya8VPvUbI1Tl9pZbX7ru2JxgbHxg2ioTBn6ltqDa5TqbPm8NBGsw1i5txRqOVKh8r1jJgFVr8L27hXVC47czsocJX/0oLEYSyMtMzMMFoEeXYCimCJFf+dnXTshPgt2N4MkShYq8LhxhkzWILXRAo6CGPPyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712813016; c=relaxed/simple;
	bh=BD34DRVDurBNSDpa8BY8MmxMXHZQgIWn3eycloRg1tw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fczQ7+16xfL39mCaW27hzO3rK0xbgODsgsLRzEchEHC15BqOuC8s3DLZ6M7owMjrI9UtbwzmwtyhIuvZstsyIPZwUkNUiTVaZ8v9b+T72hl7PXDSNZmiAaCuuzaaMA2l8+VsXndET0mnY5y/dUDIEvJTa1w0lhc/IIJaB3PWb9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=VjKA0nbb; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 9DFFB603E6;
	Thu, 11 Apr 2024 05:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1712813013;
	bh=BD34DRVDurBNSDpa8BY8MmxMXHZQgIWn3eycloRg1tw=;
	h=From:To:Cc:Subject:Date:From;
	b=VjKA0nbbtzsGdehQ1GTWcwCgfR5OR2mc4AD+xgVe9yhtGsabg5qcVsSpmJOSqOwPC
	 fpiI9oKsu5LS/oPGitFd9xNfiYji+MOj0+Jg08lN0hkdqtrE1z2CUdR1jkjYonCudd
	 DbJF1Qil1kf3MqxFyrOBEcGQ0vAiXU4mfe57HknpCOugUL7nwQBFE+0DUUl084Ginf
	 hvnoncVuYO3Al/pZ8ex8aAZnVM/kwE0WLqIzLvldj4QB/O2DrfCNQ/yHPqs85hsW78
	 nbt0FaPWeHaQTKcYqKmXDG84iIbTvBsoEW5a4VejNpAFk6yd33UWbi/qzn4C3SmJAf
	 CBN+0o6rGcl7Q==
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: Dhruva Gole <d-gole@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [RFC PATCH 0/4] Provide interconnect resets for ti-sysc users
Date: Thu, 11 Apr 2024 08:22:53 +0300
Message-ID: <20240411052257.2113-1-tony@atomide.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Here are a few experimental WIP patches to make ti-sysc provide resets for
the devices connected to the interconnect. I've only tested this with
8250_omap.

I played with implementing all the resets automatically where available,
but we could of course map just the reset used via devicetree.

There are lots of resets, and not that many users. So likely using the
devicetree to map only the used resets makes most sense from memory
consumption point of view.

However, the reset control framework changes may be desired though.
For example, MFD child devices may not get the data via devicetree.

Note that for ti-sysc driver, this series depends on an earlier pending
clean-up series posted at [0].

Regards,

Tony

[0] https://lore.kernel.org/linux-omap/20240410064010.57142-1-tony@atomide.com/T/#md369ba556149a2662f2cd5413863d29f054b27b8

Tony Lindgren (4):
  reset: Fall back to lookup if no reset node is found
  reset: Allow removing a lookup
  bus: ti-sysc: Implement reset control framework for soft reset
  serial: 8250: omap: Use reset control for resets

 drivers/bus/ti-sysc.c               | 109 ++++++++++++++++++++++++++++
 drivers/reset/core.c                |  36 ++++++++-
 drivers/tty/serial/8250/8250_omap.c |  66 ++++++-----------
 include/linux/reset-controller.h    |   7 ++
 4 files changed, 174 insertions(+), 44 deletions(-)

-- 
2.44.0

