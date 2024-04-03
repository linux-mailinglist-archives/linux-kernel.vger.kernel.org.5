Return-Path: <linux-kernel+bounces-129280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9906789682A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C346E1C25B75
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB09581207;
	Wed,  3 Apr 2024 08:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAlVLpOE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289CD82C76
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131680; cv=none; b=uE49ILQ87C+d8Dd+Xoh2xyTBUf2vmAlBJJ0rf6jM6KbXTgk8/oGCHUk6AACWgqVwX4NGP+UVW5XCVmEMn6HvQg96lwGWh8saJbbW3XfzbsEpULHa3dvbmvFUCvGQSt5AQyhe1qJytrivcAYpbQoS0Lbx76Q3Cir+MiRNxB2Pmnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131680; c=relaxed/simple;
	bh=+RZZEkb1FuJEVe5kPWRemc+Kjc4SmXvUOzkLd/XEDLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T3G0VKEgiHegotLctAld8LQB1Scuf1wXIonwUvJeHjrBcPvwn/3mPROTwKLb/OnWYxiHwFUkG1bnuvBGY91Nssm0LDCfYaZyp8yxgO2AP3DSpQDWHsPWW15StqdDjW22Ov/BJXAFgkzeiPzxJ1Z0e1bERjhuOSaieHqy0wHWoM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAlVLpOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C2CC433C7;
	Wed,  3 Apr 2024 08:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131679;
	bh=+RZZEkb1FuJEVe5kPWRemc+Kjc4SmXvUOzkLd/XEDLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UAlVLpOES8BpHSPX9xir8ZtWnkI77GoKSccDd8F6+Lk5tHErVvCS9G6JNPltXMnym
	 rw6JRTNWTdPa5bZKdSJ0J85vD98lmiNtbSSQlOIX2sLHXEq5Sn2VUDYE3dYun2NXTX
	 69JmjTv/12GuEiqIxNPjAsBBfE3znOnNROub0nUFLF5j0n2ti8dQ1JmVenQn+YcJcn
	 yACPEXgXsCS5/igxN4eicNYihVjW3GKeuNcp2rAc/hTetqC0CMP63kOVJKFP3f/iJv
	 /TANOdMIz3qmKZX+lUUUhuDWVHO+koGyTXMsGF2dubT63flnfqpvQk4yUr36PZSPla
	 cmPMc8C010LUw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Alan Cox <alan@linux.intel.com>,
	Jason Hu <jia-cheng.hu@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jin Qian <jinqian@android.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 03/34] platform: goldfish: remove ACPI_PTR() annotations
Date: Wed,  3 Apr 2024 10:06:21 +0200
Message-Id: <20240403080702.3509288-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

On platforms without ACPI support, this causes a W=1 warning from gcc when
the driver is built-in:

drivers/platform/goldfish/goldfish_pipe.c:925:36: warning: 'goldfish_pipe_acpi_match' defined but not used [-Wunused-const-variable=]
  925 | static const struct acpi_device_id goldfish_pipe_acpi_match[] = {
      |                                    ^~~~~~~~~~~~~~~~~~~~~~~~

There is no real harm in just keeping the small table around, so rather
than adding more #ifdef checks, just reference it unconditionally to avoid
the warning.

Fixes: d62f324b0ac8 ("goldfish: Enable ACPI-based enumeration for android pipe")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/goldfish/goldfish_pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 061aa9647c19..6a0a42887857 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -940,7 +940,7 @@ static struct platform_driver goldfish_pipe_driver = {
 	.driver = {
 		.name = "goldfish_pipe",
 		.of_match_table = goldfish_pipe_of_match,
-		.acpi_match_table = ACPI_PTR(goldfish_pipe_acpi_match),
+		.acpi_match_table = goldfish_pipe_acpi_match,
 	}
 };
 
-- 
2.39.2


