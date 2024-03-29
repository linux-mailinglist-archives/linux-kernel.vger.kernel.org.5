Return-Path: <linux-kernel+bounces-124890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470FE891D81
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C5F1C276F1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261F821EB81;
	Fri, 29 Mar 2024 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWEMN+ho"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617A422BF7E;
	Fri, 29 Mar 2024 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716375; cv=none; b=gfykydaVcKkHL76eCxQ1UxdPWXT59eBYST7n20S3OpB9IndFgheGtzyiCx6BqmC+Qv5XFF3kfDjGwZYw1LmHCO5mlANXDvjoJClMKTU3m3jSWpf+RJC+ay0faajEhktY/O/T6AlOavNG0pjeSNN0e6UqfJ7SsVNRwv3+rr5NFUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716375; c=relaxed/simple;
	bh=Hr6/fqEuSV+3ozSdMI0IXVF8le9J2P0Ev4/GcRK4KkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0Biquc8NE0URCNNSzRekr+deokplmv2sTCyks7kYdYEwHEUkfTFFnA/UGB1sJbKL9Z6yNR+Mzu0F+xxI+uSSjHTuK3hZ/EBk+KQCDqeSGSgJHo8D9LDPb9qIRnWG3L/PPn5ATaIFhdwVMA5sziiN9QwrkpW1fkKRh/5RLhGn4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWEMN+ho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12633C433A6;
	Fri, 29 Mar 2024 12:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716374;
	bh=Hr6/fqEuSV+3ozSdMI0IXVF8le9J2P0Ev4/GcRK4KkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lWEMN+hoZr6QISrhia8RghXGuzj5ORqnfadvyl8HKU1usBG/n7F75wotnqP2vD4+2
	 e0XCvwnXIl9BDL0T1IDWNKBoe9EqOKOJsZs5BWm8RO1lYSOhJCQdFBaIO+N5CJOMDA
	 NxoSa3rJJrv3Mh1q55nRABnDyu74Oci7fytJxSassE3ajfQdsArS7wEl+P0xlM88ZZ
	 N3PRIpAF7KA9XFPqtAwjcvqBHMidWFB2tfi1t3FazPDTGn0M9V3qrQBzjZSwAFDUch
	 XtQGC+ZPZf9ZqSdtm/GZyNa6Dpm+bTp7WucnQ6BD3NJaBki2px715ghL+sVYZDaAjM
	 VhRWaiAr3cazw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>,
	linus.walleij@linaro.org,
	linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 06/52] pinctrl: renesas: checker: Limit cfg reg enum checks to provided IDs
Date: Fri, 29 Mar 2024 08:45:00 -0400
Message-ID: <20240329124605.3091273-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 3803584a4e9b65bb5b013f862f55c5055aa86c25 ]

If the number of provided enum IDs in a variable width config register
description does not match the expected number, the checker uses the
expected number for validating the individual enum IDs.

However, this may cause out-of-bounds accesses on the array holding the
enum IDs, leading to bogus enum_id conflict warnings.  Worse, if the bug
is an incorrect bit field description (e.g. accidentally using "12"
instead of "-12" for a reserved field), thousands of warnings may be
printed, overflowing the kernel log buffer.

Fix this by limiting the enum ID check to the number of provided enum
IDs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/c7385f44f2faebb8856bcbb4e908d846fc1531fb.1705930809.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/renesas/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/core.c b/drivers/pinctrl/renesas/core.c
index c91102d3f1d15..1c7f8caf7f7cd 100644
--- a/drivers/pinctrl/renesas/core.c
+++ b/drivers/pinctrl/renesas/core.c
@@ -921,9 +921,11 @@ static void __init sh_pfc_check_cfg_reg(const char *drvname,
 		sh_pfc_err("reg 0x%x: var_field_width declares %u instead of %u bits\n",
 			   cfg_reg->reg, rw, cfg_reg->reg_width);
 
-	if (n != cfg_reg->nr_enum_ids)
+	if (n != cfg_reg->nr_enum_ids) {
 		sh_pfc_err("reg 0x%x: enum_ids[] has %u instead of %u values\n",
 			   cfg_reg->reg, cfg_reg->nr_enum_ids, n);
+		n = cfg_reg->nr_enum_ids;
+	}
 
 check_enum_ids:
 	sh_pfc_check_reg_enums(drvname, cfg_reg->reg, cfg_reg->enum_ids, n);
-- 
2.43.0


