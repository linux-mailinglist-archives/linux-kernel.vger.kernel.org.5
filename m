Return-Path: <linux-kernel+bounces-120346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EA688D614
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4889B22B27
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A884C18032;
	Wed, 27 Mar 2024 05:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TeXiLPXo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261231EB3A;
	Wed, 27 Mar 2024 05:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711518746; cv=none; b=roj7EElc2lFD/YgjY0WtqklD2io26XcOqUKbldoUcmnN7WLLNvYPA3MAmn3uXQ24OLHswv3O4n4yP0yMBsC45dPDQHGfCoEs3jZM4FttGiP0dodu4P8So4QHQ0YBM4BzoMfrEnkXQZKWj4X0r04W0fS3wlu3ri49aRBqr9FGEp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711518746; c=relaxed/simple;
	bh=DUYsEBhufHuKKK6bUgS5bqEt21XUzht90M0sAt1R+Mo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=A51WMIr6OPMPY5XPH/zH3c0byN4ZmLCsM3Ucz0A+WZ7i0SvC2CZ5ieqcxksGqpfGDmihkcURo2o1rBS6hBzR6QYN8ladodChbweatrQdmaIPwsdRW9vJnQsXUt8W8eOoAtErebIfpxogcRkjieTSFOp4+G7oq70kXePWPgSOgiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TeXiLPXo; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711518743; x=1743054743;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DUYsEBhufHuKKK6bUgS5bqEt21XUzht90M0sAt1R+Mo=;
  b=TeXiLPXoofhobFd2nlvewQ2n2qOzKpd88xnePb/yM2t8SB1AOB6mRssK
   3XvFOHj7y740DcK8hgfwZdQRNvzDkrykOKSBYnaC/0TuFMpK6LlTZ7Zdd
   TOq1zc0V52u3nYpjXzKmCsnXxc/ypkRQHRzCYN91kO57F/tTqvR7Kk7Bu
   9BfE/sSiZ44/0bUgNoBFE1eZBHRK0/8yWUw/ULP+M04hgRZ92yoYTQaYq
   3Bsfzzac/PeTj1evjrUuj5iGWqrkz2eEiZJlCSIWFIHhV0QeZbQzut/E7
   h+mDGvf5a73CPz34G/uE9vwKdtehQe01dV2P+MY0u6oI7RvC3SUBOM/ct
   Q==;
X-CSE-ConnectionGUID: xG6sBxwRSUGtmVG8uaWXig==
X-CSE-MsgGUID: qyD6Y8h1RuCgRGY+OFqL8A==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6788885"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="6788885"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 22:52:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="20669682"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 22:52:22 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH] soundwire: intel: add intel_free_stream() back
Date: Wed, 27 Mar 2024 05:52:15 +0000
Message-Id: <20240327055215.1097559-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Add the intel_free_stream() callback to deal with the change in IPC that
requires additional steps to be done to clear the gateway node_id.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index e15666962fe4..01e1a0f3ec39 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -700,6 +700,24 @@ static int intel_params_stream(struct sdw_intel *sdw,
  * DAI routines
  */
 
+static int intel_free_stream(struct sdw_intel *sdw,
+			     struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *dai,
+			     int link_id)
+{
+	struct sdw_intel_link_res *res = sdw->link_res;
+	struct sdw_intel_stream_free_data free_data;
+
+	free_data.substream = substream;
+	free_data.dai = dai;
+	free_data.link_id = link_id;
+
+	if (res->ops && res->ops->free_stream && res->dev)
+		return res->ops->free_stream(res->dev, &free_data);
+
+	return 0;
+}
+
 static int intel_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params,
 			   struct snd_soc_dai *dai)
@@ -831,6 +849,7 @@ static int
 intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 {
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_cdns_dai_runtime *dai_runtime;
 	int ret;
 
@@ -851,6 +870,12 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 		return ret;
 	}
 
+	ret = intel_free_stream(sdw, substream, dai, sdw->instance);
+	if (ret < 0) {
+		dev_err(dai->dev, "intel_free_stream: failed %d\n", ret);
+		return ret;
+	}
+
 	dai_runtime->pdi = NULL;
 
 	return 0;
-- 
2.34.1


