Return-Path: <linux-kernel+bounces-51646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 820C2848DDD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2CC1F21F8E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D274922337;
	Sun,  4 Feb 2024 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H6qo3HUu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBE8224D1;
	Sun,  4 Feb 2024 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707051402; cv=none; b=bLFVm27VKPGhy5tLG9iviPcWFxjMD6fWNGAHoL7wJx2Sjo90TcaqXRORo0EQ+H2IaSpoRtmkhTMH+eIcyKxLgQjXQDRLyVQwl2Fw4UiNjwRd+MtoCbEgXmHqltw+QAQ3ppwC5o0LrZUBERED/4gksI7sTrwUakrVpG6Binuevzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707051402; c=relaxed/simple;
	bh=JlEQKVnat7ucMHTCOzhnemzea07e6AFMCTU5Wlpz8NU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NklUfdKKHGmxRmANqt+3gF8y301ezXI7L0ekBaT4eLUOaqu5ucozIjEFc2+n0Oxyqs0F4lQbdJLVQ8vzjqKUfuEY4XdFP8jqV9ConMQZomFXUZ7uGd0F4wlNmrDupYHq9oJZLLuAVMRgfLYlNyUSceHG2z69K65PVsxnRrSDG/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H6qo3HUu; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707051400; x=1738587400;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JlEQKVnat7ucMHTCOzhnemzea07e6AFMCTU5Wlpz8NU=;
  b=H6qo3HUuXQWPpCXBxtPwSWqQYZJna+zv7yL/TDDumCM6H2USessrfYUK
   Xy+kNhDaH89G/QtNtWG2TqP29s9sg8hF76LyCC1PnYwLPWyG82S78NpNr
   II6fLZvgFym1Asj3C28jrUI06b0F7zZi3bhWztXQkX+HSdbukWRbMBDTk
   ItFRlAqA+1VeOHx/a7kOVfoLwL1yQbyfKMWjr+Ao2Pp75nV/66LrOBZFL
   qtWF9J42rcRXxfYNSWbtAt6MlRJoWzExQOFrSRDjxY9l+kfWDpsC1nDWw
   0JD3lOlHRUuvLzXknl7rceeau3WU4iETF0J3WDANvlfON8zjIArnCtppm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="4211098"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="4211098"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 04:56:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="498546"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmviesa010.fm.intel.com with ESMTP; 04 Feb 2024 04:56:39 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	lars@metafoo.de,
	Basavaraj.Natikar@amd.com
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] iio: hid-sensor-als: Return 0 for HID_USAGE_SENSOR_TIME_TIMESTAMP
Date: Sun,  4 Feb 2024 04:56:17 -0800
Message-Id: <20240204125617.2635574-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When als_capture_sample() is called with usage ID
HID_USAGE_SENSOR_TIME_TIMESTAMP, return 0. The HID sensor core ignores
the return value for capture_sample() callback, so return value doesn't
make difference. But correct the return value to return success instead
of -EINVAL.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
As part of review comments for series "Add support of color temperature
and chromaticity". This is separate from the series as this is
unrelated.

 drivers/iio/light/hid-sensor-als.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 5cd27f04b45e..b6c4bef2a7bb 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -226,6 +226,7 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
 	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
 		als_state->timestamp = hid_sensor_convert_timestamp(&als_state->common_attributes,
 								    *(s64 *)raw_data);
+		ret = 0;
 		break;
 	default:
 		break;
-- 
2.43.0


