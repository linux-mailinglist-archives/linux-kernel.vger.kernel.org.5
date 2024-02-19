Return-Path: <linux-kernel+bounces-71149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EB085A158
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960D11C21796
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EDF28DBD;
	Mon, 19 Feb 2024 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ud4+CxHB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDB924B5B;
	Mon, 19 Feb 2024 10:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708339817; cv=none; b=kUqiMNFGSaziYOzxPw+SH9HGpMgt5y36lnWRrLuSL+qOO3z/XDAPX1trVF0TtdB2qnBrx8VhcIEClPia0Nl5qHcARcuLN9jnN7izRA1CowMjSte16h+vw5NUomKzKjFiOQMmJTDh0TI6s+oUhC/z1Lp/HLHHIIXbp2E3GgFQ8SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708339817; c=relaxed/simple;
	bh=dzTaso4wO+G6d/H8AhaEyUh/RCIlWQ/zztQlM6V9F0w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WuJAi/5SosCHXTv2bxk7BbvzcxWc4OKhSHXfdQjDOigb7JvNIXMy+NXoouIbyFlycw3WbOrNdSffVXY31hs3yGSSX0o4M3c8AaWUvsVw58sq4zTf+2F9XGneEfHM3Vu1R7ijoakUKmhLHs9+/Pj89KUdic2LWFAY+UT/GurhMdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ud4+CxHB; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708339815; x=1739875815;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dzTaso4wO+G6d/H8AhaEyUh/RCIlWQ/zztQlM6V9F0w=;
  b=Ud4+CxHBvPdYkQ0YiIgs+YpENL3Z5iRQK2Oei8QbyMkbg5JrlhbZTJQ7
   GnqIXraBqwg8DMhUTerrPzWZi2+sHguEtAgFcYKrHw7oja25LruGmop+f
   ktWVYR2/yoKb5KS9JInElqVw3NER0Oxv0qlbTPTdkTDcY0Z7+JFk7dWww
   9V0dbTz7UzR53Z7IwfPd3XKiN7XRypxIn4U/eEPUAxMvLRfhkXF2pCrm0
   SvgLwbyphuj3eBkYjjP3ATvSjVB944Acm2xSLXmBumUfTKsEe8dSDmuei
   XAH191ZBnd+G7KG3/Vj1Um7E9iSJWirMAY1EYjCkyNDP2ry5Ivcy5KTFF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="6189524"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="6189524"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 02:50:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4616255"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmviesa008.fm.intel.com with ESMTP; 19 Feb 2024 02:50:12 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: vkoul@kernel.org
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	broonie@kernel.org,
	pierre-louis.bossart@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	amadeuszx.slawinski@linux.intel.com,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH] soundwire: Use snd_soc_substream_to_rtd() to obtain rtd
Date: Mon, 19 Feb 2024 11:52:06 +0100
Message-Id: <20240219105206.335738-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Utilize the helper function instead of casting from ->private_data
directly.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 drivers/soundwire/stream.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index f9c0adc0738d..4e9e7d2a942d 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1718,7 +1718,7 @@ EXPORT_SYMBOL(sdw_deprepare_stream);
 static int set_stream(struct snd_pcm_substream *substream,
 		      struct sdw_stream_runtime *sdw_stream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *dai;
 	int ret = 0;
 	int i;
@@ -1771,7 +1771,7 @@ EXPORT_SYMBOL(sdw_alloc_stream);
 int sdw_startup_stream(void *sdw_substream)
 {
 	struct snd_pcm_substream *substream = sdw_substream;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct sdw_stream_runtime *sdw_stream;
 	char *name;
 	int ret;
@@ -1815,7 +1815,7 @@ EXPORT_SYMBOL(sdw_startup_stream);
 void sdw_shutdown_stream(void *sdw_substream)
 {
 	struct snd_pcm_substream *substream = sdw_substream;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct sdw_stream_runtime *sdw_stream;
 	struct snd_soc_dai *dai;
 
-- 
2.25.1


