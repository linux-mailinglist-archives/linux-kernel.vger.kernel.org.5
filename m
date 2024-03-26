Return-Path: <linux-kernel+bounces-120084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1899588D157
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8CDE32240D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1509E13F458;
	Tue, 26 Mar 2024 22:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODHnADV8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F4F13E6C5;
	Tue, 26 Mar 2024 22:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492848; cv=none; b=PKUMKEA/x6cnLaO28xanJeC67cSQVZ40BZm4jn8hAPhu4Jct+3+vOQhiIqyNCBOs8URRC+AW3woSLTIIC4pHNyGoSuTD4TYuVDpLAfAS99HFM0g/zPF8U3WMA+G3A70PirolyheqPHEu+WeGQXz9w3kMQclymBiju6Ys/h/5enw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492848; c=relaxed/simple;
	bh=iaotj1iZQ8IOaXKa3sSgBb9LPDG2URR87VML4Asl6ZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VRBQknGcCgMEFY9pIY0qQhRKpUQp6Zx9//KkxlzYPt3oq+eiRaqcX4YW+9zS4Ue3ulJ5UzwnWJ4M6TJqPgU2409PRVDq/y5ZgK0ZbHNJGuOcwBjyrRPgIrQE+sgcnglOQgPMANLckm/au5Hso3ETLCFRguZzG/V4wLC+KNAYyTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODHnADV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897A9C433F1;
	Tue, 26 Mar 2024 22:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711492847;
	bh=iaotj1iZQ8IOaXKa3sSgBb9LPDG2URR87VML4Asl6ZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ODHnADV8jbM1W2YmWlXbh+RY49mjLG3aluEG3tx+tMw+PQaTBk0E3Hn/ulcUNVdjw
	 McUs8XBCAaX4PJeU7h+HtO5xr4XRyefi+bwFim4AgFaCvLpW4Z7RJyDojCYHnvUt2J
	 s/D4ZNnNLr53uFEBh9q6QnsfcKbagk4CBO4zgit+qyqm5GI+xP3OFxeWeqcU5FsWvV
	 U/h9UcDRN7Pwx/qFtLEkg2VRhcCqxik7J2ZQE3RM8ylDYnhepyIVgqzH4sojgBViDl
	 I1VP9IkpTDXqdRvimcukslPS5JX7UKbWx09jD8NbcVDtswEQbCbfKx1IZCkQKhOTX8
	 Z4bWASyfJpaXw==
From: Arnd Bergmann <arnd@kernel.org>
To: llvm@lists.linux.dev,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	ye xingchen <ye.xingchen@zte.com.cn>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] Input: IMS: fix printf string overflow
Date: Tue, 26 Mar 2024 23:38:05 +0100
Message-Id: <20240326223825.4084412-7-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326223825.4084412-1-arnd@kernel.org>
References: <20240326223825.4084412-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang warns about a string overflow in this driver

drivers/input/misc/ims-pcu.c:1802:2: error: 'snprintf' will always be truncated; specified size is 10, but format string expands to at least 12 [-Werror,-Wformat-truncation]
drivers/input/misc/ims-pcu.c:1814:2: error: 'snprintf' will always be truncated; specified size is 10, but format string expands to at least 12 [-Werror,-Wformat-truncation]

Make the buffer a little longer to ensure it always fits.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/misc/ims-pcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 6e8cc28debd9..80d16c92a08b 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -42,8 +42,8 @@ struct ims_pcu_backlight {
 #define IMS_PCU_PART_NUMBER_LEN		15
 #define IMS_PCU_SERIAL_NUMBER_LEN	8
 #define IMS_PCU_DOM_LEN			8
-#define IMS_PCU_FW_VERSION_LEN		(9 + 1)
-#define IMS_PCU_BL_VERSION_LEN		(9 + 1)
+#define IMS_PCU_FW_VERSION_LEN		16
+#define IMS_PCU_BL_VERSION_LEN		16
 #define IMS_PCU_BL_RESET_REASON_LEN	(2 + 1)
 
 #define IMS_PCU_PCU_B_DEVICE_ID		5
-- 
2.39.2


