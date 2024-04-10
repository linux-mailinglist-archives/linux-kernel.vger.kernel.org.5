Return-Path: <linux-kernel+bounces-138505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F8A89F264
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6412B21C7D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32A715B135;
	Wed, 10 Apr 2024 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="fnNN7Rjq"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6CA2BAEC;
	Wed, 10 Apr 2024 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712752614; cv=none; b=lcw0bmXWY7RMbqBevVi2wxnchI0JdW+CvG4pU0x2jjLuRGrb7epGggxN1sbTjWpiTEkzZMfGDDSiTQ/trGFprQx6RR09VHusA92c1ffo2+zPg6MP5lZaP0jWRwl2asAjfTVtk4+vyYSd6ZrYHt+0DzssgPndf2Cgvb0jOYDaw10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712752614; c=relaxed/simple;
	bh=RxANx2ecABIJ7VUtAP4l0MvYWpheCKmTFHpvSVmBTYE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gPTWxO3GXTe7f1f0wjJrEscVUiliOR/BewpbeDLheB/OoOkqpthKhu1oyrQWCTo2RE4VfHk8+8bKRC7bVhU5sN6Mu0D7kXOrsgk1x1CgvSiqbuS63piodIEzY9THfiyLmGNEJydvXhi26faWgbDz9+riC/yruFakIZk8O6UZYYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=fnNN7Rjq; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id F15656BE;
	Wed, 10 Apr 2024 14:36:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712752568;
	bh=RxANx2ecABIJ7VUtAP4l0MvYWpheCKmTFHpvSVmBTYE=;
	h=From:Subject:Date:To:Cc:From;
	b=fnNN7RjqfHuH/qSCYaIfOWMIlZ3URh78Jb/KTWmkY94pNQjzaZyuIDHvej7vbOMX3
	 0EgNygHIfUgeRS5wv26ih68DBT1mJKaiVhK7dWxN+j9h7Zipl/2QV/Unwy57F5Lhcj
	 Oo2V+KbCH1sosx6W3pQW3AWZYV5H0JFQbNzRngJI=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v3 0/9] media: subdev: Improve stream enable/disable
 machinery
Date: Wed, 10 Apr 2024 15:35:47 +0300
Message-Id: <20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKOHFmYC/4XNSw6CMBCA4auQrq1pC6XgynsYF32MMom0pCWNh
 nB3CysXGjOrf5L5ZiEJIkIip2ohETImDL5EfaiIHbS/A0VXmggmGlaGgtfmATTNEfSYKI5TDNS
 ZzljX9V2jOCmnU4QbPnf2ci09YJpDfO1fMt+2f8DMKaOccaVraQwwdUYHOgVvgo7uaMNINjeLT
 0v+sESxhDBW961qW+m+WOu6vgHYdq8BCwEAAA==
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2523;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=RxANx2ecABIJ7VUtAP4l0MvYWpheCKmTFHpvSVmBTYE=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmFofam8xjwyvp3kqcaLiyYajCVSk3Xp8y/IDVb
 g8L1GuoNaOJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZhaH2gAKCRD6PaqMvJYe
 9YnkEACdN/8i7fyBExglNHzkTVOmNUx5chAn8FGq8NIpHW3nqNW4jLx472cJtjwf04bPGnboRv5
 Ve5W5BEksVAI9i3v7Jns6QPXBXFU848pcoAovnFuwWhSHHAT8ixmdpOsTd/K6Jz/fIOZCvOlR9r
 KQjncmbRvcFrBtuU9P6yHHqkKOAvRltdi9eSYCEkU8St1ITjmWRjIamAkxhAkcykWKjN6YtHZx9
 RXIO0KwBfhPHzMvKR45Pg4QMvu38l5mBVMNAa4ZYqHKiAJmmVNEdeV60JNS/x5ZW1JWtLkkI/4U
 N256y09PsoRUaLWoUxrX4T7MQyOjENFeoD/tK3IpOtOCYaa+jYTWztPFCXIO+Uaq1eN+IF6HKdD
 yTFfHDSzkxVpvumYyGWhBWOmz9DOxUcWTn8bKbLBmYG6ETpfieMQQsIxcIqF5u1wB3s/xsgIIjW
 J+WY/1YWDQ/Q1zYTkAl7CUau8S7sAMe8sFeDtUPiOYq95cGQ0f/bTDX90QiC5t8nDuHsfc0q9vl
 MJgdHM3WjnJNcMase+NgjyT/Rsx0GhaFK2uyTbwcTGQgf0KDBuai2p0U/8CQpzEMMWidlvJTJBK
 KzhxZWF0NWNh25PQMYiF8PmJNlYZVPPI0vb/JhxSzEnNkBeFNiXzGF4DSzePHfvefpaUCHiYa8Y
 6qhPC1lDcftwyew==
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

 drivers/media/v4l2-core/v4l2-subdev.c | 355 ++++++++++++++++++++--------------
 include/media/v4l2-subdev.h           |  25 ++-
 2 files changed, 229 insertions(+), 151 deletions(-)
---
base-commit: 6547a87b1ffc9b3c3a17f20f71016de98c169bbb
change-id: 20240404-enable-streams-impro-db8bcd898471

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


