Return-Path: <linux-kernel+bounces-157220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB578B0EC3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6F928F129
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCDC168AF1;
	Wed, 24 Apr 2024 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NphYIdd6"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B3D161321;
	Wed, 24 Apr 2024 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973186; cv=none; b=L6Fp2BA7zQXRK9TsltFQkmyJsJBj1VtQAmLCqZ38pqrGWXglVsalaSgYRoiJKmjOAHx0/bF38c4UnoOjukbD9ZL09dwLPe4zE0Cbbo+vfXJCGuOC8eqjP9P5Mn91lxC3CA+gpNmkjKuZ2Wnlgr+fEAfeleYEs0SJvyN06wfiJVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973186; c=relaxed/simple;
	bh=1/kHOf5FrW6WAf4IYNC9B2o8lBngcUMkOHJ0ykXalqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C5CoaRLsR+PFSg9siTCHJrT97RPLPgK03tlCit0c735Tj5vPemAtykkUJEVqhCCaJq13RoMvvfl3kc/IYnB45pXZr7nF1jN856YFEXBoHq+eLMkZ+BtpNgsPSvo1cVXkHKGZBPzfmGerW2FBxSREUz9s3FShGttKngJYBgP2t5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=NphYIdd6; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C5618EBB;
	Wed, 24 Apr 2024 17:38:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713973130;
	bh=1/kHOf5FrW6WAf4IYNC9B2o8lBngcUMkOHJ0ykXalqk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NphYIdd6U88HgP/5UpLF+FYYGe/eOTYIuSygHwJK1vu06JWpLmPckmVnujJvgajbj
	 yOf6KK/N7LyHt1OlG17TJQvtcVY8mtJzavHgT66lQCywXZWhXteLFyF2l2LnVyzL/e
	 nnLDyXu4zvRdWK7wfQuyX219Laxlsz8c9hoPDzqA=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 24 Apr 2024 18:39:06 +0300
Subject: [PATCH v6 03/11] media: subdev: Add checks for subdev features
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-enable-streams-impro-v6-3-5fb14c20147d@ideasonboard.com>
References: <20240424-enable-streams-impro-v6-0-5fb14c20147d@ideasonboard.com>
In-Reply-To: <20240424-enable-streams-impro-v6-0-5fb14c20147d@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2303;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=1/kHOf5FrW6WAf4IYNC9B2o8lBngcUMkOHJ0ykXalqk=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmKSe4W8AXguIHqcnj7KU6Rzbv73B8iYfAZQjg9
 UbfIfm5msuJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZiknuAAKCRD6PaqMvJYe
 9QiPD/4+ilJ3v9bEY8t1McImzO4ggZX0aBhFQD2CiApZ7H0qsqVap2dSPVAskqlj3swmjn6dNwz
 LdKvDveEnHBqzfray8cy4FUEZvf+1nmCB/Aw2xmyCtGY/sBA7S/435Y6fnDcwKZgQfhOxJw3rQO
 N3NKIAMiOt1rd8v2LlJvTV34VzTLWzcegxUKpOyH5xTDIVGm2IxJmIaKeO5IQLxUfdc5ZbvN9SV
 YuiHKClKU48I0VLouYTK9J5HUTj/K56UQGKuvKX4ydP6owtSPN1yQOjsJhoXnxCPp33ERmvWq6k
 U2jzyifm40wC7LunSg0VhnD1P74f4mPh+oncoCvrPynePjWmW0yB2sv3lLdmWtojl2rA9ehNzhd
 irvG0s93DgIdGtl2W6kifHjvr3sQHF7/UN3Du6oToZ7YxTURyLOm15pTwx/b9i23RuTgGSaIxxp
 r0zuIQhqJa02C7LKWCDxkvjzJ8yq9akc7IneX6Yv6cYcCk5UlX02qR7djDh7ZmUbDoMq4ifJagg
 mdOt4YqPGvhwGhZSeLAICXIKER+pPXSuDgM8jaCgRDpKfaoOWejqxrjp8IeZVcbWUKIQ0nqUJeY
 tXHMF94AumkZf8H/ZO7E90VY10wAbNXFIxQHmawbre1eyLGQBUy2VhwLDOgQKv0BIEhi5SHDXkz
 oK6EkyIgEsU+8Bg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add some checks to verify that the subdev driver implements required
features.

A subdevice that supports streams (V4L2_SUBDEV_FL_STREAMS) must do one
of the following:

- Implement neither .enable/disable_streams() nor .s_stream(), if the
  subdev is part of a video driver that uses an internal method to
  enable the subdev.
- Implement only .enable/disable_streams(), if support for legacy
  sink-side subdevices is not needed.
- Implement .enable/disable_streams() and .s_stream(), if support for
  legacy sink-side subdevices is needed.

At the moment the framework doesn't check this requirement. Add the
check.

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Umang Jain <umang.jain@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 2c5a9b0029dc..b67456944ae1 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -1568,6 +1568,33 @@ int __v4l2_subdev_init_finalize(struct v4l2_subdev *sd, const char *name,
 				struct lock_class_key *key)
 {
 	struct v4l2_subdev_state *state;
+	struct device *dev = sd->dev;
+	bool has_disable_streams;
+	bool has_enable_streams;
+	bool has_s_stream;
+
+	/* Check that the subdevice implements the required features */
+
+	has_s_stream = v4l2_subdev_has_op(sd, video, s_stream);
+	has_enable_streams = v4l2_subdev_has_op(sd, pad, enable_streams);
+	has_disable_streams = v4l2_subdev_has_op(sd, pad, disable_streams);
+
+	if (has_enable_streams != has_disable_streams) {
+		dev_err(dev,
+			"subdev '%s' must implement both or neither of .enable_streams() and .disable_streams()\n",
+			sd->name);
+		return -EINVAL;
+	}
+
+	if (sd->flags & V4L2_SUBDEV_FL_STREAMS) {
+		if (has_s_stream && !has_enable_streams) {
+			dev_err(dev,
+				"subdev '%s' must implement .enable/disable_streams()\n",
+				sd->name);
+
+			return -EINVAL;
+		}
+	}
 
 	state = __v4l2_subdev_state_alloc(sd, name, key);
 	if (IS_ERR(state))

-- 
2.34.1


