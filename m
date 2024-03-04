Return-Path: <linux-kernel+bounces-90631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E803B87027A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29C9CB275A1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD323E486;
	Mon,  4 Mar 2024 13:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="URjhSu7S"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4384E3DBBA;
	Mon,  4 Mar 2024 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558249; cv=none; b=fPtP7+IFHIG3tic0ICZv1BhB7FhYd5K0YwJYWP94bYT2lkucv+/EY9j8kzhay6MMUNm+5up/z9m5w8DsnK47V3tnHcLgeOj6S7s1REZ3kWTWPRO/yo62KWo/Z+5hvKIanDX/1CQ5vZ3dvzs+9KAXVXn8U9B28164iPdfUxFxiEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558249; c=relaxed/simple;
	bh=a+T5eK5lZetFEjh26lp8lg1Xv27AgHSDJz1gUWzsTqQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=idKazh5CBt644xgtwuRljyEB6m5RnbnshWuu6IVmGChoEGLcLhuh7tzzm4tGqGcWjteVQL1QlUFEt2ZZrkubtVAla2hYeUVWGGSorLbEoX3oThPm67n/iEgBsy+hG5xD3xoZYka3XCrSER9VhwfnznnAXXmdOcrpG8aI/ZNaXqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=URjhSu7S; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709558248; x=1741094248;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=a+T5eK5lZetFEjh26lp8lg1Xv27AgHSDJz1gUWzsTqQ=;
  b=URjhSu7Sm5h5UhvUeWfuylJF3nYniNWqpzWVmBDF3nDPyVEk2nuUKd1c
   V3fMBMMFrOpAi1xSrTYvvmor3G2grqPFkEqykoVHhvN5tvATJQdTS3M2R
   CRu8zLQWNW0Lv57MWsnARPnKRZLKrVAdnVSLJT85iEMCVcDqgAj0nPeXK
   qUuzivhqxBDA6comrwb6VdjO+3ACThBIsXNSsOOMxkHyJyOvnf2fNl1FG
   2mwmH+IwhAhJKDcgLHs4694SdIvsFMzXA9boSWkilCFtzv6WP6xAcp1KI
   /iAEhzpAlvih6I0oAVpvEuL3SWSYHvCx5IQmcb8ymD9d+6wmbWfzfc5CE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4213901"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4213901"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:17:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="13656413"
Received: from ekohn-mobl1.ger.corp.intel.com (HELO localhost) ([10.246.49.145])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:17:24 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hdegoede@redhat.com, markgross@kernel.org, 
 andriy.shevchenko@linux.intel.com, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240229002659.1416623-1-srinivas.pandruvada@linux.intel.com>
References: <20240229002659.1416623-1-srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] platform/x86: ISST: Allow reading core-power state on
 HWP disabled systems
Message-Id: <170955823884.5357.9018605202965437681.b4-ty@linux.intel.com>
Date: Mon, 04 Mar 2024 15:17:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Wed, 28 Feb 2024 16:26:59 -0800, Srinivas Pandruvada wrote:

> When HWP (Hardware P-states) is disabled, dynamic SST features are
> disabled. But user should still be able to read the current core-power
> state, with legacy P-states. This will allow users to read current
> configuration with static SST enabled from BIOS.
> 
> To address this, do not call disable_dynamic_sst_features() when the
> request is for reading the state.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: ISST: Allow reading core-power state on HWP disabled systems
      commit: 959e640cf7b2d456052b346fa50574242ca56aaa

--
 i.


