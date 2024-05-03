Return-Path: <linux-kernel+bounces-168094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 027D78BB396
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B837D285F9F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EAE13A244;
	Fri,  3 May 2024 18:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cqbkAtkN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129C22943F
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 18:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714762685; cv=none; b=UOjesoj7ImRukuxaIJPLn3MqSzQ0QdyAw1m4lHFQEgyPgpxDQ700Q8CvduKQYuDVuFrA2M+7WVoF0Oznx+mjZ/YZf0PDFFsGuJh9k7pWjIOzpyfFRwzt7whgggFRc7IyIRSweoSnb0pnlH/+8HwtgcbnEVPq1ppPUV/YoFElg9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714762685; c=relaxed/simple;
	bh=XAg9GDRC+nQ5MMjM6ezG4ongE11vNd9mrpuVQFeAq28=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cZHi66st04hizzIkhy2chs5aD+HsmChc/6vCLg1c3NE8IBqHj7vwnf9buEVLuD9pO61QHoY5xjviORPQO3M946U+d1nTkDy8ker2WCP9nth/v3srR9wBReidOws42RwPAGtQ0NzwqEb6dAJTGPIYKiFU+0qpM1EWeAyxxQcCF7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cqbkAtkN; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714762684; x=1746298684;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XAg9GDRC+nQ5MMjM6ezG4ongE11vNd9mrpuVQFeAq28=;
  b=cqbkAtkNDbhO/eW2GvfdIAHXgdYKxonx8jIRpF0b7OROGhrOuNe9hSnP
   v9X/gxBwOZ48JlMRtNG+xuvag7VD81kA2l3yCdRoTMaLv0FSLbvFiMgb1
   at18M11saHCPKQVM3malZD8yaSH/3h45UeaVVShWovXMudJcGttnyG+8U
   5sjHinFmm90I83AM5pIibe2rjDfsz0noeNOIlLhwZXXQQNrQjU1UXZqd/
   ghby0TdwpZuG/dC1+uM/DexK9tXwU8JpxAgN/aE2Bfmi5eBJWKOkvqyqy
   Y3mvVMkimAro5Z+VXKCafjHDamS8fMgxr0gdU7n4BCGtgKpP0FO+ZHbqe
   g==;
X-CSE-ConnectionGUID: cTJ+B6JuT5a3jN6Y/FbE/Q==
X-CSE-MsgGUID: lOTOkKkATtKz+RiCCGopFQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="21198027"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="21198027"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 11:58:03 -0700
X-CSE-ConnectionGUID: cNIN6jWcTQ6ePOJzq0fjPg==
X-CSE-MsgGUID: BGalT7cWSpmCuWSpX1hA8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27557181"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 11:58:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2y6Z-00000003kbu-477e;
	Fri, 03 May 2024 21:57:59 +0300
Date: Fri, 3 May 2024 21:57:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Howells <dhowells@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Subject: compiler_types.h in UAPI?
Message-ID: <ZjUzt3Rysyk-oGdQ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

Hi!

Today I have stumbled over use of __force and other compiler_types.h related
things in UAPI headers. Can anybody explain to me how do they suppose to work
outside of the kernel? Or did I miss something obvious? Or it was a mistake
during UAPI split to move swab.h and byteorder/ (most of the users of those)
to UAPI in the first place?

-- 
With Best Regards,
Andy Shevchenko



