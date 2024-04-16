Return-Path: <linux-kernel+bounces-146916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A21F8A6CEC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C25BB22654
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DF912CD8A;
	Tue, 16 Apr 2024 13:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="h0JhKolb"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8B51272AA;
	Tue, 16 Apr 2024 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275728; cv=none; b=RHEyiEIkRLdtn41F9oKJyf5G+Khktuulkl2k/5skqA1HS0G0W/7DB4/wS9EstdrxiAQXl/0YC0lcoaMLhZ1VJy22z+nU69GYouxPY+zH+ks9pDqiIrLqgARB8TBB7V4EV14uoFvngrAi4thUYGJfd1Cjv3qMEJOJkauSRDv9KOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275728; c=relaxed/simple;
	bh=exasu2h4EZqJI0iWklXGcwFASRJw6cMEBWgi0mdQ6fU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q47LsLBinMaGHn9Z94l3eLIhyOpOW0E4mMaVftVnPN9TLPeG42IRAUC5b1I0dguxuLCBejwutLOG0TFTu2k8q+pjCCEIek5tGE6+san47OcOTUeZiOmPHXii1TB/89EniVIPrbTu5t9SjUiO8OTiVNm5X7at4EItZ4VUQQ3UGX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=h0JhKolb; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8D93CDFB;
	Tue, 16 Apr 2024 15:54:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713275678;
	bh=exasu2h4EZqJI0iWklXGcwFASRJw6cMEBWgi0mdQ6fU=;
	h=From:Subject:Date:To:Cc:From;
	b=h0JhKolb9oOUKjQGFbeFEStkrYto2/ef6rMEcW3yB3I68U2bEozsgtwPJdGQimM01
	 AkAsPxVOB+94VFSbVmZ6t9GU2le+WObPfWvhlE4EORuzd60JzcIxImuelG/vxem5SO
	 FpmRdwfMF0AULCYw0jznz8Z4LU3QBI+TCEX/cGl4=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v5 00/10] media: subdev: Improve stream enable/disable
 machinery
Date: Tue, 16 Apr 2024 16:55:03 +0300
Message-Id: <20240416-enable-streams-impro-v5-0-bd5fcea49388@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADeDHmYC/4XPzQ7CIAwH8FcxnMUA42Pz5HsYDwWqkrhhwCyaZ
 e8u22kHienp36S/thPJmAJmctxNJOEYcohDCWq/I+4Oww1p8CUTwYRkpSgOYB9I8ysh9JmG/pk
 i9ba1zrddKw0nZfSZ8BreK3u+lHwP+RXTZ90y8qX7Bxw5ZZQzbqBR1iIzp+ARchxshOQPLvZkc
 UextVTFEsUSwjrotNFa+YrVbCzOKlZTLFRoQHkwUrCKJbeWrlhy+dE3hrnOCat/3TXP8xeLiku
 3owEAAA==
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3391;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=exasu2h4EZqJI0iWklXGcwFASRJw6cMEBWgi0mdQ6fU=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmHoNFndRzNG0CuyQS2pjMZ6x8ti09eY/pE/oIY
 qaQzlsg8OCJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZh6DRQAKCRD6PaqMvJYe
 9Q6mD/4wU6r2VHnm1uw8semVmWg2lAGP0d8kAgHmr7ox4cvkNGwYv2cykgOGrYlvE1h0GXJaEof
 0VcaJcp10HiNqvzWuWYPlV+YdcseG8P5ljPm3S8oM9FuO/1QLFDnuOV3oGMIZG2FJNyfDg9j28T
 uBXVLn8lHMHNXJ49LwP79F2/ucNRzZnsSpx0kMJLtH8rqBd5jDrcX+FqAkEb4bjzpHziM2sNIj4
 aKeeuujzDIgonzLr65YfMcMD6adM82B9gM2I6CCPFhNm061ETeLrNoMpUJACk/7k/pjfHIS5brZ
 YECmk7jWjXY3/zQMSa81r7ygTPI9eIvpv/W+BytWAi8qZXHsMzDgp0Kv8zbE5UHaCzPH0v1vB30
 6idHQPXF0QYo+RSfA6oee7Ut3yDKp3HVJIlJADaw4/8hHhyV6UcayBd3jGGm2HUMgS7C6Ai6T3z
 89jyd6uywUx+5uqVvmayxKLDJYDnhSj1q6apLfHekMaxW2g7IuvShenMlAV7haxD8r/JWZECOcw
 zMQ9uuakg02j4KlzmqKj3g8nc1VZBe/lqqYQCaNptBPGNx6kT6UY/YIFRYsQfoBT81hBqEpIExE
 EX6rP1pWFuphBV68GwLkLmcqHrJjRl9hR34uyaAj7usjj52S9OX7CD1kNdpOP5bRbRcfrVT01fK
 hgeRT1iTMCsLLRQ==
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


