Return-Path: <linux-kernel+bounces-132713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84375899935
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04F40B22C72
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234B016132F;
	Fri,  5 Apr 2024 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="paqnmRra"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6894160865;
	Fri,  5 Apr 2024 09:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308490; cv=none; b=EC0hRuqdmT8v+a/ZSzxj+Q+aKrCFZRjJiqFk6wkamhMgV/fuKC930FNzthEOm1Gj+YeZvcnv8E3dBcfnuMQfRT8RvDx3v2fJGp7+qDLry1cMtA+JKL7hL2ltXPQu2/UZR/oU63xt/B7nVV5fAUKDWy4yahU6EBSbLIPFx+cZUhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308490; c=relaxed/simple;
	bh=ZMqVIjFWeS9JByaGYH19p6ZyKXKR2YqHtnuyDGzgYa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gAJoiXDcRiBW98GszY4VGg2qksHZSBv4hk6tGYrOGTrL+cDv7C/STZCoCLIqyuRgaApbddnvMSdfA8Q+b4cqV3f7LBnqF3vlWanQmGvOj6CFTaLyMLUgsIKwJXk7OC5rpDyaLosRs5xr8iXdRCRs4e9uV4oUY+XK0/LW/vxct8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=paqnmRra; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5BE15FAD;
	Fri,  5 Apr 2024 11:14:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712308444;
	bh=ZMqVIjFWeS9JByaGYH19p6ZyKXKR2YqHtnuyDGzgYa4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=paqnmRraCvQP7QFVnkhH9qjosBeqNcggn5jE5N2GjLNHwt2Hzk1abfNr3/tyEF8gV
	 g6OGVgs++JA6zMPJE3VHPPVAZx0rFFqXL2hloXcu1Dl7HsNV2oyJfV8gpHobDtqWGQ
	 8ThKvE4Wnh3gqoRc6euyHhfL3FbPLFOK6vfGOLgg=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 05 Apr 2024 12:14:22 +0300
Subject: [PATCH v2 4/9] media: subdev: Fix use of sd->enabled_streams in
 call_s_stream()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-enable-streams-impro-v2-4-22bca967665d@ideasonboard.com>
References: <20240405-enable-streams-impro-v2-0-22bca967665d@ideasonboard.com>
In-Reply-To: <20240405-enable-streams-impro-v2-0-22bca967665d@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2750;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=ZMqVIjFWeS9JByaGYH19p6ZyKXKR2YqHtnuyDGzgYa4=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmD8D+honWsD2rqWV8ABZrCFi72nE0kd47hVZCP
 V0dKyuTlxKJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZg/A/gAKCRD6PaqMvJYe
 9V+YD/wNdMHeKwnDckZw5TqzGGAYJopizPopdrXjHWqZ8sWhLcoeMR35PC0PiTbFelHnaS9NuOS
 NR0UGk9Wmxzwg4PQ7KBvbqSLEef+IHu2Od3QtzkbH4K0ZWYUGZgXTCnnyJq96DNGNu0aliyelgx
 I2yov8Jo24ZdbQp1z7GOO8NuqrSGgE6FUVw5iMtg7hls/QS4NVOqtK8p+ftrz0l5JTuJUIW5R6h
 GhH6spgr5mX7O5cZ6elMsxsOG02Hnbwy8e5ZN5C554b2BYaLxl/VHq82RTFOm+S7m5wIoGM329O
 4z6fK9tMgK+p5sbfUXPsCKnNCK6qxoPxgtHWn2Zf9D1ziQCTnkWnMwrJipKBMqji0kv9kulIkod
 n9t8pyfKmXP6SFIHar08p9CERZ0PQIM35s05IaxIUAH8XkVNwWcr66/x57qLpJ3hZWlCBylrGRO
 ape45BULV6PWxfKWcyQJpT5PH4VdoHPBicaygsKz2o4TkEsbSSTmvScSfcb+ju9QnOP5aHKN9YE
 Vyz1G5JKtQwNpubwmr/qQPPaIeF4h/UcyCCFrOZRNIBEU27DjYISfTz3jEO3g/F902ABqmgNMoA
 bODn/8ezno8RIPLRMJu5ugXeWYB4VQghOXm16jOwiKAcIGOi4r7FqmsD7kDEQt6wEarKWZfWijU
 GkEHfC0zym8fsig==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

call_s_stream() uses sd->enabled_streams to track whether streaming has
already been enabled. However,
v4l2_subdev_enable/disable_streams_fallback(), which was the original
user of this field, already uses it, and
v4l2_subdev_enable/disable_streams_fallback() will call call_s_stream().

This leads to a conflict as both functions set the field. Afaics, both
functions set the field to the same value, so it won't cause a runtime
bug, but it's still wrong and if we, e.g., change how
v4l2_subdev_enable/disable_streams_fallback() operates we might easily
cause bugs.

Fix this by adding a new field, 'streaming_enabled', for
call_s_stream().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 8 ++------
 include/media/v4l2-subdev.h           | 3 +++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index a15a41576918..94483b238f2a 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -421,12 +421,8 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
 	 * The .s_stream() operation must never be called to start or stop an
 	 * already started or stopped subdev. Catch offenders but don't return
 	 * an error yet to avoid regressions.
-	 *
-	 * As .s_stream() is mutually exclusive with the .enable_streams() and
-	 * .disable_streams() operation, we can use the enabled_streams field
-	 * to store the subdev streaming state.
 	 */
-	if (WARN_ON(!!sd->enabled_streams == !!enable))
+	if (WARN_ON(!!sd->streaming_enabled == !!enable))
 		return 0;
 
 	if (enable)
@@ -442,7 +438,7 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
 	}
 
 	if (!ret)
-		sd->enabled_streams = enable ? BIT(0) : 0;
+		sd->streaming_enabled = !!enable;
 
 	return ret;
 }
diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index a9e6b8146279..f55d03e0acc1 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -1043,6 +1043,8 @@ struct v4l2_subdev_platform_data {
  *		     v4l2_subdev_enable_streams() and
  *		     v4l2_subdev_disable_streams() helper functions for fallback
  *		     cases.
+ * @streaming_enabled: Tracks whether streaming has been enabled with s_stream.
+ *                     This is only for call_s_stream() internal use.
  *
  * Each instance of a subdev driver should create this struct, either
  * stand-alone or embedded in a larger struct.
@@ -1091,6 +1093,7 @@ struct v4l2_subdev {
 	 */
 	struct v4l2_subdev_state *active_state;
 	u64 enabled_streams;
+	bool streaming_enabled;
 };
 
 

-- 
2.34.1


