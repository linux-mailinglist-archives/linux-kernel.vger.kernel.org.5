Return-Path: <linux-kernel+bounces-138463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4992889F193
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0721C2270D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C66C15DBA9;
	Wed, 10 Apr 2024 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYY9z9jc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD7C15D5CE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712750330; cv=none; b=RcFWbliOlLvyetuLEOpgKET+kr59BwBfjtaMpQM1PYP64ITqyIuC+FSHRhdo4b842g/xZRvBqKslVS9Rl35rj2YrB75YdY14axwynW8/Wbh+5k2ncSjWhv0v7g1ATMkRDWt6tPBO2qQvreKctRWKnzM0tkDf4LfNRPB8qsdjQQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712750330; c=relaxed/simple;
	bh=rZ17Zq2r5GglmuwlVZDKvybg4wn7yP4nbMxcY1IRFwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SjufJ2FgxBURPdB2sr0OqcNO2DOZTOtaWfP/ULrYrFwc/HbEQ33CfW04c/UzAKTF4laHhvOuqoO7jGQLkddDSaPLBdwfP+CYNjKXTF9lyBj92bAn7JjsJOLitrPoKHSYTamfXroR0Ot239VD0oM75Dvca8JAjWOekx1fWjLSRIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYY9z9jc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6690C433F1;
	Wed, 10 Apr 2024 11:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712750330;
	bh=rZ17Zq2r5GglmuwlVZDKvybg4wn7yP4nbMxcY1IRFwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sYY9z9jcmEO9tTdM8vBgKwQv8FfuqM0s1bASlPyB8S1nbwPNs2+QMU+gpzIG9K6HC
	 2Yoei5a+E1SBFZ78y6zTcN+ITA/9bl3K7XxPYKRIZPiPFLDy5XUdAcsbVC3anuBBXw
	 g+NR7hD89euUY0/BntKr9OWjSxjn+LOXKXrGj4nLuS5k0jwUFfjQgUesO6PDRxxphQ
	 a8d5GUkxpVC3ipWpreiUrRUym9Jy5U+L6vpZe8L1vdrFfWijsvtTsVC8EPlFaC+KZn
	 PYkDjpWxomEjg3pTnTXGrWq+w6PRuP+vBqEBohOHO9X1C0fdWdpNE21WkD0De6eez0
	 gLWvdA17qTVsA==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Cyril Jean <cyril.jean@microchip.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] firmware: microchip: use scope-based cleanup where possible
Date: Wed, 10 Apr 2024 12:58:08 +0100
Message-ID: <20240410-glory-patriot-2d7c7876dcfe@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410-opulently-epic-8654bdac3422@spud>
References: <20240410-opulently-epic-8654bdac3422@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3938; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=0WayOjS6Zyrbw3ItGJG9W3xsEKlmQEnuZ+2GI5oj4yg=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGlidVfT0uZ3P5i5Me39ZkGnq/U8rSpnHH9HVxjqTKkLK 7zx2Uq0o5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABNxWsHw36v1/Jo7G90V2U+6 XHXk051U6pXF8euz5hb5F0tnHBa5uZqRYefGd3/F2VQYhazl7R5/sHtbK/RP70suW5PTuW4JC3F ndgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

There's a bunch of structs created and freed every time the mailbox is
used. Move them to use the scope-based cleanup infrastructure to avoid
manually tearing them down. mpfs_auto_update_available() didn't free the
memory that it used (albeit it allocated exactly once during probe) so
that gets moved over too.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/firmware/microchip/mpfs-auto-update.c | 59 +++++--------------
 1 file changed, 16 insertions(+), 43 deletions(-)

