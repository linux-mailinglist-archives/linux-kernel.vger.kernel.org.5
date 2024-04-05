Return-Path: <linux-kernel+bounces-132709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B15899922
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2733F283BEB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0CC15FCF4;
	Fri,  5 Apr 2024 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="if5BUlTg"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BFF145B09;
	Fri,  5 Apr 2024 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308484; cv=none; b=m5keTLNQTDV0p6IdYmoGx4mZ+FeMtT74WNWBFJm4Cu7TAObT73pLl0K/mVhEmE7sOqHPWqBrqJ+tgqT5do/PjTnoceWdCHGzeNKl78XpBrkt3iYVLf+ZCPbIphtdDhb401l8NxbY48PRRTGeQlTLqk9skbd7fopgPpxOS+1csM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308484; c=relaxed/simple;
	bh=efbwBub3rLL6KomY/OypraR+IKVimxRQzrC6GyiJAck=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QnyVfQrqP/hUuDWoss70lUd6I/JVurRtgBReagyAaiCr1kAg7wDeQFo4N9jxEVvwhLF2Mc0L9iQOqYOcbsaLcqgjODb9m0ooZV8hD1sovoh5JMTbKPvZhXD7z+Oe4zBk2dYM28DL6OCHvXCTbYknnoHjwH5Q87TRMFneKYDjR+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=if5BUlTg; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 32481D01;
	Fri,  5 Apr 2024 11:14:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712308442;
	bh=efbwBub3rLL6KomY/OypraR+IKVimxRQzrC6GyiJAck=;
	h=From:Subject:Date:To:Cc:From;
	b=if5BUlTgad9pRXhoyEKXTw7bKtr4Rr2N//9+aB7C65mOmME21Q4KMc8yXRB2wL8Dv
	 L0GJFkRRLQYNLNsi5kExAoWmYuCgi8+nuXvwSVI/8ELHF0Y6f91GZIN+vJQETLsMI6
	 Rm/d6+VlMCbddlBgpWXiKMXR46CaY2/OHxH8tkfY=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v2 0/9] media: subdev: Improve stream enable/disable
 machinery
Date: Fri, 05 Apr 2024 12:14:18 +0300
Message-Id: <20240405-enable-streams-impro-v2-0-22bca967665d@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOvAD2YC/4WNQQrCMBBFr1Jm7UgSK62uvId0kTSjHbBJmSlFK
 b27sReQv3of/vsrKAmTwrVaQWhh5ZwKuEMF/eDTk5BjYXDG1aYEKfnwItRZyI+KPE6SMYY29LG
 9tHVjoUwnoQe/d+29Kzywzlk++8tif+0f4WLRoDW28adzCGSaG0fymlPIXuKxzyN027Z9ATnZH
 Hi/AAAA
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1975;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=efbwBub3rLL6KomY/OypraR+IKVimxRQzrC6GyiJAck=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmD8D5FRo+YOaKd0n7KpEXmI8hy3TD7lM6nWSFr
 CfVv2BUnPKJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZg/A+QAKCRD6PaqMvJYe
 9TzgEACVzIZ2p6Qbc82XBj87lf3kwrp25k1n/AB5hWK6si7Cqo34WzxW4Da/EwUWl0WdjH4F8Qn
 T2I6xM3LcM1JFllVp6AgbRab5bOoTrp3+HnIM7/ylhYN5PZVpPZVCS3u+7a2nVoSJzZxnQdZb50
 OnIS0V53T4wYz6Uxy4jiIJ5AV9bURD1dHdc2Za7R+4XC56IjY2Y+Z+buOxFRMLwFJJFPwfqBFvc
 lFFC3BikK5lxO5KxTmltsh/+9icakOgcvx8Ovad/640tuIKN5YDuusWK15S/qs8hNCMqS6IRi8D
 bDEWqzdvW4iYvA8rZohSoTJhN8X1xTq13GT/XZd4qeCMt3qddb8nYblKxFuFKwBjrz0Tkar6/bZ
 8SBWIqgELKHVz90hur3Gre2wGvAnYxs4xTOv0xP5/di4nbET/jrkm/yOYRbCumgnzVFoX+4xEIQ
 cYHLtkICkcsCcL8YopLa1H6uzKjE4GxKSChwm+BHFvacSpEUHwa7jQZZ0wIxuon596v5oeLkX4v
 r5zWD/kUDc4b2KtXVVy3XUO/iFHQ7bQsUnwANT1SPwt9YJajZUf4rIndkYtl6hR4bMr6xfOvLLh
 vCNGP7qvyzTFAghgVwfapA9/hb81tEKsGOIdhEi+eZcSHFUwBRPsVHN0dv2le0GzXLVO/D77M2P
 Jqyf1pkCGENt51A==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

This series works on the .s_stream, .enable_streams, .disable_streams
related code. The main feature introduced here, in the last patch, is
adding support for .enable/disable_streams() for subdevs that do not
implement full streams support.

Additionally we add support for the privacy led when
v4l2_subdev_enable/disable_streams() is used.

I have tested this on RPi5.

 Tomi

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Changes in v2:
- New patches for privacy led
- Use v4l2_subdev_has_op()
- Use BITS_PER_BYTE instead of 8
- Fix 80+ line issues
- Fix typos
- Check for pad < 64 also in the non-routing .enable/disable_streams code path
- Dropped "media: subdev: Support enable/disable_streams for non-streams
  subdevs", which is implemented in a different way in new patches in this series
- Link to v1: https://lore.kernel.org/r/20240404-enable-streams-impro-v1-0-1017a35bbe07@ideasonboard.com

---
Tomi Valkeinen (9):
      media: subdev: Add privacy led helpers
      media: subdev: Use v4l2_subdev_has_op() in v4l2_subdev_enable/disable_streams()
      media: subdev: Add checks for subdev features
      media: subdev: Fix use of sd->enabled_streams in call_s_stream()
      media: subdev: Improve v4l2_subdev_enable/disable_streams_fallback
      media: subdev: Add v4l2_subdev_is_streaming()
      media: subdev: Support privacy led in v4l2_subdev_enable/disable_streams()
      media: subdev: Refactor v4l2_subdev_enable/disable_streams()
      media: subdev: Support single-stream case in v4l2_subdev_enable/disable_streams()

 drivers/media/v4l2-core/v4l2-subdev.c | 364 ++++++++++++++++++++--------------
 include/media/v4l2-subdev.h           |  25 ++-
 2 files changed, 237 insertions(+), 152 deletions(-)
---
base-commit: b82779648dfd3814df4e381f086326ec70fd791f
change-id: 20240404-enable-streams-impro-db8bcd898471

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


