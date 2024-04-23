Return-Path: <linux-kernel+bounces-155462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA26C8AEAE8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25746B223CC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E1413D2A0;
	Tue, 23 Apr 2024 15:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePaTI8/W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B2913BAFE;
	Tue, 23 Apr 2024 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885643; cv=none; b=Ioak9dRWzbV3PcqXj7M2qNsB99iAehLucLUAfO1m9IzFAYMkqvzyO/h7/OCy5fpm2GZfXBUyDgjBn1gtsYzZWFrtoq47tPblsbm3Vy7ycVTy/naoOLwHMjl7/BuPKYEPh0akeKgdW1N1uX1hfVs6pePeUCGAHiJtgupDiywcBGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885643; c=relaxed/simple;
	bh=OyvbrdsdOf2HxYi0DXyL+Wx579OMeT8jr9c640c8pY4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=obkVByb/pv2183ui7PX3Dkq6pgrlSRQTVp/RGg9cLipdbfxIKL1eQfAiw75FdnAmCyqE/NjTDleyXbel+mHBJA72M0CUpXSmiYFCe51qwv9Ndu+H0rnEZCriuDdvpaFMRuJNX9JvHNUdxUDvXe7odQddVZhi0IQUTbcwTYp34kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePaTI8/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2386EC2BD11;
	Tue, 23 Apr 2024 15:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713885643;
	bh=OyvbrdsdOf2HxYi0DXyL+Wx579OMeT8jr9c640c8pY4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ePaTI8/WeGCq3oP9TPCFaFFHRJ/MYBA+RPJJNmoBRx8Gg5wQXfXvjVf7izK/YOc9f
	 L/TFkEIWp6gqmQHnIczV2UPkAY/LUhHwHVh3+1ikEY6PK4FyW2AgAkQWnLrUk5XCdx
	 g3uvo5iCPRiqJl7kHucO+W4ZHwCR2emSNC+6TTUlcAzS25ItrsK7HbRfEboX3VrZZl
	 rlLNVKxW5AzFeXtqwcE6KG9uxS2E2U5fbUurJEAdIF5zL9oAVkq9w+qLKtkIGD5sim
	 4UGQjWqZenRAKORFz6Pn0jncs3hZ456GzHlPES/1DNEp1PPWPQqcf2Eq4nvUQnnU/K
	 XLClRxdhahKoQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEA0C4345F;
	Tue, 23 Apr 2024 15:20:43 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v2 0/4] dev_printk: add dev_errp_probe() helper
Date: Tue, 23 Apr 2024 17:20:29 +0200
Message-Id: <20240423-dev-add_dev_errp_probe-v2-0-12f43c5d8b0d@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAL3RJ2YC/x2MQQqAIBAAvxJ7TjAzgr4SIdZutReVFSIQ/550G
 uYwUyCTMGVYugJCD2eOoYnpOzhuHy5SjM3BaGO1NaNCepRHdI2ORJJLEndSA6K20zye1k/Q4iR
 08vuP163WDyo3lnloAAAA
To: Petr Mladek <pmladek@suse.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Chris Down <chris@chrisdown.name>, John Ogness <john.ogness@linutronix.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Andi Shyti <andi.shyti@kernel.org>, Jyoti Bhayana <jbhayana@google.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713885641; l=1190;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=OyvbrdsdOf2HxYi0DXyL+Wx579OMeT8jr9c640c8pY4=;
 b=41tRg6ufy5pwxxCdDpPaKGvcgOMYRhybemdpQjZ2/Fd1w219f0pYfxPZNYkVdRLz/hQG2fDR5
 SWNbzCJuCvYCvKJVNHX+MCFghLuwPPD0itHC517e+02X/5N33+emX0k
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Hi,

Here it goes the second version of this. Main difference is the
introduction of dev_err_cast_probe(). Full log:

v1:
 * https://lore.kernel.org/all/20240404-dev-add_dev_errp_probe-v1-0-d18e3eb7ec3f@analog.com/

v2:
 * Patch 1:
   - Renamed dev_errp_probe() -> dev_err_ptr_probe();
   - Added dev_err_cast_probe().
 * Patch 2:
   - Make use of dev_err_cast_probe();
   - Also use dev_err_ptr_probe() in __ltc2983_custom_sensor_new().  
 * Patch 3:
   - Use dev_err_cast_probe().

---
Nuno Sa (4):
      dev_printk: add new dev_err_probe() helpers
      iio: temperature: ltc2983: convert to dev_err_probe()
      iio: backend: make use of dev_err_cast_probe()
      iio: common: scmi_iio: convert to dev_err_probe()

 drivers/iio/common/scmi_sensors/scmi_iio.c |  45 ++---
 drivers/iio/industrialio-backend.c         |   8 +-
 drivers/iio/temperature/ltc2983.c          | 282 +++++++++++++----------------
 include/linux/dev_printk.h                 |   9 +
 4 files changed, 158 insertions(+), 186 deletions(-)
---
base-commit: a59668a9397e7245b26e9be85d23f242ff757ae8
change-id: 20240423-dev-add_dev_errp_probe-1dd04573f4a5
--

Thanks!
- Nuno Sá