diff --git a/drivers/firmware/microchip/mpfs-auto-update.c b/drivers/firmware/microchip/mpfs-auto-update.c
index d7ce27f4ba1b..30de47895b1c 100644
--- a/drivers/firmware/microchip/mpfs-auto-update.c
+++ b/drivers/firmware/microchip/mpfs-auto-update.c
@@ -175,28 +175,17 @@ static enum fw_upload_err mpfs_auto_update_poll_complete(struct fw_upload *fw_up
 static int mpfs_auto_update_verify_image(struct fw_upload *fw_uploader)
 {
 	struct mpfs_auto_update_priv *priv = fw_uploader->dd_handle;
-	struct mpfs_mss_response *response;
-	struct mpfs_mss_msg *message;
-	u32 *response_msg;
+	u32 *response_msg __free(kfree) =
+		kzalloc(AUTO_UPDATE_FEATURE_RESP_SIZE * sizeof(*response_msg), GFP_KERNEL);
+	struct mpfs_mss_response *response __free(kfree) =
+		kzalloc(sizeof(struct mpfs_mss_response), GFP_KERNEL);
+	struct mpfs_mss_msg *message __free(kfree) =
+		kzalloc(sizeof(struct mpfs_mss_msg), GFP_KERNEL);
 	int ret;
 
-	response_msg = devm_kzalloc(priv->dev, AUTO_UPDATE_FEATURE_RESP_SIZE * sizeof(response_msg),
-				    GFP_KERNEL);
-	if (!response_msg)
+	if (!response_msg || !response || !message)
 		return -ENOMEM;
 
-	response = devm_kzalloc(priv->dev, sizeof(struct mpfs_mss_response), GFP_KERNEL);
-	if (!response) {
-		ret = -ENOMEM;
-		goto free_response_msg;
-	}
-
-	message = devm_kzalloc(priv->dev, sizeof(struct mpfs_mss_msg), GFP_KERNEL);
-	if (!message) {
-		ret = -ENOMEM;
-		goto free_response;
-	}
-
 	/*
 	 * The system controller can verify that an image in the flash is valid.
 	 * Rather than duplicate the check in this driver, call the relevant
@@ -218,20 +207,12 @@ static int mpfs_auto_update_verify_image(struct fw_upload *fw_uploader)
 	ret = mpfs_blocking_transaction(priv->sys_controller, message);
 	if (ret | response->resp_status) {
 		dev_warn(priv->dev, "Verification of Upgrade Image failed!\n");
-		ret = ret ? ret : -EBADMSG;
-		goto free_message;
+		return ret ? ret : -EBADMSG;
 	}
 
 	dev_info(priv->dev, "Verification of Upgrade Image passed!\n");
 
-free_message:
-	devm_kfree(priv->dev, message);
-free_response:
-	devm_kfree(priv->dev, response);
-free_response_msg:
-	devm_kfree(priv->dev, response_msg);
-
-	return ret;
+	return 0;
 }
 
 static int mpfs_auto_update_set_image_address(struct mpfs_auto_update_priv *priv,
@@ -406,23 +387,15 @@ static const struct fw_upload_ops mpfs_auto_update_ops = {
 
 static int mpfs_auto_update_available(struct mpfs_auto_update_priv *priv)
 {
-	struct mpfs_mss_response *response;
-	struct mpfs_mss_msg *message;
-	u32 *response_msg;
+	u32 *response_msg __free(kfree) =
+		kzalloc(AUTO_UPDATE_FEATURE_RESP_SIZE * sizeof(*response_msg), GFP_KERNEL);
+	struct mpfs_mss_response *response __free(kfree) =
+		kzalloc(sizeof(struct mpfs_mss_response), GFP_KERNEL);
+	struct mpfs_mss_msg *message __free(kfree) =
+		kzalloc(sizeof(struct mpfs_mss_msg), GFP_KERNEL);
 	int ret;
 
-	response_msg = devm_kzalloc(priv->dev,
-				    AUTO_UPDATE_FEATURE_RESP_SIZE * sizeof(*response_msg),
-				    GFP_KERNEL);
-	if (!response_msg)
-		return -ENOMEM;
-
-	response = devm_kzalloc(priv->dev, sizeof(struct mpfs_mss_response), GFP_KERNEL);
-	if (!response)
-		return -ENOMEM;
-
-	message = devm_kzalloc(priv->dev, sizeof(struct mpfs_mss_msg), GFP_KERNEL);
-	if (!message)
+	if (!response_msg || !response || !message)
 		return -ENOMEM;
 
 	/*
-- 
2.43.0


