Return-Path: <linux-kernel+bounces-63299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F56852D67
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2088928D6CA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF2C225D2;
	Tue, 13 Feb 2024 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7OXrFkF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6D8225AD;
	Tue, 13 Feb 2024 10:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818564; cv=none; b=NJTKzv7bbpBuPFOgrgkEsD9zwORTnSG6P5mfBc4umbHkabMGo7U97MOTMWpL1nVLaOgd1nd6OnaHFUAEHEsLOyQslS7gb5uJLD7COmygMUqruft86u+/ipvB+7gi3lS0sW4WRcju11nwOMSWFcKZcQCaoiyBBMzxlaxlfIgEZMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818564; c=relaxed/simple;
	bh=PoqpGDtl2PNN6stViwRE7OniT1lnZ+4h8gX5yvog+rE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GOaCmLFaoeeXTz0ROpv1S10LY06iadSt3BjM3yCM1tbkJepUpntSSG0kpG2qFuYgAmeLQ6rbvldXdVffBFsG12Uq17UlUD79uwcBcTwLaMWJEznucRXn2a/FEVae3ohSSCJ1sSM3alzmclgDgA6Ok6xHJ85wnTxs+qFUFxbW/tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7OXrFkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B67C433F1;
	Tue, 13 Feb 2024 10:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707818563;
	bh=PoqpGDtl2PNN6stViwRE7OniT1lnZ+4h8gX5yvog+rE=;
	h=From:To:Cc:Subject:Date:From;
	b=S7OXrFkFbOzm1aNy2U+MLDP9ayyBBmRGmQfSVM8f1Tif1Y8g9elXuZPfh2PUVEYwY
	 BjYNxTJZe0dHRrM9RKHACdg6U6p+cds+ENiAkUyGzmgrlMv6DKThg4eC83XSXtC1Lh
	 LK0IEdGdtyFc3PpyhG29mXS0z45PYM7eO6gi1x9QLgHvYDNc0WYtJIX4WG4XSb+t1s
	 Iyzn8gQ+Tm8dk9GKE+yHB40cV50q2wFDw+oF0gxTJvvACP+ZYaymwxiObS6XYUV+0U
	 YjfnWengG31dmMXad3PNOu1ituvRuWAOr8lwXFTItyePpDRSWHF7L0Rfru14aWT6kt
	 1SKHmmbDTdmeQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Jean Delvare <jdelvare@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] firmware: dmi-id: add a release callback function
Date: Tue, 13 Feb 2024 11:02:17 +0100
Message-Id: <20240213100238.456912-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

dmi_class uses kfree() as the .release function, but that now causes
a warning with clang-16 as it violates control flow integrity (KCFI)
rules:

drivers/firmware/dmi-id.c:174:17: error: cast from 'void (*)(const void *)' to 'void (*)(struct device *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  174 |         .dev_release = (void(*)(struct device *)) kfree,

Add an explicit function to call kfree() instead.

Fixes: 4f5c791a850e ("DMI-based module autoloading")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/firmware/dmi-id.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/dmi-id.c b/drivers/firmware/dmi-id.c
index 5f3a3e913d28..d19c78a78ae3 100644
--- a/drivers/firmware/dmi-id.c
+++ b/drivers/firmware/dmi-id.c
@@ -169,9 +169,14 @@ static int dmi_dev_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
+static void dmi_dev_release(struct device *dev)
+{
+	kfree(dev);
+}
+
 static struct class dmi_class = {
 	.name = "dmi",
-	.dev_release = (void(*)(struct device *)) kfree,
+	.dev_release = dmi_dev_release,
 	.dev_uevent = dmi_dev_uevent,
 };
 
-- 
2.39.2


