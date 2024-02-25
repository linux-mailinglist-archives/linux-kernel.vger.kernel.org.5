Return-Path: <linux-kernel+bounces-80117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A80B4862AE5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D091C20E04
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF48618EB3;
	Sun, 25 Feb 2024 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erGDqepY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1317B18AF9
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708873219; cv=none; b=Z5OZpKQWwI3rhEn1aISPh1ACqBcU4Eg2IOotQZo0/ljvmFIVGWxpzc5928dW/vze5D3cAp7e4zmWTlb8bdcvmbylts6TzXcI+lSm2iaZrTAD7LTqHIIIxG+EtaZg+EjKLCcL4F7CJW8P+Lv3I9rHzkj/aRwALyEhCQ4IYEb67pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708873219; c=relaxed/simple;
	bh=6CinCFKAoCYXsxW9O9gPEeiQ2N+cxWINRDgn5ZKO1nM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a5LGWkU8CrQbnmU2qsXa54bW+cmykD1r5blq2wO7ho0fA8mK/G73K+4XYGgwSo0gqCoI1L6/aXw7R7p12RYCJdoSJA40Rrd28vtAI6HvqylZsqPciGKhClT5H4OV7AeMwSk0hNAQjQT6l41QqpT/Kp/rD9x+zA90G0jHTiDApp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erGDqepY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DE1C433C7;
	Sun, 25 Feb 2024 15:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708873218;
	bh=6CinCFKAoCYXsxW9O9gPEeiQ2N+cxWINRDgn5ZKO1nM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=erGDqepYet+GW5jazTQFdXEALeq2frVJuSD+rZGWCfNqgoqJYHB5E4o9oEHhlH7SB
	 GyKU1MCNhcmOPIouzeF7t16U405hlv5LS3kKZ1S4tryQdsEcxlOdy3MibL98B/TZeH
	 r55dCIgAyaeuvkOiZrQWzVRw3TP4mGrCLx7TtaYG/44x0kgxuzbrHlVdUSi7DKpeiT
	 zPoAofK9W4PdFoHwsv++LDocbI1LbBYpUXmlV0DfjWkOHWKzm0p4+H6oiWdp2YqZN0
	 zcM9WZFdrg4OC/ylBS9l0Yi1GAwWz5LDWCX3tFPtUaQGzNXyq5sUSK5vWJbugC6ZZb
	 t29zq/lXtzwzg==
From: Mark Brown <broonie@kernel.org>
Date: Sun, 25 Feb 2024 14:59:33 +0000
Subject: [PATCH 7/8] regulator: mp8859: Report slew rate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240225-regulator-mp8859-v1-7-68ee2c839ded@kernel.org>
References: <20240225-regulator-mp8859-v1-0-68ee2c839ded@kernel.org>
In-Reply-To: <20240225-regulator-mp8859-v1-0-68ee2c839ded@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: linux-kernel@vger.kernel.org, Markus Reichl <m.reichl@fivetechno.de>, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1390; i=broonie@kernel.org;
 h=from:subject:message-id; bh=6CinCFKAoCYXsxW9O9gPEeiQ2N+cxWINRDgn5ZKO1nM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBl21XvplZ61zQIvdl7OTNyrlZRkxv916h7KIJ8t
 B8UxCxQ5cqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZdtV7wAKCRAk1otyXVSH
 0GMZB/0ZL8/Sbs+eXy7b577Yj4n4sf2ipLN+dKfrIu4xv72nJMeCdg27q+qeAzJFej2ZYa/Eurg
 /LJUAj0UxpasN1xnp5m+wEj7md3CklLYz+parUhjrEu/LGKWxW5969rIqvVKoz0/YtXTRR2hg/L
 Rl7rew0an36FOqTsrxLISQX/pMtQBD4xdg2scMLj11jnT4lSpHzYPGNnwcYmvXnY9JkNq6CQ4l4
 08b700GqIrrbWOvnBwttW9wWLqnk5NdArCTkmeJxXmSN6OibknJZebWTRC96woWXdVdI1sKY5Y/
 cKDhoDAkmBJeRpIaUnrDXc4W7QAM3LyUbOcfbspEotImDea4
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The MP8859 implements voltage changes at the rate of 1mV/us, tell the core
about this so that it can provide appropriate delays on voltage changes.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mp8859.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/regulator/mp8859.c b/drivers/regulator/mp8859.c
index fc1636d69bca..3e849e1a172f 100644
--- a/drivers/regulator/mp8859.c
+++ b/drivers/regulator/mp8859.c
@@ -81,6 +81,20 @@ static int mp8859_get_voltage_sel(struct regulator_dev *rdev)
 	return val;
 }
 
+static int mp8859_set_voltage_time_sel(struct regulator_dev *rdev,
+				       unsigned int from, unsigned int to)
+{
+	int change;
+
+	/* The voltage ramps at 1mV/uS, selectors are 10mV */
+	if (from > to)
+		change = from - to;
+	else
+		change = to - from;
+
+	return change * 10 * 1000;
+}
+
 static unsigned int mp8859_get_mode(struct regulator_dev *rdev)
 {
 	unsigned int val;
@@ -220,6 +234,7 @@ static const struct regulator_ops mp8859_ops = {
 	.set_voltage_sel = mp8859_set_voltage_sel,
 	.get_voltage_sel = mp8859_get_voltage_sel,
 	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_time_sel = mp8859_set_voltage_time_sel,
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,

-- 
2.39.2


