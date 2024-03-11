Return-Path: <linux-kernel+bounces-98788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9C8877F6E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047851F225E8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C383D388;
	Mon, 11 Mar 2024 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BvZp9KN5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4E23C068;
	Mon, 11 Mar 2024 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710158468; cv=none; b=fqaRT4CXbdVDqTy3weJ9a0XSrpz4US7f+yMAvSgQkYtzFzjfPwAys5ZkIpa+22/vTe5WzKoD904oslypY3Ipo6wZNrZfVGj5SvVVPVhKWomkp0mzlzgYhx9MKdUVDJ9xovNQMs5KS4ld/snXkIC7eHzXUIltU5+gSPkxplWYPW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710158468; c=relaxed/simple;
	bh=lliEJ0rTAJo2Gw0pexcruBzN2lkhcVuR43ot9jWsI2E=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jk9HPvnqubvnb4IF89xBjAFWmLeexl6dgcGCZmOgyxkIdizXH5Scc8QDWChLDakBDsKLopl+GufpGpo+DMrdRM6Ifn6erWPKYVCxbjxq/k75l9RD59Ive4vSJimPCEQqjJiGp2hHpyCVAZPQUf6RQPCTkR3jQ3WGHO5baAZX2oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BvZp9KN5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710158467; x=1741694467;
  h=from:to:in-reply-to:references:subject:message-id:date:
   mime-version:content-transfer-encoding;
  bh=lliEJ0rTAJo2Gw0pexcruBzN2lkhcVuR43ot9jWsI2E=;
  b=BvZp9KN5l0Hcf22/ZKtjZVBLWieE7T9QH9xeo40kGWTSMnV5LeUUcXQe
   t+Vgwdq72jZ347mGCmln12vnaEosRnSZNnTGpVhC/TYN7aUo3U+hjBGxa
   ij53XtkfGDceXJLSGHW3rj7ImGzqnhzZj7V8R04vmz1VbImXMjJ6LKGwH
   oQS8fd7mvD5P+jVD0vNNmUsXjj4MhrjAmk5DdwyXHKzp6n7PLII9Unq8+
   DpS0jgmtWOz6AqYeISYDVz8I4qZcRoJzP3i1tRdilkUOfFS3/zihpDb7Z
   +YbiE8J/VAGhM430+yLJcOyETsSOZGESyQUT2sycasElwf15h3MaSWKPU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="15377175"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="15377175"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 05:01:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11032094"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.201])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 05:01:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 david.e.box@intel.com, kane.chen@intel.corp-partner.google.com, 
 Kane Chen <kane.chen@intel.com>
In-Reply-To: <20240308033127.1013053-1-kane.chen@intel.com>
References: <20240308033127.1013053-1-kane.chen@intel.com>
Subject: Re: [PATCH v2 1/1] platform/x86/intel/pmc: Improve PKGC residency
 counters debug
Message-Id: <171015845757.2407.106134476792192282.b4-ty@linux.intel.com>
Date: Mon, 11 Mar 2024 14:00:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Fri, 08 Mar 2024 11:31:27 +0800, Kane Chen wrote:

> The current code only prints PKGC-10 residency when the PKGC-10
> is not reached in previous 'freeze' attempt. To debug PKGC-10 issues, we
> also need to know other PKGC residency counters to better triage issues.
> Ex:
> 1. When system is stuck in PC2, it can be caused short LTR from device.
> 2. When system is stuck in PC8, it can be caused by display engine.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/intel/pmc: Improve PKGC residency counters debug
      commit: f117a06ccaf48c8e2637bc3fa35d038c0c92c43d

--
 i.


