Return-Path: <linux-kernel+bounces-72693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA0385B771
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848802833A7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14D260DF0;
	Tue, 20 Feb 2024 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="doKNTYM1"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD54C6025F;
	Tue, 20 Feb 2024 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421313; cv=none; b=XU4/BASfqeyxbM0nQ15ZD5XTvTuLju2QbUIhQHDZQRxzMK9FYJTkloZPyNd7sCZdhH9EDtbjME8B+gVqqqRWYEzpC80+3j3Y3V/SdslGgGkMGbvk1SO8r8bZCOCHGqKZl9yxz/gDP66tjD0rf0D595ODCdPpxaFNQOEro96GIVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421313; c=relaxed/simple;
	bh=K/AN/YaK9IVBdY77EnacWtZKhgY2CAqnGWG4BCo+u2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nhu+aMulpuUVL3IIU9lh7HzJyIc5kuVhmaklqVk+qfxyQyUS14/uvEm2shPkQclEe+rqMUNb9pFPgJJUxkOx+J9+WPIDu34xiAOlPTNmuIjJigjotcBue5xZTx0j4C+ISueyxyeZ/42mtBLRMg45B0dVRdm0Z+24L6+z3SHUHuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=doKNTYM1; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.159])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 10E3113AC;
	Tue, 20 Feb 2024 10:28:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708421301;
	bh=K/AN/YaK9IVBdY77EnacWtZKhgY2CAqnGWG4BCo+u2o=;
	h=From:To:Cc:Subject:Date:From;
	b=doKNTYM181xnhCsMJdbDYkGANkM6CjeQ8dF6gwQiJLA2G3ggXZeqbJa0thv6OulH/
	 kXoLzezBBGPO3ogQYZmAvs+QAaK1B68fgqFdyIVw/+JllTs0JviYlqgRe0OeIwBRYI
	 Pc/XMF3T7s6ggMyeE9OhJE0QrchihmYWrZkxuKr8=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v3 0/5] media: imx335: Support additional link-freq and TPG
Date: Tue, 20 Feb 2024 14:58:16 +0530
Message-ID: <20240220092821.1993-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for additional link frequency and
test pattern generator on IMX335.

Patch 1/5 is a drive-by patch which sets default value to one
of the reserved register. The non-default value of 0x01 has been
found responsible to break CSI-2 configuration on one of the i.MX8MP
based platform. Setting to default value seem to fix it and has been
tested on RPi5 (downstream BSP) in additional to i.MX8MP platform
running mainline.

Patch 2/5 adds usage of v4l2_link_freq_to_bitmap V4L2 helper.

Patch 3/5 supports for additional link-frequency supported by IMX335

Patch 4/5 is also a prep-up patch for TPG introduction(in 5/5), as the test
pattern needs sensor to be powered up to apply the test pattern.

Patch 5/5 adds the TPG.

changes in v3:
- Update the patch 1/5 to set the reserved register value
  to it's default value (instead of dropping it).
- Drop "i2c: " from commit message in 3/5

Changes in v2:
- add new patch 2/5 to use v4l2_link_freq_to_bitmap
- fixup a return; in 4/5

Matthias Fend (1):
  media: imx335: Add support for test pattern generator

Umang Jain (4):
  media: imx335: Set reserved register to default value
  media: imx335: Use v4l2_link_freq_to_bitmap helper
  media: imx335: Support multiple link frequency
  media: imx335: Refactor power sequence to set controls

 drivers/media/i2c/imx335.c | 251 ++++++++++++++++++++++++++++++-------
 1 file changed, 206 insertions(+), 45 deletions(-)

-- 
2.43.0


