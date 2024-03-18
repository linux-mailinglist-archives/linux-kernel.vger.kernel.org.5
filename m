Return-Path: <linux-kernel+bounces-106099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C013B87E923
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF88C1C21110
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB7B381A4;
	Mon, 18 Mar 2024 12:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YKs9AN7a"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB2F37700;
	Mon, 18 Mar 2024 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710763764; cv=none; b=mi7vFZsRd4Dc9kBaWIBWUXaylriiiWzHQlU9Rf8mx25zrWK7y+MOPSvWpdAlnT8p0zjnglCHcLdGyDUzrDpoNfa60xksjHb8lGup2mzczC6/SMzgkl/VW9UWWU8J95ydOSP+J1XWR8aQv0xjo23eOrtAUr7QkN2dfkTfcajLfUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710763764; c=relaxed/simple;
	bh=GRJyf9/6lu9L0rxjV5ep/uj1h5ZQaCB1kW/gwg3CDjo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IaZVGk1i2Ul6wSW3mMOi1qt8xvSoFWk1GiJjGDkqh8QWfnUk2BeNWwu3eCZcoQvxK6MGMBUsbicrLq4mYzfop/jaHGJLzNFZqeCl7Po5mL0d+g0p1URnmajZC91ZCY7JUSIaSSojeKCQdoxmSB0HLi0hoSi/xvIue1LUUycUiww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YKs9AN7a; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710763763; x=1742299763;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GRJyf9/6lu9L0rxjV5ep/uj1h5ZQaCB1kW/gwg3CDjo=;
  b=YKs9AN7a8Sd19r613kshfqviK4tH1eei52kZIkFJEAnaL+i/vV3ICwRY
   JP5mGM9Xt2MFJoV/Qfr2oy6NaNPoExo7cDcmTZNmXZ3ymlwoufbJUmgci
   BFyNIXIxq6r0oWUb4kvr4cTCp2ZEbXE2mhk8C7zxLNdAyYZjN4C0TAU8I
   biSTa2Dvoha2Y10mFtZ1c4gQdxUuRJsAkDPtSEu+QXjwmVcP2gmV7p83r
   1S2c08M4JC9p9x3PV8OK73pIBrN7/vwcUOIL0tEnRq+7ybZDuW6mKhZHj
   ekzWK5zmYc1C3ULEHPC6fCST64t1C6urUpCqPA4p6xrm0pXpND0zXX1Or
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="17017572"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="17017572"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 05:09:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="13337857"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.11])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 05:09:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 18 Mar 2024 14:09:13 +0200 (EET)
To: "Luke D. Jones" <luke@ljones.dev>
cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/1] asus-wmi: add support for 2024 ROG Mini-LED
In-Reply-To: <20240310065408.63703-1-luke@ljones.dev>
Message-ID: <9ccb144f-3e6e-0ae7-496e-de4cf75171e5@linux.intel.com>
References: <20240310065408.63703-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 10 Mar 2024, Luke D. Jones wrote:

> Changelog:
> - v1
>   - Add missing value conversion for new mini-led
>   - Catch and ignore a bogus read return if set to "off"
> 
> Luke D. Jones (1):
>   platform/x86: asus-wmi: add support for 2024 ROG Mini-LED

Hi Luke,

I've small troubles in following the patch version in your recent batch 
of patches. Could you please list which of these are the versions you 
consider the correct / "latest" one:

https://patchwork.kernel.org/project/platform-driver-x86/list/?submitter=193685

?

While Hans will be handling the 6.10 cycle, I could review the latest 
versions and close the wrong ones so it will be easier for Hans to pick up 
the correct ones.

-- 
 i.


