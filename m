Return-Path: <linux-kernel+bounces-78716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CDA8617D3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5860B2A7D0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5077412F598;
	Fri, 23 Feb 2024 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEGjQbLT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2F612E1FC;
	Fri, 23 Feb 2024 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705306; cv=none; b=BMx5jWSx1sq/gHyEyCQ9joUeX2CkunDlJVyIzgxA5575C7DVKMk3ne7+JRbHj2Oy7HYXEY4IpjzBTrkT7LuBT/1jSpbaRA4fXuZ1dMfsgEZXuxZJ+ZisHpy0BAb3TJN70NOjfoaAv56RNPmntbrJPFIkgdc02+Nas4hgiLSqiVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705306; c=relaxed/simple;
	bh=xpFapP+t1GY5qR3wsOV3Nl7p1ssqEBrzSJNPZBMtc1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFI/fH2J9L6lrHvDw4evAMNEStBs44EjjdJi5yEbVnVozLJWzzF0h6qIglo28+V4ozpLnnS0QP599ENMczuOr3XDGgkO+SWQn0tIGYOFqkHSgmAPb+Jp7rN+62V5UFLPIHQLgLE8YJFXqSsJTIgFrVCbZbqcHX0voChg2qj752w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEGjQbLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5718C433C7;
	Fri, 23 Feb 2024 16:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708705306;
	bh=xpFapP+t1GY5qR3wsOV3Nl7p1ssqEBrzSJNPZBMtc1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nEGjQbLTNrvj5xvemmvu7cU++u5DUAhThDVhFtJAbvNhZh52GS0dWxyDGbNRWF87n
	 HUEZZ0CYQelFRrFeco9tC0pUYsbfvHrGeINupOZ4RbLwjB64cafgQK80qN2WNFRiy+
	 LtjVnEKE08bclZyqYV7k/tE/myoP8NSF+grve0Chg0R99hyUUO+U56UQcD06eOVKeP
	 oD9XQ4jpIrzi/VwbkEiGpJ/zCAarWralV7pF9zv8pnmG9wj7zpt9RMx+3s1vt2OOHr
	 DjAB5xcgFcZIQ3BtK0QCN5/YZzIDwmRphV+zNXl0t+z44W1t58QtHDnHMyQipchf2q
	 WWWXnG41ER2rw==
From: Conor Dooley <conor@kernel.org>
To: linux@roeck-us.net
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Jean Delvare <jdelvare@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Zev Weiss <zev@bewilderbeest.net>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Naresh Solanki <naresh.solanki@9elements.com>
Subject: [PATCH v2 3/5] hwmon: (pmbus/tda38640) Use PMBUS_REGULATOR_ONE to declare regulator
Date: Fri, 23 Feb 2024 16:21:07 +0000
Message-ID: <20240223-catnap-companion-c42fdd8ad110@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223-moonrise-feminist-de59b9e1b3ba@spud>
References: <20240223-moonrise-feminist-de59b9e1b3ba@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=927; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=1ZtfL4H/Opueo+tkLhUryZdEDy0uFp+4wOJDc4cuTnE=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKk3jv6QmRr4IpfD1GNPlhl7Sechbpbey7VHl657v/pEP esyjUWNHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjI0XqG//6vT5qbeOaEFHX0 H2d9cPjxYteDcba/Gi7dfzh33x7HgAqG/z77DgnPX/j+RRTXP/VFv3h7ui5nr7+8Nmb9S2ET/qv +h9kB
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

If a chip only provides a single regulator, it should be named 'vout'
and not 'vout0'. Declare regulator using PMBUS_REGULATOR_ONE() to make
that happen.

Cc: Conor Dooley <conor@kernel.org>
Cc: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/hwmon/pmbus/tda38640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/tda38640.c b/drivers/hwmon/pmbus/tda38640.c
index 09cd114b1736..c31889a036f0 100644
--- a/drivers/hwmon/pmbus/tda38640.c
+++ b/drivers/hwmon/pmbus/tda38640.c
@@ -15,7 +15,7 @@
 #include "pmbus.h"
 
 static const struct regulator_desc __maybe_unused tda38640_reg_desc[] = {
-	PMBUS_REGULATOR("vout", 0),
+	PMBUS_REGULATOR_ONE("vout"),
 };
 
 struct tda38640_data {
-- 
2.43.0


