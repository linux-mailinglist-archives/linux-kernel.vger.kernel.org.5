Return-Path: <linux-kernel+bounces-125439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9E68925EF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323912849F6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BE013B59A;
	Fri, 29 Mar 2024 21:12:08 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CA713BC09
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 21:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711746727; cv=none; b=J6lwaylQ3XXmIHHm0C55iuYbdthX3z6QVFHuqRjSJ5zJ9tikQw+2iebyCIy2negcEOa4eBnmkYKgTxRP2YLkT0ZWr0FQKy9rkztQq8mxRbLsFHgX47rpTqmYXYfVefcxs8jm9k9uizu8yRRKZBivQzptEUcIWiNGOf6oLN7T40s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711746727; c=relaxed/simple;
	bh=JtTL+c2bS9aqbGNEYLyo6HGZV7l/VlUDv6dCdKlmUBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fXwRfspPfQobshX9MIR6BN/vfvM1T+5iJ0E/ORM94FwbmGtpCt4mPTntQKpIiYuYOPIzkYBtvl5lHD6niVlb+UHvNtNiv1wT5MSEEpR0frx1xbUUHzr8VCFfKDRGLjCLoGdAKOMDGa9+f/TvCs83wG7BPtoEaXXjmxHb7LDiLv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rqJVy-0001yF-D5; Fri, 29 Mar 2024 22:11:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rqJVx-009GFO-64; Fri, 29 Mar 2024 22:11:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rqJVx-00DTbq-0K;
	Fri, 29 Mar 2024 22:11:53 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Finn Thain <fthain@linux-m68k.org>,
	Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH 0/4] scsi: Prevent several section mismatch warnings
Date: Fri, 29 Mar 2024 22:11:40 +0100
Message-ID: <cover.1711746359.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=880; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=JtTL+c2bS9aqbGNEYLyo6HGZV7l/VlUDv6dCdKlmUBM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmBy6NXVfMslrPLjkOkeq7mIZbqPjp3E8rCJiB+ OHgjgP80fyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZgcujQAKCRCPgPtYfRL+ Tp30B/485swCHclkSUfxdbzl6LRqoMGm/3w3ra76KMgu7JCNI31x31py2PnVssaLu2xa4MetMuR 1LILiSkP/Sqbnghqi1Ke/Uez1WRb3Wheiq+Ohik2C9r2kYLArykfj/RQdCgBdKzZbP03GMelwX6 LdO+NLL3qlJKs1yOijXe5CJIQWpU/0gav18m7j+k2AARJZB9+nHyQ8h3rHHpQC+MqQ7fSwiQs71 KRsoP5nXxc4pJFK5KlAk+8UBJe63ZQufpCLXornZ9M1GHOZ49ax4DkLVqdKXewEZi8GGS/0Gxd2 jPxIDt0c2G+kvhmObS3Ux97sacdQv8RWV2uyGB9tFYZoILTa
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello,

this series fixes the same issue in four drivers. The warning is a false
positive and to suppress it the driver structs are marked with
__refdata and a comment is added to describe the (non-trivial)
situation.

Best regards
Uwe

Uwe Kleine-König (4):
  scsi: a3000: Mark driver struct with __refdata to prevent section mismatch
  scsi: a4000t: Mark driver struct with __refdata to prevent section mismatch
  scsi: atari_scsi: Mark driver struct with __refdata to prevent section mismatch
  scsi: mac_scsi: Mark driver struct with __refdata to prevent section mismatch

 drivers/scsi/a3000.c      | 8 +++++++-
 drivers/scsi/a4000t.c     | 8 +++++++-
 drivers/scsi/atari_scsi.c | 8 +++++++-
 drivers/scsi/mac_scsi.c   | 8 +++++++-
 4 files changed, 28 insertions(+), 4 deletions(-)

base-commit: a6bd6c9333397f5a0e2667d4d82fef8c970108f2
-- 
2.43.0


