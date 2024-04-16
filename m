Return-Path: <linux-kernel+bounces-146648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5CE8A68C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B661F214E2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1C612AAF6;
	Tue, 16 Apr 2024 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="XijPJ+Vf"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BACD12A17B;
	Tue, 16 Apr 2024 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264041; cv=none; b=dhBgxxSdh4vaPW21oU1aY3jIQXCuJI4589YuyAE5JnZAcwT4+P//2yTs8W0hifHnI6u0/sUjcaM4tNBP0vqvgQiw4UdDKMhj9Kb2SmghV8ul7wKnhNlUBoj69TrSe2EWKUz3qSz4ojdCLLLuqz8YRyHJeWhH6B7LgZWStaWJ6bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264041; c=relaxed/simple;
	bh=NLCsfA0/1jawAaRZjCj1kEooc2FTLF/KVL46Xk47Xt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=thF9Eods3zw7q/Nd783zNmLhVQge3v6CLKJhZHf4qtIn5BZSi9KVBGvnSCVHt3ydlX7hMZyDy8NEqdOO4A9w/ToDk8kVWsHHy7YZJQ2z22xh2vpfscn3w4q5ygTJmobxcKiwehz2kVHmSqsgmmQTnNO3hLOBovpBiOIVmjia5To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=XijPJ+Vf; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0BDE5E0C;
	Tue, 16 Apr 2024 12:39:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713263988;
	bh=NLCsfA0/1jawAaRZjCj1kEooc2FTLF/KVL46Xk47Xt8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XijPJ+Vf+Vi4TJRN730/BSACDzhIO4yI1f02r31bBGO2M+2d48bFB6mp7RGBzU0fG
	 YhSi62w8UEgk4EfMUjr3ddvwsucuazE9C0w6o7y9XeYa2j4EN8U8aZdJt7G/Hp1xqM
	 2jLuhH6xz/XEMgQUHbZB0uC4FQu3wektagcFW55U=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 16 Apr 2024 13:40:03 +0300
Subject: [PATCH v4 04/10] media: subdev: Fix use of sd->enabled_streams in
 call_s_stream()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-enable-streams-impro-v4-4-1d370c9c2b6d@ideasonboard.com>
References: <20240416-enable-streams-impro-v4-0-1d370c9c2b6d@ideasonboard.com>
In-Reply-To: <20240416-enable-streams-impro-v4-0-1d370c9c2b6d@ideasonboard.com>
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
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmHlWdCVINE/MGQEgrvq115qaGw8B4C4LcnMpC/
 hNsw88UC8KJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZh5VnQAKCRD6PaqMvJYe
 9d5gD/4wFR12lEGv7sSZhHI8F4kotv+d3sQ+9Bsn5ddMy/Hjf7ET8FWDLUonzGRC1gzlIdfzQ7f
 vcrpNPKnu0irrKHvzItbvVSLwlL9vCN/CYlMbt6b/epQ3leGlpN7npX1DWlf9NBC4we7K3B9yzR
 6LPLwWv0deO2oGoIX87Ffr786QMApeXOXx0vjLgifFZ5yLxkNvRtabPMGgh+3b+0rueC6WmDFaK
 G1EsSxelv7Im1/SHkSuNHR0OzySp41iNgWgfMZ6tEPDO5/RPxWQZhrIXnXU9iPJKBDzbZFbQ9Hn
 2gPm1Djm6hxoDIkR+x0rP+HL4L7zS3RjoYC74FNHKalnVIr1popuoEtqXwCWSe32upAc2JaHGCx
 Z15YjKK4v6cGt2kctPse5p9Xs/BVZY9k29uekvU0e1tiw4fpHMv/c++T0zh9ZhmbJtvDnw8DCiA
 D/VPYpLP/KGrsxodFr19WKuxWO3W2sGInM29/WxsaNKbE/qrhXYU9Je3KL7oig2dGup8jKDLJmu
 650rYZJPHh9Dv1BztBIa1wYYu0X/DTuI4BXw9DrNjTcZQ+feRhgbzB5BYyTvs5C4Wb7nA85lfT+
 IQjkrjNVn3ZK6kaf21mcGKkugC4Q5xDDrrjT5yLNqBtPW0/1GRwg3iXTxPAdwwIFHi55gQZYlci
 1Sb/ygA/BsIe7VA==
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


