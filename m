Return-Path: <linux-kernel+bounces-129284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F916896838
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B58528B70C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9296885261;
	Wed,  3 Apr 2024 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxMBY/dL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C513584FBA;
	Wed,  3 Apr 2024 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131719; cv=none; b=p/1m3M1E5RxwrtiIWG48aNV/sUEElzyBvpfCY2I6LQa4khjoZf8VyxdZqUhiuzvKCVciKprMTl0hK0hdKD0DKiH2usHsygxgtUS7qRzM4YQ8ZT47/wYIJUb57coNNx0avjSVsPkfF7Xl0kF/vxn+IV4yBeAN17RMY2ILTkO3qac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131719; c=relaxed/simple;
	bh=3FgSuQ7tiSYGFrQ5YgtJKC7vrKzdmqUOX9CzJzQDHso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PI37arfRXglia+LPQUTpcpxFo3RCZ2gZ5fqYTDsjfrgVFmsGSyBCiLFQegNIA+n5ohU7IQU3bJ1W5wCQvusb8lsyHVyWGp0CM2T/WkXYY1vxjYPbCLm5rXUDD83rqol9BF+VAPvCJBExKlG/lDq/XCeEt14uou3IjCuwwqopT+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxMBY/dL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1BBC433C7;
	Wed,  3 Apr 2024 08:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131719;
	bh=3FgSuQ7tiSYGFrQ5YgtJKC7vrKzdmqUOX9CzJzQDHso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nxMBY/dLT6CayFR5A/KNDA9+vTisu7sftWa5Fvqb/eWp5hcNJVBZxE9PlPmmG0QXZ
	 PMutL9J0QSHGMavbJbyARu2AUBjoIc+3iSnRqlG0axBXj/qfXEED6BpTlolCLYUMOj
	 ezmb4Sd4u19bTzrzPZBjQ267Nwk8617FXcMyq6nCqmafQWbowELlaEoijdQv6RWuKJ
	 ULjhPLhit5npJ+VXlpwMZ7Xdy6KT9Qph/ZBNCTOBM1xBHql8FNz7ybTgT3dzMFonXw
	 T1Ga5mqfORgR30VA1C3RLnZnowT51tCaV2hczw1rvEgp7DBkjzev151PGQBnGvDbs3
	 QJ2+o6Xmk6guw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-input@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 07/34] Input: stmpe-ts - mark OF related data as maybe unused
Date: Wed,  3 Apr 2024 10:06:25 +0200
Message-Id: <20240403080702.3509288-8-arnd@kernel.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

When compile tested with W=1 on x86_64 with driver as built-in:

  stmpe-ts.c:371:34: error: unused variable 'stmpe_ts_ids' [-Werror,-Wunused-const-variable]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/touchscreen/stmpe-ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
index b204fdb2d22c..022b3e94266d 100644
--- a/drivers/input/touchscreen/stmpe-ts.c
+++ b/drivers/input/touchscreen/stmpe-ts.c
@@ -366,7 +366,7 @@ static struct platform_driver stmpe_ts_driver = {
 };
 module_platform_driver(stmpe_ts_driver);
 
-static const struct of_device_id stmpe_ts_ids[] = {
+static const struct of_device_id stmpe_ts_ids[] __maybe_unused = {
 	{ .compatible = "st,stmpe-ts", },
 	{ },
 };
-- 
2.39.2


