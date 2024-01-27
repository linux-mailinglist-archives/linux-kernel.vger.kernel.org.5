Return-Path: <linux-kernel+bounces-41260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5AB83EE2B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822021F224DC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642962C19A;
	Sat, 27 Jan 2024 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="COIITEB8"
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A1C28E02;
	Sat, 27 Jan 2024 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.104.132.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706371461; cv=none; b=G+RLVxDnIVn0Zkx7/s+qpr4bB3+1FI8dnWXJ9H+U1/E+wiceDmzxeqkdF1L+dStq/a/h73KRYVfJoYSsEozzISJI2n/pB2LAcKeSeHLNjiMAxgoKDQEdIql2NrDzKkE6d1a/FACGWkYsuUiPEGWL2RZRYN3gJut2+idwNJeOh+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706371461; c=relaxed/simple;
	bh=LTtc/KGc3er11Li2smUvdjG1aLcglxo3OSttIx7IDpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YlIOODYG8r2XTYD9cpJDaGBbVcUfHmsjgvSRQ/cB2ztPe0RIWBLE3TINpwpW07CJAJ5tXeN81I/NxhpDz0fghBhijvCv5KLTIN5NQ73OegEijLuHcVHSEnScSOt70PmjRjPCLiDIGv0QV9PI6i2AmXiQvujCvk7OeyYeDA8ctB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=COIITEB8; arc=none smtp.client-ip=172.104.132.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.80.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id F079628F2BC;
	Sat, 27 Jan 2024 16:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1706371452;
	bh=LTtc/KGc3er11Li2smUvdjG1aLcglxo3OSttIx7IDpI=;
	h=From:To:Cc:Subject:Date;
	b=COIITEB8x+6MkFg/9rAcIUXu8R1EmER2zdVDa8IY3vKQa324tO+sxBv0r7rYNY4oG
	 u2z+HUjyKsb7O8fX5707+pr3kQg3Fkae3vMk/A6cg/TL0SKTAVBtRsJtFElZQQAVKp
	 +OgDkzYzPZyhkfHEBTZG9Kxe1z/g0exQaIBoBuIU=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 0/4] iio: pressure: hsc030pa: cleanup and triggered buffer
Date: Sat, 27 Jan 2024 18:03:54 +0200
Message-ID: <20240127160405.19696-1-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This set of patches covers the following:

 - small cleanup
 - mandatory 2ms delay between readings
 - support for triggered buffer readings

The support for devices that have "sleep mode" factory option that was
present in v1 of this patchset was removed, for a few reasons:

 - a Honeywell employee told me that this chip variant is extremely
    unlikely to be found in the wild, which also makes testing the
    driver functionality impossible
 - I found no reliable way of generating i2c/spi bus traffic with no
    payload (toggle CS for SPI case, send i2c packet containing only
    the address byte) that are required for the wakeup sequence.


Petre Rodan (4):
  dt-bindings: iio: pressure: honeywell,hsc030pa.yaml add spi props
  iio: pressure: hsc030pa cleanup
  iio: pressure: hsc030pa add mandatory delay
  iio: pressure: hsc030pa add triggered buffer

 .../iio/pressure/honeywell,hsc030pa.yaml      |  3 ++
 drivers/iio/pressure/Kconfig                  |  2 +
 drivers/iio/pressure/hsc030pa.c               | 49 ++++++++++++++++++-
 drivers/iio/pressure/hsc030pa.h               |  7 +++
 drivers/iio/pressure/hsc030pa_i2c.c           |  9 +++-
 drivers/iio/pressure/hsc030pa_spi.c           |  7 ++-
 6 files changed, 73 insertions(+), 4 deletions(-)

-- 
2.43.0


