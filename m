Return-Path: <linux-kernel+bounces-146920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B17F8A6CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0541C21FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EA712F58D;
	Tue, 16 Apr 2024 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NIliTIPH"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0973812E1E8;
	Tue, 16 Apr 2024 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275734; cv=none; b=WXPBBw9lBohW5Ve7F2FtprzgtSQn1a0QM2yTzoaRfPfe5OQjTOpCfP65hjGKMvw6/K7OTmP+p1yqKdjlYH5b6dRiNyKgn6azz464Dx/1ydb1zAcTY++NnINgq/nkEhE4KePGSHNQ0NBBrf8OKAL/DgsRuk6RuoOkvW6KBb8KX+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275734; c=relaxed/simple;
	bh=NLCsfA0/1jawAaRZjCj1kEooc2FTLF/KVL46Xk47Xt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tFIQCDqsbWuXNTXhshyS+GKN4aneCPF4itANO5kjzsSL8pYxjK3mbi53JnFPIrLEk60m+3i52pJXv8wSZuRBV7yp5c/rl8r/L1uG5cvF/ZCRxzKMZ7aUpSQSI7vgvggEC4U27SqqXzHT8Oga1zpwj/9fJTPRfLiaYLtL7a7KiO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=NIliTIPH; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B94B816F9;
	Tue, 16 Apr 2024 15:54:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713275681;
	bh=NLCsfA0/1jawAaRZjCj1kEooc2FTLF/KVL46Xk47Xt8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NIliTIPHes8MtlEHA7MhxC/kbzLqeotcrlS/UpASA92zhUy5AEflrwkfbhez47njI
	 JkXAdm9QuMbtKgC1jZRs8UVichTyM0QaLBgEbhJEaUDf6Zx/d7q859hpB4G9YfTZE4
	 6dKirAwGOB35qfoowZJ1hjko66c7QumoWU5ZF7co=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 16 Apr 2024 16:55:07 +0300
Subject: [PATCH v5 04/10] media: subdev: Fix use of sd->enabled_streams in
 call_s_stream()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-enable-streams-impro-v5-4-bd5fcea49388@ideasonboard.com>
References: <20240416-enable-streams-impro-v5-0-bd5fcea49388@ideasonboard.com>
In-Reply-To: <20240416-enable-streams-impro-v5-0-bd5fcea49388@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2934;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=NLCsfA0/1jawAaRZjCj1kEooc2FTLF/KVL46Xk47Xt8=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmHoNJNCTMlYddG5HW+h+gJCRYhx/YapiwhSX+f
 2LzF5knjCqJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZh6DSQAKCRD6PaqMvJYe
 9c4AEACa/1vIyHsGoKDXKTgNCbqDiOuIZ3qlHOHdCDyncQR7A8pmIci5VkATKGr4shdoaY6ASnj
 4mjubq5RoQJlEAEJ1ZdtT3dcq1pFety2bHA5Yn2AO+5VnDhA+YXpPy2xbcwlQ+yeyN3QES7qFhg
 328srCay8+GbqjYLKXJ+sFA720dyU/9MWJM0EBtoKNLYpJ/ouXdNz3HjHMcdKIhKW+HY18+edbK
 oVapeyrtSzGwh5AFAm+Ed5WPfKu7/TY7up0ognDjBIi87nHyb8fPyCch50GOMoxMVN3oECRCESX
 yEpPzWNLJQpUSnSDjpjdJ70suVrsjcjCB3f0iaTOEi/KZx8ejDqQTEA/3E5rdHPimXgWJM6u4xK
 1xm+Sv/Dz4beLTkCBA5XHpSgRQYdkSWtr+XQUG/fCJ1Jqv5PGETXkFkZ2/H6D14dUA3DqJ+FZed
 JlPRlfPXBhMJsqpsZlweDCF0hcxNYCWP1z+rU6Unjm4Mx/vhYPv7uh+flPsgE191YqLyMNqd1C1
 17QQ423ETYZ1hWK2nHGYMouNXpvkyrgtmhhNkCNZkj4wr+EVhmpWv2wCppHtTSuH2IBxeIQ9B+7
 09KOZiv9ylMcA45LP0qhZF8UfXgY53FnEYHxmT82zOBoc4xmBVFWyGh0OfxcDZqnD5WWup2ADsF
 SELiu9xCnrrfcRA==
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

Fix this by adding a new field, 's_stream_enabled', for
call_s_stream().

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 8 ++------
 include/media/v4l2-subdev.h           | 3 +++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 606a909cd778..941cf7be22c3 100644
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
+	if (WARN_ON(sd->s_stream_enabled == !!enable))
 		return 0;
 
 	ret = sd->ops->video->s_stream(sd, enable);
@@ -437,7 +433,7 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
 	}
 
 	if (!ret) {
-		sd->enabled_streams = enable ? BIT(0) : 0;
+		sd->s_stream_enabled = enable;
 
 		if (enable)
 			v4l2_subdev_enable_privacy_led(sd);
diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index a9e6b8146279..b3c3777db464 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -1043,6 +1043,8 @@ struct v4l2_subdev_platform_data {
  *		     v4l2_subdev_enable_streams() and
  *		     v4l2_subdev_disable_streams() helper functions for fallback
  *		     cases.
+ * @s_stream_enabled: Tracks whether streaming has been enabled with s_stream.
+ *                    This is only for call_s_stream() internal use.
  *
  * Each instance of a subdev driver should create this struct, either
  * stand-alone or embedded in a larger struct.
@@ -1091,6 +1093,7 @@ struct v4l2_subdev {
 	 */
 	struct v4l2_subdev_state *active_state;
 	u64 enabled_streams;
+	bool s_stream_enabled;
 };
 
 

-- 
2.34.1


