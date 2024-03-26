Return-Path: <linux-kernel+bounces-118604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7DC88BD25
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5781C34F0D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708F26775E;
	Tue, 26 Mar 2024 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XLydjVmy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179995A116;
	Tue, 26 Mar 2024 09:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443695; cv=none; b=Ol54mNAtxoCnAVUczBtb9HBaaSW3duSRkUP94Pm7DIpxkrRp8TM+dUX6o0vqlYKpm+rKQgnuqZeuHJee7x1mkKzi6yVR6jJg0/XTA4qGA8qlReubjxBw1aizY1V1XluvrYv5aYcjQfYKeMMJ2uWB5iGfEcb8EVGZ8M+hv644R3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443695; c=relaxed/simple;
	bh=fI/ZOOnPs8ra4ukyZ3lcLRv1xqdItGb5OJoMllvqB68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sKJwbhu/6xXY6Er+tRFtvZYnoqoBt++GoeGgeeFzbv9M5Nt40LP6+chudSt9wgJkcmyk42bTQI4sCHR71hmIR2ljF2Z6iA5oYal7INf061NGxIQjJFulrut4Q+QonL+r9FfkMa06+60iUBesGeHC9/RlWzme0QixEvZ5KB4iFwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XLydjVmy; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711443694; x=1742979694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fI/ZOOnPs8ra4ukyZ3lcLRv1xqdItGb5OJoMllvqB68=;
  b=XLydjVmykZA8IudLbaN7lpAJk+4pUTy7iruAZtbJWFKiwzjEQKWd7tUt
   0CScgRNQaaQ3vyN8MUjyZLerHqYV4xsSOi89AyispdeoU5EYHsvUpRKJ3
   jBHtNDBY2GPRG435HceyTFnSEkB94GslCFjmhFxc3kGRgE2sJyXKjO6g5
   0oNTHqMuPGit57bbIPZgCCbvmsx98hF9V2eVDL/kFuxNhbtOk9TzrhjHB
   YW+SoRhgVopLB/hlImFsyusstlaR3mpRYTbBwvGN9Li+S8xBQwznGJ2uU
   8QbQ4vrKtbSjh6fA7iYAF9cdsuClbmIRcOW13aHBQDyXUKxOhyUWp/X23
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6343356"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="6343356"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="20614515"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:01:28 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 4/7] soundwire: reconcile dp0_prop and dpn_prop
Date: Tue, 26 Mar 2024 09:01:19 +0000
Message-Id: <20240326090122.1051806-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326090122.1051806-1-yung-chuan.liao@linux.intel.com>
References: <20240326090122.1051806-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The definitions for DP0 are missing a set of fields that are required
to reuse the same configuration code as DPn.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index e5d0aa58e7f6..e3a4bccc2a7e 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -235,7 +235,8 @@ enum sdw_clk_stop_mode {
  * @BRA_flow_controlled: Slave implementation results in an OK_NotReady
  * response
  * @simple_ch_prep_sm: If channel prepare sequence is required
- * @imp_def_interrupts: If set, each bit corresponds to support for
+  * @ch_prep_timeout: Port-specific timeout value, in milliseconds
+  * @imp_def_interrupts: If set, each bit corresponds to support for
  * implementation-defined interrupts
  *
  * The wordlengths are specified by Spec as max, min AND number of
@@ -249,6 +250,7 @@ struct sdw_dp0_prop {
 	u32 *words;
 	bool BRA_flow_controlled;
 	bool simple_ch_prep_sm;
+	u32 ch_prep_timeout;
 	bool imp_def_interrupts;
 };
 
-- 
2.34.1


