Return-Path: <linux-kernel+bounces-132711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 902AB899931
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C227F1C20DDB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E361607AD;
	Fri,  5 Apr 2024 09:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="fQ/TxB00"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF3D15FD14;
	Fri,  5 Apr 2024 09:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308487; cv=none; b=BxFtqy8HhYIymF2uer2QvFZHD50ksKOWBbu+MvnFSPHha6mN2jIgB4MIb4L1fsgnHV5yU3tg9WnMk1U56COUBc6eNFG9mmIuCZrt67/Bip94cYuvlqJNiQWf633OrYX0zceCJnrE9HdZgKsNvfO7ayc502yNqNMjvJIVyhG/W5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308487; c=relaxed/simple;
	bh=UE2b6SzpsQRbGE5W0cWVQkZnin+2haEBI6zkPJQq4uo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W3nZqicT5CFyIXNSCCDs82e7fMNxmC5DE4DVeLDG2wLQKpWtU14clm86Yn6YnFJ5gD30x1XOVUBn5KnapAsdzd0rzKSHlAYes6s7Y4FdtvscD900BpLfyEmsA9ZwORoVyjLrnH/8tSYcb58p6NTQEXdHyrZusQpRPm4aixjfVyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=fQ/TxB00; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 47E5EE4F;
	Fri,  5 Apr 2024 11:14:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712308443;
	bh=UE2b6SzpsQRbGE5W0cWVQkZnin+2haEBI6zkPJQq4uo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fQ/TxB00wibOG4PkD2IT1yqNGRvkHQUTpEIyW0hsfjWQBMQu7yTcRRJg4oOGc+kam
	 OM6q3NqoWyfVHI00+euDdmwoWOkUxnKPhsMDrk+H2jBzLoNN4Ixrd6yjIY/ZQa5OaE
	 djzn9n+sQg98MPo1UzkG5JfJRximRP4MeofcByAA=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 05 Apr 2024 12:14:20 +0300
Subject: [PATCH v2 2/9] media: subdev: Use v4l2_subdev_has_op() in
 v4l2_subdev_enable/disable_streams()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-enable-streams-impro-v2-2-22bca967665d@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1222;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=UE2b6SzpsQRbGE5W0cWVQkZnin+2haEBI6zkPJQq4uo=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmD8D9K5iIjKVUtmtwZf2pTelg9lof7jPSMpSIZ
 V8xePwiY2+JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZg/A/QAKCRD6PaqMvJYe
 9YIID/9T5pG6gvmH5sYZJc+FmbqXnGAj4Y5miV2l2t2/wpKay6dL/kRUFgETLFSGthPCZmezRb/
 OQhHE+kKSzD2dlOPynHZ7WBsHxPzTY6CJR09owJCkCheTAUvFrRdhNN7Uzbn8ccNe1/o28MQ8FN
 1qp94vIyNjye7fVAoOzs0k4LwiGmEhFKzJtPjKe6sAO2pEn3vv765sKKIOMeElu1w65DWlfqPe1
 g3+91ZpOGtOhvqOV+U5pzqxUk1HSIK8vRbi1g1ges8J9aQvWdGFtQRAobJhctWpvNajcTx5XLdG
 2etZdm8/7aK9CWjA2nzF2FsJtcR17QcB7eZQ8svxpHK/S9l+yzWdKz1cdNe6YPDfmIW7M3Kz037
 U+m13ccnw+o566BfwKAoruG62lJUno5BlarM3HF/j22JQwtW9JoCtHYSJifVrVKCJWjMd/qaB8Z
 gJP6uwHkms5dhdhx2Lk6u/TlfSS/Tyf0HRT+28ShcZ2KLZexnyqybOGmNOxhL/gdCD/7YDmKLsf
 if+83pCq9Twujwtc3Mx4DFX0pgNpokxeQgFHtNGxIr1Em/QFJiSNjhRZeJpf5SIoB1g212jDpAx
 n3hmZzL9isEaos/SDli8lnVFNylN4SmMDVBNeVmOMQwqWDoy3CtPatKv4TSi4fEthgChKvgo3Ef
 qm/G0vaYBJt6i9A==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Use v4l2_subdev_has_op() in v4l2_subdev_enable/disable_streams().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 942c7a644033..c8124919b92c 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -2132,7 +2132,7 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 		return 0;
 
 	/* Fallback on .s_stream() if .enable_streams() isn't available. */
-	if (!sd->ops->pad || !sd->ops->pad->enable_streams)
+	if (!v4l2_subdev_has_op(sd, pad, enable_streams))
 		return v4l2_subdev_enable_streams_fallback(sd, pad,
 							   streams_mask);
 
@@ -2249,7 +2249,7 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
 		return 0;
 
 	/* Fallback on .s_stream() if .disable_streams() isn't available. */
-	if (!sd->ops->pad || !sd->ops->pad->disable_streams)
+	if (!v4l2_subdev_has_op(sd, pad, disable_streams))
 		return v4l2_subdev_disable_streams_fallback(sd, pad,
 							    streams_mask);
 

-- 
2.34.1


