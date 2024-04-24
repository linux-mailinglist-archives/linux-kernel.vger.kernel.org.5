Return-Path: <linux-kernel+bounces-157217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7B68B0EF2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80AB1B2D5E1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216C213DBB2;
	Wed, 24 Apr 2024 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="irVVORht"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF23111AD;
	Wed, 24 Apr 2024 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973183; cv=none; b=mwMpTS1kO7lNqSAW8oQxrwBwc9sFqpllCEAEy8IKn5owAwpSv5JOk8jyp9limJnf4pgVCtP9kKztBgKW/gH8fNopgxhv/gSOmWwlQgMKKzsjyP2Q10HbQ6aKijcqS4XiW2twwWK1NZqJCiaZYNBT37OatgFCyfB1KNPgjtlkJ1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973183; c=relaxed/simple;
	bh=m0YZ72ZLPdLubYXTMMAHiaCA6BZPp53Y50ofn9e1YhQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mDUvxxvFnm6oumrmdf2xQcLH5Nw24PUqnjYiDzSiiKOFL4oi6IzgbS1xtIpovflgsnO7SMjmYSKA9RDxvGPBvAIhK80qkxeIb/UhlR1TQ+fhm/LClP2EGUPu+i6MjdfBcPSx91vQMJyfywHEE4/hadJa0atnw8GAXxCgBuHJ9Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=irVVORht; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2ACA4674;
	Wed, 24 Apr 2024 17:38:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713973128;
	bh=m0YZ72ZLPdLubYXTMMAHiaCA6BZPp53Y50ofn9e1YhQ=;
	h=From:Subject:Date:To:Cc:From;
	b=irVVORhtnl4hjHQavMChGZ//Qrg13pphNsnNjHmQJJqcJ+GvfhHwPQ1JKiq1MAYia
	 OFyO6eDm2IgB1FJ6yCVidBPdvpCObUZ7DqCyxnztYNeumyM/j5iANe/Q2FCye6JX5o
	 ccIaWA7RW4VZd2j9WfkRJr94WBiQhfIgtUUAWi1E=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v6 00/11] media: subdev: Improve stream enable/disable
 machinery
Date: Wed, 24 Apr 2024 18:39:03 +0300
Message-Id: <20240424-enable-streams-impro-v6-0-5fb14c20147d@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJcnKWYC/43PzU7DMAwH8FeZciYo30k58R6IgxN7LBJtpmSqQ
 FPfnXSnHohAPv0t+Wf7zhrVTI29nO6s0ppbLksP7unE0gWWD+IZe2ZKKCN6cVogfhJvt0owN57
 nay0cY4gJwxSMl6yPXiud89eDfXvv+ZLbrdTvx5ZV7t0/wFVywaWQHrSNkYR/zUjQyhILVHxOZ
 Wa7u6qjZQeW6pZSMcHkvHMWB5Y+WFIMLN0tsuTBInijxMAyR8sNLLP/iNqLNCUV3egu+x/Ldiu
 iPScCM+kQfrG2bfsBJvSg6u8BAAA=
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3931;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=m0YZ72ZLPdLubYXTMMAHiaCA6BZPp53Y50ofn9e1YhQ=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmKSey6qYaIGkw1A76uBzdkVcnfitPjU/V7+yLQ
 qcs30vpyLeJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZiknsgAKCRD6PaqMvJYe
 9WsID/0UIaYpv7AJ5S8oYDuaGQKmcZOj407+XaHUjkyvw/nB74S6o3wkDiZR4tnx94pvz7E+zMH
 TzVxBnVGfYtRVhFDohA7JXbshwLrIjCPNRyC47iyHxaBUZyZozeRQwo03mFnixtqJbx+1rKxtXL
 mLeyun7Pqs452LY7TpGIbuukzaBxv1qJi6jThriX4qsf3YY4C99h5qahuMz6w6/r3/qrA9ZuwS6
 xNdDxhHzNW/Wjsk4YwTtJ6YVLX5x3hUijC4IuKXE9XMndW6YeTY0TiBQmDSXHnlBdkOml1FgtOn
 pesQ8WHbkVITd85bVGzwkCBhVUd91/gXabANlr64lL8jadVtJ7rzmhKP3nbTQU5lXeXl4rVj4PQ
 Zvxvs7RHeKCA4FyS/7YKFSjtVjNrxBMcEGOxFCiusXT8e2eJraNx1oszAISX7EL9U6GV8SSpRTx
 R1NJKx9vkIXzuHXjbci+If6UUNS1yms4hFWSJYLTHEk2d2h9vyJ7Ax+CE+iZb+UxEriBz2c1iwy
 1QZv+kdYzn0rI/ct/wkzGsQhKqkc+jGQ+IQkztq2MFqJRaLfBdlSzhxr2bCVLjxel9TVpuWLM4D
 WLi3IOwrPH6fT9fNDDxWLoH3bXvmsx7aQ+PQ2VUJLl7ALTpCUcPd2a8cQ1wpK893SeSKFzZecm4
 oCvx83A4bHO9LaA==
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
Changes in v6:
- v4l2_subdev_enable_streams() and v4l2_subdev_disable_streams()
  accidentally returned -EINVAL when a stream was already
  enabled/disabled. Change it back to -EALREADY.
- Add TODO note about privacy leds to "media: subdev: Support
  single-stream case in v4l2_subdev_enable/disable_streams()"
- New commit "media: subdev: Improve s_stream documentation"
- Link to v5: https://lore.kernel.org/r/20240416-enable-streams-impro-v5-0-bd5fcea49388@ideasonboard.com

Changes in v5:
- Fix issues with non-routing case:
  - Always set 'found_streams' variable instead of leaving it
    uninitialized in "Support single-stream case in
    v4l2_subdev_enable/disable_streams()"
  - Fix the "implicit" stream from bit 1 to bit 0 in "Support
    non-routing subdevs in v4l2_subdev_s_stream_helper()"
- Link to v4: https://lore.kernel.org/r/20240416-enable-streams-impro-v4-0-1d370c9c2b6d@ideasonboard.com

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
Tomi Valkeinen (11):
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
      media: subdev: Improve s_stream documentation

 drivers/media/v4l2-core/v4l2-subdev.c | 385 ++++++++++++++++++++--------------
 include/media/v4l2-subdev.h           |  34 ++-
 2 files changed, 261 insertions(+), 158 deletions(-)
---
base-commit: e42a204f0519a2540f1507ac2798be2aeaa76bee
change-id: 20240404-enable-streams-impro-db8bcd898471

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


