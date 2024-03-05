Return-Path: <linux-kernel+bounces-92405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FC0871FC5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4121C204F9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AE485954;
	Tue,  5 Mar 2024 13:05:00 +0000 (UTC)
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAED85920;
	Tue,  5 Mar 2024 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.14.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709643899; cv=none; b=dMxwc7XYeX2/KTaj2f3uf/48rwrMYvdiqagrUIK0hZ5eTr+WC921C4gmNSteryq1Sak0efTNG59zWMEDhMnitmh4on4h4paA8TO3CqtI+aT1Wu/t+twTKj5U7bW9A4XwBM6ln4KPLx7zfdYF2vazeMkea3xxEJjPSa+nu1CUeps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709643899; c=relaxed/simple;
	bh=+f5WPj+Hs8JDeSBI7bZCvVcopKa+wIJUqwzofqncSOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jt7Y2ZZJtLRrB9cadvu1vsPeVXCpoAPKiFJTub/AQLW11W696vgTLg+1ApaucO5W5Vyv9yGpRFzGhYBeKxZ/xTzhM0EYc7fcdM7LkyTJtJaYdToJvrB2P4X92/BqHr3TKwX6I0zPejffHuwVNtpOW+VKy9vQuWVwk+OtZwJ5USM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org; spf=pass smtp.mailfrom=gpxsee.org; arc=none smtp.client-ip=37.205.14.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpxsee.org
Received: from mgb4.digiteq.red (unknown [62.77.71.229])
	by mx.gpxsee.org (Postfix) with ESMTPSA id E43F045DF1;
	Tue,  5 Mar 2024 13:55:19 +0100 (CET)
From: tumic@gpxsee.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Martin=20T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
Subject: [PATCH 0/2] media: mgb4: YUV and variable framerate support
Date: Tue,  5 Mar 2024 14:54:08 +0100
Message-ID: <20240305135410.54694-1-tumic@gpxsee.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Martin Tůma <martin.tuma@digiteqautomotive.com>

Recent mgb4 FW update added support for the YUV image format and variable
framerates independent of the signal framerate. The following patches extend
the mgb4 driver with support for both features.

Martin Tůma (2):
  media: mgb4: Add support for YUV image formats
  media: mgb4: Add support for V4L2_CAP_TIMEPERFRAME

 Documentation/admin-guide/media/mgb4.rst |   8 +-
 drivers/media/pci/mgb4/mgb4_core.c       |   2 +-
 drivers/media/pci/mgb4/mgb4_core.h       |   2 +
 drivers/media/pci/mgb4/mgb4_io.h         |  28 +-
 drivers/media/pci/mgb4/mgb4_sysfs_out.c  |   9 +-
 drivers/media/pci/mgb4/mgb4_vin.c        | 198 +++++++++++---
 drivers/media/pci/mgb4/mgb4_vin.h        |   3 +-
 drivers/media/pci/mgb4/mgb4_vout.c       | 316 ++++++++++++++++++++---
 drivers/media/pci/mgb4/mgb4_vout.h       |   5 +-
 9 files changed, 491 insertions(+), 80 deletions(-)


base-commit: 65e6a2773d655172143cc0b927cdc89549842895
-- 
2.44.0


