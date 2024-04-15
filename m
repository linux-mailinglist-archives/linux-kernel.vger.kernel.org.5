Return-Path: <linux-kernel+bounces-145119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 450EC8A4FCF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75FCA1C2100A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633AB83CDB;
	Mon, 15 Apr 2024 12:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="g9Kk6v8T"
Received: from outbound3.mail.transip.nl (outbound3.mail.transip.nl [136.144.136.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594BA82499;
	Mon, 15 Apr 2024 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185385; cv=none; b=bvNoi78MYtjPWf+f+3HWWoGjENUNIHkEQ3idFAtdp+Jyk3KUAPKl99czVgSHjn69ARDd+aBuODYCCtMbQUq7/sghV+hbEd7QlUQjuDIdbb03t4SqysL1m6wQMsCqXBk+P+rxAXNQPQ0Hprck0FUWrb+QrwsXlhMS+8bo6hzdYRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185385; c=relaxed/simple;
	bh=fFjr581oUCD76AtdkhZoA/GFCc0fkSuUuNYux/eLX9A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CZkww+ktSR9/Fo0EJCGO8AbbzDZBczEXWheC+VA277d2X3yloJVWMEQhVzenaCKCcCxHcgjy46uPNiDsyR534/nrwFamPGRDIGwDwAWXCQOLq0N8VUaZfusZjcmiTIF5u6V8dzwBl7TNNYI9JNhX2mmjKtNadP6KpHl8jC2VQsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=g9Kk6v8T; arc=none smtp.client-ip=136.144.136.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Received: from submission10.mail.transip.nl (unknown [10.103.8.161])
	by outbound3.mail.transip.nl (Postfix) with ESMTP id 4VJ6FF02FSzxPR7;
	Mon, 15 Apr 2024 14:39:45 +0200 (CEST)
Received: from herrie-desktop.. (110-31-146-85.ftth.glasoperator.nl [85.146.31.110])
	by submission10.mail.transip.nl (Postfix) with ESMTPA id 4VJ6FC6z7qz1gwbH;
	Mon, 15 Apr 2024 14:39:43 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: andersson@kernel.org
Cc: benwolsieffer@gmail.com,
	chris.chapuis@gmail.com,
	Herman van Hazendonk <github.com@herrie.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lee Jones <lee@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: pm8xxx: add support for PM8901
Date: Mon, 15 Apr 2024 14:39:41 +0200
Message-Id: <20240415123941.1527938-1-github.com@herrie.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission10.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1713184784; h=from:subject:to:cc:date:
 mime-version; bh=K3wyjMMG9BjGGWfB78VxA7BRtU3wFacG5xG7q2RWTnM=;
 b=g9Kk6v8TV0O5yzRAyyV7U10Tf4nClDK6+5z5HeYSqCLe8nMgrs3XngQXLJcXUzhes88+7T
 RApfCLBkufqfXKvZX1R/6Eq1gIMI0Oe1GXcZkZxQyffFllxuLae3SHyHJUkIDcvj2nJwqM
 O8XlYTh5wDELoK6lmI+pJ5uSc6K5n3kEw7peOLiGg4Qn1J2HSeX6X7vfAHUsGbrmAAEl1O
 McMDYkZn3g/CmW1iL478XQgEAXo6fSA1CDonSDAVROr8B6hcbb0MHiM08n7YZK4Ndp4Bxl
 hAaWwS2VcWMaD3+Bkq5491Ry/nT7PBtXeoQT/ieYQ3+nDs2VqCWaes09a2ToXg==
X-Report-Abuse-To: abuse@transip.nl

Add support for the pm8901 PMIC used by msm8660.

Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
---
 drivers/mfd/qcom-pm8xxx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
index 8b6285f687da..9cca14d54d8d 100644
--- a/drivers/mfd/qcom-pm8xxx.c
+++ b/drivers/mfd/qcom-pm8xxx.c
@@ -501,6 +501,7 @@ static const struct pm_irq_data pm8821_data = {
 static const struct of_device_id pm8xxx_id_table[] = {
 	{ .compatible = "qcom,pm8058", .data = &pm8xxx_data},
 	{ .compatible = "qcom,pm8821", .data = &pm8821_data},
+	{ .compatible = "qcom,pm8901", .data = &pm8xxx_data},
 	{ .compatible = "qcom,pm8921", .data = &pm8xxx_data},
 	{ }
 };

