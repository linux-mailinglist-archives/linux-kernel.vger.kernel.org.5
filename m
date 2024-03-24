Return-Path: <linux-kernel+bounces-113550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAA1888539
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55FF51C24846
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B411C3A31;
	Sun, 24 Mar 2024 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDW8Qr4V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD14B1C3A19;
	Sun, 24 Mar 2024 22:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320352; cv=none; b=nNVFINjsBuY02rTvzAPxX3ZUNHE+i0SBv9R4tSf1UZBI7JBzTfBWUN6Lw+DptoTpNctwRWsC65ss6b7mTN7Yvi9jn8AQwCEU8Pom+NZ0OzrF3D+qMjUP7vdN4ZnNkqhHeMgnD6OC5oLHWzN6eLey1zjU5y5cXvEhlUK7S9XJvTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320352; c=relaxed/simple;
	bh=ZjFtkj7Sg9roU8JTgLvzvOkOFj7QNLiKkRGYICIm8bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grygXGd37Zid8poupXLUL1JwyVH2scd330TioO1UNmey5jlK0dTsNSMZdICMN4ZFge14Vk7ePMF7u4li37zLuLMyqbW2+xWbj9VzAobkU7eKNTXkQ8OODLA7o0pEUNX6TzWBRZjQY3t0Gwvt3Y2oAIMsvOk/XjbDyOnhZLPolbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDW8Qr4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CF6C433C7;
	Sun, 24 Mar 2024 22:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320352;
	bh=ZjFtkj7Sg9roU8JTgLvzvOkOFj7QNLiKkRGYICIm8bQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GDW8Qr4VMNLmPC7ExZahDUpOue4PzQMe15tPVIh3ieewf8TPOnJF/g5mJm49R863c
	 CQvDZ1VwBnTVpBmYYJQ0uoXyJGcRakor4ajOruLhRTeQGmV3l0tI6s+Sjv/WRvvyu5
	 1AV8DPCHCcl0uQJ3JFKOHb8r1y0vYbNIRb5g4gVEz3HqwNLgIe9ZM/bWSa2+tJSqn+
	 fGmSoeVnwimh+MfSMx6X8hn43rLUfCA0063XYiIj2MDP6XTeglOFFxg2nL9+Cf2fgs
	 vI1tFEk/YEeIveUzBihGrTkhSD7szkf4mM8q025QNaOy8EtyNopeqeUhIPmSM1RNXk
	 LAB3v+FpWQs0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Michael Walle <mwalle@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 659/715] spi: Fix error code checking in spi_mem_exec_op()
Date: Sun, 24 Mar 2024 18:33:58 -0400
Message-ID: <20240324223455.1342824-660-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <florian.fainelli@broadcom.com>

[ Upstream commit 29895ce18311ddd702973ddb3a6c687db663e0fb ]

After commit cff49d58f57e ("spi: Unify error codes by replacing -ENOTSUPP with
-EOPNOTSUPP"), our SPI NOR flashes would stop probing with the following
visible in the kernel log:

[    2.196300] brcmstb_qspi f0440920.qspi: using bspi-mspi mode
[    2.210295] spi-nor: probe of spi1.0 failed with error -95

It turns out that the check in spi_mem_exec_op() was changed to check
for -ENOTSUPP (old error code) or -EOPNOTSUPP (new error code), but this
means that for drivers that were converted, the second condition is now
true, and we stop falling through like we used to. Fix the error to
check for neither error being neither -ENOTSUPP *nor* -EOPNOTSUPP.

Fixes: cff49d58f57e ("spi: Unify error codes by replacing -ENOTSUPP with -EOPNOTSUPP")
Reviewed-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Link: https://msgid.link/r/20240313194530.3150446-1-florian.fainelli@broadcom.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index c9d6d42a88f55..17b8baf749e6a 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -382,7 +382,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		 * read path) and expect the core to use the regular SPI
 		 * interface in other cases.
 		 */
-		if (!ret || ret != -ENOTSUPP || ret != -EOPNOTSUPP) {
+		if (!ret || (ret != -ENOTSUPP && ret != -EOPNOTSUPP)) {
 			spi_mem_add_op_stats(ctlr->pcpu_statistics, op, ret);
 			spi_mem_add_op_stats(mem->spi->pcpu_statistics, op, ret);
 
-- 
2.43.0


