Return-Path: <linux-kernel+bounces-90628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892B1870272
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B9BBB27059
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061363D98D;
	Mon,  4 Mar 2024 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kvNGVIwV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067843D565;
	Mon,  4 Mar 2024 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558227; cv=none; b=g9yAzGdORnYIOP6d0i25brQSbkIO11iPAAldYS7G8yVhbM2Gm4T4rSw1XExbjwVYYFb1XCNADIb8P/O2l/LdUjO7R28oCSS1z6Fut1HwxdwFCLb2ZpgZ6C1Ema0W5LjP83QJpfCJcWN00zgiS+ZlB9Wdp3OtAGoiVIf0QHqSrTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558227; c=relaxed/simple;
	bh=aHO61Fw3YcuzKPVaQ0d2bWO0FKGgjcXcNHrY8DEIZZI=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aBtuNH1MKIkhWKnG2kJp5ry2PBj9y6uVY5/D+AcIB9s/QhGpF87tE1lOA+3Ez8I3MVVteWLTt8wIh2hU/6tgyzAN1MTKZTNhb4TVPvq1THjtTIoxFkouvBh3m0euUQKeKg2d91WJ2qzfY1zkqlCvUvE670mTRXs0Z2m8u/XmmM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kvNGVIwV; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709558227; x=1741094227;
  h=from:to:in-reply-to:references:subject:message-id:date:
   mime-version:content-transfer-encoding;
  bh=aHO61Fw3YcuzKPVaQ0d2bWO0FKGgjcXcNHrY8DEIZZI=;
  b=kvNGVIwVl2GVRmWVfO3bwxuZ1gQc6qC0VZtCeSjQTBdw9ru9/KVIaah3
   kNCp6sguEkBAFEtzY8Rrrmgi7xhSl7S3xuZ71AZHKcbEOTRXdRZJTuMfI
   1K2tRBvRANpO8p8AATkEWT5dnW6qa6V0FQBvB91H1/UBR5MAf6NpsJdJX
   GuNGUC2lKHoKOnRtrG0sJi74pNmIcFg0psPde320V6qamBozQe5lS9qfq
   GqDieNRpnsIboClRS6/2AF6KuYLz8lPsIaL/n5Vnnps66nMMYWY1MarSk
   1M16px/1dK4rjBql91e6+sSO2aJi+XFh02+P9UnDmoNt+Y3Z6CCsJW9Zt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="26512899"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="26512899"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:17:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="9367135"
Received: from ekohn-mobl1.ger.corp.intel.com (HELO localhost) ([10.246.49.145])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:17:03 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: rajvi.jingar@linux.intel.com, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com, 
 hdegoede@redhat.com, "David E. Box" <david.e.box@linux.intel.com>
In-Reply-To: <20240227190134.1592072-1-david.e.box@linux.intel.com>
References: <20240227190134.1592072-1-david.e.box@linux.intel.com>
Subject: Re: [PATCH V2 1/3] platform/x86/intel/vsec: Remove nuisance
 message
Message-Id: <170955821765.5357.6032325294708039590.b4-ty@linux.intel.com>
Date: Mon, 04 Mar 2024 15:16:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Tue, 27 Feb 2024 11:01:32 -0800, David E. Box wrote:

> intel_vsec_walk_header() is used to configure features from devices that
> don't provide a PCI VSEC or DVSEC structure. Some of these features may
> be unsupported and fail to load. Ignore them silently as we do for
> unsupported features described by VSEC/DVSEC.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/3] platform/x86/intel/vsec: Remove nuisance message
      commit: ad742f6580e1d50a5482fc4f2ed0d248fa784677
[2/3] platform/x86/intel/pmc/lnl: Remove SSRAM support
      commit: 728720381879e9e0bc68ff9edca52261c1f5bc31
[3/3] platform/x86/intel/pmc/arl: Put GNA device in D3
      commit: a5e28e2b384fe5c8fed36907cf4297d629612bdb

--
 i.


