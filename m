Return-Path: <linux-kernel+bounces-93474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 449B287304D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5032B27A4A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9975D753;
	Wed,  6 Mar 2024 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="uv6E7dXY"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBA5D502;
	Wed,  6 Mar 2024 08:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709712655; cv=none; b=rGZ4D+EpAoA8ZovWR1IxmNyd4j6bWBqm4bDT1JN12e2kobredY9FQZhhbfDVga/UlKKQ27sf80sPUdCTuIsfwQlqydZtPkW9yLlhxdsJfTr5AOSZDheEa29THrsdOes/wyYIdCeDzKcOiD1HEFbQHt0JpLwe90okZPd1UuBhNIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709712655; c=relaxed/simple;
	bh=EwGnP4GfcTn4Eg7n3kdExZA8KqZQYmEVoIGGMnavcho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lCMnKlK7ZE/TVOqAwy192oypa6UqB9IF5/AWKn9IFpPIjMr41lgkjkq5+ZUgcyu5aXm83uiKlP3emnLv55wyIBSiQKgb8UA47RhdBvOpeCWe0c7ILb4yP9UphKoJYxij8ArujWiXj9LStV+KkoXe91hRD1EVZ4zUGimIgtz6lW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=uv6E7dXY; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.251.226.70])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0BAF2BD1;
	Wed,  6 Mar 2024 09:10:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709712633;
	bh=EwGnP4GfcTn4Eg7n3kdExZA8KqZQYmEVoIGGMnavcho=;
	h=From:To:Cc:Subject:Date:From;
	b=uv6E7dXYMrnYaIz4CJhkL4hb7aCxz7K6nV4eCT1/MBevsRFVJCPqY7oYYPHoqWdQP
	 hjYw929tq2LxaJmJVzl0IPCu7SFk+dwPscnmha0xH4yBpCOgcnxQc5lXtxa0uuUkQk
	 EBiC9B9TeWW6qlPWtpMz6SA1xSMiyNWHYmoOn8Wg=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 0/5] media: imx335: 2/4 lane ops and improvements
Date: Wed,  6 Mar 2024 13:40:33 +0530
Message-ID: <20240306081038.212412-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Another batch of improvements of the imx335 driver.

Patch 1/5 adds support for 2 or 4 lane operation modes.

Patch 2/5 call the V4L2 fwnode device parser to handle controls that are
standardised by the framework.

Patch 3/5 introduces the use of CCI for registers access.

Patch 4/4 fixes the height value discrepency. Accessible height is 1944,
as per the data sheet in all-pixel scan mode.

Patch 5/5 fixes the max analogue gain value.

Kieran Bingham (2):
  media: imx335: Support 2 or 4 lane operation modes
  media: imx335: Parse fwnode properties

Umang Jain (3):
  media: imx335: Use V4L2 CCI for accessing sensor registers
  media: imx335: Fix active area height discrepency
  media: imx335: Limit analogue gain value

 drivers/media/i2c/Kconfig  |   1 +
 drivers/media/i2c/imx335.c | 596 ++++++++++++++++++-------------------
 2 files changed, 287 insertions(+), 310 deletions(-)

-- 
2.43.0


