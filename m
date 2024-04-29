Return-Path: <linux-kernel+bounces-162140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C3E8B5693
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C261B1F236A5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA5546452;
	Mon, 29 Apr 2024 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="mFsf7TdV"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD84C40BFE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390134; cv=none; b=hUNSGvPEae7NZLKe6MDiw3MIixEIJAFIS/UVuG8psbGVPqJhs4b4Ph5mfB8nfHaSdCtmERoOk882+FrBRoPDwXyC/HkiA3/sdHh8fWGqI25/VaAsq/fDoOQU7YrkNwuOTylEFbEQpFdto1HFKW7zSFX7dZ9PvSZY601FuDDUlk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390134; c=relaxed/simple;
	bh=60QpStQOhAZIW9mb3S0HOBlCt88AByrWdkN0ZXP5wz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d1NfQE9BA1IEE/Ys12KT01VDlrqbJBIOrE4hUkg+yEqUlZnLR90F+yOw5xSNGO0nKWGS5XCj5z3OveomXxnMiv729Olw4KsLjwN2kTrw5VpmYPuAR5gs510YPLR1JprWSgHpgcSP4RiyA7rud6gwZNJX3wXsg+C51Fq7TaLjUik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=mFsf7TdV; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=fAVKMqRoK3GEyb
	zsjMIQAuD5pNP2sMiRqK4blj9QPNs=; b=mFsf7TdVwL/397rbVrkXr2nBV8tMCW
	XHy9YScgS2ZQnBjtt3TOVqzHClpOGhxN7qMbIZThDZKEib3yuxqbiXJQ/RVQOXhi
	XVq61D9hQBt9dSB8QxIxvI9PENpSZqPTazwt6LYp2ADbtXc5hvCP0CnmexUQ8Aw5
	yB5auSBygdg8jQfpPFdkzf3QvCFon727ZkRfED6dggWW0NiKQquqVJXObAfixcxg
	gz3L0ZILg/RiGoDHPTO71G7W1Tc8BXMAhs+XBl/Y4VQ9Pr/IBC9bvop6Zw4zn5Ia
	9wKlUKh+HFHuI1/d6IqP6AGauU2movDEBKcWjjXKkFi8KuD3M+ORlGyg==
Received: (qmail 2279485 invoked from network); 29 Apr 2024 13:28:43 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Apr 2024 13:28:43 +0200
X-UD-Smtp-Session: l3s3148p1@KkJPjjoXgAptKPB4
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-spi@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 0/8] spi: use 'time_left' instead of 'timeout' with wait_for_*() functions
Date: Mon, 29 Apr 2024 13:28:33 +0200
Message-ID: <20240429112843.67628-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_for_*() functions causing patterns like:

        timeout = wait_for_completion_timeout(...)
        if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
obvious and self explaining.

This is part of a tree-wide series. The rest of the patches can be found here
(some parts may still be WIP):

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/time_left

Because these patches are generated, I audit them before sending. This is why I
will send series step by step. Build bot is happy with these patches, though.
No functional changes intended.

Wolfram Sang (8):
  spi: armada-3700: use 'time_left' variable with
    wait_for_completion_timeout()
  spi: fsl-lpspi: use 'time_left' variable with
    wait_for_completion_timeout()
  spi: imx: use 'time_left' variable with wait_for_completion_timeout()
  spi: pic32-sqi: use 'time_left' variable with
    wait_for_completion_timeout()
  spi: pic32: use 'time_left' variable with
    wait_for_completion_timeout()
  spi: sun4i: use 'time_left' variable with
    wait_for_completion_timeout()
  spi: sun6i: use 'time_left' variable with
    wait_for_completion_timeout()
  spi: xlp: use 'time_left' variable with wait_for_completion_timeout()

 drivers/spi/spi-armada-3700.c |  8 ++++----
 drivers/spi/spi-fsl-lpspi.c   | 14 +++++++-------
 drivers/spi/spi-imx.c         | 20 ++++++++++----------
 drivers/spi/spi-pic32-sqi.c   |  6 +++---
 drivers/spi/spi-pic32.c       |  6 +++---
 drivers/spi/spi-sun4i.c       |  9 +++++----
 drivers/spi/spi-sun6i.c       | 17 +++++++++--------
 drivers/spi/spi-xlp.c         |  8 ++++----
 8 files changed, 45 insertions(+), 43 deletions(-)

-- 
2.43.0


