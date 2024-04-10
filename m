Return-Path: <linux-kernel+bounces-139093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB41C89FE72
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A0261F24D21
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18C917BB20;
	Wed, 10 Apr 2024 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEysqtGN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E8817BB03;
	Wed, 10 Apr 2024 17:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769985; cv=none; b=kANAicr74bLPVmW3CCeNNZdOvub0jg6/5hoz4BuL4Uh831A4KXuDJb5C33loRNyTJrWolkewK+HGYl9iTPc6WhsEny9epGsOVsMebQPbYn53QiBUFfbCgMnJftLL51eFHZQ4D14aYMV1Ep/AumiiG0aYSW6LKfVRqIFSIXgeUtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769985; c=relaxed/simple;
	bh=zIgG0P2RDfvyJWTx4AwOqHCkNM6cYKWlhMdnl65tn24=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sR3fVrRueHkfyxMFHfjEk3X1ASwkE4WnekqZLQDLhLe0zOLGoTOviOJgOlADpiC/BZzXlyseKZELQVp+tepx0ekl2YJk1Ol4VXJ1An8k7XuuhsCbJPlLZ/cHE2r1lQtJtXvPuAnbWt0ZWpnlYryM/ThHrNnwByocjCJwIIjtWiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEysqtGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000CAC433F1;
	Wed, 10 Apr 2024 17:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712769983;
	bh=zIgG0P2RDfvyJWTx4AwOqHCkNM6cYKWlhMdnl65tn24=;
	h=From:To:Cc:Subject:Date:From;
	b=jEysqtGN8wFSyrbP6OivUS/LZQTbyj1AGSdI5tBWZD1lT0fMR72SG8iUAZvn/SKyD
	 OszsETuG2xMJ8BZeRKQixIGZ+BV3vBNzjW+zxl9/3PMurWdMwmL83GfqRQpY4x5RUh
	 hmcbcK925B5CnkFBSf1f71slmM5lWLEneIGUg0BLwSOLn7mhPqRAg30xOk2QxCSqub
	 8M3J3bcTlvh6FLrWkESICq6CCim9a+WIfB8UR9wX4rcR7sX3MYlYuuRN0X+ev+vRHw
	 njD1eadKBJyxhQcW97rOYqGD2f1+unSGjesMwgU85RV/72/L7t6LGiu37X0onEEdtO
	 1mWHZhwmNdyMQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Robert Marko <robert.marko@sartura.hr>,
	Luka Perkov <luka.perkov@sartura.hr>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] regulator: qcom-refgen: fix module autoloading
Date: Wed, 10 Apr 2024 19:26:14 +0200
Message-Id: <20240410172615.255424-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/regulator/qcom-refgen-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/qcom-refgen-regulator.c b/drivers/regulator/qcom-refgen-regulator.c
index 656fe330d38f..063e12c08e75 100644
--- a/drivers/regulator/qcom-refgen-regulator.c
+++ b/drivers/regulator/qcom-refgen-regulator.c
@@ -140,6 +140,7 @@ static const struct of_device_id qcom_refgen_match_table[] = {
 	{ .compatible = "qcom,sm8250-refgen-regulator", .data = &sm8250_refgen_desc },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, qcom_refgen_match_table);
 
 static struct platform_driver qcom_refgen_driver = {
 	.probe = qcom_refgen_probe,
-- 
2.34.1


