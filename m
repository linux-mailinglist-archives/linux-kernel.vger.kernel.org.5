Return-Path: <linux-kernel+bounces-138460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F4289F190
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B672817E2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC3F15B151;
	Wed, 10 Apr 2024 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzkTexlU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE9F15B142
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712750325; cv=none; b=qonpyIbGLIY8oBuTiJQdgwPCGrPU0CCfCswybRPLuR1GhLY2VYX6YdMoj2u1IhJdqPxNj/CN8G67NRroKn8AC+qtBy8cgAY3yfkmLQZjwYG1oGPdF+mngQztyqxD9lPscIN363t5iK+82a0IH0D1JogfPxO2GmcoHkgkPlTYpV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712750325; c=relaxed/simple;
	bh=miFooV5xlwUAoCg/5+WmOIw7hiB7FtagEK3Q2jQpBdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCzeHN2JABkNFCCXbTdNihU8nP9HMCjdS6XQuTR/hJ5TWfmuuGzyOZfwDwGDWwcqIHL10oKkw9NFZTWmNncanNxWooiQeLebvKTpvz8MYX+HNbEKEZshlcjfV0ymon/lKPUXczWO51mXEO1Vct5VmQdcEFjN+SpjgaOgCLcNlZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzkTexlU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B724C43394;
	Wed, 10 Apr 2024 11:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712750324;
	bh=miFooV5xlwUAoCg/5+WmOIw7hiB7FtagEK3Q2jQpBdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LzkTexlUdZzTNblZagdSguoN7Auvwyg5ucQMjlq+cptVQwFQ4S867LO/VGgVQ25q1
	 VTUXuPxX2YRuFFbOfc+vkQY7WlmW5Jdt4DKt79iebKHmaX7ED+HaeoHFIT0C4ugRL+
	 rJgJeQsfQG7vm+75L4d7106btgyKMPzToYMmFkXkIS+VxRVQqrhSrvjrzFh3Ga72Gp
	 LbgeBgxre8b7e4fJX64eavrDEv51lh66jxVdQb6vp/RIU6mjy0blehj1w31tybG7kY
	 hfFnXfndpz7KzVwYlROXa+6YdsGM3E40qG5qSaBTLDqrFnbcD4/e2rWYvxmOVYVvlv
	 Oplqn6rf66Z5g==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Cyril Jean <cyril.jean@microchip.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] firmware: microchip: don't unconditionally print validation success
Date: Wed, 10 Apr 2024 12:58:05 +0100
Message-ID: <20240410-throwing-sandworm-7d03e4e2f4e8@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410-opulently-epic-8654bdac3422@spud>
References: <20240410-opulently-epic-8654bdac3422@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1033; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=bV+GMkr+Qxwo4lMIT/B+7/B5KMkZCVAYKLvbSQ6UzsY=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGlidVesmcN/GW7tkMwrORDPaLzTzH1p8vWTh5Zni3yrb YxN2vu3o5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABPZIszwv+z3nHNeM45xms/P ifjf1NKtIvw0wGjhOfO0BSdPGqxKsGRkmO7Y8GXVvIqnl019DRTuX808xacV1bN4xZo8zeDmY99 YuAE=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

If validation fails, both prints are made. Skip the success one in the
failure case.

Fixes: ec5b0f1193ad ("firmware: microchip: add PolarFire SoC Auto Update support")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/firmware/microchip/mpfs-auto-update.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/microchip/mpfs-auto-update.c b/drivers/firmware/microchip/mpfs-auto-update.c
index 33343e83373c..298ad21e139b 100644
--- a/drivers/firmware/microchip/mpfs-auto-update.c
+++ b/drivers/firmware/microchip/mpfs-auto-update.c
@@ -218,10 +218,12 @@ static int mpfs_auto_update_verify_image(struct fw_upload *fw_uploader)
 	if (ret | response->resp_status) {
 		dev_warn(priv->dev, "Verification of Upgrade Image failed!\n");
 		ret = ret ? ret : -EBADMSG;
+		goto free_message;
 	}
 
 	dev_info(priv->dev, "Verification of Upgrade Image passed!\n");
 
+free_message:
 	devm_kfree(priv->dev, message);
 free_response:
 	devm_kfree(priv->dev, response);
-- 
2.43.0


