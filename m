Return-Path: <linux-kernel+bounces-73296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 466C985C094
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845A02860E2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C3F77F2C;
	Tue, 20 Feb 2024 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBoVchCP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777BF779F8
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444909; cv=none; b=YX7lnyPHofkoJVCrBlxOGJJnQ9sWu38dALj8pBNy18WRZQ+Kf2zCsoHfMNkAIwvHJKFJpxO7eCvCgj6O/BE7rS4rgzImAWIUJO0tbumSQXspN5OCV+wLqlG0pgFy39dbX9TfEWhzt+JuznyKxyF4lh102XeHYp5CcJExAC+o4YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444909; c=relaxed/simple;
	bh=k9i5CDXCj2jRiO0gg1dwwa6YKSVNtiS35vfagBcjp8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h1FA/8xSVopxYXCGDZof7D+ACIWZeNPdDW5Q/ZCpqJIgihelTPYILh/cQc48Q2yEdWXORU24dnSl+L+6JFnxP0+g5W/6FgoEffh3W3AMyDqDbNzQQ9vILmXonqmYavVG7ClLxHkxmX3jg0iuVQusVHhaXFthUBUgQjm6YdU3uvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBoVchCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A9AC43609;
	Tue, 20 Feb 2024 16:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708444909;
	bh=k9i5CDXCj2jRiO0gg1dwwa6YKSVNtiS35vfagBcjp8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JBoVchCP4MT6g4IfPN3bwyot5hifA7r5ccdXoHkhwBFTpB9P2oDIElVyJIWtADYHh
	 35X/e3UzPDJK+OrY0YJFkUBlYMvvxMKWpXplfMTZP4smcUaHVxiIMle0uD+uod513a
	 HliA1XITBmBfh2Py7PfczK3TPTcIruohxXqoFiyJ1IrFSLSrd223DJCUfWEzQS+Szd
	 yFIrOL6SBq/1aEWViZYzKFY1ge2/jmfq+qFC8ZeVLFkKZKDf72YiNGUP3nQ+Ivqc7F
	 yfQnIpLqeIaWIwbPvETHhOTzw0Wd9hhIrcnbwRkDE+AFyw2746NzfXuHmLrSVVAMNs
	 pkyT6jlQpZlyA==
From: Oded Gabbay <ogabbay@kernel.org>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 10/13] accel/habanalabs/hwmon: rate limit errors user can generate
Date: Tue, 20 Feb 2024 18:01:26 +0200
Message-Id: <20240220160129.909714-10-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220160129.909714-1-ogabbay@kernel.org>
References: <20240220160129.909714-1-ogabbay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ofir Bitton <obitton@habana.ai>

Fetching sensor data can fail due to various reasons. In order
not to pollute the kernel log, those error prints must be
rate limited.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/hwmon.c | 29 +++++++++++++------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/accel/habanalabs/common/hwmon.c b/drivers/accel/habanalabs/common/hwmon.c
index 1ee2ee07e9ed..36b951b5f503 100644
--- a/drivers/accel/habanalabs/common/hwmon.c
+++ b/drivers/accel/habanalabs/common/hwmon.c
@@ -46,7 +46,7 @@ static u32 fixup_flags_legacy_fw(struct hl_device *hdev, enum hwmon_sensor_types
 		break;
 
 	default:
-		dev_err(hdev->dev, "unsupported h/w sensor type %d\n", type);
+		dev_err_ratelimited(hdev->dev, "unsupported h/w sensor type %d\n", type);
 		flags = cpucp_flags;
 		break;
 	}
@@ -134,7 +134,7 @@ static u32 adjust_hwmon_flags(struct hl_device *hdev, enum hwmon_sensor_types ty
 			break;
 
 		default:
-			dev_err(hdev->dev, "unsupported h/w sensor type %d\n", type);
+			dev_err_ratelimited(hdev->dev, "unsupported h/w sensor type %d\n", type);
 			flags = cpucp_flags;
 			break;
 		}
