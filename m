Return-Path: <linux-kernel+bounces-134540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EBA89B2C1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8002816B5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA6239FF3;
	Sun,  7 Apr 2024 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3c/UYLL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688361EEE9
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712505334; cv=none; b=l91VSrgCex7AlO3KdMV7yu/pzvqqEfRqfmdABNj/5AznuEQKphTNN5Kb4Bq0R+Nq8PMw+rF8QWl7pN+dFw+NEUmqh2EuD/GYi4KIUD2ylXrjbOrIzKLPm1o1fJjVlorF77YDfp/9UwzY61J/jVHUAgqYBJS5/YbrRIXchV0Wvs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712505334; c=relaxed/simple;
	bh=6kkPJdu5raGq+lO4qJBmb+P54LbJQkkF985xzuXyRbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HH9kggHbpctthiiORugUjdLnPrlcZZ/T7LOx7BzMa192PmYXEUKlNhxeQMknauA4Du7VRRfx0i07tksUKFht0ahccVXnIQXMXBm0wlmL9nz6nBzk91ecvqHgHS/Vid4N6J29rfRg2My+u3LpZBhBOPDawzGPE26YU7WJfuNaPlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l3c/UYLL; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712505333; x=1744041333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6kkPJdu5raGq+lO4qJBmb+P54LbJQkkF985xzuXyRbo=;
  b=l3c/UYLLpPtWMcrABbHo96I+eUcX+PPpe0JujCCQZ2sHs7urs+F92LAm
   rMwxA0tGZmx3dx0fstrI0o4VfA79T6VHdAHMUznyU9FAZaxmbVBnOdQQp
   MK9u6RheBowuCmJSJTMIF/wkUxxhzASZCxeYARc1K5e8m/xTAykkzvLzc
   42PdSMwTbPOSdcuUK0H84m1aDgaJDn/Tn1xSV20gAPSOgmmIK7G6Sq9TF
   g5yH7S55iYdM3Ll2YhFkZx7/8yZ3RBd+ON2VSusVMTAKAXrPN5VVcChdU
   t8aTGmOHxPErwf5tXoIp2OaS0+q8ME+z0xvOlsSuvj9e21Yl/7MIh87A9
   Q==;
X-CSE-ConnectionGUID: bX2802nGSSmQ9xyonZ0lNQ==
X-CSE-MsgGUID: a9m9aotXTXKEh/GAXWvKNg==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="30271189"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="30271189"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 08:55:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="937090007"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="937090007"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Apr 2024 08:55:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 2E8AF1CB; Sun,  7 Apr 2024 18:55:27 +0300 (EEST)
Date: Sun, 7 Apr 2024 18:55:27 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Sean Christopherson <seanjc@google.com>, 
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv9 00/17] x86/tdx: Add kexec support
Message-ID: <da7hfavumtb4nyp6se2pwwkq3idxgzpehnn67qsjdgigh6xq7f@lk4w5o7o6ama>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
 <bdeda1f9-b7d2-4bc3-ad20-342478be464b@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdeda1f9-b7d2-4bc3-ad20-342478be464b@amd.com>

On Thu, Apr 04, 2024 at 01:27:47PM -0500, Kalra, Ashish wrote:
> The cover letter mention the inclusion of the following patch - Keep page
> tables that maps E820_TYPE_ACPI (Ashish)
> 
> But i don't this patch included in your patch-set.

Ouch. My bad. Will fix in v10.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

