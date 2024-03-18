Return-Path: <linux-kernel+bounces-106311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B6287EC44
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16C21C21130
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2B1524B5;
	Mon, 18 Mar 2024 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQ2aKkHk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818A1524A0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710776160; cv=none; b=mnacq2ovnLSzzAftwMdk7k5tsUDdtw8oSYi3+rMZq2vmMwBufQLYTwVZ1JdDE8e3B+oOTZORaVGcfm8QKkQZ7CIsPWiYLhlYUTfcrAqzw2TmJxtpr2ijdfh6AHHZzlFpPQilUpxIn0eM4kzc45JipX4+9cnti77oLxoA/YszzTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710776160; c=relaxed/simple;
	bh=ncNnzzFLD+EC1GvgwoBIzC/SxHOpyQdJBZwQhlX29Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LSZhz7LE7CNwXVTLABceMSlQDDhWwXdfAbdzrjfvhZGO8XEr0/0Bc7ZRTbymyBc0XK0jcOQ/w3uZhKZtyS53f+7S4NJLf8UTSY0zpvaX+9bL3TRa9XM8ldLFZ34xTv9A1XeWIJduZzhd4SXoI40MrHMCbzYETvt3gIQkYBj3rK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQ2aKkHk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CACC433C7;
	Mon, 18 Mar 2024 15:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710776160;
	bh=ncNnzzFLD+EC1GvgwoBIzC/SxHOpyQdJBZwQhlX29Wg=;
	h=From:To:Cc:Subject:Date:From;
	b=BQ2aKkHkv1zDAn9yStDByoWz04vcdYPWvhGzZv+qLja5DUTMe3cBOXsNhkWJdVT4n
	 RZs4V3S073kARMk7iEYeMojLaGVZIKgNVYymGW8jgXvqilVXbWZENDOqHIAjBkumxZ
	 fsKQQavth1WLtG2cjZ5/078fmQc16tT+z9blV13/xquDSfC4XyMUwLoTwTZdsl9XnD
	 0x53/pknATPxfx3V3xgl1jVxbObiUmUxNgAu9EXWOC5SmzFXoQ4JEHcaUhh4gieoK7
	 06wn+Z8Bk0NpEc5UQFDqCb1B5nPhXvcn9awOhEm/Vr7DA+9Okm3oga6/jUWK+sVam2
	 cilITj8QMM9gw==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] perf: starfive: fix 64-bit only COMPILE_TEST condition
Date: Mon, 18 Mar 2024 15:35:04 +0000
Message-ID: <20240318-emphatic-rally-f177a4fe1bdc@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=qRhFK3rYTyezrGe8FKEh70/bj4HDt75Auhc2y3YLrUk=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKk/4jV2Jhj8lRK/e2l6+fr4o6XnurPS5pmvtrnV8mPNO Y7pPf8fdJSyMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAi98wZGbZxhey/UqvwaQGj sZ9dYKrpdY841h9yCk8P1we/lFLZb8PwvyJva/D3roz7mzev0TI4fe1FwPG0pyrLuMW+fWM/+fz YYyYA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

ARCH_STARFIVE is not restricted to 64-bit platforms, so while Will's
addition of a 64-bit only condition satisfied the build robots doing
COMPILE_TEST builds, Palmer ran into the same problems with writeq()
being undefined during regular rv32 builds.

Promote the dependency on 64-bit to its own `depends on` so that the
driver can never be included in 32-bit builds.

Reported-by: Palmer Dabbelt <palmer@rivosinc.com>
Fixes: c2b24812f7bc ("perf: starfive: Add StarLink PMU support")
Fixes: f0dbc6d0de38 ("perf: starfive: Only allow COMPILE_TEST for 64-bit architectures")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Will Deacon <will@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
CC: linux-arm-kernel@lists.infradead.org
CC: linux-kernel@vger.kernel.org
---
 drivers/perf/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 5060e1f1ea10..7526a9e714fa 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -87,7 +87,8 @@ config RISCV_PMU_SBI
 	  filtering, counter configuration.
 
 config STARFIVE_STARLINK_PMU
-	depends on ARCH_STARFIVE || (COMPILE_TEST && 64BIT)
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	depends on 64BIT
 	bool "StarFive StarLink PMU"
 	help
 	   Provide support for StarLink Performance Monitor Unit.
-- 
2.43.0


