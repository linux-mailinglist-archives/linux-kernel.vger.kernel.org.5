Return-Path: <linux-kernel+bounces-109924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4208857D7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413181C21663
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B145812F;
	Thu, 21 Mar 2024 11:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UrV3KXCb"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAA857311;
	Thu, 21 Mar 2024 11:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711019576; cv=none; b=bjwt9goHlpGc95U+y+TMIDncvTQ2fcP8e0uH9yTPkEWSMV7WUnnMmjYaPrkxdS02cBQJLQqge5mbCN7vLPzjrOz25KZUoxxIS3zw7O+2obed+Bjg7CFKO6FEs/0y8cTuw24N0FlfFEE3c2WeaFCTD5nKOMBZdTESDcnbtacPMMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711019576; c=relaxed/simple;
	bh=Y1vEpjXP+hUSiO75YanMSSda5LJPJ5/Uc3Fh6hMJB3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lAKzFF8EdZlYtlGsv/9MQwBd/kIn05dbdPpZhNs8KcTIBGWcjSGLm7wf62fr1MFH3TA+KNjNsT4vme8qGcS5OAtvrhBtCcN6+evZPCTV8hVpOL/vkny4wTGKfHEjejnGROAvy9F5r/Dwr7fsXc1VjevofAwzgMRPHetWmUEECX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=UrV3KXCb; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.138])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 38DAA7E9;
	Thu, 21 Mar 2024 12:12:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711019545;
	bh=Y1vEpjXP+hUSiO75YanMSSda5LJPJ5/Uc3Fh6hMJB3o=;
	h=From:To:Cc:Subject:Date:From;
	b=UrV3KXCbceAkCKZa88ecK4iAyv7+O9XsMURdZ9UwMQtyXgLmKaGBzwTIUy+Bu3G8N
	 v/GOwNpCak/bMAwk6yr8YUea/ANzV7YDIXSnB3DjZThiu0YUH6RdAHr1iFpGiRcI8r
	 +EVXLV+Ak2lAmjKW7+olf1EHaBXsWtHf7Pb55Dyw=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	open list <linux-kernel@vger.kernel.org>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v3 0/6] media: imx335: 2/4 lane ops and improvements
Date: Thu, 21 Mar 2024 16:42:33 +0530
Message-ID: <20240321111239.808735-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(Re-sending as previous time, I forgot to CC linux-media@, no wonder
I didn't receive any feedback on this series).

Another batch of improvements of the imx335 driver.

Patch 1/6 adds support for 2 or 4 lane operation modes.

Patch 2/6 call the V4L2 fwnode device parser to handle controls that are
standardised by the framework.

Patch 3/6 introduces the use of CCI for registers access.

Patch 4/5 uses decimal values for sizes registers (instead of
hexadecimal). This improves overall readability

Patch 5/6 fixes the height value discrepency. Accessible height is 1944,
as per the data sheet in all-pixel scan mode.

Patch 6/6 fixes the max analogue gain value.

changes in v3:
- fix patch 2/6 where we need to free ctrl handler
  on error path.

changes in v2:
- New patch 4/6
- Drop calculating the pixel clock from link freq.
- CCI register address sort (incremental)
- Fix cci_write for REG_HOLD handling and add a comment.
- Remove  unused macros as part of 3/6

Kieran Bingham (2):
  media: imx335: Support 2 or 4 lane operation modes
  media: imx335: Parse fwnode properties

Umang Jain (4):
  media: imx335: Use V4L2 CCI for accessing sensor registers
  media: imx335: Use integer values for size registers
  media: imx335: Fix active area height discrepency
  media: imx335: Limit analogue gain value

 drivers/media/i2c/Kconfig  |   1 +
 drivers/media/i2c/imx335.c | 646 ++++++++++++++++++-------------------
 2 files changed, 310 insertions(+), 337 deletions(-)


base-commit: 54ee11761885407056f4ca60309739e2db6b02dc
-- 
2.43.0