@@ -162,7 +162,8 @@ int hl_build_hwmon_channel_info(struct hl_device *hdev, struct cpucp_sensor *sen
 			break;
 
 		if (type >= HWMON_NR_SENSOR_TYPES) {
-			dev_err(hdev->dev, "Got wrong sensor type %d from device\n", type);
+			dev_err_ratelimited(hdev->dev,
+				"Got wrong sensor type %d from device\n", type);
 			return -EINVAL;
 		}
 
@@ -584,7 +585,7 @@ int hl_get_temperature(struct hl_device *hdev,
 	*value = (long) result;
 
 	if (rc) {
-		dev_err(hdev->dev,
+		dev_err_ratelimited(hdev->dev,
 			"Failed to get temperature from sensor %d, error %d\n",
 			sensor_index, rc);
 		*value = 0;
@@ -611,7 +612,7 @@ int hl_set_temperature(struct hl_device *hdev,
 						0, NULL);
 
 	if (rc)
-		dev_err(hdev->dev,
+		dev_err_ratelimited(hdev->dev,
 			"Failed to set temperature of sensor %d, error %d\n",
 			sensor_index, rc);
 
@@ -638,7 +639,7 @@ int hl_get_voltage(struct hl_device *hdev,
 	*value = (long) result;
 
 	if (rc) {
-		dev_err(hdev->dev,
+		dev_err_ratelimited(hdev->dev,
 			"Failed to get voltage from sensor %d, error %d\n",
 			sensor_index, rc);
 		*value = 0;
@@ -667,7 +668,7 @@ int hl_get_current(struct hl_device *hdev,
 	*value = (long) result;
 
 	if (rc) {
-		dev_err(hdev->dev,
+		dev_err_ratelimited(hdev->dev,
 			"Failed to get current from sensor %d, error %d\n",
 			sensor_index, rc);
 		*value = 0;
@@ -696,7 +697,7 @@ int hl_get_fan_speed(struct hl_device *hdev,
 	*value = (long) result;
 
 	if (rc) {
-		dev_err(hdev->dev,
+		dev_err_ratelimited(hdev->dev,
 			"Failed to get fan speed from sensor %d, error %d\n",
 			sensor_index, rc);
 		*value = 0;
@@ -725,7 +726,7 @@ int hl_get_pwm_info(struct hl_device *hdev,
 	*value = (long) result;
 
 	if (rc) {
-		dev_err(hdev->dev,
+		dev_err_ratelimited(hdev->dev,
 			"Failed to get pwm info from sensor %d, error %d\n",
 			sensor_index, rc);
 		*value = 0;
@@ -752,7 +753,7 @@ void hl_set_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr,
 						0, NULL);
 
 	if (rc)
-		dev_err(hdev->dev,
+		dev_err_ratelimited(hdev->dev,
 			"Failed to set pwm info to sensor %d, error %d\n",
 			sensor_index, rc);
 }
@@ -775,7 +776,7 @@ int hl_set_voltage(struct hl_device *hdev,
 						0, NULL);
 
 	if (rc)
-		dev_err(hdev->dev,
+		dev_err_ratelimited(hdev->dev,
 			"Failed to set voltage of sensor %d, error %d\n",
 			sensor_index, rc);
 
@@ -800,7 +801,7 @@ int hl_set_current(struct hl_device *hdev,
 						0, NULL);
 
 	if (rc)
-		dev_err(hdev->dev,
+		dev_err_ratelimited(hdev->dev,
 			"Failed to set current of sensor %d, error %d\n",
 			sensor_index, rc);
 
@@ -831,7 +832,7 @@ int hl_set_power(struct hl_device *hdev,
 						0, NULL);
 
 	if (rc)
-		dev_err(hdev->dev,
+		dev_err_ratelimited(hdev->dev,
 			"Failed to set power of sensor %d, error %d\n",
 			sensor_index, rc);
 
@@ -858,7 +859,7 @@ int hl_get_power(struct hl_device *hdev,
 	*value = (long) result;
 
 	if (rc) {
-		dev_err(hdev->dev,
+		dev_err_ratelimited(hdev->dev,
 			"Failed to get power of sensor %d, error %d\n",
 			sensor_index, rc);
 		*value = 0;
-- 
2.34.1


