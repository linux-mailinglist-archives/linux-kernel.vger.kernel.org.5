Return-Path: <linux-kernel+bounces-132716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A3089993B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444251C20FF0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB1E161B5E;
	Fri,  5 Apr 2024 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="tUj2wrdA"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C5216191D;
	Fri,  5 Apr 2024 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308495; cv=none; b=P6m7B83mkbEclE7VlZccTocl8XWuls5zaRRAC67yphJCZaDS3qNn/YWe7w+QPLHYa8lD1y+wRk+33JGUAzWNsVPH0q+pnR6yarrU/I9j7hWkQDF44gCcwvMIcNeW3guYIMyHaPP6ll8+sfePf/RJ7cqK+USzwPpB/uq4aYT53ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308495; c=relaxed/simple;
	bh=iU08g9MecKbH8Kv5xSp2Mtj+ZCNUisKoXNwFY/0rf5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pu73sarGX3iUcYWoqMYXVKVoM85N2GR6MHLHArURSkeLPwzAARmTM7Jvnbe36lM86IS6uQOMdE/O9rxS2/+Oo7U2YnJyPO6ZhpnxWaMYw9qo5MUUU1aL8Gi41cBBE1zX8QYdNynuzk0iEECeya7HtJZE+SH8kP4RHX9RJml7lYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=tUj2wrdA; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 01F9711CF;
	Fri,  5 Apr 2024 11:14:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712308446;
	bh=iU08g9MecKbH8Kv5xSp2Mtj+ZCNUisKoXNwFY/0rf5Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tUj2wrdAYMj8fOFeETnfOj/+IEN5yUDkVBEBMN3r2JH5aQIznvYIdfLMG1oiBf2io
	 rQYhiAftK1K1l/HCBVDi4pLvUeyRNkZquw7kT6UKSkfwEY1gweOYsvobkZuGiEjZNo
	 upG5GSFddl3lx1NpuWPqSdKZYXy9pi4WHg1JZmQk=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 05 Apr 2024 12:14:25 +0300
Subject: [PATCH v2 7/9] media: subdev: Support privacy led in
 v4l2_subdev_enable/disable_streams()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-enable-streams-impro-v2-7-22bca967665d@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1874;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=iU08g9MecKbH8Kv5xSp2Mtj+ZCNUisKoXNwFY/0rf5Y=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmD8D/5HQ/hSya32BORPX6e587qoHIlAHE+GdWS
 aqL6JF0gymJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZg/A/wAKCRD6PaqMvJYe
 9f8dD/4yyRK+YjsWX74ZICp2NiJvkgX9cbiifBMWo3Eb6tvnVso9luTmUkoPerjTNOTauS4QlcK
 Dl3MW+88cw0+6kqdtt+bxPaaXYW+9anugGL3ISxm9hEZW2XTD1a7akYmFlBREHCaG5VAmNcVdnc
 pLg/SJfpA21NsqNDCqby0XWsr+rQPy9XxyZbt+9UC4ZgJVorBq1TP/d0UxyvRhvMpfvDbnCXeMd
 gVYi/cgIUTaxnC0nOwJWW88FoDQz89TaPgXDeACvEFHAJxB5T4pb3fw+OniesSdeAQKMobr4Pzo
 C1q93c1568H8cf8kAJJfiWUo4CrIVaV5voxH7vbWg/RjtbWvh7BCXNpLiZv4WDiqzWTVnl/NK5d
 nXv7lZZH0dexScPSRxse2qOvHbyq5uaduCp7aAODQbJxsjsCUgX2CzBDuwbzy9wr1fz9VW9718S
 c20Zy47pDIhb71tt3QIVLcnLmSsmPd0EZvriPufAeJJeifbALNK3F2RsR/YXW2M0gKhlyw0/DNN
 gxHtFxqcFsTQGz6ejQwNs9T5GfHVkyp1ucfPFe64gMvdxbPTjsK3Y0KjM+bIFDloppZoHZWB34V
 WC90b4MzdBgliz4y/G24w6rK4dqwxP0FymUn3Ib7y4Er/tuTYa9Oo01jsdnaMJGOm9tsGK1b3j9
 WA6jmK2mDTd70xQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

We support camera privacy leds with the .s_stream, in call_s_stream, but
we don't have that support when the subdevice implements
enable/disable_streams.

Add the support by enabling the led when the first stream for a
subdevice is enabled, and disabling the led then the last stream is
disabled.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index b4981447961a..015f2fb423c9 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -2149,6 +2149,7 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 {
 	struct device *dev = sd->entity.graph_obj.mdev->dev;
 	struct v4l2_subdev_state *state;
+	bool already_streaming;
 	u64 found_streams = 0;
 	unsigned int i;
 	int ret;
@@ -2197,6 +2198,11 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 
 	dev_dbg(dev, "enable streams %u:%#llx\n", pad, streams_mask);
 
+	already_streaming = v4l2_subdev_is_streaming(sd);
+
+	if (!already_streaming)
+		v4l2_subdev_enable_privacy_led(sd);
+
 	/* Call the .enable_streams() operation. */
 	ret = v4l2_subdev_call(sd, pad, enable_streams, state, pad,
 			       streams_mask);
@@ -2216,6 +2222,9 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 	}
 
 done:
+	if (ret && !already_streaming)
+		v4l2_subdev_disable_privacy_led(sd);
+
 	v4l2_subdev_unlock_state(state);
 
 	return ret;
@@ -2339,6 +2348,9 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
 	}
 
 done:
+	if (!v4l2_subdev_is_streaming(sd))
+		v4l2_subdev_disable_privacy_led(sd);
+
 	v4l2_subdev_unlock_state(state);
 
 	return ret;

-- 
2.34.1


