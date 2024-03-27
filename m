Return-Path: <linux-kernel+bounces-121759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D1588ED4A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13CC22A551E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DB215252E;
	Wed, 27 Mar 2024 17:49:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FE514D701;
	Wed, 27 Mar 2024 17:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561757; cv=none; b=ccr7aWx3WvQn8hbhHJbSMeT/r/vXMjsQD/wpdkz9Y6W00CWwEVbOzOLcxggmMfDSf77vuoJVAKfpIq3vL+XhkDKZGVisqJMqYQ9KJxdZLnsIgLtlL4RUeFgjYApISlW9nQJAAa6ky62JybahWV9QqMK5n0NltPAg7SUxTM1cAKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561757; c=relaxed/simple;
	bh=xMlBPCxx67Kd23VCZ7ClsLvlUlSfPjC+64ZiDaRXLaY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mY3wJockNOyiKHmCEodq1KlXmtIHnfnU55N+JkOxvHKIiwJcKuhJI2UjmirVh637nDuKlczaRsvCWyAVAHfbys90OemMHRTyM58DFMuFiPT7sB7EU0bItM0rAPvvHz0LDvjbqyJ87jt1NKb/iAgFOLDjHHFa1ISuJaqElr1Qsds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C04C43390;
	Wed, 27 Mar 2024 17:49:13 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] fpga: altera: drop driver owner assignment
Date: Wed, 27 Mar 2024 18:49:09 +0100
Message-Id: <20240327174909.519796-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in spi_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/fpga/altera-ps-spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index 740980e7cef8..d0ec3539b31f 100644
--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -284,7 +284,6 @@ MODULE_DEVICE_TABLE(spi, altera_ps_spi_ids);
 static struct spi_driver altera_ps_driver = {
 	.driver = {
 		.name = "altera-ps-spi",
-		.owner = THIS_MODULE,
 		.of_match_table = of_ef_match,
 	},
 	.id_table = altera_ps_spi_ids,
-- 
2.34.1


