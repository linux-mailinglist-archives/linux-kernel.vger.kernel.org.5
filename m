Return-Path: <linux-kernel+bounces-72212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F9985B0DC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84BD1F2156A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71964C610;
	Tue, 20 Feb 2024 02:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="airOT42a"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539E544376;
	Tue, 20 Feb 2024 02:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708395985; cv=none; b=F7X+XiFnNdsyC2SYWdOuOCVSFcXGA8pKG4Eex7dH50g9kRO2sno2UDtb75DdMUYCKhqK11PXrCEANCOmXrowTOkVqH50ntGketlXeszaOO4A/ZcdERp07DcLjcRbkf2B90LPZE9ALfwC3zxiENZLcofSvyktPoBqjsF3lnK0lVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708395985; c=relaxed/simple;
	bh=sSFcBmBcAk4T9tJy9ngYiOxTsXTtLCeQSq45nTKxugc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZPBS5B8Ed3Mr8f7Tr0nkCnJ6BmeGBdF5E1bKwMxLMInwSvn94uqyIMk8MsoBsf9Q+EJKeOaBSeXyHPhCBPLY+mKvktjVbbvfFfjCh9UO8mpS6gjXpg2eDGDlraCSnpEUiP4ZLPL+HzlSzt3ZxVhRcD16ZN3wM0ujicQEJnmk+/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=airOT42a; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708395983; x=1739931983;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sSFcBmBcAk4T9tJy9ngYiOxTsXTtLCeQSq45nTKxugc=;
  b=airOT42aOsHEZ3TAVQdAsRB7fLAPexgeoDFGBHhaWU8ouwMuqE/Nyotc
   il3fEQpikoxZ3DL+dEN6yBLR2IeDVlIwmg+KkQzC98K4e/u9BNUjlrvip
   7IpXs1qn1PzLfajx/oUiMYQV+Ixdwn8TSY0tnV3sNlo+yfJ6gg5NL7RKf
   MbA1SPuqGMhBUsB8KUQDlBlrNXtsG/ic7adXMjqSTSc49/bYD2/UHPwpU
   QDHvUgtpsXSzB301pIdkaatAUlC4puSCkk88KIcg+CF14nie7YPq/0J0U
   tr3+LQSDSyZeGCLw7CK56N3HNdBPeHoKOVSpzJw03kp9jYF5v1WzpaLCg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2357350"
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="2357350"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 18:26:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="4538214"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmviesa007.fm.intel.com with ESMTP; 19 Feb 2024 18:26:22 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/2] cpufreq: intel_pstate: Update Meteor Lake EPPs
Date: Mon, 19 Feb 2024 18:26:05 -0800
Message-Id: <20240220022607.485129-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add feature to update all EPPs and update Meteor Lake EPP values.

Srinivas Pandruvada (2):
  cpufreq: intel_pstate: Allow model specific EPPs
  cpufreq: intel_pstate: Update default EPPs for Meteor Lake

 drivers/cpufreq/intel_pstate.c | 43 +++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 6 deletions(-)

-- 
2.43.0


