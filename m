Return-Path: <linux-kernel+bounces-146644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAC28A68BA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43197287DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611DF128814;
	Tue, 16 Apr 2024 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SV6FsifC"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1355E127E23;
	Tue, 16 Apr 2024 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264035; cv=none; b=QyuA42l/2cKqk4OAHTIn8AICauqIvnEji1CS2OAW/vlaIk6z5pdu3vpECmOBI950M/JM9QftQQCYVfevPyjMCjwIJDmJ2Jw0LNCOfq+WFg93jykbpIsrEhr7NiWibwoJiUqZxiHxksUo2qbQZ1ylXB4Io3tavz1lV6inqLSs+KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264035; c=relaxed/simple;
	bh=uDjhSvGIZUFTUCzeNveZemaCTPneAk4ZpGLN06s4Zu4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hvyhaq9mACOaFOg8WRCVfj0hPDTvgG52TUSWOcr7ziYQe6lh7RRxBugbIBfbsrHJDiO7+EvMYoU/06lL4teCrycumznojN96bgKW7LlzwvVqLfmin0G/gfln7cxXwOBFjHPeNQ+wXtZgYpBLtjOVAISVG15XeWA/yHjL7ql7YiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=SV6FsifC; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D5180480;
	Tue, 16 Apr 2024 12:39:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713263986;
	bh=uDjhSvGIZUFTUCzeNveZemaCTPneAk4ZpGLN06s4Zu4=;
	h=From:Subject:Date:To:Cc:From;
	b=SV6FsifCawHp+mX2b68oK9Xmhvjltrcq9/pM1mvEsKGozobfmwfff4fVtomKpzIO5
	 lPhMYT4Bd1ejOjVvv2NQj3tnfdKoXwLg1WIHVopmkQ6z8T/+oeNZNR1UzdEngFr6Ty
	 FWg+zHQEnBTvggJpTc6kAtGe+O8CuoWCvCjEmjrA=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v4 00/10] media: subdev: Improve stream enable/disable
 machinery
Date: Tue, 16 Apr 2024 13:39:59 +0300
Message-Id: <20240416-enable-streams-impro-v4-0-1d370c9c2b6d@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH9VHmYC/4XNwQ6DIAyA4VcxnMcCCKI77T2WHYp0k2SCAWO2G
 N996MnDzNLT36RfZ5IwOkzkUswk4uSSCz6HPBWk7cA/kTqbmwgmJMtD0YN5IU1jROgTdf0QA7W
 mNq2tm1pqTvLpEPHh3ht7u+fuXBpD/GxfJr5u/4ATp4xyxjWUyhhk+uosQgreBIj23IaerO4k9
 pY6sES2hDAtNJWuKmUPrHJncXZgldlChRqUBS0F+2Ety/IFg0JXplcBAAA=
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2949;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=uDjhSvGIZUFTUCzeNveZemaCTPneAk4ZpGLN06s4Zu4=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmHlWYAR4WFGLaY8EkcqDFDsZPietw1zxCLZInL
 BwX4X+rQDSJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZh5VmAAKCRD6PaqMvJYe
 9fpYEACnawAsLlH8HPhkEtJHfjnC9b5RJn4N6HW2ayspqz1P83SFXRg3LCplI2Rbtah6ijor+F1
 062rfqROy4ga+Ir1zw1PfkbzlMyXp7miPANmBD4mCrrmg3YcUXGgEc7dfXp/0I/x73Poc+cdNx2
 JgHgr6m11stq+fY/Tbva84eSCIwAUXW2fCQlN0ehO5zTclWvnCF7nI+mn9YBroneSkAKI0S1KeO
 Zpfp1BnlcgILe97Y/w8T0HI9y5nrVdgHZFkxXAqsuYAFXz9Bs+YEwWMCB0Kdc69020SUMd6+zhO
 iPzuk1LYR5CXQaqaFeduRWvbLkCLTlZir9+TR5tzhyQz/LDxejllxQRRCJelY32NEgBoN85jLbP
 K4wIAK3GWkP0+xcA/4AIVIx6/RK4ajL6p7cRbeVYrsGwXk+qv92S+PIaJm90KKu0hfajJWk51fo
 A8hbwtRVDlYLU9i4HVYEhrFCpyB0pFZN4QsI5i3OaCWRZzsX1Sap3/70gznpWaBXPtXfljbg/Qg
 5mLrDpPFnM9mq8Vnm54ecYbRaRc9vWd2siLf9atTHgomd6h5eeUZQ+brvmbUAcrXEma0rMS5Kmw
 3cFblDJPvFvt5Da09Mm/KqEpWJQ44pvFNyruYvLtl2KlBdxsV9s0bDaMuH0QQQpY5CXs995Q+NS
 R+uHfVsNaTWcYTQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

This series works on the .s_stream, .enable_streams, .disable_streams
related code. The main feature introduced here, in the last two patchs,
is adding support for .enable/disable_streams() for subdevs that do not
implement full streams support.

Additionally we add support for the privacy led when
v4l2_subdev_enable/disable_streams() is used.

I have tested this on RPi5.

 Tomi

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Changes in v4:
- Added Rb tags
- Rename 'streaming_enabled' to 's_stream_enabled'
- Cosmetic changes (comments / patch descs)
- Added new patch "media: subdev: Support non-routing subdevs in  v4l2_subdev_s_stream_helper()".
- Link to v3: https://lore.kernel.org/r/20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com

Changes in v3:
- Rebased on top of "[PATCH v2 1/1] media: v4l: Don't turn on privacy LED if streamon fails"
- Drop extra "!!" in "media: subdev: Fix use of sd->enabled_streams in  call_s_stream()"
- Enable privacy LED after a succesfull stream enable in  "media: subdev: Support privacy led in v4l2_subdev_enable/disable_streams()"
- Init 'cfg' variable when declaring in "media: subdev: Refactor v4l2_subdev_enable/disable_streams()"
- Link to v2: https://lore.kernel.org/r/20240405-enable-streams-impro-v2-0-22bca967665d@ideasonboard.com

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
Tomi Valkeinen (10):
      media: subdev: Add privacy led helpers
      media: subdev: Use v4l2_subdev_has_op() in v4l2_subdev_enable/disable_streams()
      media: subdev: Add checks for subdev features
      media: subdev: Fix use of sd->enabled_streams in call_s_stream()
      media: subdev: Improve v4l2_subdev_enable/disable_streams_fallback
      media: subdev: Add v4l2_subdev_is_streaming()
      media: subdev: Support privacy led in v4l2_subdev_enable/disable_streams()
      media: subdev: Refactor v4l2_subdev_enable/disable_streams()
      media: subdev: Support single-stream case in v4l2_subdev_enable/disable_streams()
      media: subdev: Support non-routing subdevs in v4l2_subdev_s_stream_helper()

 drivers/media/v4l2-core/v4l2-subdev.c | 378 ++++++++++++++++++++--------------
 include/media/v4l2-subdev.h           |  25 ++-
 2 files changed, 245 insertions(+), 158 deletions(-)
---
base-commit: 6547a87b1ffc9b3c3a17f20f71016de98c169bbb
change-id: 20240404-enable-streams-impro-db8bcd898471

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


