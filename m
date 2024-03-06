Return-Path: <linux-kernel+bounces-93804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB648734D5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF342826AE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC106605CE;
	Wed,  6 Mar 2024 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U1gzvKde"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BF35FDD2;
	Wed,  6 Mar 2024 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722220; cv=none; b=RgTv19VySXoz+cb52Ev1cL3rKmuuc8KhrnkAoGBm6xM4espMMzW4FFT8dEy7LOOOnsEmL+of7CdwkB3Vtw5wL2JRcBGuWJFF+3bBmoz/EXL2ohwyrllhbPJN8xCqxe4w3N07Yp0DzzwhN8pqRRENFkHhBwbH7PgM6rYAngf/p1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722220; c=relaxed/simple;
	bh=/FQwOjsjlEXsuJlp+9wnACCslIvKGqy6TJS6hVnDSpM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a7J9ZJaHzuxQ376T9hKQpmd7ALCL1D/tIXJHHpa4lOpE514As12muMQ7gEjdju0QVIfnjfLTk6btXVVV7Wmg2ZitNI2yl7V99pyBR7LTmWrwbVVcvOOIgaRRan8HMc8sgVfNKNZkQRI6ne02nfqpLkemFrFIcSlO5pmERIrVJnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U1gzvKde; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709722218; x=1741258218;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=/FQwOjsjlEXsuJlp+9wnACCslIvKGqy6TJS6hVnDSpM=;
  b=U1gzvKdeI0onrymFaAShjZAbTUAczFLnHIrpCFJVCtQSpOf7wnOKE1Mq
   LtVQ8VRYqFCTKBgbhH/T5gQyQ0i93HAwkKlbTo/KD3GK5appwdzvSvge8
   vN06GMR3z2oThZ86xFED4Sfn2JW0xpjF83qF4YSIOuw+jpET4zcO13ISC
   bCKvATWFAgtIUOCxXq6AfVRqWBMre5qYMF/5NfDKpYqN5PVM+evJjBFUR
   L1ioQC9M8xtpl2GGABZoYhe0X0SjveQsAHF6J981jFJuV4PgacR5g/kwp
   C2+CHIiTTa0/JzbzMXw7n9alir096kUpceAkJVUQiiYutrlgbzzN/OwMv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="8143242"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="8143242"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 02:50:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="14394664"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 02:50:16 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Shyam-sundar.S-k@amd.com, Armin Wolf <W_Armin@gmx.de>
Cc: hdegoede@redhat.com, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240304205005.10078-1-W_Armin@gmx.de>
References: <20240304205005.10078-1-W_Armin@gmx.de>
Subject: Re: [PATCH v3 0/4] platform/x86/amd/pmf: Fix policy binary
 handling
Message-Id: <170972220931.2521.8343066824996760779.b4-ty@linux.intel.com>
Date: Wed, 06 Mar 2024 12:50:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Mon, 04 Mar 2024 21:50:01 +0100, Armin Wolf wrote:

> This patch series fixes various issues inside the policy binary
> handling code.
> The first patch makes sure that a valid error code is returned upon
> failing to start the policy engine, while the second patch drops the
> usage of readl() on non-io memory.
> The last two patches fix a possible out-of-bounds memory access when
> parsing the policy binary header.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/4] platform/x86/amd/pmf: Fix return value of amd_pmf_start_policy_engine()
      commit: 98cfcece0ab86c99bc106633d764fb6ad4a35b8e
[2/4] platform/x86/amd/pmf: Do not use readl() for policy buffer access
      commit: 379a7c64c4fa33315b504ede86a87188dc88fef4
[3/4] platform/x86/amd/pmf: Use struct for cookie header
      commit: a87d92223084f61d37da4952ad68634ea8a7caaf
[4/4] platform/x86/amd/pmf: Fix possible out-of-bound memory accesses
      commit: 1e7a14ee259e2ff85be51bf36a7692b20233159a

--
 i.


