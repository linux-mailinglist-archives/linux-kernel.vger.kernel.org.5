Return-Path: <linux-kernel+bounces-80112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 577E8862AE0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB421B212C7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708DD15E86;
	Sun, 25 Feb 2024 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPR3cbfP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83FE14AB0
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708873206; cv=none; b=OGD9COWXFdvOvHNvx7dIUs/TiXz+rks/ZsEN9GJIp0If8whbkhKRyn0ClMmgiKIny/2+Ws4/IFQh6M8WuYy7htPDCFDChlr+lvzEu9THz3eh3jBwWrqU3LNxHr3YRsyO4bI92oSVv5UVNd4wH5+gPL7flp5hBeXfRwywxAK7OYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708873206; c=relaxed/simple;
	bh=Ri9GKojig0WR0PPAwktljb2h7Sk6O8o1TjFabHp87bo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mrF/MxIuFNf/2VaCom2DDZa+84YdKm9nqzL0yntVKeUTbpo5Ox277H1CJq+1muFf2XtZUWF/Laoe4W/jwHqkBJ4ObdnSp/kWhF3V/Q22z8KB5b+h72Thid9IxaN27qHCWrsIG6Tj55IDqgJ7U6gKscBjRQ+coM//jdjfjuWo7aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPR3cbfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3111BC43399;
	Sun, 25 Feb 2024 15:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708873206;
	bh=Ri9GKojig0WR0PPAwktljb2h7Sk6O8o1TjFabHp87bo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NPR3cbfP+76KmJERadOEk+QKYOrTEWk9gSnnBAyh1Z1gvfp2Kn4LXtYZEAIwwqDgb
	 PCcgfBoH9e7j5ltotjnESPIthvdJviVssgG7DeeX/mkw0ERZJuUtJKKQrGpmDxonNy
	 vgXWr7F94sYRHzRPBCOyQrAMYTesb9MepBJ8ukWIwSpKin3/HoxySarJUM2QDdb1Je
	 eTm2RUsv8jf7bbv7f6USZILggvEpVSekMGh4paczf7oHKRaYZ4vJVu7gWn5euqtI0j
	 lf9f8+gPWLB91KDHnKyzd+DEAAErR5WtlDAMPZxhbOfZbnODh+1plMw0y9ax46r08w
	 HXZvVnvlNE3bg==
From: Mark Brown <broonie@kernel.org>
Date: Sun, 25 Feb 2024 14:59:28 +0000
Subject: [PATCH 2/8] regulator: mp8859: Validate and log device identifier
 information
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240225-regulator-mp8859-v1-2-68ee2c839ded@kernel.org>
References: <20240225-regulator-mp8859-v1-0-68ee2c839ded@kernel.org>
In-Reply-To: <20240225-regulator-mp8859-v1-0-68ee2c839ded@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: linux-kernel@vger.kernel.org, Markus Reichl <m.reichl@fivetechno.de>, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1922; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Ri9GKojig0WR0PPAwktljb2h7Sk6O8o1TjFabHp87bo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBl21Xr4gN+ow5UDiTTVaGdF6dFFmdf9eEQ4delN
 A5Aej/FzU6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZdtV6wAKCRAk1otyXVSH
 0HDhB/4pt/EWEl8hjTqqKYOtmgG1eQP8VyvSnhdYafgFuvD6w5w6X6f8cTklfD3emSXtTuVYacK
 Il6A5q58KG71/eP/9zP4AMYXLSgzOb4i1foEZUo03hgPwaDeafdTBE046+JZXoGVXfpM0acLp7A
 3DMpvLAeRU+g1cWJAcbZV68/RIdh1V9Zzz/Ri8iEHXnru1TTOsBVG/MRJfqSysHASzfAGbr0JG9
 njfpMJvPStMlhz3pYHb7SE11W24qMw1Gr05/iZ4jm61Qf/ye9YVC1cZv+kvddckTqlUNHkjKafT
 Og0svaJIp+iCHqBasWrpbFlCOdMgx6Aohf9Pvh2h7JCGI1F+
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Ensure that we are talking to a device which reports the expected ID
register information and log the OTP and revision information for
diagnostic purposes.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mp8859.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/regulator/mp8859.c b/drivers/regulator/mp8859.c
index 689b56680d93..b07bc63a25cb 100644
--- a/drivers/regulator/mp8859.c
+++ b/drivers/regulator/mp8859.c
@@ -147,12 +147,46 @@ static int mp8859_i2c_probe(struct i2c_client *i2c)
 	struct regulator_config config = {.dev = &i2c->dev};
 	struct regmap *regmap = devm_regmap_init_i2c(i2c, &mp8859_regmap);
 	struct regulator_dev *rdev;
+	unsigned int val, rev;
 
 	if (IS_ERR(regmap)) {
 		ret = PTR_ERR(regmap);
 		dev_err(&i2c->dev, "regmap init failed: %d\n", ret);
 		return ret;
 	}
+
+	ret = regmap_read(regmap, MP8859_MFR_ID_REG, &val);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to read manufacturer ID: %d\n", ret);
+		return ret;
+	}
+	if (val != 0x9) {
+		dev_err(&i2c->dev, "Manufacturer ID %x != 9\n", val);
+		return -EINVAL;
+	}
+
+	ret = regmap_read(regmap, MP8859_DEV_ID_REG, &val);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to read device ID: %d\n", ret);
+		return ret;
+	}
+	if (val != 0x58) {
+		dev_err(&i2c->dev, "Manufacturer ID %x != 0x58\n", val);
+		return -EINVAL;
+	}
+
+	ret = regmap_read(regmap, MP8859_IC_REV_REG, &rev);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to read device revision: %d\n", ret);
+		return ret;
+	}
+	ret = regmap_read(regmap, MP8859_ID1_REG, &val);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to read device ID1: %d\n", ret);
+		return ret;
+	}
+	dev_info(&i2c->dev, "MP8859-%04d revision %d\n", val, rev);
+
 	rdev = devm_regulator_register(&i2c->dev, &mp8859_regulators[0],
 					&config);
 

-- 
2.39.2


