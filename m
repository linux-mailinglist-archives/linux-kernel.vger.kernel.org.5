Return-Path: <linux-kernel+bounces-163870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B2F8B74F4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EDE6284E11
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5176B13CFA0;
	Tue, 30 Apr 2024 11:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Ehtc5jzT"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D1813C9C3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478082; cv=none; b=X8NIXWcbuW118QxvYpCo3mci5Cd9xTy1t43KWvnVG9dbz6lj7Wsf7Sdv8SVhoh723DJjXGZvpOgDtDZUl0VvC+AE2sIeOzwAZqlnAoo5QzZ6zimHbseZ4+yweeJXuhI6GUmyteInKg2tTND14PGgOFL9rx6NFnVJoKlBShbKVbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478082; c=relaxed/simple;
	bh=uLSlj939XV8NBcLkdHeM4WkD/CoBnFZy5OTyuh04CxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pO+kXs9aBG+O2C6E8hG0pkWeAfi8ugeISAm970UN5wpAMbqQthQxwPapj7ymTDfaEgvOKWJ8QtZegEjcYRzopl9PsDvb7k8zoj/ZioS/4MQoPDYqZRWJZqpaqQ7op3gz4hm79nGik84DWO9iNnoYNPpSmOzR4qp/e5DIXWoqCqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Ehtc5jzT; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=wu/qhcWtV7OY0J
	N4E7D/iNzNkQ/EkgfsbfNGnSZA7Go=; b=Ehtc5jzTSgAhzTN+5VDaHzhJ3CIZkf
	yjvF+nachfocPY+LnBFurXN11ZR28tr1kUdMMiuQp96tvCdxCiyr6SQRNKVIdTfa
	+rG0KknZdCgD0cVxwGgBRktJehHz1JnyFzRegOO0YMb+JF4cRRzKGdkaRFXZdti0
	HG+BF1Lzt/+PLw8+Q3yVa5OPZUNGV44vRXIWY2CA+ZD4XHbhH/jKD7L+gedFGX+z
	3HH6p4vFWQCLqQ8LSm7jA0hOkumEZspJhI3nhWUu0ax/xw4D3C9ko9zd3Tdonj+D
	4+iTCQcKS0zgMwulq4rWfOMl3y9QM3R9k7cVPl+V9f7s5h/Dgmt32aRQ==
Received: (qmail 2621450 invoked from network); 30 Apr 2024 13:54:38 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Apr 2024 13:54:38 +0200
X-UD-Smtp-Session: l3s3148p1@b+DXCE8XMKtehhrb
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: alsa-devel@alsa-project.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	patches@opensource.cirrus.com,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 0/4] ASoC: use 'time_left' instead of 'timeout' with wait_for_*() functions
Date: Tue, 30 Apr 2024 13:54:33 +0200
Message-ID: <20240430115438.29134-1-wsa+renesas@sang-engineering.com>
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

Wolfram Sang (4):
  ASoC: codecs: wm8962: use 'time_left' variable with
    wait_for_completion_timeout()
  ASoC: codecs: wm8993: use 'time_left' variable with
    wait_for_completion_timeout()
  ASoC: codecs: wm8994: use 'time_left' variable with
    wait_for_completion_timeout()
  ASoC: codecs: wm8996: use 'time_left' variable with
    wait_for_completion_timeout()

 sound/soc/codecs/wm8962.c | 12 ++++++------
 sound/soc/codecs/wm8993.c | 12 ++++++------
 sound/soc/codecs/wm8994.c |  8 ++++----
 sound/soc/codecs/wm8996.c | 14 +++++++-------
 4 files changed, 23 insertions(+), 23 deletions(-)

-- 
2.43.0


